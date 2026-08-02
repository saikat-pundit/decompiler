package org.apache.cordova;

import android.content.Intent;
import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;
import android.os.Debug;
import android.webkit.RenderProcessGoneDetail;
import android.webkit.WebView;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.function.BiConsumer;
import org.apache.cordova.PluginResult;
import org.json.JSONException;

/* JADX INFO: loaded from: classes.dex */
public class PluginManager {
    private static String DEFAULT_HOSTNAME = "localhost";
    private static String SCHEME_HTTPS = "https";
    private static final int SLOW_EXEC_WARNING_THRESHOLD;
    private static String TAG = "PluginManager";
    private final CordovaWebView app;
    private final CordovaInterface ctx;
    private boolean isInitialized;
    private CordovaPlugin permissionRequester;
    private final Map<String, CordovaPlugin> pluginMap = Collections.synchronizedMap(new LinkedHashMap());
    private final Map<String, PluginEntry> entryMap = Collections.synchronizedMap(new LinkedHashMap());

    static {
        SLOW_EXEC_WARNING_THRESHOLD = Debug.isDebuggerConnected() ? 60 : 16;
    }

    public PluginManager(CordovaWebView cordovaWebView, CordovaInterface cordovaInterface, Collection<PluginEntry> collection) {
        this.ctx = cordovaInterface;
        this.app = cordovaWebView;
        setPluginEntries(collection);
    }

    public Collection<PluginEntry> getPluginEntries() {
        return this.entryMap.values();
    }

    public void setPluginEntries(Collection<PluginEntry> collection) {
        if (this.isInitialized) {
            onPause(false);
            onDestroy();
            this.pluginMap.clear();
            this.entryMap.clear();
        }
        Iterator<PluginEntry> it = collection.iterator();
        while (it.hasNext()) {
            addService(it.next());
        }
        if (this.isInitialized) {
            startupPlugins();
        }
    }

    public void init() {
        LOG.d(TAG, "init()");
        this.isInitialized = true;
        onPause(false);
        onDestroy();
        this.pluginMap.clear();
        startupPlugins();
    }

    private void startupPlugins() {
        synchronized (this.entryMap) {
            for (PluginEntry pluginEntry : this.entryMap.values()) {
                if (pluginEntry.onload) {
                    getPlugin(pluginEntry.service);
                } else {
                    LOG.d(TAG, "startupPlugins: put - " + pluginEntry.service);
                    this.pluginMap.put(pluginEntry.service, null);
                }
            }
        }
    }

    public void exec(String str, String str2, String str3, String str4) {
        CordovaPlugin plugin = getPlugin(str);
        if (plugin == null) {
            LOG.d(TAG, "exec() call to unknown plugin: " + str);
            this.app.sendPluginResult(new PluginResult(PluginResult.Status.CLASS_NOT_FOUND_EXCEPTION), str3);
            return;
        }
        CallbackContext callbackContext = new CallbackContext(str3, this.app);
        try {
            long jCurrentTimeMillis = System.currentTimeMillis();
            boolean zExecute = plugin.execute(str2, str4, callbackContext);
            long jCurrentTimeMillis2 = System.currentTimeMillis() - jCurrentTimeMillis;
            if (jCurrentTimeMillis2 > SLOW_EXEC_WARNING_THRESHOLD) {
                LOG.w(TAG, "THREAD WARNING: exec() call to " + str + "." + str2 + " blocked the main thread for " + jCurrentTimeMillis2 + "ms. Plugin should use CordovaInterface.getThreadPool().");
            }
            if (zExecute) {
                return;
            }
            callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.INVALID_ACTION));
        } catch (JSONException unused) {
            callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.JSON_EXCEPTION));
        } catch (Exception e) {
            LOG.e(TAG, "Uncaught exception from plugin", e);
            callbackContext.error(e.getMessage());
        }
    }

    public CordovaPlugin getPlugin(String str) {
        CordovaPlugin cordovaPluginInstantiatePlugin = this.pluginMap.get(str);
        if (cordovaPluginInstantiatePlugin == null) {
            PluginEntry pluginEntry = this.entryMap.get(str);
            if (pluginEntry == null) {
                return null;
            }
            if (pluginEntry.plugin != null) {
                cordovaPluginInstantiatePlugin = pluginEntry.plugin;
            } else {
                cordovaPluginInstantiatePlugin = instantiatePlugin(pluginEntry.pluginClass);
            }
            CordovaInterface cordovaInterface = this.ctx;
            CordovaWebView cordovaWebView = this.app;
            cordovaPluginInstantiatePlugin.privateInitialize(str, cordovaInterface, cordovaWebView, cordovaWebView.getPreferences());
            LOG.d(TAG, "getPlugin - put: " + str);
            this.pluginMap.put(str, cordovaPluginInstantiatePlugin);
        }
        return cordovaPluginInstantiatePlugin;
    }

    public void addService(String str, String str2) {
        addService(str, str2, false);
    }

    public void addService(String str, String str2, boolean z) {
        addService(new PluginEntry(str, str2, z));
    }

    public void addService(PluginEntry pluginEntry) {
        this.entryMap.put(pluginEntry.service, pluginEntry);
        if (pluginEntry.plugin != null) {
            CordovaPlugin cordovaPlugin = pluginEntry.plugin;
            String str = pluginEntry.service;
            CordovaInterface cordovaInterface = this.ctx;
            CordovaWebView cordovaWebView = this.app;
            cordovaPlugin.privateInitialize(str, cordovaInterface, cordovaWebView, cordovaWebView.getPreferences());
            LOG.d(TAG, "addService: put - " + pluginEntry.service);
            this.pluginMap.put(pluginEntry.service, pluginEntry.plugin);
        }
    }

    public void onPause(boolean z) {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null) {
                    cordovaPlugin.onPause(z);
                }
            }
        }
    }

    public boolean onReceivedHttpAuthRequest(CordovaWebView cordovaWebView, ICordovaHttpAuthHandler iCordovaHttpAuthHandler, String str, String str2) {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null && cordovaPlugin.onReceivedHttpAuthRequest(this.app, iCordovaHttpAuthHandler, str, str2)) {
                    return true;
                }
            }
            return false;
        }
    }

    public boolean onReceivedClientCertRequest(CordovaWebView cordovaWebView, ICordovaClientCertRequest iCordovaClientCertRequest) {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null && cordovaPlugin.onReceivedClientCertRequest(this.app, iCordovaClientCertRequest)) {
                    return true;
                }
            }
            return false;
        }
    }

    public void onResume(boolean z) {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null) {
                    cordovaPlugin.onResume(z);
                }
            }
        }
    }

    public void onStart() {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null) {
                    cordovaPlugin.onStart();
                }
            }
        }
    }

    public void onStop() {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null) {
                    cordovaPlugin.onStop();
                }
            }
        }
    }

    public void onDestroy() {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null) {
                    cordovaPlugin.onDestroy();
                }
            }
        }
    }

    public Object postMessage(final String str, final Object obj) {
        LOG.d(TAG, "postMessage: " + str);
        synchronized (this.pluginMap) {
            this.pluginMap.forEach(new BiConsumer() { // from class: org.apache.cordova.PluginManager$$ExternalSyntheticLambda0
                @Override // java.util.function.BiConsumer
                public final void accept(Object obj2, Object obj3) {
                    PluginManager.lambda$postMessage$0(str, obj, (String) obj2, (CordovaPlugin) obj3);
                }
            });
        }
        return this.ctx.onMessage(str, obj);
    }

    static /* synthetic */ void lambda$postMessage$0(String str, Object obj, String str2, CordovaPlugin cordovaPlugin) {
        if (cordovaPlugin != null) {
            cordovaPlugin.onMessage(str, obj);
        }
    }

    public void onNewIntent(Intent intent) {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null) {
                    cordovaPlugin.onNewIntent(intent);
                }
            }
        }
    }

    private String getLaunchUrlPrefix() {
        if (!this.app.getPreferences().getBoolean("AndroidInsecureFileModeEnabled", false)) {
            return this.app.getPreferences().getString("scheme", SCHEME_HTTPS).toLowerCase() + "://" + this.app.getPreferences().getString("hostname", DEFAULT_HOSTNAME).toLowerCase() + '/';
        }
        return "file://";
    }

    public boolean shouldAllowRequest(String str) {
        Boolean boolShouldAllowRequest;
        synchronized (this.entryMap) {
            Iterator<PluginEntry> it = this.entryMap.values().iterator();
            while (it.hasNext()) {
                CordovaPlugin cordovaPlugin = this.pluginMap.get(it.next().service);
                if (cordovaPlugin != null && (boolShouldAllowRequest = cordovaPlugin.shouldAllowRequest(str)) != null) {
                    return boolShouldAllowRequest.booleanValue();
                }
            }
            if (str.startsWith("blob:") || str.startsWith("data:") || str.startsWith("about:blank") || str.startsWith("https://ssl.gstatic.com/accessibility/javascript/android/")) {
                return true;
            }
            if (str.startsWith("file://")) {
                return !str.contains("/app_webview/");
            }
            return false;
        }
    }

    public boolean shouldAllowNavigation(String str) {
        Boolean boolShouldAllowNavigation;
        synchronized (this.entryMap) {
            Iterator<PluginEntry> it = this.entryMap.values().iterator();
            while (it.hasNext()) {
                CordovaPlugin cordovaPlugin = this.pluginMap.get(it.next().service);
                if (cordovaPlugin != null && (boolShouldAllowNavigation = cordovaPlugin.shouldAllowNavigation(str)) != null) {
                    return boolShouldAllowNavigation.booleanValue();
                }
            }
            return str.startsWith(getLaunchUrlPrefix()) || str.startsWith("about:blank");
        }
    }

    public boolean shouldAllowBridgeAccess(String str) {
        Boolean boolShouldAllowBridgeAccess;
        synchronized (this.entryMap) {
            Iterator<PluginEntry> it = this.entryMap.values().iterator();
            while (it.hasNext()) {
                CordovaPlugin cordovaPlugin = this.pluginMap.get(it.next().service);
                if (cordovaPlugin != null && (boolShouldAllowBridgeAccess = cordovaPlugin.shouldAllowBridgeAccess(str)) != null) {
                    return boolShouldAllowBridgeAccess.booleanValue();
                }
            }
            return str.startsWith(getLaunchUrlPrefix());
        }
    }

    public Boolean shouldOpenExternalUrl(String str) {
        Boolean boolShouldOpenExternalUrl;
        synchronized (this.entryMap) {
            Iterator<PluginEntry> it = this.entryMap.values().iterator();
            while (it.hasNext()) {
                CordovaPlugin cordovaPlugin = this.pluginMap.get(it.next().service);
                if (cordovaPlugin != null && (boolShouldOpenExternalUrl = cordovaPlugin.shouldOpenExternalUrl(str)) != null) {
                    return boolShouldOpenExternalUrl;
                }
            }
            return false;
        }
    }

    public boolean onOverrideUrlLoading(String str) {
        synchronized (this.entryMap) {
            Iterator<PluginEntry> it = this.entryMap.values().iterator();
            while (it.hasNext()) {
                CordovaPlugin cordovaPlugin = this.pluginMap.get(it.next().service);
                if (cordovaPlugin != null && cordovaPlugin.onOverrideUrlLoading(str)) {
                    return true;
                }
            }
            return false;
        }
    }

    public void onReset() {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null) {
                    cordovaPlugin.onReset();
                }
            }
        }
    }

    Uri remapUri(Uri uri) {
        Uri uriRemapUri;
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null && (uriRemapUri = cordovaPlugin.remapUri(uri)) != null) {
                    return uriRemapUri;
                }
            }
            return null;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:9:0x0012  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    private org.apache.cordova.CordovaPlugin instantiatePlugin(java.lang.String r6) {
        /*
            r5 = this;
            r0 = 0
            if (r6 == 0) goto L12
            java.lang.String r1 = ""
            boolean r1 = r1.equals(r6)     // Catch: java.lang.Exception -> L10
            if (r1 != 0) goto L12
            java.lang.Class r1 = java.lang.Class.forName(r6)     // Catch: java.lang.Exception -> L10
            goto L13
        L10:
            r1 = move-exception
            goto L31
        L12:
            r1 = r0
        L13:
            r2 = 0
            if (r1 == 0) goto L18
            r3 = 1
            goto L19
        L18:
            r3 = r2
        L19:
            java.lang.Class<org.apache.cordova.CordovaPlugin> r4 = org.apache.cordova.CordovaPlugin.class
            boolean r4 = r4.isAssignableFrom(r1)     // Catch: java.lang.Exception -> L10
            r3 = r3 & r4
            if (r3 == 0) goto L4e
            java.lang.Class[] r3 = new java.lang.Class[r2]     // Catch: java.lang.Exception -> L10
            java.lang.reflect.Constructor r1 = r1.getDeclaredConstructor(r3)     // Catch: java.lang.Exception -> L10
            java.lang.Object[] r2 = new java.lang.Object[r2]     // Catch: java.lang.Exception -> L10
            java.lang.Object r1 = r1.newInstance(r2)     // Catch: java.lang.Exception -> L10
            org.apache.cordova.CordovaPlugin r1 = (org.apache.cordova.CordovaPlugin) r1     // Catch: java.lang.Exception -> L10
            return r1
        L31:
            r1.printStackTrace()
            java.io.PrintStream r1 = java.lang.System.out
            java.lang.StringBuilder r2 = new java.lang.StringBuilder
            java.lang.String r3 = "Error adding plugin "
            r2.<init>(r3)
            java.lang.StringBuilder r6 = r2.append(r6)
            java.lang.String r2 = "."
            java.lang.StringBuilder r6 = r6.append(r2)
            java.lang.String r6 = r6.toString()
            r1.println(r6)
        L4e:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: org.apache.cordova.PluginManager.instantiatePlugin(java.lang.String):org.apache.cordova.CordovaPlugin");
    }

    public void onConfigurationChanged(Configuration configuration) {
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null) {
                    cordovaPlugin.onConfigurationChanged(configuration);
                }
            }
        }
    }

    public Bundle onSaveInstanceState() {
        Bundle bundleOnSaveInstanceState;
        Bundle bundle = new Bundle();
        synchronized (this.pluginMap) {
            for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
                if (cordovaPlugin != null && (bundleOnSaveInstanceState = cordovaPlugin.onSaveInstanceState()) != null) {
                    bundle.putBundle(cordovaPlugin.getServiceName(), bundleOnSaveInstanceState);
                }
            }
        }
        return bundle;
    }

    public ArrayList<CordovaPluginPathHandler> getPluginPathHandlers() {
        ArrayList<CordovaPluginPathHandler> arrayList = new ArrayList<>();
        for (CordovaPlugin cordovaPlugin : this.pluginMap.values()) {
            if (cordovaPlugin != null && cordovaPlugin.getPathHandler() != null) {
                arrayList.add(cordovaPlugin.getPathHandler());
            }
        }
        return arrayList;
    }

    public boolean onRenderProcessGone(WebView webView, RenderProcessGoneDetail renderProcessGoneDetail) {
        boolean z;
        synchronized (this.entryMap) {
            Iterator<PluginEntry> it = this.entryMap.values().iterator();
            z = false;
            while (it.hasNext()) {
                CordovaPlugin cordovaPlugin = this.pluginMap.get(it.next().service);
                if (cordovaPlugin != null && cordovaPlugin.onRenderProcessGone(webView, renderProcessGoneDetail)) {
                    z = true;
                }
            }
        }
        return z;
    }
}
