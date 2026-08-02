.class Lnl/xservices/plugins/Toast$1$3;
.super Landroid/os/CountDownTimer;
.source "Toast.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lnl/xservices/plugins/Toast$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lnl/xservices/plugins/Toast$1;

.field final synthetic val$toast:Landroid/widget/Toast;


# direct methods
.method constructor <init>(Lnl/xservices/plugins/Toast$1;JJLandroid/widget/Toast;)V
    .locals 0

    .line 202
    iput-object p1, p0, Lnl/xservices/plugins/Toast$1$3;->this$1:Lnl/xservices/plugins/Toast$1;

    iput-object p6, p0, Lnl/xservices/plugins/Toast$1$3;->val$toast:Landroid/widget/Toast;

    invoke-direct {p0, p2, p3, p4, p5}, Landroid/os/CountDownTimer;-><init>(JJ)V

    return-void
.end method


# virtual methods
.method public onFinish()V
    .locals 5

    .line 211
    iget-object v0, p0, Lnl/xservices/plugins/Toast$1$3;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v0, v0, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    iget-object v1, p0, Lnl/xservices/plugins/Toast$1$3;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v1, v1, Lnl/xservices/plugins/Toast$1;->val$msg:Ljava/lang/String;

    iget-object v2, p0, Lnl/xservices/plugins/Toast$1$3;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v2, v2, Lnl/xservices/plugins/Toast$1;->val$data:Lorg/json/JSONObject;

    iget-object v3, p0, Lnl/xservices/plugins/Toast$1$3;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v3, v3, Lnl/xservices/plugins/Toast$1;->val$callbackContext:Lorg/apache/cordova/CallbackContext;

    const-string v4, "hide"

    invoke-static {v0, v4, v1, v2, v3}, Lnl/xservices/plugins/Toast;->-$$Nest$mreturnTapEvent(Lnl/xservices/plugins/Toast;Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)Z

    .line 212
    iget-object v0, p0, Lnl/xservices/plugins/Toast$1$3;->val$toast:Landroid/widget/Toast;

    invoke-virtual {v0}, Landroid/widget/Toast;->cancel()V

    return-void
.end method

.method public onTick(J)V
    .locals 0

    return-void
.end method
