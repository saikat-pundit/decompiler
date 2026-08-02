package org.apache.cordova.dialogs;

import android.R;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.widget.EditText;
import android.widget.TextView;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.LOG;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class Notification extends CordovaPlugin {
    private static final String ACTION_ACTIVITY_START = "activityStart";
    private static final String ACTION_ACTIVITY_STOP = "activityStop";
    private static final String ACTION_ALERT = "alert";
    private static final String ACTION_BEEP = "beep";
    private static final String ACTION_CONFIRM = "confirm";
    private static final String ACTION_PROGRESS_START = "progressStart";
    private static final String ACTION_PROGRESS_STOP = "progressStop";
    private static final String ACTION_PROGRESS_VALUE = "progressValue";
    private static final String ACTION_PROMPT = "prompt";
    private static final long BEEP_TIMEOUT = 5000;
    private static final long BEEP_WAIT_TINE = 100;
    private static final String LOG_TAG = "Notification";
    public int confirmResult = -1;
    public ProgressDialog spinnerDialog = null;
    public ProgressDialog progressDialog = null;

    @Override // org.apache.cordova.CordovaPlugin
    public boolean execute(String str, JSONArray jSONArray, CallbackContext callbackContext) throws Throwable {
        CallbackContext callbackContext2;
        if (this.f4cordova.getActivity().isFinishing()) {
            return true;
        }
        if (str.equals(ACTION_BEEP)) {
            beep(jSONArray.getLong(0));
            callbackContext2 = callbackContext;
        } else {
            if (str.equals(ACTION_ALERT)) {
                alert(jSONArray.getString(0), jSONArray.getString(1), jSONArray.getString(2), callbackContext);
                return true;
            }
            if (str.equals(ACTION_CONFIRM)) {
                confirm(jSONArray.getString(0), jSONArray.getString(1), jSONArray.getJSONArray(2), callbackContext);
                return true;
            }
            if (str.equals(ACTION_PROMPT)) {
                prompt(jSONArray.getString(0), jSONArray.getString(1), jSONArray.getJSONArray(2), jSONArray.getString(3), callbackContext);
                return true;
            }
            callbackContext2 = callbackContext;
            if (str.equals(ACTION_ACTIVITY_START)) {
                activityStart(jSONArray.getString(0), jSONArray.getString(1));
            } else if (str.equals(ACTION_ACTIVITY_STOP)) {
                activityStop();
            } else if (str.equals(ACTION_PROGRESS_START)) {
                progressStart(jSONArray.getString(0), jSONArray.getString(1));
            } else if (str.equals(ACTION_PROGRESS_VALUE)) {
                progressValue(jSONArray.getInt(0));
            } else {
                if (!str.equals(ACTION_PROGRESS_STOP)) {
                    return false;
                }
                progressStop();
            }
        }
        callbackContext2.success();
        return true;
    }

    public void beep(final long j) {
        this.f4cordova.getThreadPool().execute(new Runnable() { // from class: org.apache.cordova.dialogs.Notification.1
            @Override // java.lang.Runnable
            public void run() {
                Ringtone ringtone = RingtoneManager.getRingtone(Notification.this.f4cordova.getActivity().getBaseContext(), RingtoneManager.getDefaultUri(2));
                if (ringtone != null) {
                    for (long j2 = 0; j2 < j; j2++) {
                        ringtone.play();
                        long j3 = Notification.BEEP_TIMEOUT;
                        while (ringtone.isPlaying() && j3 > 0) {
                            j3 -= Notification.BEEP_WAIT_TINE;
                            try {
                                Thread.sleep(Notification.BEEP_WAIT_TINE);
                            } catch (InterruptedException unused) {
                                Thread.currentThread().interrupt();
                            }
                        }
                    }
                }
            }
        });
    }

    public synchronized void alert(final String str, final String str2, final String str3, final CallbackContext callbackContext) throws Throwable {
        try {
            try {
                final CordovaInterface cordovaInterface = this.f4cordova;
                this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: org.apache.cordova.dialogs.Notification.2
                    @Override // java.lang.Runnable
                    public void run() {
                        AlertDialog.Builder builderCreateDialog = Notification.this.createDialog(cordovaInterface);
                        builderCreateDialog.setMessage(str);
                        builderCreateDialog.setTitle(str2);
                        builderCreateDialog.setCancelable(true);
                        builderCreateDialog.setPositiveButton(str3, new DialogInterface.OnClickListener() { // from class: org.apache.cordova.dialogs.Notification.2.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                dialogInterface.dismiss();
                                callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, 0));
                            }
                        });
                        builderCreateDialog.setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: org.apache.cordova.dialogs.Notification.2.2
                            @Override // android.content.DialogInterface.OnCancelListener
                            public void onCancel(DialogInterface dialogInterface) {
                                dialogInterface.dismiss();
                                callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, 0));
                            }
                        });
                        Notification.this.changeTextDirection(builderCreateDialog);
                    }
                });
            } catch (Throwable th) {
                th = th;
                throw th;
            }
        } catch (Throwable th2) {
            th = th2;
        }
    }

    public synchronized void confirm(final String str, final String str2, final JSONArray jSONArray, final CallbackContext callbackContext) throws Throwable {
        try {
            try {
                final CordovaInterface cordovaInterface = this.f4cordova;
                this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: org.apache.cordova.dialogs.Notification.3
                    @Override // java.lang.Runnable
                    public void run() {
                        AlertDialog.Builder builderCreateDialog = Notification.this.createDialog(cordovaInterface);
                        builderCreateDialog.setMessage(str);
                        builderCreateDialog.setTitle(str2);
                        builderCreateDialog.setCancelable(true);
                        if (jSONArray.length() > 0) {
                            try {
                                builderCreateDialog.setNegativeButton(jSONArray.getString(0), new DialogInterface.OnClickListener() { // from class: org.apache.cordova.dialogs.Notification.3.1
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        dialogInterface.dismiss();
                                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, 1));
                                    }
                                });
                            } catch (JSONException unused) {
                                LOG.d(Notification.LOG_TAG, "JSONException on first button.");
                            }
                        }
                        if (jSONArray.length() > 1) {
                            try {
                                builderCreateDialog.setNeutralButton(jSONArray.getString(1), new DialogInterface.OnClickListener() { // from class: org.apache.cordova.dialogs.Notification.3.2
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        dialogInterface.dismiss();
                                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, 2));
                                    }
                                });
                            } catch (JSONException unused2) {
                                LOG.d(Notification.LOG_TAG, "JSONException on second button.");
                            }
                        }
                        if (jSONArray.length() > 2) {
                            try {
                                builderCreateDialog.setPositiveButton(jSONArray.getString(2), new DialogInterface.OnClickListener() { // from class: org.apache.cordova.dialogs.Notification.3.3
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        dialogInterface.dismiss();
                                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, 3));
                                    }
                                });
                            } catch (JSONException unused3) {
                                LOG.d(Notification.LOG_TAG, "JSONException on third button.");
                            }
                        }
                        builderCreateDialog.setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: org.apache.cordova.dialogs.Notification.3.4
                            @Override // android.content.DialogInterface.OnCancelListener
                            public void onCancel(DialogInterface dialogInterface) {
                                dialogInterface.dismiss();
                                callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, 0));
                            }
                        });
                        Notification.this.changeTextDirection(builderCreateDialog);
                    }
                });
            } catch (Throwable th) {
                th = th;
                throw th;
            }
        } catch (Throwable th2) {
            th = th2;
        }
    }

    public synchronized void prompt(final String str, final String str2, final JSONArray jSONArray, final String str3, final CallbackContext callbackContext) throws Throwable {
        try {
            try {
                final CordovaInterface cordovaInterface = this.f4cordova;
                this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: org.apache.cordova.dialogs.Notification.4
                    @Override // java.lang.Runnable
                    public void run() {
                        final EditText editText = new EditText(cordovaInterface.getActivity());
                        editText.setTextColor(cordovaInterface.getActivity().getResources().getColor(R.color.primary_text_light));
                        editText.setText(str3);
                        AlertDialog.Builder builderCreateDialog = Notification.this.createDialog(cordovaInterface);
                        builderCreateDialog.setMessage(str);
                        builderCreateDialog.setTitle(str2);
                        builderCreateDialog.setCancelable(true);
                        builderCreateDialog.setView(editText);
                        final JSONObject jSONObject = new JSONObject();
                        if (jSONArray.length() > 0) {
                            try {
                                builderCreateDialog.setNegativeButton(jSONArray.getString(0), new DialogInterface.OnClickListener() { // from class: org.apache.cordova.dialogs.Notification.4.1
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        dialogInterface.dismiss();
                                        try {
                                            jSONObject.put("buttonIndex", 1);
                                            jSONObject.put("input1", editText.getText().toString().trim().length() == 0 ? str3 : editText.getText());
                                        } catch (JSONException e) {
                                            LOG.d(Notification.LOG_TAG, "JSONException on first button.", e);
                                        }
                                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, jSONObject));
                                    }
                                });
                            } catch (JSONException unused) {
                                LOG.d(Notification.LOG_TAG, "JSONException on first button.");
                            }
                        }
                        if (jSONArray.length() > 1) {
                            try {
                                builderCreateDialog.setNeutralButton(jSONArray.getString(1), new DialogInterface.OnClickListener() { // from class: org.apache.cordova.dialogs.Notification.4.2
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        dialogInterface.dismiss();
                                        try {
                                            jSONObject.put("buttonIndex", 2);
                                            jSONObject.put("input1", editText.getText().toString().trim().length() == 0 ? str3 : editText.getText());
                                        } catch (JSONException e) {
                                            LOG.d(Notification.LOG_TAG, "JSONException on second button.", e);
                                        }
                                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, jSONObject));
                                    }
                                });
                            } catch (JSONException unused2) {
                                LOG.d(Notification.LOG_TAG, "JSONException on second button.");
                            }
                        }
                        if (jSONArray.length() > 2) {
                            try {
                                builderCreateDialog.setPositiveButton(jSONArray.getString(2), new DialogInterface.OnClickListener() { // from class: org.apache.cordova.dialogs.Notification.4.3
                                    @Override // android.content.DialogInterface.OnClickListener
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        dialogInterface.dismiss();
                                        try {
                                            jSONObject.put("buttonIndex", 3);
                                            jSONObject.put("input1", editText.getText().toString().trim().length() == 0 ? str3 : editText.getText());
                                        } catch (JSONException e) {
                                            LOG.d(Notification.LOG_TAG, "JSONException on third button.", e);
                                        }
                                        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, jSONObject));
                                    }
                                });
                            } catch (JSONException unused3) {
                                LOG.d(Notification.LOG_TAG, "JSONException on third button.");
                            }
                        }
                        builderCreateDialog.setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: org.apache.cordova.dialogs.Notification.4.4
                            @Override // android.content.DialogInterface.OnCancelListener
                            public void onCancel(DialogInterface dialogInterface) {
                                dialogInterface.dismiss();
                                try {
                                    jSONObject.put("buttonIndex", 0);
                                    jSONObject.put("input1", editText.getText().toString().trim().length() == 0 ? str3 : editText.getText());
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }
                                callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, jSONObject));
                            }
                        });
                        Notification.this.changeTextDirection(builderCreateDialog);
                    }
                });
            } catch (Throwable th) {
                th = th;
                throw th;
            }
        } catch (Throwable th2) {
            th = th2;
        }
    }

    public synchronized void activityStart(final String str, final String str2) throws Throwable {
        Throwable th;
        try {
            try {
                ProgressDialog progressDialog = this.spinnerDialog;
                if (progressDialog != null) {
                    try {
                        progressDialog.dismiss();
                        this.spinnerDialog = null;
                    } catch (Throwable th2) {
                        th = th2;
                        throw th;
                    }
                }
                final CordovaInterface cordovaInterface = this.f4cordova;
                this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: org.apache.cordova.dialogs.Notification.5
                    @Override // java.lang.Runnable
                    public void run() {
                        this.spinnerDialog = Notification.this.createProgressDialog(cordovaInterface);
                        this.spinnerDialog.setTitle(str);
                        this.spinnerDialog.setMessage(str2);
                        this.spinnerDialog.setCancelable(true);
                        this.spinnerDialog.setIndeterminate(true);
                        this.spinnerDialog.setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: org.apache.cordova.dialogs.Notification.5.1
                            @Override // android.content.DialogInterface.OnCancelListener
                            public void onCancel(DialogInterface dialogInterface) {
                                this.spinnerDialog = null;
                            }
                        });
                        this.spinnerDialog.show();
                    }
                });
            } catch (Throwable th3) {
                th = th3;
                th = th;
                throw th;
            }
        } catch (Throwable th4) {
            th = th4;
        }
    }

    public synchronized void activityStop() {
        ProgressDialog progressDialog = this.spinnerDialog;
        if (progressDialog != null) {
            progressDialog.dismiss();
            this.spinnerDialog = null;
        }
    }

    public synchronized void progressStart(final String str, final String str2) throws Throwable {
        Throwable th;
        try {
            try {
                ProgressDialog progressDialog = this.progressDialog;
                if (progressDialog != null) {
                    try {
                        progressDialog.dismiss();
                        this.progressDialog = null;
                    } catch (Throwable th2) {
                        th = th2;
                        throw th;
                    }
                }
                final CordovaInterface cordovaInterface = this.f4cordova;
                this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: org.apache.cordova.dialogs.Notification.6
                    @Override // java.lang.Runnable
                    public void run() {
                        this.progressDialog = Notification.this.createProgressDialog(cordovaInterface);
                        this.progressDialog.setProgressStyle(1);
                        this.progressDialog.setTitle(str);
                        this.progressDialog.setMessage(str2);
                        this.progressDialog.setCancelable(true);
                        this.progressDialog.setMax(100);
                        this.progressDialog.setProgress(0);
                        this.progressDialog.setOnCancelListener(new DialogInterface.OnCancelListener() { // from class: org.apache.cordova.dialogs.Notification.6.1
                            @Override // android.content.DialogInterface.OnCancelListener
                            public void onCancel(DialogInterface dialogInterface) {
                                this.progressDialog = null;
                            }
                        });
                        this.progressDialog.show();
                    }
                });
            } catch (Throwable th3) {
                th = th3;
                th = th;
                throw th;
            }
        } catch (Throwable th4) {
            th = th4;
        }
    }

    public synchronized void progressValue(int i) {
        ProgressDialog progressDialog = this.progressDialog;
        if (progressDialog != null) {
            progressDialog.setProgress(i);
        }
    }

    public synchronized void progressStop() {
        ProgressDialog progressDialog = this.progressDialog;
        if (progressDialog != null) {
            progressDialog.dismiss();
            this.progressDialog = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public AlertDialog.Builder createDialog(CordovaInterface cordovaInterface) {
        return new AlertDialog.Builder(cordovaInterface.getActivity(), 5);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public ProgressDialog createProgressDialog(CordovaInterface cordovaInterface) {
        return new ProgressDialog(cordovaInterface.getActivity(), 5);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void changeTextDirection(AlertDialog.Builder builder) {
        builder.create();
        ((TextView) builder.show().findViewById(R.id.message)).setTextDirection(5);
    }
}
