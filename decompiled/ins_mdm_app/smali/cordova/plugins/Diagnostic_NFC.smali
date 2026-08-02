.class public Lcordova/plugins/Diagnostic_NFC;
.super Lorg/apache/cordova/CordovaPlugin;
.source "Diagnostic_NFC.java"


# static fields
.field public static final NFC_STATE_OFF:Ljava/lang/String; = "powered_off"

.field public static final NFC_STATE_ON:Ljava/lang/String; = "powered_on"

.field public static final NFC_STATE_TURNING_OFF:Ljava/lang/String; = "powering_off"

.field public static final NFC_STATE_TURNING_ON:Ljava/lang/String; = "powering_on"

.field public static final NFC_STATE_UNKNOWN:Ljava/lang/String; = "unknown"

.field public static final NFC_STATE_VALUE_OFF:I = 0x1

.field public static final NFC_STATE_VALUE_ON:I = 0x3

.field public static final NFC_STATE_VALUE_TURNING_OFF:I = 0x4

.field public static final NFC_STATE_VALUE_TURNING_ON:I = 0x2

.field public static final NFC_STATE_VALUE_UNKNOWN:I = 0x0

.field public static final TAG:Ljava/lang/String; = "Diagnostic_NFC"

.field public static instance:Lcordova/plugins/Diagnostic_NFC;

.field public static nfcManager:Landroid/nfc/NfcManager;


# instance fields
.field protected final NFCStateChangedReceiver:Landroid/content/BroadcastReceiver;

.field protected currentContext:Lorg/apache/cordova/CallbackContext;

.field protected currentNFCState:Ljava/lang/String;

.field private diagnostic:Lcordova/plugins/Diagnostic;


# direct methods
.method static bridge synthetic -$$Nest$fgetdiagnostic(Lcordova/plugins/Diagnostic_NFC;)Lcordova/plugins/Diagnostic;
    .locals 0

    iget-object p0, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 100
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    .line 90
    const-string v0, "unknown"

    iput-object v0, p0, Lcordova/plugins/Diagnostic_NFC;->currentNFCState:Ljava/lang/String;

    .line 254
    new-instance v0, Lcordova/plugins/Diagnostic_NFC$1;

    invoke-direct {v0, p0}, Lcordova/plugins/Diagnostic_NFC$1;-><init>(Lcordova/plugins/Diagnostic_NFC;)V

    iput-object v0, p0, Lcordova/plugins/Diagnostic_NFC;->NFCStateChangedReceiver:Landroid/content/BroadcastReceiver;

    return-void
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 151
    iput-object p3, p0, Lcordova/plugins/Diagnostic_NFC;->currentContext:Lorg/apache/cordova/CallbackContext;

    const/4 p2, 0x0

    .line 154
    :try_start_0
    const-string v0, "switchToNFCSettings"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 155
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_NFC;->switchToNFCSettings()V

    .line 156
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto :goto_0

    .line 157
    :cond_0
    const-string v0, "isNFCPresent"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 158
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_NFC;->isNFCPresent()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 159
    :cond_1
    const-string v0, "isNFCEnabled"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 160
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_NFC;->isNFCEnabled()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 161
    :cond_2
    const-string v0, "isNFCAvailable"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    .line 162
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_NFC;->isNFCAvailable()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    :goto_0
    return v1

    .line 164
    :cond_3
    iget-object p1, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string p3, "Invalid action"

    invoke-virtual {p1, p3}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p2

    :catch_0
    move-exception p1

    .line 168
    iget-object p3, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string v0, "Exception occurred: "

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    return p2
.end method

.method public getNFCState(I)Ljava/lang/String;
    .locals 1

    const/4 v0, 0x1

    if-eq p1, v0, :cond_3

    const/4 v0, 0x2

    if-eq p1, v0, :cond_2

    const/4 v0, 0x3

    if-eq p1, v0, :cond_1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_0

    .line 245
    const-string p1, "unknown"

    return-object p1

    .line 242
    :cond_0
    const-string p1, "powering_off"

    return-object p1

    .line 239
    :cond_1
    const-string p1, "powered_on"

    return-object p1

    .line 236
    :cond_2
    const-string p1, "powering_on"

    return-object p1

    .line 233
    :cond_3
    const-string p1, "powered_off"

    return-object p1
.end method

.method public initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V
    .locals 4

    .line 110
    const-string v0, "Diagnostic_NFC"

    const-string v1, "initialize()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 111
    sput-object p0, Lcordova/plugins/Diagnostic_NFC;->instance:Lcordova/plugins/Diagnostic_NFC;

    .line 112
    invoke-static {}, Lcordova/plugins/Diagnostic;->getInstance()Lcordova/plugins/Diagnostic;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    .line 115
    :try_start_0
    iget-object v0, v0, Lcordova/plugins/Diagnostic;->applicationContext:Landroid/content/Context;

    iget-object v1, p0, Lcordova/plugins/Diagnostic_NFC;->NFCStateChangedReceiver:Landroid/content/BroadcastReceiver;

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "android.nfc.action.ADAPTER_STATE_CHANGED"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 116
    iget-object v0, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    iget-object v0, v0, Lcordova/plugins/Diagnostic;->applicationContext:Landroid/content/Context;

    const-string v1, "nfc"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/nfc/NfcManager;

    sput-object v0, Lcordova/plugins/Diagnostic_NFC;->nfcManager:Landroid/nfc/NfcManager;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 118
    iget-object v1, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unable to register NFC state change receiver: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcordova/plugins/Diagnostic;->logWarning(Ljava/lang/String;)V

    .line 122
    :goto_0
    :try_start_1
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_NFC;->isNFCAvailable()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "powered_on"

    goto :goto_1

    :cond_0
    const-string v0, "powered_off"

    :goto_1
    iput-object v0, p0, Lcordova/plugins/Diagnostic_NFC;->currentNFCState:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_1
    move-exception v0

    .line 124
    iget-object v1, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unable to get initial NFC state: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcordova/plugins/Diagnostic;->logWarning(Ljava/lang/String;)V

    .line 127
    :goto_2
    invoke-super {p0, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    return-void
.end method

.method public isNFCAvailable()Z
    .locals 1

    .line 211
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_NFC;->isNFCPresent()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_NFC;->isNFCEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public isNFCEnabled()Z
    .locals 3

    const/4 v0, 0x0

    .line 202
    :try_start_0
    sget-object v1, Lcordova/plugins/Diagnostic_NFC;->nfcManager:Landroid/nfc/NfcManager;

    invoke-virtual {v1}, Landroid/nfc/NfcManager;->getDefaultAdapter()Landroid/nfc/NfcAdapter;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 203
    invoke-virtual {v1}, Landroid/nfc/NfcAdapter;->isEnabled()Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    :catch_0
    move-exception v1

    .line 205
    iget-object v2, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lcordova/plugins/Diagnostic;->logError(Ljava/lang/String;)V

    return v0
.end method

.method public isNFCPresent()Z
    .locals 3

    const/4 v0, 0x0

    .line 191
    :try_start_0
    sget-object v1, Lcordova/plugins/Diagnostic_NFC;->nfcManager:Landroid/nfc/NfcManager;

    invoke-virtual {v1}, Landroid/nfc/NfcManager;->getDefaultAdapter()Landroid/nfc/NfcAdapter;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    :catch_0
    move-exception v1

    .line 194
    iget-object v2, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lcordova/plugins/Diagnostic;->logError(Ljava/lang/String;)V

    return v0
.end method

.method public notifyNFCStateChange(I)V
    .locals 4

    const-string v0, "nfc._onNFCStateChange(\""

    const-string v1, "NFC state changed to: "

    .line 216
    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic_NFC;->getNFCState(I)Ljava/lang/String;

    move-result-object p1

    .line 218
    :try_start_0
    iget-object v2, p0, Lcordova/plugins/Diagnostic_NFC;->currentNFCState:Ljava/lang/String;

    if-eq p1, v2, :cond_0

    .line 219
    iget-object v2, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 220
    iget-object v1, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\");"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcordova/plugins/Diagnostic;->executePluginJavascript(Ljava/lang/String;)V

    .line 221
    iput-object p1, p0, Lcordova/plugins/Diagnostic_NFC;->currentNFCState:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 224
    iget-object v0, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Error retrieving current NFC state on state change: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcordova/plugins/Diagnostic;->logError(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onDestroy()V
    .locals 4

    .line 135
    :try_start_0
    iget-object v0, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    iget-object v0, v0, Lcordova/plugins/Diagnostic;->applicationContext:Landroid/content/Context;

    iget-object v1, p0, Lcordova/plugins/Diagnostic_NFC;->NFCStateChangedReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .line 137
    iget-object v1, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unable to unregister NFC state change receiver: "

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

.method public switchToNFCSettings()V
    .locals 2

    .line 180
    iget-object v0, p0, Lcordova/plugins/Diagnostic_NFC;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string v1, "Switch to NFC Settings"

    invoke-virtual {v0, v1}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 181
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.WIRELESS_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 183
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.NFC_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 185
    iget-object v1, p0, Lcordova/plugins/Diagnostic_NFC;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
