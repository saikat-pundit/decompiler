.class public Lcordova/plugins/Diagnostic_Camera;
.super Lorg/apache/cordova/CordovaPlugin;
.source "Diagnostic_Camera.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "Diagnostic_Camera"

.field public static instance:Lcordova/plugins/Diagnostic_Camera;


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

    .line 77
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    return-void
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 104
    iput-object p3, p0, Lcordova/plugins/Diagnostic_Camera;->currentContext:Lorg/apache/cordova/CallbackContext;

    const/4 p2, 0x0

    .line 107
    :try_start_0
    const-string v0, "isCameraPresent"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 108
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_Camera;->isCameraPresent()Z

    move-result p1

    const/4 v0, 0x1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    return v0

    .line 110
    :cond_0
    iget-object p1, p0, Lcordova/plugins/Diagnostic_Camera;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string p3, "Invalid action"

    invoke-virtual {p1, p3}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p2

    :catch_0
    move-exception p1

    .line 114
    iget-object p3, p0, Lcordova/plugins/Diagnostic_Camera;->diagnostic:Lcordova/plugins/Diagnostic;

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

    .line 87
    const-string v0, "Diagnostic_Camera"

    const-string v1, "initialize()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 88
    sput-object p0, Lcordova/plugins/Diagnostic_Camera;->instance:Lcordova/plugins/Diagnostic_Camera;

    .line 89
    invoke-static {}, Lcordova/plugins/Diagnostic;->getInstance()Lcordova/plugins/Diagnostic;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic_Camera;->diagnostic:Lcordova/plugins/Diagnostic;

    .line 91
    invoke-super {p0, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    return-void
.end method

.method public isCameraPresent()Z
    .locals 3

    .line 121
    invoke-static {}, Landroid/hardware/Camera;->getNumberOfCameras()I

    move-result v0

    .line 122
    iget-object v1, p0, Lcordova/plugins/Diagnostic_Camera;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/appcompat/app/AppCompatActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 123
    const-string v2, "android.hardware.camera"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method
