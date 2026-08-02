package cordova.plugin;

import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentSender;
import android.os.Bundle;
import android.util.Log;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.ResultCallback;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.LocationSettingsRequest;
import com.google.android.gms.location.LocationSettingsResult;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class RequestLocationAccuracy extends CordovaPlugin implements GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener, ResultCallback<LocationSettingsResult> {
    protected static final int ERROR_CANNOT_CHANGE_ACCURACY = 3;
    protected static final int ERROR_EXCEPTION = 2;
    protected static final int ERROR_GOOGLE_API_CONNECTION_FAILED = 5;
    protected static final int ERROR_INVALID_ACCURACY = 1;
    protected static final int ERROR_INVALID_ACTION = 0;
    protected static final int ERROR_USER_DISAGREED = 4;
    protected static final int REQUEST_CHECK_SETTINGS = 1;
    protected static final int REQUEST_PRIORITY_BALANCED_POWER_ACCURACY = 2;
    protected static final int REQUEST_PRIORITY_HIGH_ACCURACY = 3;
    protected static final int REQUEST_PRIORITY_LOW_POWER = 1;
    protected static final int REQUEST_PRIORITY_NO_POWER = 0;
    protected static final int SUCCESS_SETTINGS_SATISFIED = 0;
    protected static final int SUCCESS_USER_AGREED = 1;
    public static final String TAG = "RequestLocationAccuracy";
    protected GoogleApiAvailability googleApiAvailability;
    protected LocationRequest mLocationRequest;
    protected LocationSettingsRequest mLocationSettingsRequest;
    protected GoogleApiClient mGoogleApiClient = null;
    protected CallbackContext context = null;
    protected ConnectionResult permanentError = null;

    @Override // org.apache.cordova.CordovaPlugin
    public void initialize(CordovaInterface cordovaInterface, CordovaWebView cordovaWebView) {
        super.initialize(cordovaInterface, cordovaWebView);
        try {
            this.googleApiAvailability = GoogleApiAvailability.getInstance();
            buildGoogleApiClient();
        } catch (Exception e) {
            handleError(e.getMessage(), 2);
        }
    }

    @Override // org.apache.cordova.CordovaPlugin
    public boolean execute(String str, JSONArray jSONArray, CallbackContext callbackContext) throws JSONException {
        this.context = callbackContext;
        try {
            if (str.equals("request")) {
                return request(jSONArray.getInt(0));
            }
            if (str.equals("canRequest")) {
                return canRequest();
            }
            handleError("Invalid action", 0);
            return false;
        } catch (Exception e) {
            handleError(e.getMessage(), 2);
            return false;
        }
    }

    public boolean request(int i) throws Exception {
        int i2;
        ConnectionResult connectionResult = this.permanentError;
        if (connectionResult != null) {
            onConnectionFailed(connectionResult);
            return true;
        }
        if (this.mGoogleApiClient == null) {
            handleError("Google Play Services Client failed to initialize", 5);
            return true;
        }
        if (i == 0) {
            i2 = LocationRequest.PRIORITY_NO_POWER;
        } else if (i == 1) {
            i2 = 104;
        } else if (i == 2) {
            i2 = 102;
        } else {
            if (i != 3) {
                handleError("'" + i + "' is not a valid accuracy constant", 1);
                return false;
            }
            i2 = 100;
        }
        createLocationRequest(i2);
        buildLocationSettingsRequest();
        checkLocationSettings();
        return true;
    }

    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    public boolean canRequest() throws Exception {
        this.context.success(isLocationAuthorized() ? 1 : 0);
        return true;
    }

    private boolean isLocationAuthorized() throws Exception {
        boolean z = hasPermission("android.permission.ACCESS_FINE_LOCATION") || hasPermission("android.permission.ACCESS_COARSE_LOCATION");
        Log.v(TAG, "Location permission is ".concat(z ? "authorized" : "unauthorized"));
        return z;
    }

    private boolean hasPermission(String str) throws Exception {
        try {
            return ((Boolean) this.f4cordova.getClass().getMethod("hasPermission", str.getClass()).invoke(this.f4cordova, str)).booleanValue();
        } catch (NoSuchMethodException unused) {
            Log.w(TAG, "Cordova v15.0.0 does not support runtime permissions so defaulting to GRANTED for " + str);
            return true;
        }
    }

    protected void handleError(String str, int i) {
        try {
            Log.e(TAG, str);
            if (this.context != null) {
                JSONObject jSONObject = new JSONObject();
                jSONObject.put("message", str);
                jSONObject.put("code", i);
                this.context.error(jSONObject);
            }
        } catch (JSONException e) {
            Log.e(TAG, e.toString());
        }
    }

    protected void handleSuccess(String str, int i) {
        try {
            Log.i(TAG, str);
            if (this.context != null) {
                JSONObject jSONObject = new JSONObject();
                jSONObject.put("message", str);
                jSONObject.put("code", i);
                this.context.success(jSONObject);
            }
        } catch (JSONException e) {
            handleError(e.getMessage(), 2);
        }
    }

    protected synchronized void buildGoogleApiClient() {
        Log.i(TAG, "Building GoogleApiClient");
        this.mGoogleApiClient = new GoogleApiClient.Builder(this.f4cordova.getActivity()).addConnectionCallbacks(this).addOnConnectionFailedListener(this).addApi(LocationServices.API).build();
        Log.i(TAG, "Connect Google API client");
        this.mGoogleApiClient.connect();
    }

    protected void createLocationRequest(int i) {
        Log.i(TAG, "Create location request");
        LocationRequest locationRequest = new LocationRequest();
        this.mLocationRequest = locationRequest;
        locationRequest.setPriority(i);
    }

    protected void buildLocationSettingsRequest() {
        Log.i(TAG, "Build location settings request");
        LocationSettingsRequest.Builder builder = new LocationSettingsRequest.Builder();
        builder.addLocationRequest(this.mLocationRequest);
        builder.setAlwaysShow(true);
        this.mLocationSettingsRequest = builder.build();
    }

    protected void checkLocationSettings() {
        Log.i(TAG, "Check location settings");
        LocationServices.SettingsApi.checkLocationSettings(this.mGoogleApiClient, this.mLocationSettingsRequest).setResultCallback(this);
    }

    @Override // com.google.android.gms.common.api.ResultCallback
    public void onResult(LocationSettingsResult locationSettingsResult) {
        Log.i(TAG, "onResult()");
        Status status = locationSettingsResult.getStatus();
        int statusCode = status.getStatusCode();
        if (statusCode == 0) {
            Log.i(TAG, "All location settings are satisfied.");
            handleSuccess("All location settings are satisfied.", 0);
            return;
        }
        if (statusCode != 6) {
            if (statusCode != 8502) {
                return;
            }
            handleError("Location settings are inadequate, and cannot be fixed here. Dialog not created.", 3);
        } else {
            Log.i(TAG, "Location settings are not satisfied. Show the user a dialog to upgrade location settings ");
            try {
                this.f4cordova.setActivityResultCallback(this);
                status.startResolutionForResult(this.f4cordova.getActivity(), 1);
            } catch (IntentSender.SendIntentException e) {
                handleError("PendingIntent unable to execute request: ".concat(e.getMessage()), 3);
            }
        }
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        Log.i(TAG, "onActivityResult()");
        if (i != 1) {
            return;
        }
        if (i2 == -1) {
            Log.i(TAG, "User agreed to make required location settings changes.");
            handleSuccess("User agreed to make required location settings changes.", 1);
        } else {
            if (i2 != 0) {
                return;
            }
            handleError("User chose not to make required location settings changes.", 4);
        }
    }

    @Override // com.google.android.gms.common.api.GoogleApiClient.ConnectionCallbacks
    public void onConnected(Bundle bundle) {
        Log.i(TAG, "Connected to GoogleApiClient");
    }

    @Override // com.google.android.gms.common.api.GoogleApiClient.ConnectionCallbacks
    public void onConnectionSuspended(int i) {
        Log.i(TAG, "Connection suspended");
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onStart() {
        Log.i(TAG, "On start");
        super.onStart();
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onDestroy() {
        Log.i(TAG, "On onDestroy");
        if (this.mGoogleApiClient != null) {
            super.onStop();
            Log.i(TAG, "Disconnect Google API client");
            try {
                this.mGoogleApiClient.disconnect();
            } catch (Exception e) {
                handleError(e.getMessage(), 2);
            }
        }
    }

    @Override // com.google.android.gms.common.api.GoogleApiClient.OnConnectionFailedListener
    public void onConnectionFailed(ConnectionResult connectionResult) {
        this.permanentError = connectionResult;
        String str = "The client attempted to connect to the service but the user is not signed in.";
        switch (connectionResult.getErrorCode()) {
            case 1:
                str = "Google Play services is missing on this device.";
                break;
            case 2:
                str = "The installed version of Google Play services is out of date.";
                break;
            case 3:
                str = "The installed version of Google Play services has been disabled on this device.";
                break;
            case 4:
            case 17:
                break;
            case 5:
                str = "he client attempted to connect to the service with an invalid account name specified.";
                break;
            case 6:
                str = "Completing the connection requires some form of resolution.";
                break;
            case 7:
                str = "A network error occurred.";
                break;
            case 8:
                str = "An internal error occurred.";
                break;
            case 9:
                str = "The version of the Google Play services installed on this device is not authentic.";
                break;
            case 10:
                str = "The application is misconfigured.";
                break;
            case 11:
                str = "The application is not licensed to the user.";
                break;
            case 12:
            default:
                str = "Unknown reason";
                break;
            case 13:
                str = "The connection was canceled.";
                break;
            case 14:
                str = "The timeout was exceeded while waiting for the connection to complete.";
                break;
            case 15:
                str = "An interrupt occurred while waiting for the connection complete.";
                break;
            case 16:
                str = "One of the API components you attempted to connect to is not available.";
                break;
            case 18:
                str = "Google Play service is currently being updated on this device.";
                break;
            case 19:
                str = "Google Play service doesn't have one or more required permissions.";
                break;
        }
        handleError("Failed to connect to Google Play Services: ".concat(str), 5);
        int iIsGooglePlayServicesAvailable = this.googleApiAvailability.isGooglePlayServicesAvailable(this.f4cordova.getActivity().getApplicationContext());
        if (this.googleApiAvailability.isUserResolvableError(iIsGooglePlayServicesAvailable)) {
            Dialog errorDialog = this.googleApiAvailability.getErrorDialog(this.f4cordova.getActivity(), iIsGooglePlayServicesAvailable, 0);
            errorDialog.setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: cordova.plugin.RequestLocationAccuracy.1
                @Override // android.content.DialogInterface.OnCancelListener
                public void onCancel(DialogInterface dialogInterface) {
                    RequestLocationAccuracy.this.f4cordova.getActivity().finish();
                }
            });
            errorDialog.show();
            this.permanentError = null;
        }
    }
}
