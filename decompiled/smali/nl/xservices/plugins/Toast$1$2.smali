.class Lnl/xservices/plugins/Toast$1$2;
.super Ljava/lang/Object;
.source "Toast.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


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


# direct methods
.method constructor <init>(Lnl/xservices/plugins/Toast$1;)V
    .locals 0

    .line 194
    iput-object p1, p0, Lnl/xservices/plugins/Toast$1$2;->this$1:Lnl/xservices/plugins/Toast$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 3

    .line 197
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lnl/xservices/plugins/Toast$1$2;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object p1, p1, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    iget-object p2, p0, Lnl/xservices/plugins/Toast$1$2;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object p2, p2, Lnl/xservices/plugins/Toast$1;->val$msg:Ljava/lang/String;

    iget-object v0, p0, Lnl/xservices/plugins/Toast$1$2;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v0, v0, Lnl/xservices/plugins/Toast$1;->val$data:Lorg/json/JSONObject;

    iget-object v1, p0, Lnl/xservices/plugins/Toast$1$2;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v1, v1, Lnl/xservices/plugins/Toast$1;->val$callbackContext:Lorg/apache/cordova/CallbackContext;

    const-string v2, "touch"

    invoke-static {p1, v2, p2, v0, v1}, Lnl/xservices/plugins/Toast;->-$$Nest$mreturnTapEvent(Lnl/xservices/plugins/Toast;Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method
