.class public Lcordova/plugins/Diagnostic_Bluetooth;
.super Lorg/apache/cordova/CordovaPlugin;
.source "Diagnostic_Bluetooth.java"


# static fields
.field protected static final BLUETOOTH_STATE_POWERED_OFF:Ljava/lang/String; = "powered_off"

.field protected static final BLUETOOTH_STATE_POWERED_ON:Ljava/lang/String; = "powered_on"

.field protected static final BLUETOOTH_STATE_POWERING_OFF:Ljava/lang/String; = "powering_off"

.field protected static final BLUETOOTH_STATE_POWERING_ON:Ljava/lang/String; = "powering_on"

.field protected static final BLUETOOTH_STATE_UNKNOWN:Ljava/lang/String; = "unknown"

.field public static final TAG:Ljava/lang/String; = "Diagnostic_Bluetooth"

.field public static instance:Lcordova/plugins/Diagnostic_Bluetooth;


# instance fields
.field protected final bluetoothStateChangeReceiver:Landroid/content/BroadcastReceiver;

.field private currentBluetoothState:Ljava/lang/String;

.field protected currentContext:Lorg/apache/cordova/CallbackContext;

.field private diagnostic:Lcordova/plugins/Diagnostic;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 109
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    const/4 v0, 0x0

    .line 82
    iput-object v0, p0, Lcordova/plugins/Diagnostic_Bluetooth;->currentBluetoothState:Ljava/lang/String;

    .line 287
    new-instance v0, Lcordova/plugins/Diagnostic_Bluetooth$1;

    invoke-direct {v0, p0}, Lcordova/plugins/Diagnostic_Bluetooth$1;-><init>(Lcordova/plugins/Diagnostic_Bluetooth;)V

    iput-object v0, p0, Lcordova/plugins/Diagnostic_Bluetooth;->bluetoothStateChangeReceiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method public static setBluetoothState(Z)Z
    .locals 2

    .line 231
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    .line 232
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v1

    if-eqz p0, :cond_0

    if-nez v1, :cond_0

    .line 234
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->enable()Z

    move-result p0

    return p0

    :cond_0
    if-nez p0, :cond_1

    if-eqz v1, :cond_1

    .line 237
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->disable()Z

    move-result p0

    return p0

    :cond_1
    const/4 p0, 0x1

    return p0
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 153
    iput-object p3, p0, Lcordova/plugins/Diagnostic_Bluetooth;->currentContext:Lorg/apache/cordova/CallbackContext;

    const/4 v0, 0x0

    .line 156
    :try_start_0
    const-string v1, "switchToBluetoothSettings"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    .line 157
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->switchToBluetoothSettings()V

    .line 158
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_0

    .line 159
    :cond_0
    const-string v1, "isBluetoothAvailable"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 160
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->isBluetoothAvailable()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 161
    :cond_1
    const-string v1, "isBluetoothEnabled"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 162
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->isBluetoothEnabled()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 163
    :cond_2
    const-string v1, "hasBluetoothSupport"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 164
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->hasBluetoothSupport()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 165
    :cond_3
    const-string v1, "hasBluetoothLESupport"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 166
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->hasBluetoothLESupport()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 167
    :cond_4
    const-string v1, "hasBluetoothLEPeripheralSupport"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 168
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->hasBluetoothLEPeripheralSupport()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 169
    :cond_5
    const-string v1, "setBluetoothState"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 170
    invoke-virtual {p2, v0}, Lorg/json/JSONArray;->getBoolean(I)Z

    move-result p1

    invoke-static {p1}, Lcordova/plugins/Diagnostic_Bluetooth;->setBluetoothState(Z)Z

    .line 171
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto :goto_0

    .line 172
    :cond_6
    const-string p2, "getBluetoothState"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    .line 173
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->getBluetoothState()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(Ljava/lang/String;)V

    :goto_0
    return v2

    .line 175
    :cond_7
    iget-object p1, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string p2, "Invalid action"

    invoke-virtual {p1, p2}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception p1

    .line 179
    iget-object p2, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string p3, "Exception occurred: "

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    return v0
.end method

.method public getBluetoothState()Ljava/lang/String;
    .locals 3

    .line 245
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->hasBluetoothSupport()Z

    move-result v0

    const-string v1, "unknown"

    if-eqz v0, :cond_1

    .line 246
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-nez v0, :cond_0

    .line 248
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string v2, "Bluetooth adapter unavailable or not found"

    invoke-virtual {v0, v2}, Lcordova/plugins/Diagnostic;->logWarning(Ljava/lang/String;)V

    return-object v1

    .line 251
    :cond_0
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getState()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 260
    :pswitch_0
    const-string v0, "powering_off"

    return-object v0

    .line 257
    :pswitch_1
    const-string v0, "powered_on"

    return-object v0

    .line 263
    :pswitch_2
    const-string v0, "powering_on"

    return-object v0

    .line 254
    :pswitch_3
    const-string v0, "powered_off"

    return-object v0

    :cond_1
    :goto_0
    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0xa
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public hasBluetoothLEPeripheralSupport()Z
    .locals 1

    .line 223
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 224
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isMultipleAdvertisementSupported()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public hasBluetoothLESupport()Z
    .locals 2

    .line 216
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Bluetooth;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 217
    const-string v1, "android.hardware.bluetooth_le"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public hasBluetoothSupport()Z
    .locals 2

    .line 210
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Bluetooth;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 211
    const-string v1, "android.hardware.bluetooth"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V
    .locals 4

    .line 119
    const-string v0, "Diagnostic_Bluetooth"

    const-string v1, "initialize()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 120
    sput-object p0, Lcordova/plugins/Diagnostic_Bluetooth;->instance:Lcordova/plugins/Diagnostic_Bluetooth;

    .line 121
    invoke-static {}, Lcordova/plugins/Diagnostic;->getInstance()Lcordova/plugins/Diagnostic;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    .line 124
    :try_start_0
    iget-object v0, v0, Lcordova/plugins/Diagnostic;->applicationContext:Landroid/content/Context;

    iget-object v1, p0, Lcordova/plugins/Diagnostic_Bluetooth;->bluetoothStateChangeReceiver:Landroid/content/BroadcastReceiver;

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "android.bluetooth.adapter.action.STATE_CHANGED"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 125
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->getBluetoothState()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic_Bluetooth;->currentBluetoothState:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 127
    iget-object v1, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unable to register Bluetooth state change receiver: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcordova/plugins/Diagnostic;->logWarning(Ljava/lang/String;)V

    .line 130
    :goto_0
    invoke-super {p0, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    return-void
.end method

.method public isBluetoothAvailable()Z
    .locals 1

    .line 199
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->hasBluetoothSupport()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->isBluetoothEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public isBluetoothEnabled()Z
    .locals 1

    .line 204
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 205
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public notifyBluetoothStateChange()V
    .locals 5

    const-string v0, "bluetooth._onBluetoothStateChange(\""

    const-string v1, "Bluetooth state changed to: "

    .line 272
    :try_start_0
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Bluetooth;->getBluetoothState()Ljava/lang/String;

    move-result-object v2

    .line 273
    iget-object v3, p0, Lcordova/plugins/Diagnostic_Bluetooth;->currentBluetoothState:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 274
    iget-object v3, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 275
    iget-object v1, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\");"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcordova/plugins/Diagnostic;->executePluginJavascript(Ljava/lang/String;)V

    .line 276
    iput-object v2, p0, Lcordova/plugins/Diagnostic_Bluetooth;->currentBluetoothState:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .line 279
    iget-object v1, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Error retrieving current Bluetooth state on Bluetooth state change: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcordova/plugins/Diagnostic;->logError(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onDestroy()V
    .locals 4

    .line 138
    :try_start_0
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    iget-object v0, v0, Lcordova/plugins/Diagnostic;->applicationContext:Landroid/content/Context;

    iget-object v1, p0, Lcordova/plugins/Diagnostic_Bluetooth;->bluetoothStateChangeReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .line 140
    iget-object v1, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unable to unregister Bluetooth state change receiver: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcordova/plugins/Diagnostic;->logWarning(Ljava/lang/String;)V

    return-void
.end method

.method public switchToBluetoothSettings()V
    .locals 2

    .line 193
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Bluetooth;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string v1, "Switch to Bluetooth Settings"

    invoke-virtual {v0, v1}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 194
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.BLUETOOTH_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 195
    iget-object v1, p0, Lcordova/plugins/Diagnostic_Bluetooth;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
