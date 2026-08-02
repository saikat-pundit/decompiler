.class Lorg/apache/cordova/networkinformation/NetworkManager$1;
.super Landroid/content/BroadcastReceiver;
.source "NetworkManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/apache/cordova/networkinformation/NetworkManager;->registerConnectivityActionReceiver()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/cordova/networkinformation/NetworkManager;


# direct methods
.method constructor <init>(Lorg/apache/cordova/networkinformation/NetworkManager;)V
    .locals 0

    .line 156
    iput-object p1, p0, Lorg/apache/cordova/networkinformation/NetworkManager$1;->this$0:Lorg/apache/cordova/networkinformation/NetworkManager;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    .line 160
    iget-object p1, p0, Lorg/apache/cordova/networkinformation/NetworkManager$1;->this$0:Lorg/apache/cordova/networkinformation/NetworkManager;

    iget-object p1, p1, Lorg/apache/cordova/networkinformation/NetworkManager;->webView:Lorg/apache/cordova/CordovaWebView;

    if-eqz p1, :cond_0

    .line 161
    iget-object p1, p0, Lorg/apache/cordova/networkinformation/NetworkManager$1;->this$0:Lorg/apache/cordova/networkinformation/NetworkManager;

    iget-object v0, p1, Lorg/apache/cordova/networkinformation/NetworkManager;->sockMan:Landroid/net/ConnectivityManager;

    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    invoke-static {p1, v0}, Lorg/apache/cordova/networkinformation/NetworkManager;->-$$Nest$mupdateConnectionInfo(Lorg/apache/cordova/networkinformation/NetworkManager;Landroid/net/NetworkInfo;)V

    .line 165
    :cond_0
    iget-object p1, p0, Lorg/apache/cordova/networkinformation/NetworkManager$1;->this$0:Lorg/apache/cordova/networkinformation/NetworkManager;

    invoke-static {p1}, Lorg/apache/cordova/networkinformation/NetworkManager;->-$$Nest$fgetlastTypeOfNetwork(Lorg/apache/cordova/networkinformation/NetworkManager;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "none"

    if-nez p1, :cond_1

    move-object p1, v0

    goto :goto_0

    .line 168
    :cond_1
    iget-object p1, p0, Lorg/apache/cordova/networkinformation/NetworkManager$1;->this$0:Lorg/apache/cordova/networkinformation/NetworkManager;

    invoke-static {p1}, Lorg/apache/cordova/networkinformation/NetworkManager;->-$$Nest$fgetlastTypeOfNetwork(Lorg/apache/cordova/networkinformation/NetworkManager;)Ljava/lang/String;

    move-result-object p1

    .line 172
    :goto_0
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    .line 173
    const-string p1, "noConnectivity"

    const/4 v0, 0x0

    invoke-virtual {p2, p1, v0}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result p1

    .line 174
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "Intent no connectivity: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const-string v0, "NetworkManager"

    invoke-static {v0, p2}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p1, :cond_2

    .line 176
    const-string p1, "Really no connectivity"

    invoke-static {v0, p1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    .line 178
    :cond_2
    const-string p1, "!!! Switching to unknown, Intent states there is a connectivity."

    invoke-static {v0, p1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 179
    iget-object p1, p0, Lorg/apache/cordova/networkinformation/NetworkManager$1;->this$0:Lorg/apache/cordova/networkinformation/NetworkManager;

    const-string p2, "unknown"

    invoke-static {p1, p2}, Lorg/apache/cordova/networkinformation/NetworkManager;->-$$Nest$msendUpdate(Lorg/apache/cordova/networkinformation/NetworkManager;Ljava/lang/String;)V

    :cond_3
    return-void
.end method
