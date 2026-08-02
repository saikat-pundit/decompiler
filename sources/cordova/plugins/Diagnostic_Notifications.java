package cordova.plugins;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.util.Log;
import androidx.core.app.NotificationManagerCompat;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

/* JADX INFO: loaded from: classes.dex */
public class Diagnostic_Notifications extends CordovaPlugin {
    public static final String TAG = "Diagnostic_Notifications";
    public static Diagnostic_Notifications instance;
    protected CallbackContext currentContext;
    private Diagnostic diagnostic;

    @Override // org.apache.cordova.CordovaPlugin
    public void initialize(CordovaInterface cordovaInterface, CordovaWebView cordovaWebView) {
        Log.d(TAG, "initialize()");
        instance = this;
        this.diagnostic = Diagnostic.getInstance();
        super.initialize(cordovaInterface, cordovaWebView);
    }

    @Override // org.apache.cordova.CordovaPlugin
    public boolean execute(String str, JSONArray jSONArray, CallbackContext callbackContext) throws JSONException {
        this.currentContext = callbackContext;
        try {
            if (str.equals("isRemoteNotificationsEnabled")) {
                callbackContext.success(isRemoteNotificationsEnabled() ? 1 : 0);
            } else if (str.equals("switchToNotificationSettings")) {
                switchToNotificationSettings();
                callbackContext.success();
            } else {
                this.diagnostic.handleError("Invalid action");
                return false;
            }
            return true;
        } catch (Exception e) {
            this.diagnostic.handleError("Exception occurred: ".concat(e.getMessage()));
            return false;
        }
    }

    public boolean isRemoteNotificationsEnabled() {
        return NotificationManagerCompat.from(this.f4cordova.getActivity().getApplicationContext()).areNotificationsEnabled();
    }

    public void switchToNotificationSettings() {
        Context applicationContext = this.f4cordova.getActivity().getApplicationContext();
        Intent intent = new Intent();
        String packageName = applicationContext.getPackageName();
        if (Build.VERSION.SDK_INT >= 26) {
            this.diagnostic.logDebug("Switch to notification Settings");
            intent.setAction("android.settings.APP_NOTIFICATION_SETTINGS");
            intent.putExtra("android.provider.extra.APP_PACKAGE", packageName);
        } else {
            intent.setAction("android.settings.APPLICATION_DETAILS_SETTINGS");
            intent.setData(Uri.parse("package:" + packageName));
            this.diagnostic.logDebug("Switch to notification Settings: Only possible on android O or above. Falling back to application details");
        }
        this.f4cordova.getActivity().startActivity(intent);
    }
}
