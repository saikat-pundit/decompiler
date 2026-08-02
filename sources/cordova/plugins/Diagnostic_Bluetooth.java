package cordova.plugins;

import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

/* JADX INFO: loaded from: classes.dex */
public class Diagnostic_Bluetooth extends CordovaPlugin {
    protected static final String BLUETOOTH_STATE_POWERED_OFF = "powered_off";
    protected static final String BLUETOOTH_STATE_POWERED_ON = "powered_on";
    protected static final String BLUETOOTH_STATE_POWERING_OFF = "powering_off";
    protected static final String BLUETOOTH_STATE_POWERING_ON = "powering_on";
    protected static final String BLUETOOTH_STATE_UNKNOWN = "unknown";
    public static final String TAG = "Diagnostic_Bluetooth";
    public static Diagnostic_Bluetooth instance;
    protected CallbackContext currentContext;
    private Diagnostic diagnostic;
    private String currentBluetoothState = null;
    protected final BroadcastReceiver bluetoothStateChangeReceiver = new BroadcastReceiver() { // from class: cordova.plugins.Diagnostic_Bluetooth.1
        @Override // android.content.BroadcastReceiver
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (Diagnostic_Bluetooth.instance == null || !action.equals("android.bluetooth.adapter.action.STATE_CHANGED")) {
                return;
            }
            Log.v(Diagnostic_Bluetooth.TAG, "bluetoothStateChangeReceiver");
            Diagnostic_Bluetooth.instance.notifyBluetoothStateChange();
        }
    };

    @Override // org.apache.cordova.CordovaPlugin
    public void initialize(CordovaInterface cordovaInterface, CordovaWebView cordovaWebView) {
        Log.d(TAG, "initialize()");
        instance = this;
        Diagnostic diagnostic = Diagnostic.getInstance();
        this.diagnostic = diagnostic;
        try {
            diagnostic.applicationContext.registerReceiver(this.bluetoothStateChangeReceiver, new IntentFilter("android.bluetooth.adapter.action.STATE_CHANGED"));
            this.currentBluetoothState = getBluetoothState();
        } catch (Exception e) {
            this.diagnostic.logWarning("Unable to register Bluetooth state change receiver: " + e.getMessage());
        }
        super.initialize(cordovaInterface, cordovaWebView);
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onDestroy() {
        try {
            this.diagnostic.applicationContext.unregisterReceiver(this.bluetoothStateChangeReceiver);
        } catch (Exception e) {
            this.diagnostic.logWarning("Unable to unregister Bluetooth state change receiver: " + e.getMessage());
        }
    }

    @Override // org.apache.cordova.CordovaPlugin
    public boolean execute(String str, JSONArray jSONArray, CallbackContext callbackContext) throws JSONException {
        this.currentContext = callbackContext;
        try {
            if (str.equals("switchToBluetoothSettings")) {
                switchToBluetoothSettings();
                callbackContext.success();
            } else if (str.equals("isBluetoothAvailable")) {
                callbackContext.success(isBluetoothAvailable() ? 1 : 0);
            } else if (str.equals("isBluetoothEnabled")) {
                callbackContext.success(isBluetoothEnabled() ? 1 : 0);
            } else if (str.equals("hasBluetoothSupport")) {
                callbackContext.success(hasBluetoothSupport() ? 1 : 0);
            } else if (str.equals("hasBluetoothLESupport")) {
                callbackContext.success(hasBluetoothLESupport() ? 1 : 0);
            } else if (str.equals("hasBluetoothLEPeripheralSupport")) {
                callbackContext.success(hasBluetoothLEPeripheralSupport() ? 1 : 0);
            } else if (str.equals("setBluetoothState")) {
                setBluetoothState(jSONArray.getBoolean(0));
                callbackContext.success();
            } else if (str.equals("getBluetoothState")) {
                callbackContext.success(getBluetoothState());
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

    public void switchToBluetoothSettings() {
        this.diagnostic.logDebug("Switch to Bluetooth Settings");
        this.f4cordova.getActivity().startActivity(new Intent("android.settings.BLUETOOTH_SETTINGS"));
    }

    public boolean isBluetoothAvailable() {
        return hasBluetoothSupport() && isBluetoothEnabled();
    }

    public boolean isBluetoothEnabled() {
        BluetoothAdapter defaultAdapter = BluetoothAdapter.getDefaultAdapter();
        return defaultAdapter != null && defaultAdapter.isEnabled();
    }

    public boolean hasBluetoothSupport() {
        return this.f4cordova.getActivity().getPackageManager().hasSystemFeature("android.hardware.bluetooth");
    }

    public boolean hasBluetoothLESupport() {
        return this.f4cordova.getActivity().getPackageManager().hasSystemFeature("android.hardware.bluetooth_le");
    }

    public boolean hasBluetoothLEPeripheralSupport() {
        BluetoothAdapter defaultAdapter = BluetoothAdapter.getDefaultAdapter();
        return defaultAdapter != null && defaultAdapter.isMultipleAdvertisementSupported();
    }

    public static boolean setBluetoothState(boolean z) {
        BluetoothAdapter defaultAdapter = BluetoothAdapter.getDefaultAdapter();
        boolean zIsEnabled = defaultAdapter.isEnabled();
        if (z && !zIsEnabled) {
            return defaultAdapter.enable();
        }
        if (z || !zIsEnabled) {
            return true;
        }
        return defaultAdapter.disable();
    }

    public String getBluetoothState() {
        if (hasBluetoothSupport()) {
            BluetoothAdapter defaultAdapter = BluetoothAdapter.getDefaultAdapter();
            if (defaultAdapter == null) {
                this.diagnostic.logWarning("Bluetooth adapter unavailable or not found");
                return "unknown";
            }
            switch (defaultAdapter.getState()) {
            }
            return "unknown";
        }
        return "unknown";
    }

    public void notifyBluetoothStateChange() {
        try {
            String bluetoothState = getBluetoothState();
            if (bluetoothState.equals(this.currentBluetoothState)) {
                return;
            }
            this.diagnostic.logDebug("Bluetooth state changed to: " + bluetoothState);
            this.diagnostic.executePluginJavascript("bluetooth._onBluetoothStateChange(\"" + bluetoothState + "\");");
            this.currentBluetoothState = bluetoothState;
        } catch (Exception e) {
            this.diagnostic.logError("Error retrieving current Bluetooth state on Bluetooth state change: " + e.toString());
        }
    }
}
