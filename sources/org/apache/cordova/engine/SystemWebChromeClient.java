package org.apache.cordova.engine;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.view.View;
import android.webkit.GeolocationPermissions;
import android.webkit.JsPromptResult;
import android.webkit.JsResult;
import android.webkit.PermissionRequest;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebStorage;
import android.webkit.WebView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import androidx.core.content.FileProvider;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import org.apache.cordova.CordovaDialogsHelper;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.LOG;

/* JADX INFO: loaded from: classes.dex */
public class SystemWebChromeClient extends WebChromeClient {
    private static final int FILECHOOSER_RESULTCODE = 5173;
    private static final String LOG_TAG = "SystemWebChromeClient";
    private long MAX_QUOTA = 104857600;
    private Context appContext;
    private CordovaDialogsHelper dialogsHelper;
    private View mCustomView;
    private WebChromeClient.CustomViewCallback mCustomViewCallback;
    private View mVideoProgressView;
    protected final SystemWebViewEngine parentEngine;

    public SystemWebChromeClient(SystemWebViewEngine systemWebViewEngine) {
        this.parentEngine = systemWebViewEngine;
        this.appContext = systemWebViewEngine.webView.getContext();
        this.dialogsHelper = new CordovaDialogsHelper(this.appContext);
    }

    @Override // android.webkit.WebChromeClient
    public boolean onJsAlert(WebView webView, String str, String str2, final JsResult jsResult) {
        this.dialogsHelper.showAlert(str2, new CordovaDialogsHelper.Result() { // from class: org.apache.cordova.engine.SystemWebChromeClient.1
            @Override // org.apache.cordova.CordovaDialogsHelper.Result
            public void gotResult(boolean z, String str3) {
                if (z) {
                    jsResult.confirm();
                } else {
                    jsResult.cancel();
                }
            }
        });
        return true;
    }

    @Override // android.webkit.WebChromeClient
    public boolean onJsConfirm(WebView webView, String str, String str2, final JsResult jsResult) {
        this.dialogsHelper.showConfirm(str2, new CordovaDialogsHelper.Result() { // from class: org.apache.cordova.engine.SystemWebChromeClient.2
            @Override // org.apache.cordova.CordovaDialogsHelper.Result
            public void gotResult(boolean z, String str3) {
                if (z) {
                    jsResult.confirm();
                } else {
                    jsResult.cancel();
                }
            }
        });
        return true;
    }

    @Override // android.webkit.WebChromeClient
    public boolean onJsPrompt(WebView webView, String str, String str2, String str3, final JsPromptResult jsPromptResult) {
        String strPromptOnJsPrompt = this.parentEngine.bridge.promptOnJsPrompt(str, str2, str3);
        if (strPromptOnJsPrompt != null) {
            jsPromptResult.confirm(strPromptOnJsPrompt);
            return true;
        }
        this.dialogsHelper.showPrompt(str2, str3, new CordovaDialogsHelper.Result() { // from class: org.apache.cordova.engine.SystemWebChromeClient.3
            @Override // org.apache.cordova.CordovaDialogsHelper.Result
            public void gotResult(boolean z, String str4) {
                if (z) {
                    jsPromptResult.confirm(str4);
                } else {
                    jsPromptResult.cancel();
                }
            }
        });
        return true;
    }

    @Override // android.webkit.WebChromeClient
    public void onExceededDatabaseQuota(String str, String str2, long j, long j2, long j3, WebStorage.QuotaUpdater quotaUpdater) {
        LOG.d(LOG_TAG, "onExceededDatabaseQuota estimatedSize: %d  currentQuota: %d  totalUsedQuota: %d", Long.valueOf(j2), Long.valueOf(j), Long.valueOf(j3));
        quotaUpdater.updateQuota(this.MAX_QUOTA);
    }

    @Override // android.webkit.WebChromeClient
    public void onGeolocationPermissionsShowPrompt(String str, GeolocationPermissions.Callback callback) {
        super.onGeolocationPermissionsShowPrompt(str, callback);
        callback.invoke(str, true, false);
        CordovaPlugin plugin = this.parentEngine.pluginManager.getPlugin("Geolocation");
        if (plugin == null || plugin.hasPermisssion()) {
            return;
        }
        plugin.requestPermissions(0);
    }

    @Override // android.webkit.WebChromeClient
    public void onShowCustomView(View view, WebChromeClient.CustomViewCallback customViewCallback) {
        this.parentEngine.getCordovaWebView().showCustomView(view, customViewCallback);
    }

    @Override // android.webkit.WebChromeClient
    public void onHideCustomView() {
        this.parentEngine.getCordovaWebView().hideCustomView();
    }

    @Override // android.webkit.WebChromeClient
    public View getVideoLoadingProgressView() {
        if (this.mVideoProgressView == null) {
            LinearLayout linearLayout = new LinearLayout(this.parentEngine.getView().getContext());
            linearLayout.setOrientation(1);
            RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(-2, -2);
            layoutParams.addRule(13);
            linearLayout.setLayoutParams(layoutParams);
            ProgressBar progressBar = new ProgressBar(this.parentEngine.getView().getContext());
            LinearLayout.LayoutParams layoutParams2 = new LinearLayout.LayoutParams(-2, -2);
            layoutParams2.gravity = 17;
            progressBar.setLayoutParams(layoutParams2);
            linearLayout.addView(progressBar);
            this.mVideoProgressView = linearLayout;
        }
        return this.mVideoProgressView;
    }

    @Override // android.webkit.WebChromeClient
    public boolean onShowFileChooser(WebView webView, final ValueCallback<Uri[]> valueCallback, WebChromeClient.FileChooserParams fileChooserParams) {
        Intent intent;
        final Uri uriCreateUriForFile;
        Intent intentCreateIntent = fileChooserParams.createIntent();
        boolean z = false;
        if (fileChooserParams.getMode() == 1) {
            z = true;
        }
        intentCreateIntent.putExtra("android.intent.extra.ALLOW_MULTIPLE", z);
        String[] acceptTypes = fileChooserParams.getAcceptTypes();
        if (acceptTypes.length > 1) {
            intentCreateIntent.setType("*/*");
            intentCreateIntent.putExtra("android.intent.extra.MIME_TYPES", acceptTypes);
        }
        if (fileChooserParams.isCaptureEnabled()) {
            intent = new Intent("android.media.action.IMAGE_CAPTURE");
            Context context = this.parentEngine.getView().getContext();
            if (context.getPackageManager().hasSystemFeature("android.hardware.camera.any") && intent.resolveActivity(context.getPackageManager()) != null) {
                try {
                    File fileCreateTempFile = createTempFile(context);
                    LOG.d(LOG_TAG, "Temporary photo capture file: " + fileCreateTempFile);
                    uriCreateUriForFile = createUriForFile(context, fileCreateTempFile);
                } catch (IOException e) {
                    e = e;
                    uriCreateUriForFile = null;
                }
                try {
                    LOG.d(LOG_TAG, "Temporary photo capture URI: " + uriCreateUriForFile);
                    intent.putExtra("output", uriCreateUriForFile);
                } catch (IOException e2) {
                    e = e2;
                    LOG.e(LOG_TAG, "Unable to create temporary file for photo capture", e);
                    intent = null;
                }
            } else {
                LOG.w(LOG_TAG, "Device does not support photo capture");
                intent = null;
                uriCreateUriForFile = null;
            }
        } else {
            intent = null;
            uriCreateUriForFile = null;
        }
        Intent intentCreateChooser = Intent.createChooser(intentCreateIntent, null);
        if (intent != null) {
            intentCreateChooser.putExtra("android.intent.extra.INITIAL_INTENTS", new Intent[]{intent});
        }
        try {
            LOG.i(LOG_TAG, "Starting intent for file chooser");
            this.parentEngine.f9cordova.startActivityForResult(new CordovaPlugin() { // from class: org.apache.cordova.engine.SystemWebChromeClient.4
                /* JADX WARN: Removed duplicated region for block: B:24:0x00ac  */
                @Override // org.apache.cordova.CordovaPlugin
                /*
                    Code decompiled incorrectly, please refer to instructions dump.
                    To view partially-correct code enable 'Show inconsistent code' option in preferences
                */
                public void onActivityResult(int r6, int r7, android.content.Intent r8) {
                    /*
                        r5 = this;
                        r6 = -1
                        if (r7 != r6) goto Lac
                        java.util.ArrayList r6 = new java.util.ArrayList
                        r6.<init>()
                        java.lang.String r7 = "SystemWebChromeClient"
                        if (r8 == 0) goto L30
                        android.net.Uri r0 = r8.getData()
                        if (r0 == 0) goto L30
                        java.lang.StringBuilder r0 = new java.lang.StringBuilder
                        java.lang.String r1 = "Adding file (single): "
                        r0.<init>(r1)
                        android.net.Uri r1 = r8.getData()
                        java.lang.StringBuilder r0 = r0.append(r1)
                        java.lang.String r0 = r0.toString()
                        org.apache.cordova.LOG.v(r7, r0)
                        android.net.Uri r8 = r8.getData()
                        r6.add(r8)
                        goto L83
                    L30:
                        android.net.Uri r0 = r2
                        if (r0 == 0) goto L4e
                        java.lang.StringBuilder r8 = new java.lang.StringBuilder
                        java.lang.String r0 = "Adding camera capture: "
                        r8.<init>(r0)
                        android.net.Uri r0 = r2
                        java.lang.StringBuilder r8 = r8.append(r0)
                        java.lang.String r8 = r8.toString()
                        org.apache.cordova.LOG.v(r7, r8)
                        android.net.Uri r8 = r2
                        r6.add(r8)
                        goto L83
                    L4e:
                        if (r8 == 0) goto L83
                        android.content.ClipData r0 = r8.getClipData()
                        if (r0 == 0) goto L83
                        android.content.ClipData r8 = r8.getClipData()
                        int r0 = r8.getItemCount()
                        r1 = 0
                    L5f:
                        if (r1 >= r0) goto L83
                        android.content.ClipData$Item r2 = r8.getItemAt(r1)
                        android.net.Uri r2 = r2.getUri()
                        java.lang.StringBuilder r3 = new java.lang.StringBuilder
                        java.lang.String r4 = "Adding file (multiple): "
                        r3.<init>(r4)
                        java.lang.StringBuilder r3 = r3.append(r2)
                        java.lang.String r3 = r3.toString()
                        org.apache.cordova.LOG.v(r7, r3)
                        if (r2 == 0) goto L80
                        r6.add(r2)
                    L80:
                        int r1 = r1 + 1
                        goto L5f
                    L83:
                        boolean r8 = r6.isEmpty()
                        if (r8 != 0) goto Lac
                        java.lang.StringBuilder r8 = new java.lang.StringBuilder
                        java.lang.String r0 = "Receive file chooser URL: "
                        r8.<init>(r0)
                        java.lang.String r0 = r6.toString()
                        java.lang.StringBuilder r8 = r8.append(r0)
                        java.lang.String r8 = r8.toString()
                        org.apache.cordova.LOG.d(r7, r8)
                        int r7 = r6.size()
                        android.net.Uri[] r7 = new android.net.Uri[r7]
                        java.lang.Object[] r6 = r6.toArray(r7)
                        android.net.Uri[] r6 = (android.net.Uri[]) r6
                        goto Lad
                    Lac:
                        r6 = 0
                    Lad:
                        android.webkit.ValueCallback r7 = r3
                        r7.onReceiveValue(r6)
                        return
                    */
                    throw new UnsupportedOperationException("Method not decompiled: org.apache.cordova.engine.SystemWebChromeClient.AnonymousClass4.onActivityResult(int, int, android.content.Intent):void");
                }
            }, intentCreateChooser, FILECHOOSER_RESULTCODE);
        } catch (ActivityNotFoundException e3) {
            LOG.w(LOG_TAG, "No activity found to handle file chooser intent.", e3);
            valueCallback.onReceiveValue(null);
        }
        return true;
    }

    private File createTempFile(Context context) throws IOException {
        return File.createTempFile("temp", ".jpg", context.getCacheDir());
    }

    private Uri createUriForFile(Context context, File file) throws IOException {
        return FileProvider.getUriForFile(context, context.getPackageName() + ".cdv.core.file.provider", file);
    }

    @Override // android.webkit.WebChromeClient
    public void onPermissionRequest(PermissionRequest permissionRequest) {
        LOG.d(LOG_TAG, "onPermissionRequest: " + Arrays.toString(permissionRequest.getResources()));
        permissionRequest.grant(permissionRequest.getResources());
    }

    public void destroyLastDialog() {
        this.dialogsHelper.destroyLastDialog();
    }
}
