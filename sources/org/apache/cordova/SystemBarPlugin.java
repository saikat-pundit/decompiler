package org.apache.cordova;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Color;
import android.os.Build;
import android.view.View;
import android.view.ViewParent;
import android.view.Window;
import android.view.WindowInsetsController;
import android.widget.FrameLayout;
import androidx.core.content.ContextCompat;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowCompat;
import org.json.JSONArray;
import org.json.JSONException;

/* JADX INFO: loaded from: classes.dex */
public class SystemBarPlugin extends CordovaPlugin {
    static final int INVALID_COLOR = -1;
    static final String PLUGIN_NAME = "SystemBarPlugin";
    private Context context;
    private Resources resources;
    private int overrideStatusBarBackgroundColor = -1;
    private boolean canEdgeToEdge = false;

    @Override // org.apache.cordova.CordovaPlugin
    protected void pluginInitialize() {
        Context context = this.f4cordova.getContext();
        this.context = context;
        this.resources = context.getResources();
        boolean z = false;
        if (this.preferences.getBoolean("AndroidEdgeToEdge", false) && Build.VERSION.SDK_INT >= 35) {
            z = true;
        }
        this.canEdgeToEdge = z;
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        this.f4cordova.getActivity().runOnUiThread(new SystemBarPlugin$$ExternalSyntheticLambda2(this));
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onResume(boolean z) {
        super.onResume(z);
        this.f4cordova.getActivity().runOnUiThread(new SystemBarPlugin$$ExternalSyntheticLambda2(this));
    }

    @Override // org.apache.cordova.CordovaPlugin
    public Object onMessage(String str, Object obj) {
        if (!str.equals("updateSystemBars")) {
            return null;
        }
        this.f4cordova.getActivity().runOnUiThread(new SystemBarPlugin$$ExternalSyntheticLambda2(this));
        return null;
    }

    @Override // org.apache.cordova.CordovaPlugin
    public boolean execute(String str, final JSONArray jSONArray, CallbackContext callbackContext) throws JSONException {
        if (this.canEdgeToEdge) {
            return false;
        }
        if ("setStatusBarVisible".equals(str)) {
            final boolean z = jSONArray.getBoolean(0);
            this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: org.apache.cordova.SystemBarPlugin$$ExternalSyntheticLambda0
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.m1666lambda$execute$0$orgapachecordovaSystemBarPlugin(z);
                }
            });
        } else {
            if (!"setStatusBarBackgroundColor".equals(str)) {
                return false;
            }
            this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: org.apache.cordova.SystemBarPlugin$$ExternalSyntheticLambda1
                @Override // java.lang.Runnable
                public final void run() {
                    this.f$0.m1667lambda$execute$1$orgapachecordovaSystemBarPlugin(jSONArray);
                }
            });
        }
        callbackContext.success();
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: setStatusBarVisible, reason: merged with bridge method [inline-methods] */
    public void m1666lambda$execute$0$orgapachecordovaSystemBarPlugin(boolean z) {
        View statusBarView = getStatusBarView(this.webView);
        if (statusBarView != null) {
            statusBarView.setVisibility(z ? 0 : 8);
            FrameLayout rootLayout = getRootLayout(this.webView);
            if (rootLayout != null) {
                ViewCompat.requestApplyInsets(rootLayout);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: setStatusBarBackgroundColor, reason: merged with bridge method [inline-methods] */
    public void m1667lambda$execute$1$orgapachecordovaSystemBarPlugin(JSONArray jSONArray) {
        try {
            int colorFromString = parseColorFromString(String.format("#%02X%02X%02X%02X", Integer.valueOf(jSONArray.getInt(0)), Integer.valueOf(jSONArray.getInt(1)), Integer.valueOf(jSONArray.getInt(2)), Integer.valueOf(jSONArray.getInt(3))));
            if (colorFromString == -1) {
                return;
            }
            this.overrideStatusBarBackgroundColor = colorFromString;
            updateStatusBar(colorFromString);
        } catch (JSONException unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void updateSystemBars() {
        int preferenceBackgroundColor = getPreferenceBackgroundColor();
        if (preferenceBackgroundColor == -1) {
            preferenceBackgroundColor = this.canEdgeToEdge ? 0 : getUiModeColor();
        }
        updateRootView(preferenceBackgroundColor);
        int i = this.overrideStatusBarBackgroundColor;
        if (i != -1) {
            preferenceBackgroundColor = i;
        } else if (this.preferences.contains("StatusBarBackgroundColor")) {
            preferenceBackgroundColor = getPreferenceStatusBarBackgroundColor();
        } else if (!this.preferences.contains("BackgroundColor")) {
            preferenceBackgroundColor = this.canEdgeToEdge ? 0 : getUiModeColor();
        }
        updateStatusBar(preferenceBackgroundColor);
    }

    private void updateRootView(int i) {
        boolean zIsColorLight;
        WindowInsetsController insetsController;
        Window window = this.f4cordova.getActivity().getWindow();
        View viewFindViewById = this.f4cordova.getActivity().findViewById(android.R.id.content);
        if (viewFindViewById != null) {
            viewFindViewById.setBackgroundColor(i);
        }
        if (i == 0) {
            zIsColorLight = isColorLight(getUiModeColor());
        } else {
            zIsColorLight = isColorLight(i);
        }
        if (Build.VERSION.SDK_INT >= 30 && (insetsController = window.getInsetsController()) != null) {
            if (zIsColorLight) {
                insetsController.setSystemBarsAppearance(0, 8);
            } else {
                insetsController.setSystemBarsAppearance(8, 8);
            }
        }
        WindowCompat.getInsetsController(window, window.getDecorView()).setAppearanceLightNavigationBars(zIsColorLight);
        if (Build.VERSION.SDK_INT >= 26) {
            window.setNavigationBarColor(i);
        } else {
            window.setNavigationBarColor(ViewCompat.MEASURED_STATE_MASK);
        }
    }

    private void updateStatusBar(int i) {
        boolean zIsColorLight;
        Window window = this.f4cordova.getActivity().getWindow();
        View statusBarView = getStatusBarView(this.webView);
        if (statusBarView != null) {
            statusBarView.setBackgroundColor(i);
        }
        if (i == 0) {
            zIsColorLight = isColorLight(getUiModeColor());
        } else {
            zIsColorLight = isColorLight(i);
        }
        WindowCompat.getInsetsController(window, window.getDecorView()).setAppearanceLightStatusBars(zIsColorLight);
    }

    private static boolean isColorLight(int i) {
        return (((((double) Color.red(i)) / 255.0d) * 0.299d) + ((((double) Color.green(i)) / 255.0d) * 0.587d)) + ((((double) Color.blue(i)) / 255.0d) * 0.114d) > 0.5d;
    }

    private int getPreferenceStatusBarBackgroundColor() {
        int colorFromString = parseColorFromString(this.preferences.getString("StatusBarBackgroundColor", null));
        return colorFromString != -1 ? colorFromString : getUiModeColor();
    }

    private int getPreferenceBackgroundColor() {
        try {
            return this.preferences.getInteger("BackgroundColor", -1);
        } catch (NumberFormatException unused) {
            LOG.e(PLUGIN_NAME, "Invalid background color argument. Example valid string: '0x00000000'");
            return -1;
        }
    }

    private FrameLayout getRootLayout(CordovaWebView cordovaWebView) {
        ViewParent parent = cordovaWebView.getView().getParent();
        if (parent instanceof FrameLayout) {
            return (FrameLayout) parent;
        }
        return null;
    }

    private View getStatusBarView(CordovaWebView cordovaWebView) {
        FrameLayout rootLayout = getRootLayout(cordovaWebView);
        if (rootLayout == null) {
            return null;
        }
        for (int i = 0; i < rootLayout.getChildCount(); i++) {
            View childAt = rootLayout.getChildAt(i);
            if ("statusBarView".equals(childAt.getTag())) {
                return childAt;
            }
        }
        return null;
    }

    private int getUiModeColor() {
        String str = (this.resources.getConfiguration().uiMode & 48) == 32 ? "#121318" : "#FAF8FF";
        int identifier = this.resources.getIdentifier("cdv_background_color", "color", this.context.getPackageName());
        if (identifier != 0) {
            return ContextCompat.getColor(this.context, identifier);
        }
        return Color.parseColor(str);
    }

    private int parseColorFromString(String str) {
        if (str.isEmpty()) {
            return -1;
        }
        try {
            return Color.parseColor(str);
        } catch (IllegalArgumentException unused) {
            LOG.e(PLUGIN_NAME, "Invalid color hex code. Valid format: #RRGGBB or #AARRGGBB");
            return -1;
        }
    }
}
