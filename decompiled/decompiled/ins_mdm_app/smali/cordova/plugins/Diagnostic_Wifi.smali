.class public Lcordova/plugins/Diagnostic_Wifi;
.super Lorg/apache/cordova/CordovaPlugin;
.source "Diagnostic_Wifi.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "Diagnostic_Wifi"

.field public static instance:Lcordova/plugins/Diagnostic_Wifi;


# instance fields
.field protected currentContext:Lorg/apache/cordova/CallbackContext;

.field private diagnostic:Lcordova/plugins/Diagnostic;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 79
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    return-void
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 106
    iput-object p3, p0, Lcordova/plugins/Diagnostic_Wifi;->currentContext:Lorg/apache/cordova/CallbackContext;

    const/4 v0, 0x0

    .line 109
    :try_start_0
    const-string v1, "switchToWifiSettings"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    .line 110
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Wifi;->switchToWifiSettings()V

    .line 111
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto :goto_0

    .line 112
    :cond_0
    const-string v1, "isWifiAvailable"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 113
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Wifi;->isWifiAvailable()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 114
    :cond_1
    const-string v1, "setWifiState"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 115
    invoke-virtual {p2, v0}, Lorg/json/JSONArray;->getBoolean(I)Z

    move-result p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic_Wifi;->setWifiState(Z)V

    .line 116
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    :goto_0
    return v2

    .line 118
    :cond_2
    iget-object p1, p0, Lcordova/plugins/Diagnostic_Wifi;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string p2, "Invalid action"

    invoke-virtual {p1, p2}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception p1

    .line 122
    iget-object p2, p0, Lcordova/plugins/Diagnostic_Wifi;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string p3, "Exception occurred: "

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    return v0
.end method

.method public initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V
    .locals 2

    .line 89
    const-string v0, "Diagnostic_Wifi"

    const-string v1, "initialize()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 90
    sput-object p0, Lcordova/plugins/Diagnostic_Wifi;->instance:Lcordova/plugins/Diagnostic_Wifi;

    .line 91
    invoke-static {}, Lcordova/plugins/Diagnostic;->getInstance()Lcordova/plugins/Diagnostic;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic_Wifi;->diagnostic:Lcordova/plugins/Diagnostic;

    .line 93
    invoke-super {p0, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    return-void
.end method

.method public isWifiAvailable()Z
    .locals 2

    .line 129
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Wifi;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    .line 130
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->isWifiEnabled()Z

    move-result v0

    return v0
.end method

.method public setWifiState(Z)V
    .locals 2

    .line 141
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Wifi;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    if-eqz p1, :cond_0

    .line 142
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->isWifiEnabled()Z

    move-result v1

    if-nez v1, :cond_0

    const/4 p1, 0x1

    .line 143
    invoke-virtual {v0, p1}, Landroid/net/wifi/WifiManager;->setWifiEnabled(Z)Z

    return-void

    :cond_0
    if-nez p1, :cond_1

    .line 144
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->isWifiEnabled()Z

    move-result p1

    if-eqz p1, :cond_1

    const/4 p1, 0x0

    .line 145
    invoke-virtual {v0, p1}, Landroid/net/wifi/WifiManager;->setWifiEnabled(Z)Z

    :cond_1
    return-void
.end method

.method public switchToWifiSettings()V
    .locals 2

    .line 135
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Wifi;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string v1, "Switch to Wifi Settings"

    invoke-virtual {v0, v1}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 136
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.WIFI_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 137
    iget-object v1, p0, Lcordova/plugins/Diagnostic_Wifi;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
