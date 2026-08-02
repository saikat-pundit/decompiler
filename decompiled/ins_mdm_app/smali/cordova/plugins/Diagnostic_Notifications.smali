.class public Lcordova/plugins/Diagnostic_Notifications;
.super Lorg/apache/cordova/CordovaPlugin;
.source "Diagnostic_Notifications.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "Diagnostic_Notifications"

.field public static instance:Lcordova/plugins/Diagnostic_Notifications;


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

    .line 83
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

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

    .line 110
    iput-object p3, p0, Lcordova/plugins/Diagnostic_Notifications;->currentContext:Lorg/apache/cordova/CallbackContext;

    const/4 p2, 0x0

    .line 113
    :try_start_0
    const-string v0, "isRemoteNotificationsEnabled"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 114
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Notifications;->isRemoteNotificationsEnabled()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 115
    :cond_0
    const-string v0, "switchToNotificationSettings"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 116
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Notifications;->switchToNotificationSettings()V

    .line 117
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    :goto_0
    return v1

    .line 119
    :cond_1
    iget-object p1, p0, Lcordova/plugins/Diagnostic_Notifications;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string p3, "Invalid action"

    invoke-virtual {p1, p3}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p2

    :catch_0
    move-exception p1

    .line 123
    iget-object p3, p0, Lcordova/plugins/Diagnostic_Notifications;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string v0, "Exception occurred: "

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    return p2
.end method

.method public initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V
    .locals 2

    .line 93
    const-string v0, "Diagnostic_Notifications"

    const-string v1, "initialize()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 94
    sput-object p0, Lcordova/plugins/Diagnostic_Notifications;->instance:Lcordova/plugins/Diagnostic_Notifications;

    .line 95
    invoke-static {}, Lcordova/plugins/Diagnostic;->getInstance()Lcordova/plugins/Diagnostic;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic_Notifications;->diagnostic:Lcordova/plugins/Diagnostic;

    .line 97
    invoke-super {p0, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    return-void
.end method

.method public isRemoteNotificationsEnabled()Z
    .locals 1

    .line 131
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Notifications;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroidx/core/app/NotificationManagerCompat;->from(Landroid/content/Context;)Landroidx/core/app/NotificationManagerCompat;

    move-result-object v0

    .line 132
    invoke-virtual {v0}, Landroidx/core/app/NotificationManagerCompat;->areNotificationsEnabled()Z

    move-result v0

    return v0
.end method

.method public switchToNotificationSettings()V
    .locals 4

    .line 137
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Notifications;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 138
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    .line 139
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 140
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1a

    if-lt v2, v3, :cond_0

    .line 141
    iget-object v2, p0, Lcordova/plugins/Diagnostic_Notifications;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string v3, "Switch to notification Settings"

    invoke-virtual {v2, v3}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 142
    const-string v2, "android.settings.APP_NOTIFICATION_SETTINGS"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 143
    const-string v2, "android.provider.extra.APP_PACKAGE"

    invoke-virtual {v1, v2, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0

    .line 145
    :cond_0
    const-string v2, "android.settings.APPLICATION_DETAILS_SETTINGS"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 146
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "package:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 147
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Notifications;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string v2, "Switch to notification Settings: Only possible on android O or above. Falling back to application details"

    invoke-virtual {v0, v2}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 149
    :goto_0
    iget-object v0, p0, Lcordova/plugins/Diagnostic_Notifications;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
