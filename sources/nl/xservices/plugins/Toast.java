package nl.xservices.plugins;

import android.R;
import android.graphics.Color;
import android.graphics.drawable.GradientDrawable;
import android.os.Build;
import android.os.CountDownTimer;
import android.text.Layout;
import android.text.SpannableString;
import android.text.style.AlignmentSpan;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.core.app.NotificationCompat;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class Toast extends CordovaPlugin {
    private static final String ACTION_HIDE_EVENT = "hide";
    private static final String ACTION_SHOW_EVENT = "show";
    private static final int BASE_TOP_BOTTOM_OFFSET = 20;
    private static final int GRAVITY_BOTTOM = 81;
    private static final int GRAVITY_CENTER = 17;
    private static final int GRAVITY_TOP = 49;
    private static final boolean IS_AT_LEAST_JELLY_BEAN = true;
    private static final boolean IS_AT_LEAST_LOLLIPOP = true;
    private static final boolean IS_AT_LEAST_PIE;
    private static final boolean IS_AT_LEAST_R;
    private static CountDownTimer _timer;
    private JSONObject currentData;
    private String currentMessage;
    private boolean isPaused;
    private android.widget.Toast mostRecentToast;
    private ViewGroup viewGroup;

    static {
        IS_AT_LEAST_PIE = Build.VERSION.SDK_INT >= 28;
        IS_AT_LEAST_R = Build.VERSION.SDK_INT >= 30;
    }

    @Override // org.apache.cordova.CordovaPlugin
    public boolean execute(String str, JSONArray jSONArray, final CallbackContext callbackContext) throws JSONException {
        if (ACTION_HIDE_EVENT.equals(str)) {
            returnTapEvent(ACTION_HIDE_EVENT, this.currentMessage, this.currentData, callbackContext);
            hide();
            callbackContext.success();
            return true;
        }
        if (ACTION_SHOW_EVENT.equals(str)) {
            if (this.isPaused) {
                return true;
            }
            JSONObject jSONObject = jSONArray.getJSONObject(0);
            final String string = jSONObject.getString("message");
            final SpannableString spannableString = new SpannableString(string);
            spannableString.setSpan(new AlignmentSpan.Standard(Layout.Alignment.ALIGN_CENTER), 0, string.length() - 1, 18);
            final String string2 = jSONObject.getString("duration");
            final String string3 = jSONObject.getString("position");
            int i = jSONObject.has("addPixelsY") ? jSONObject.getInt("addPixelsY") : 0;
            final JSONObject jSONObject2 = jSONObject.has("data") ? jSONObject.getJSONObject("data") : null;
            final JSONObject jSONObjectOptJSONObject = jSONObject.optJSONObject("styling");
            this.currentMessage = string;
            this.currentData = jSONObject2;
            final int i2 = i;
            this.f4cordova.getActivity().runOnUiThread(new Runnable() { // from class: nl.xservices.plugins.Toast.1
                /* JADX WARN: Type inference failed for: r2v15, types: [nl.xservices.plugins.Toast$1$3] */
                @Override // java.lang.Runnable
                public void run() {
                    int i3;
                    if ("short".equalsIgnoreCase(string2)) {
                        i3 = 2000;
                    } else {
                        i3 = "long".equalsIgnoreCase(string2) ? 4000 : Integer.parseInt(string2);
                    }
                    final android.widget.Toast toastMakeText = android.widget.Toast.makeText(Toast.IS_AT_LEAST_LOLLIPOP ? Toast.this.f4cordova.getActivity().getWindow().getContext() : Toast.this.f4cordova.getActivity().getApplicationContext(), spannableString, !"short".equalsIgnoreCase(string2) ? 1 : 0);
                    if ("top".equals(string3)) {
                        toastMakeText.setGravity(Toast.GRAVITY_TOP, 0, i2 + 20);
                    } else if ("bottom".equals(string3)) {
                        toastMakeText.setGravity(Toast.GRAVITY_BOTTOM, 0, 20 - i2);
                    } else if ("center".equals(string3)) {
                        toastMakeText.setGravity(17, 0, i2);
                    } else {
                        callbackContext.error("invalid position. valid options are 'top', 'center' and 'bottom'");
                        return;
                    }
                    if (jSONObjectOptJSONObject != null && Toast.IS_AT_LEAST_JELLY_BEAN && !Toast.IS_AT_LEAST_R) {
                        String strOptString = jSONObjectOptJSONObject.optString("backgroundColor", "#333333");
                        String strOptString2 = jSONObjectOptJSONObject.optString("textColor", "#ffffff");
                        Double dValueOf = Double.valueOf(jSONObjectOptJSONObject.optDouble("textSize", -1.0d));
                        double dOptDouble = jSONObjectOptJSONObject.optDouble("opacity", 0.8d);
                        int iOptInt = jSONObjectOptJSONObject.optInt("cornerRadius", 100);
                        int iOptInt2 = jSONObjectOptJSONObject.optInt("horizontalPadding", 50);
                        int iOptInt3 = jSONObjectOptJSONObject.optInt("verticalPadding", 30);
                        GradientDrawable gradientDrawable = new GradientDrawable();
                        gradientDrawable.setCornerRadius(iOptInt);
                        gradientDrawable.setAlpha((int) (dOptDouble * 255.0d));
                        gradientDrawable.setColor(Color.parseColor(strOptString));
                        toastMakeText.getView().setBackground(gradientDrawable);
                        TextView textView = (TextView) toastMakeText.getView().findViewById(R.id.message);
                        textView.setTextColor(Color.parseColor(strOptString2));
                        if (dValueOf.doubleValue() > -1.0d) {
                            textView.setTextSize(dValueOf.floatValue());
                        }
                        toastMakeText.getView().setPadding(iOptInt2, iOptInt3, iOptInt2, iOptInt3);
                        if (Toast.IS_AT_LEAST_LOLLIPOP) {
                            toastMakeText.getView().setElevation(6.0f);
                        }
                    }
                    if (!Toast.IS_AT_LEAST_R) {
                        if (Toast.IS_AT_LEAST_LOLLIPOP) {
                            Toast.this.getViewGroup().setOnTouchListener(new View.OnTouchListener() { // from class: nl.xservices.plugins.Toast.1.1
                                @Override // android.view.View.OnTouchListener
                                public boolean onTouch(View view, MotionEvent motionEvent) {
                                    float height;
                                    float height2;
                                    if (motionEvent.getAction() != 0) {
                                        return false;
                                    }
                                    if (Toast.this.mostRecentToast == null || !Toast.this.mostRecentToast.getView().isShown()) {
                                        Toast.this.getViewGroup().setOnTouchListener(null);
                                        return false;
                                    }
                                    float width = Toast.this.mostRecentToast.getView().getWidth() / 2.0f;
                                    float width2 = (view.getWidth() / 2) - width;
                                    float width3 = (view.getWidth() / 2) + width;
                                    float gravity = Toast.this.mostRecentToast.getGravity();
                                    float yOffset = Toast.this.mostRecentToast.getYOffset();
                                    float height3 = Toast.this.mostRecentToast.getView().getHeight();
                                    if (gravity == 81.0f) {
                                        height2 = (view.getHeight() - yOffset) - height3;
                                        height = view.getHeight() - yOffset;
                                    } else if (gravity == 17.0f) {
                                        float f = height3 / 2.0f;
                                        height2 = ((view.getHeight() / 2) + yOffset) - f;
                                        height = (view.getHeight() / 2) + yOffset + f;
                                    } else {
                                        height = yOffset + height3;
                                        float x = motionEvent.getX();
                                        float y = motionEvent.getY();
                                        return x < width2 && x <= width3 && y >= yOffset && y <= height && Toast.this.returnTapEvent("touch", string, jSONObject2, callbackContext);
                                    }
                                    yOffset = height2;
                                    float x2 = motionEvent.getX();
                                    float y2 = motionEvent.getY();
                                    if (x2 < width2) {
                                    }
                                }
                            });
                        } else {
                            toastMakeText.getView().setOnTouchListener(new View.OnTouchListener() { // from class: nl.xservices.plugins.Toast.1.2
                                @Override // android.view.View.OnTouchListener
                                public boolean onTouch(View view, MotionEvent motionEvent) {
                                    return motionEvent.getAction() == 0 && Toast.this.returnTapEvent("touch", string, jSONObject2, callbackContext);
                                }
                            });
                        }
                    }
                    Toast._timer = new CountDownTimer(i3, 2500L) { // from class: nl.xservices.plugins.Toast.1.3
                        @Override // android.os.CountDownTimer
                        public void onTick(long j) {
                        }

                        @Override // android.os.CountDownTimer
                        public void onFinish() {
                            Toast.this.returnTapEvent(Toast.ACTION_HIDE_EVENT, string, jSONObject2, callbackContext);
                            toastMakeText.cancel();
                        }
                    }.start();
                    Toast.this.mostRecentToast = toastMakeText;
                    toastMakeText.show();
                    PluginResult pluginResult = new PluginResult(PluginResult.Status.OK);
                    pluginResult.setKeepCallback(true);
                    callbackContext.sendPluginResult(pluginResult);
                }
            });
            return true;
        }
        callbackContext.error("toast." + str + " is not a supported function. Did you mean 'show'?");
        return false;
    }

    private void hide() {
        android.widget.Toast toast = this.mostRecentToast;
        if (toast != null) {
            toast.cancel();
            getViewGroup().setOnTouchListener(null);
        }
        CountDownTimer countDownTimer = _timer;
        if (countDownTimer != null) {
            countDownTimer.cancel();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean returnTapEvent(String str, String str2, JSONObject jSONObject, CallbackContext callbackContext) {
        JSONObject jSONObject2 = new JSONObject();
        try {
            jSONObject2.put(NotificationCompat.CATEGORY_EVENT, str);
            jSONObject2.put("message", str2);
            jSONObject2.put("data", jSONObject);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        callbackContext.success(jSONObject2);
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public ViewGroup getViewGroup() {
        if (this.viewGroup == null) {
            this.viewGroup = (ViewGroup) ((ViewGroup) this.f4cordova.getActivity().findViewById(R.id.content)).getChildAt(0);
        }
        return this.viewGroup;
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onPause(boolean z) {
        hide();
        this.isPaused = true;
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onResume(boolean z) {
        this.isPaused = false;
    }
}
