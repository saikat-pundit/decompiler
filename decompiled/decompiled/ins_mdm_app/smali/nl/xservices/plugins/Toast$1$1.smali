.class Lnl/xservices/plugins/Toast$1$1;
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

    .line 150
    iput-object p1, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 8

    .line 153
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 156
    :cond_0
    iget-object v0, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v0, v0, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    invoke-static {v0}, Lnl/xservices/plugins/Toast;->-$$Nest$fgetmostRecentToast(Lnl/xservices/plugins/Toast;)Landroid/widget/Toast;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v0, v0, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    invoke-static {v0}, Lnl/xservices/plugins/Toast;->-$$Nest$fgetmostRecentToast(Lnl/xservices/plugins/Toast;)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->isShown()Z

    move-result v0

    if-nez v0, :cond_1

    goto/16 :goto_2

    .line 161
    :cond_1
    iget-object v0, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v0, v0, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    invoke-static {v0}, Lnl/xservices/plugins/Toast;->-$$Nest$fgetmostRecentToast(Lnl/xservices/plugins/Toast;)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getWidth()I

    move-result v0

    int-to-float v0, v0

    .line 162
    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    int-to-float v2, v2

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v0, v3

    sub-float/2addr v2, v0

    .line 163
    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v4

    div-int/lit8 v4, v4, 0x2

    int-to-float v4, v4

    add-float/2addr v4, v0

    .line 168
    iget-object v0, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v0, v0, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    invoke-static {v0}, Lnl/xservices/plugins/Toast;->-$$Nest$fgetmostRecentToast(Lnl/xservices/plugins/Toast;)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->getGravity()I

    move-result v0

    int-to-float v0, v0

    .line 169
    iget-object v5, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v5, v5, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    invoke-static {v5}, Lnl/xservices/plugins/Toast;->-$$Nest$fgetmostRecentToast(Lnl/xservices/plugins/Toast;)Landroid/widget/Toast;

    move-result-object v5

    invoke-virtual {v5}, Landroid/widget/Toast;->getYOffset()I

    move-result v5

    int-to-float v5, v5

    .line 170
    iget-object v6, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v6, v6, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    invoke-static {v6}, Lnl/xservices/plugins/Toast;->-$$Nest$fgetmostRecentToast(Lnl/xservices/plugins/Toast;)Landroid/widget/Toast;

    move-result-object v6

    invoke-virtual {v6}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6}, Landroid/view/View;->getHeight()I

    move-result v6

    int-to-float v6, v6

    const/high16 v7, 0x42a20000    # 81.0f

    cmpl-float v7, v0, v7

    if-nez v7, :cond_2

    .line 173
    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v0

    int-to-float v0, v0

    sub-float/2addr v0, v5

    sub-float/2addr v0, v6

    .line 174
    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result p1

    int-to-float p1, p1

    sub-float/2addr p1, v5

    :goto_0
    move v5, v0

    goto :goto_1

    :cond_2
    const/high16 v7, 0x41880000    # 17.0f

    cmpl-float v0, v0, v7

    if-nez v0, :cond_3

    .line 176
    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    int-to-float v0, v0

    add-float/2addr v0, v5

    div-float/2addr v6, v3

    sub-float/2addr v0, v6

    .line 177
    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result p1

    div-int/lit8 p1, p1, 0x2

    int-to-float p1, p1

    add-float/2addr p1, v5

    add-float/2addr p1, v6

    goto :goto_0

    :cond_3
    add-float p1, v5, v6

    .line 184
    :goto_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    .line 185
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result p2

    cmpl-float v2, v0, v2

    if-ltz v2, :cond_4

    cmpg-float v0, v0, v4

    if-gtz v0, :cond_4

    cmpl-float v0, p2, v5

    if-ltz v0, :cond_4

    cmpg-float p1, p2, p1

    if-gtz p1, :cond_4

    .line 190
    iget-object p1, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object p1, p1, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    iget-object p2, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object p2, p2, Lnl/xservices/plugins/Toast$1;->val$msg:Ljava/lang/String;

    iget-object v0, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v0, v0, Lnl/xservices/plugins/Toast$1;->val$data:Lorg/json/JSONObject;

    iget-object v2, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object v2, v2, Lnl/xservices/plugins/Toast$1;->val$callbackContext:Lorg/apache/cordova/CallbackContext;

    const-string v3, "touch"

    invoke-static {p1, v3, p2, v0, v2}, Lnl/xservices/plugins/Toast;->-$$Nest$mreturnTapEvent(Lnl/xservices/plugins/Toast;Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)Z

    move-result p1

    if-eqz p1, :cond_4

    const/4 p1, 0x1

    return p1

    :cond_4
    return v1

    .line 157
    :cond_5
    :goto_2
    iget-object p1, p0, Lnl/xservices/plugins/Toast$1$1;->this$1:Lnl/xservices/plugins/Toast$1;

    iget-object p1, p1, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    invoke-static {p1}, Lnl/xservices/plugins/Toast;->-$$Nest$mgetViewGroup(Lnl/xservices/plugins/Toast;)Landroid/view/ViewGroup;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/ViewGroup;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    return v1
.end method
