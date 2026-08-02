package cordova.plugins;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.BatteryManager;
import android.os.Build;
import android.provider.Settings;
import android.util.Log;
import androidx.core.app.ActivityCompat;
import androidx.core.app.NotificationCompat;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import kotlin.time.DurationKt;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class Diagnostic extends CordovaPlugin {
    public static final String CPU_ARCH_ARMv6 = "ARMv6";
    public static final String CPU_ARCH_ARMv7 = "ARMv7";
    public static final String CPU_ARCH_ARMv8 = "ARMv8";
    public static final String CPU_ARCH_MIPS = "MIPS";
    public static final String CPU_ARCH_MIPS_64 = "MIPS_64";
    public static final String CPU_ARCH_UNKNOWN = "unknown";
    public static final String CPU_ARCH_X86 = "X86";
    public static final String CPU_ARCH_X86_64 = "X86_64";
    protected static final Integer GET_EXTERNAL_SD_CARD_DETAILS_PERMISSION_REQUEST;
    protected static final String STATUS_DENIED_ALWAYS = "DENIED_ALWAYS";
    protected static final String STATUS_DENIED_ONCE = "DENIED_ONCE";
    protected static final String STATUS_GRANTED = "GRANTED";
    protected static final String STATUS_NOT_REQUESTED = "NOT_REQUESTED";
    public static final String TAG = "Diagnostic";
    protected static final String externalStorageClassName = "cordova.plugins.Diagnostic_External_Storage";
    public static Diagnostic instance;
    protected static final Map<String, String> permissionsMap;
    protected Context applicationContext;
    protected CallbackContext currentContext;
    protected SharedPreferences.Editor editor;
    protected SharedPreferences sharedPref;
    protected HashMap<String, CallbackContext> callbackContexts = new HashMap<>();
    protected HashMap<String, JSONObject> permissionStatuses = new HashMap<>();
    boolean debugEnabled = false;

    static {
        HashMap map = new HashMap();
        addBiDirMapEntry(map, "READ_CALENDAR", "android.permission.READ_CALENDAR");
        addBiDirMapEntry(map, "WRITE_CALENDAR", "android.permission.WRITE_CALENDAR");
        addBiDirMapEntry(map, "CAMERA", "android.permission.CAMERA");
        addBiDirMapEntry(map, "READ_CONTACTS", "android.permission.READ_CONTACTS");
        addBiDirMapEntry(map, "WRITE_CONTACTS", "android.permission.WRITE_CONTACTS");
        addBiDirMapEntry(map, "GET_ACCOUNTS", "android.permission.GET_ACCOUNTS");
        addBiDirMapEntry(map, "ACCESS_FINE_LOCATION", "android.permission.ACCESS_FINE_LOCATION");
        addBiDirMapEntry(map, "ACCESS_COARSE_LOCATION", "android.permission.ACCESS_COARSE_LOCATION");
        addBiDirMapEntry(map, "ACCESS_BACKGROUND_LOCATION", "android.permission.ACCESS_BACKGROUND_LOCATION");
        addBiDirMapEntry(map, "RECORD_AUDIO", "android.permission.RECORD_AUDIO");
        addBiDirMapEntry(map, "READ_PHONE_STATE", "android.permission.READ_PHONE_STATE");
        addBiDirMapEntry(map, "CALL_PHONE", "android.permission.CALL_PHONE");
        addBiDirMapEntry(map, "ADD_VOICEMAIL", "com.android.voicemail.permission.ADD_VOICEMAIL");
        addBiDirMapEntry(map, "USE_SIP", "android.permission.USE_SIP");
        addBiDirMapEntry(map, "PROCESS_OUTGOING_CALLS", "android.permission.PROCESS_OUTGOING_CALLS");
        addBiDirMapEntry(map, "SEND_SMS", "android.permission.SEND_SMS");
        addBiDirMapEntry(map, "RECEIVE_SMS", "android.permission.RECEIVE_SMS");
        addBiDirMapEntry(map, "READ_SMS", "android.permission.READ_SMS");
        addBiDirMapEntry(map, "RECEIVE_WAP_PUSH", "android.permission.RECEIVE_WAP_PUSH");
        addBiDirMapEntry(map, "RECEIVE_MMS", "android.permission.RECEIVE_MMS");
        addBiDirMapEntry(map, "WRITE_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE");
        addBiDirMapEntry(map, "READ_CALL_LOG", "android.permission.READ_CALL_LOG");
        addBiDirMapEntry(map, "WRITE_CALL_LOG", "android.permission.WRITE_CALL_LOG");
        addBiDirMapEntry(map, "READ_EXTERNAL_STORAGE", "android.permission.READ_EXTERNAL_STORAGE");
        addBiDirMapEntry(map, "BODY_SENSORS", "android.permission.BODY_SENSORS");
        addBiDirMapEntry(map, "ACTIVITY_RECOGNITION", "android.permission.ACTIVITY_RECOGNITION");
        permissionsMap = Collections.unmodifiableMap(map);
        GET_EXTERNAL_SD_CARD_DETAILS_PERMISSION_REQUEST = 1000;
        instance = null;
    }

    public static Diagnostic getInstance() {
        return instance;
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void initialize(CordovaInterface cordovaInterface, CordovaWebView cordovaWebView) {
        Log.d(TAG, "initialize()");
        instance = this;
        this.applicationContext = this.f4cordova.getActivity().getApplicationContext();
        SharedPreferences sharedPreferences = cordovaInterface.getActivity().getSharedPreferences(TAG, 0);
        this.sharedPref = sharedPreferences;
        this.editor = sharedPreferences.edit();
        super.initialize(cordovaInterface, cordovaWebView);
    }

    @Override // org.apache.cordova.CordovaPlugin
    public boolean execute(String str, JSONArray jSONArray, CallbackContext callbackContext) throws JSONException {
        this.currentContext = callbackContext;
        try {
            if (str.equals("enableDebug")) {
                this.debugEnabled = true;
                logDebug("Debug enabled");
                callbackContext.success();
            } else if (str.equals("switchToSettings")) {
                switchToAppSettings();
                callbackContext.success();
            } else if (str.equals("switchToMobileDataSettings")) {
                switchToMobileDataSettings();
                callbackContext.success();
            } else if (str.equals("switchToWirelessSettings")) {
                switchToWirelessSettings();
                callbackContext.success();
            } else if (str.equals("isDataRoamingEnabled")) {
                callbackContext.success(isDataRoamingEnabled() ? 1 : 0);
            } else if (str.equals("getPermissionAuthorizationStatus")) {
                getPermissionAuthorizationStatus(jSONArray);
            } else if (str.equals("getPermissionsAuthorizationStatus")) {
                getPermissionsAuthorizationStatus(jSONArray);
            } else if (str.equals("requestRuntimePermission")) {
                requestRuntimePermission(jSONArray);
            } else if (str.equals("requestRuntimePermissions")) {
                requestRuntimePermissions(jSONArray);
            } else if (str.equals("isADBModeEnabled")) {
                callbackContext.success(isADBModeEnabled() ? 1 : 0);
            } else if (str.equals("isDeviceRooted")) {
                callbackContext.success(isDeviceRooted() ? 1 : 0);
            } else if (str.equals("restart")) {
                restart(jSONArray);
            } else if (str.equals("getArchitecture")) {
                callbackContext.success(getCPUArchitecture());
            } else if (str.equals("getCurrentBatteryLevel")) {
                callbackContext.success(getCurrentBatteryLevel());
            } else {
                handleError("Invalid action");
                return false;
            }
            return true;
        } catch (Exception e) {
            handleError("Exception occurred: ".concat(e.getMessage()));
            return false;
        }
    }

    public void restart(JSONArray jSONArray) throws Exception {
        if (jSONArray.getBoolean(0)) {
            doColdRestart();
        } else {
            doWarmRestart();
        }
    }

    public boolean isDataRoamingEnabled() throws Exception {
        return Settings.Global.getInt(this.f4cordova.getActivity().getContentResolver(), "data_roaming", 0) == 1;
    }

    public void switchToAppSettings() {
        logDebug("Switch to App Settings");
        Intent intent = new Intent("android.settings.APPLICATION_DETAILS_SETTINGS");
        intent.setData(Uri.fromParts("package", this.f4cordova.getActivity().getPackageName(), null));
        this.f4cordova.getActivity().startActivity(intent);
    }

    public void switchToMobileDataSettings() {
        logDebug("Switch to Mobile Data Settings");
        this.f4cordova.getActivity().startActivity(new Intent("android.settings.DATA_ROAMING_SETTINGS"));
    }

    public void switchToWirelessSettings() {
        logDebug("Switch to wireless Settings");
        this.f4cordova.getActivity().startActivity(new Intent("android.settings.WIRELESS_SETTINGS"));
    }

    public void getPermissionsAuthorizationStatus(JSONArray jSONArray) throws Exception {
        this.currentContext.success(_getPermissionsAuthorizationStatus(jsonArrayToStringArray(jSONArray.getJSONArray(0))));
    }

    public void getPermissionAuthorizationStatus(JSONArray jSONArray) throws Exception {
        String string = jSONArray.getString(0);
        JSONArray jSONArray2 = new JSONArray();
        jSONArray2.put(string);
        this.currentContext.success(_getPermissionsAuthorizationStatus(jsonArrayToStringArray(jSONArray2)).getString(string));
    }

    public void requestRuntimePermissions(JSONArray jSONArray) throws Exception {
        _requestRuntimePermissions(jSONArray.getJSONArray(0), storeContextByRequestId());
    }

    public void requestRuntimePermission(JSONArray jSONArray) throws Exception {
        requestRuntimePermission(jSONArray.getString(0));
    }

    public void requestRuntimePermission(String str) throws Exception {
        requestRuntimePermission(str, storeContextByRequestId());
    }

    public void requestRuntimePermission(String str, int i) throws Exception {
        JSONArray jSONArray = new JSONArray();
        jSONArray.put(str);
        _requestRuntimePermissions(jSONArray, i);
    }

    public int getADBMode() {
        return Settings.Global.getInt(this.applicationContext.getContentResolver(), "adb_enabled", 0);
    }

    public boolean isADBModeEnabled() {
        boolean z = false;
        try {
            if (getADBMode() == 1) {
                z = true;
            }
        } catch (Exception e) {
            logError(e.getMessage());
        }
        logDebug("ADB mode enabled: " + z);
        return z;
    }

    /* JADX WARN: Removed duplicated region for block: B:29:0x0097 A[PHI: r3
      0x0097: PHI (r3v6 java.lang.Process) = (r3v5 java.lang.Process), (r3v7 java.lang.Process) binds: [B:28:0x0095, B:22:0x0088] A[DONT_GENERATE, DONT_INLINE]] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    public boolean isDeviceRooted() {
        /*
            r8 = this;
            java.lang.String r0 = android.os.Build.TAGS
            r1 = 1
            if (r0 == 0) goto Le
            java.lang.String r2 = "test-keys"
            boolean r0 = r0.contains(r2)
            if (r0 == 0) goto Le
            return r1
        Le:
            r0 = 2
            r2 = 0
            r3 = 9
            java.lang.String[] r4 = new java.lang.String[r3]     // Catch: java.lang.Exception -> L53
            java.lang.String r5 = "/system/app/Superuser.apk"
            r4[r2] = r5     // Catch: java.lang.Exception -> L53
            java.lang.String r5 = "/sbin/su"
            r4[r1] = r5     // Catch: java.lang.Exception -> L53
            java.lang.String r5 = "/system/bin/su"
            r4[r0] = r5     // Catch: java.lang.Exception -> L53
            java.lang.String r5 = "/system/xbin/su"
            r6 = 3
            r4[r6] = r5     // Catch: java.lang.Exception -> L53
            java.lang.String r5 = "/data/local/xbin/su"
            r6 = 4
            r4[r6] = r5     // Catch: java.lang.Exception -> L53
            java.lang.String r5 = "/data/local/bin/su"
            r6 = 5
            r4[r6] = r5     // Catch: java.lang.Exception -> L53
            java.lang.String r5 = "/system/sd/xbin/su"
            r6 = 6
            r4[r6] = r5     // Catch: java.lang.Exception -> L53
            java.lang.String r5 = "/system/bin/failsafe/su"
            r6 = 7
            r4[r6] = r5     // Catch: java.lang.Exception -> L53
            java.lang.String r5 = "/data/local/su"
            r6 = 8
            r4[r6] = r5     // Catch: java.lang.Exception -> L53
            r5 = r2
        L40:
            if (r5 >= r3) goto L5b
            r6 = r4[r5]     // Catch: java.lang.Exception -> L53
            java.io.File r7 = new java.io.File     // Catch: java.lang.Exception -> L53
            r7.<init>(r6)     // Catch: java.lang.Exception -> L53
            boolean r6 = r7.exists()     // Catch: java.lang.Exception -> L53
            if (r6 == 0) goto L50
            return r1
        L50:
            int r5 = r5 + 1
            goto L40
        L53:
            r3 = move-exception
            java.lang.String r3 = r3.getMessage()
            r8.logDebug(r3)
        L5b:
            r3 = 0
            java.lang.Runtime r4 = java.lang.Runtime.getRuntime()     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            java.lang.String[] r0 = new java.lang.String[r0]     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            java.lang.String r5 = "/system/xbin/which"
            r0[r2] = r5     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            java.lang.String r5 = "su"
            r0[r1] = r5     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            java.lang.Process r3 = r4.exec(r0)     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            java.io.BufferedReader r0 = new java.io.BufferedReader     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            java.io.InputStreamReader r4 = new java.io.InputStreamReader     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            java.io.InputStream r5 = r3.getInputStream()     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            r4.<init>(r5)     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            r0.<init>(r4)     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            java.lang.String r0 = r0.readLine()     // Catch: java.lang.Throwable -> L8b java.lang.Exception -> L8d
            if (r0 == 0) goto L88
            if (r3 == 0) goto L87
            r3.destroy()
        L87:
            return r1
        L88:
            if (r3 == 0) goto L9a
            goto L97
        L8b:
            r0 = move-exception
            goto L9b
        L8d:
            r0 = move-exception
            java.lang.String r0 = r0.getMessage()     // Catch: java.lang.Throwable -> L8b
            r8.logDebug(r0)     // Catch: java.lang.Throwable -> L8b
            if (r3 == 0) goto L9a
        L97:
            r3.destroy()
        L9a:
            return r2
        L9b:
            if (r3 == 0) goto La0
            r3.destroy()
        La0:
            throw r0
        */
        throw new UnsupportedOperationException("Method not decompiled: cordova.plugins.Diagnostic.isDeviceRooted():boolean");
    }

    public void logDebug(String str) {
        if (this.debugEnabled) {
            Log.d(TAG, str);
            executeGlobalJavascript("console.log(\"Diagnostic[native]: " + escapeDoubleQuotes(str) + "\")");
        }
    }

    public void logInfo(String str) {
        Log.i(TAG, str);
        if (this.debugEnabled) {
            executeGlobalJavascript("console.info(\"Diagnostic[native]: " + escapeDoubleQuotes(str) + "\")");
        }
    }

    public void logWarning(String str) {
        Log.w(TAG, str);
        if (this.debugEnabled) {
            executeGlobalJavascript("console.warn(\"Diagnostic[native]: " + escapeDoubleQuotes(str) + "\")");
        }
    }

    public void logError(String str) {
        Log.e(TAG, str);
        if (this.debugEnabled) {
            executeGlobalJavascript("console.error(\"Diagnostic[native]: " + escapeDoubleQuotes(str) + "\")");
        }
    }

    public String escapeDoubleQuotes(String str) {
        return str.replace("\"", "\\\"").replace("%22", "\\%22");
    }

    public void handleError(String str, CallbackContext callbackContext) {
        try {
            logError(str);
            callbackContext.error(str);
        } catch (Exception e) {
            logError(e.toString());
        }
    }

    public void handleError(String str) {
        handleError(str, this.currentContext);
    }

    public void handleError(String str, int i) {
        CallbackContext callbackContext;
        String strValueOf = String.valueOf(i);
        if (this.callbackContexts.containsKey(strValueOf)) {
            callbackContext = this.callbackContexts.get(strValueOf);
        } else {
            callbackContext = this.currentContext;
        }
        handleError(str, callbackContext);
        clearRequest(i);
    }

    protected JSONObject _getPermissionsAuthorizationStatus(String[] strArr) throws Exception {
        JSONObject jSONObject = new JSONObject();
        for (int i = 0; i < strArr.length; i++) {
            String str = strArr[i];
            Map<String, String> map = permissionsMap;
            if (!map.containsKey(str)) {
                throw new Exception("Permission name '" + str + "' is not a valid permission");
            }
            if (Build.VERSION.SDK_INT < 29 && str.equals("ACCESS_BACKGROUND_LOCATION")) {
                str = "ACCESS_COARSE_LOCATION";
            }
            if (Build.VERSION.SDK_INT < 29 && str.equals("ACTIVITY_RECOGNITION")) {
                str = "BODY_SENSORS";
            }
            String str2 = map.get(str);
            Log.v(TAG, "Get authorisation status for " + str2);
            if (hasPermission(str2)) {
                jSONObject.put(str, STATUS_GRANTED);
            } else if (!shouldShowRequestPermissionRationale(this.f4cordova.getActivity(), str2)) {
                if (isPermissionRequested(str)) {
                    jSONObject.put(str, STATUS_DENIED_ALWAYS);
                } else {
                    jSONObject.put(str, STATUS_NOT_REQUESTED);
                }
            } else {
                jSONObject.put(str, STATUS_DENIED_ONCE);
            }
        }
        return jSONObject;
    }

    protected void _requestRuntimePermissions(JSONArray jSONArray, int i) throws Exception {
        JSONObject jSONObject_getPermissionsAuthorizationStatus = _getPermissionsAuthorizationStatus(jsonArrayToStringArray(jSONArray));
        JSONArray jSONArray2 = new JSONArray();
        for (int i2 = 0; i2 < jSONObject_getPermissionsAuthorizationStatus.names().length(); i2++) {
            String string = jSONObject_getPermissionsAuthorizationStatus.names().getString(i2);
            if (jSONObject_getPermissionsAuthorizationStatus.getString(string) == STATUS_GRANTED) {
                Log.d(TAG, "Permission already granted for " + string);
                JSONObject jSONObject = this.permissionStatuses.get(String.valueOf(i));
                jSONObject.put(string, STATUS_GRANTED);
                this.permissionStatuses.put(String.valueOf(i), jSONObject);
            } else {
                String str = permissionsMap.get(string);
                Log.d(TAG, "Requesting permission for " + str);
                jSONArray2.put(str);
            }
        }
        if (jSONArray2.length() > 0) {
            Log.v(TAG, "Requesting permissions");
            requestPermissions(this, i, jsonArrayToStringArray(jSONArray2));
        } else {
            Log.d(TAG, "No permissions to request: returning result");
            sendRuntimeRequestResult(i);
        }
    }

    protected void sendRuntimeRequestResult(int i) {
        String strValueOf = String.valueOf(i);
        CallbackContext callbackContext = this.callbackContexts.get(strValueOf);
        JSONObject jSONObject = this.permissionStatuses.get(strValueOf);
        Log.v(TAG, "Sending runtime request result for id=" + strValueOf);
        callbackContext.success(jSONObject);
    }

    protected int storeContextByRequestId() {
        return storeContextByRequestId(this.currentContext);
    }

    protected int storeContextByRequestId(CallbackContext callbackContext) {
        String strGenerateRandomRequestId = generateRandomRequestId();
        this.callbackContexts.put(strGenerateRandomRequestId, callbackContext);
        this.permissionStatuses.put(strGenerateRandomRequestId, new JSONObject());
        return Integer.valueOf(strGenerateRandomRequestId).intValue();
    }

    protected String generateRandomRequestId() {
        while (true) {
            String strGenerateRandom = null;
            while (strGenerateRandom == null) {
                strGenerateRandom = generateRandom();
                if (this.callbackContexts.containsKey(strGenerateRandom)) {
                    break;
                }
            }
            return strGenerateRandom;
        }
    }

    protected String generateRandom() {
        return Integer.toString(new Random().nextInt(DurationKt.NANOS_IN_MILLIS) + 1);
    }

    protected String[] jsonArrayToStringArray(JSONArray jSONArray) throws JSONException {
        if (jSONArray == null) {
            return null;
        }
        int length = jSONArray.length();
        String[] strArr = new String[length];
        for (int i = 0; i < length; i++) {
            strArr[i] = jSONArray.optString(i);
        }
        return strArr;
    }

    protected CallbackContext getContextById(String str) throws Exception {
        if (!this.callbackContexts.containsKey(str)) {
            throw new Exception("No context found for request id=" + str);
        }
        return this.callbackContexts.get(str);
    }

    protected void clearRequest(int i) {
        String strValueOf = String.valueOf(i);
        if (this.callbackContexts.containsKey(strValueOf)) {
            this.callbackContexts.remove(strValueOf);
            this.permissionStatuses.remove(strValueOf);
        }
    }

    protected static void addBiDirMapEntry(Map map, Object obj, Object obj2) {
        map.put(obj, obj2);
        map.put(obj2, obj);
    }

    protected boolean hasPermission(String str) throws Exception {
        try {
            return ((Boolean) this.f4cordova.getClass().getMethod("hasPermission", str.getClass()).invoke(this.f4cordova, str)).booleanValue();
        } catch (NoSuchMethodException unused) {
            logWarning("Cordova v15.0.0 does not support runtime permissions so defaulting to GRANTED for " + str);
            return true;
        }
    }

    protected void requestPermissions(CordovaPlugin cordovaPlugin, int i, String[] strArr) throws Exception {
        try {
            this.f4cordova.getClass().getMethod("requestPermissions", CordovaPlugin.class, Integer.TYPE, String[].class).invoke(this.f4cordova, cordovaPlugin, Integer.valueOf(i), strArr);
            for (String str : strArr) {
                setPermissionRequested(permissionsMap.get(str));
            }
        } catch (NoSuchMethodException unused) {
            throw new Exception("requestPermissions() method not found in CordovaInterface implementation of Cordova v15.0.0");
        }
    }

    protected boolean shouldShowRequestPermissionRationale(Activity activity, String str) throws Exception {
        try {
            return ((Boolean) ActivityCompat.class.getMethod("shouldShowRequestPermissionRationale", Activity.class, String.class).invoke(null, activity, str)).booleanValue();
        } catch (NoSuchMethodException unused) {
            throw new Exception("shouldShowRequestPermissionRationale() method not found in ActivityCompat class.");
        }
    }

    public void executeGlobalJavascript(final String str) {
        this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: cordova.plugins.Diagnostic.1
            @Override // java.lang.Runnable
            public void run() {
                Diagnostic.this.webView.loadUrl("javascript:" + str);
            }
        });
    }

    public void executePluginJavascript(String str) {
        executeGlobalJavascript("cordova.plugins.diagnostic." + str);
    }

    protected void doWarmRestart() {
        this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: cordova.plugins.Diagnostic.2
            @Override // java.lang.Runnable
            public void run() {
                try {
                    Diagnostic.this.logInfo("Warm restarting main activity");
                    Diagnostic.instance.f4cordova.getActivity().recreate();
                } catch (Exception e) {
                    Diagnostic.this.handleError("Unable to warm restart main activity: " + e.getMessage());
                }
            }
        });
    }

    protected void doColdRestart() {
        try {
            logInfo("Cold restarting application");
            Context context = this.applicationContext;
            if (context != null) {
                PackageManager packageManager = context.getPackageManager();
                if (packageManager != null) {
                    Intent launchIntentForPackage = packageManager.getLaunchIntentForPackage(context.getPackageName());
                    if (launchIntentForPackage != null) {
                        ((AlarmManager) context.getSystemService(NotificationCompat.CATEGORY_ALARM)).set(1, System.currentTimeMillis() + 100, PendingIntent.getActivity(context, 223344, launchIntentForPackage, 268435456));
                        Log.i(TAG, "Killing application for cold restart");
                        System.exit(0);
                        return;
                    }
                    handleError("Unable to cold restart application: StartActivity is null");
                    return;
                }
                handleError("Unable to cold restart application: PackageManager is null");
                return;
            }
            handleError("Unable to cold restart application: Context is null");
        } catch (Exception e) {
            handleError("Unable to cold restart application: " + e.getMessage());
        }
    }

    protected String getCPUArchitecture() {
        String str = Build.SUPPORTED_ABIS[0];
        if (str == "armeabi") {
            return CPU_ARCH_ARMv6;
        }
        if (str.equals("armeabi-v7a")) {
            return CPU_ARCH_ARMv7;
        }
        if (str.equals("arm64-v8a")) {
            return CPU_ARCH_ARMv8;
        }
        if (str.equals("x86")) {
            return CPU_ARCH_X86;
        }
        if (str.equals("x86_64")) {
            return CPU_ARCH_X86_64;
        }
        if (str.equals("mips")) {
            return CPU_ARCH_MIPS;
        }
        if (str.equals("mips64")) {
            return CPU_ARCH_MIPS_64;
        }
        return "unknown";
    }

    protected void setPermissionRequested(String str) {
        this.editor.putBoolean(str, true);
        if (this.editor.commit()) {
            return;
        }
        handleError("Failed to set permission requested flag for " + str);
    }

    protected boolean isPermissionRequested(String str) {
        return this.sharedPref.getBoolean(str, false);
    }

    protected int getCurrentBatteryLevel() {
        return ((BatteryManager) this.f4cordova.getContext().getApplicationContext().getSystemService("batterymanager")).getIntProperty(4);
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onRequestPermissionResult(int i, String[] strArr, int[] iArr) throws JSONException {
        Class<?> cls;
        String str;
        String strValueOf = String.valueOf(i);
        Log.v(TAG, "Received result for permissions request id=" + strValueOf);
        try {
            CallbackContext contextById = getContextById(strValueOf);
            JSONObject jSONObject = this.permissionStatuses.get(strValueOf);
            int length = strArr.length;
            for (int i2 = 0; i2 < length; i2++) {
                String str2 = strArr[i2];
                String str3 = permissionsMap.get(str2);
                if (Build.VERSION.SDK_INT < 29 && str3.equals("ACCESS_BACKGROUND_LOCATION")) {
                    str3 = "ACCESS_COARSE_LOCATION";
                }
                if (Build.VERSION.SDK_INT < 29 && str3.equals("ACTIVITY_RECOGNITION")) {
                    str3 = "BODY_SENSORS";
                }
                if (iArr[i2] == -1) {
                    if (!shouldShowRequestPermissionRationale(this.f4cordova.getActivity(), str2)) {
                        if (isPermissionRequested(str3)) {
                            str = STATUS_DENIED_ALWAYS;
                        } else {
                            str = STATUS_NOT_REQUESTED;
                        }
                    } else {
                        str = STATUS_DENIED_ONCE;
                    }
                } else {
                    str = STATUS_GRANTED;
                }
                jSONObject.put(str3, str);
                Log.v(TAG, "Authorisation for " + str3 + " is " + jSONObject.get(str3));
                clearRequest(i);
            }
            try {
                cls = Class.forName(externalStorageClassName);
            } catch (ClassNotFoundException unused) {
                cls = null;
            }
            if (i == GET_EXTERNAL_SD_CARD_DETAILS_PERMISSION_REQUEST.intValue() && cls != null) {
                cls.getMethod("onReceivePermissionResult", new Class[0]).invoke(null, new Object[0]);
            } else {
                contextById.success(jSONObject);
            }
        } catch (Exception e) {
            handleError("Exception occurred onRequestPermissionsResult: ".concat(e.getMessage()), i);
        }
    }
}
