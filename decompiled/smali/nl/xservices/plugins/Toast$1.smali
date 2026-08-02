.class Lnl/xservices/plugins/Toast$1;
.super Ljava/lang/Object;
.source "Toast.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lnl/xservices/plugins/Toast;->execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lnl/xservices/plugins/Toast;

.field final synthetic val$addPixelsY:I

.field final synthetic val$callbackContext:Lorg/apache/cordova/CallbackContext;

.field final synthetic val$data:Lorg/json/JSONObject;

.field final synthetic val$duration:Ljava/lang/String;

.field final synthetic val$message:Landroid/text/Spannable;

.field final synthetic val$msg:Ljava/lang/String;

.field final synthetic val$position:Ljava/lang/String;

.field final synthetic val$styling:Lorg/json/JSONObject;


# direct methods
.method constructor <init>(Lnl/xservices/plugins/Toast;Ljava/lang/String;Landroid/text/Spannable;Ljava/lang/String;ILorg/apache/cordova/CallbackContext;Lorg/json/JSONObject;Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 81
    iput-object p1, p0, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    iput-object p2, p0, Lnl/xservices/plugins/Toast$1;->val$duration:Ljava/lang/String;

    iput-object p3, p0, Lnl/xservices/plugins/Toast$1;->val$message:Landroid/text/Spannable;

    iput-object p4, p0, Lnl/xservices/plugins/Toast$1;->val$position:Ljava/lang/String;

    iput p5, p0, Lnl/xservices/plugins/Toast$1;->val$addPixelsY:I

    iput-object p6, p0, Lnl/xservices/plugins/Toast$1;->val$callbackContext:Lorg/apache/cordova/CallbackContext;

    iput-object p7, p0, Lnl/xservices/plugins/Toast$1;->val$styling:Lorg/json/JSONObject;

    iput-object p8, p0, Lnl/xservices/plugins/Toast$1;->val$msg:Ljava/lang/String;

    iput-object p9, p0, Lnl/xservices/plugins/Toast$1;->val$data:Lorg/json/JSONObject;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 17

    move-object/from16 v1, p0

    .line 84
    iget-object v0, v1, Lnl/xservices/plugins/Toast$1;->val$duration:Ljava/lang/String;

    const-string v2, "short"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 v0, 0x7d0

    goto :goto_0

    .line 86
    :cond_0
    const-string v0, "long"

    iget-object v3, v1, Lnl/xservices/plugins/Toast$1;->val$duration:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/16 v0, 0xfa0

    goto :goto_0

    .line 90
    :cond_1
    iget-object v0, v1, Lnl/xservices/plugins/Toast$1;->val$duration:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 93
    :goto_0
    invoke-static {}, Lnl/xservices/plugins/Toast;->-$$Nest$sfgetIS_AT_LEAST_LOLLIPOP()Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, v1, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    iget-object v3, v3, Lnl/xservices/plugins/Toast;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v3}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    invoke-virtual {v3}, Landroidx/appcompat/app/AppCompatActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getContext()Landroid/content/Context;

    move-result-object v3

    goto :goto_1

    :cond_2
    iget-object v3, v1, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    iget-object v3, v3, Lnl/xservices/plugins/Toast;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v3}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    invoke-virtual {v3}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    :goto_1
    iget-object v4, v1, Lnl/xservices/plugins/Toast$1;->val$message:Landroid/text/Spannable;

    .line 95
    iget-object v5, v1, Lnl/xservices/plugins/Toast$1;->val$duration:Ljava/lang/String;

    invoke-virtual {v2, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    const/4 v7, 0x1

    xor-int/2addr v2, v7

    .line 92
    invoke-static {v3, v4, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v6

    .line 98
    const-string v2, "top"

    iget-object v3, v1, Lnl/xservices/plugins/Toast$1;->val$position:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_3

    .line 99
    iget v2, v1, Lnl/xservices/plugins/Toast$1;->val$addPixelsY:I

    add-int/lit8 v2, v2, 0x14

    const/16 v4, 0x31

    invoke-virtual {v6, v4, v3, v2}, Landroid/widget/Toast;->setGravity(III)V

    goto :goto_2

    .line 100
    :cond_3
    const-string v2, "bottom"

    iget-object v4, v1, Lnl/xservices/plugins/Toast$1;->val$position:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 101
    iget v2, v1, Lnl/xservices/plugins/Toast$1;->val$addPixelsY:I

    rsub-int/lit8 v2, v2, 0x14

    const/16 v4, 0x51

    invoke-virtual {v6, v4, v3, v2}, Landroid/widget/Toast;->setGravity(III)V

    goto :goto_2

    .line 102
    :cond_4
    const-string v2, "center"

    iget-object v4, v1, Lnl/xservices/plugins/Toast$1;->val$position:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    const/16 v2, 0x11

    .line 103
    iget v4, v1, Lnl/xservices/plugins/Toast$1;->val$addPixelsY:I

    invoke-virtual {v6, v2, v3, v4}, Landroid/widget/Toast;->setGravity(III)V

    .line 111
    :goto_2
    iget-object v2, v1, Lnl/xservices/plugins/Toast$1;->val$styling:Lorg/json/JSONObject;

    if-eqz v2, :cond_6

    invoke-static {}, Lnl/xservices/plugins/Toast;->-$$Nest$sfgetIS_AT_LEAST_JELLY_BEAN()Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-static {}, Lnl/xservices/plugins/Toast;->-$$Nest$sfgetIS_AT_LEAST_R()Z

    move-result v2

    if-nez v2, :cond_6

    .line 114
    iget-object v2, v1, Lnl/xservices/plugins/Toast$1;->val$styling:Lorg/json/JSONObject;

    const-string v3, "backgroundColor"

    const-string v4, "#333333"

    invoke-virtual {v2, v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 115
    iget-object v3, v1, Lnl/xservices/plugins/Toast$1;->val$styling:Lorg/json/JSONObject;

    const-string v4, "textColor"

    const-string v5, "#ffffff"

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 116
    iget-object v4, v1, Lnl/xservices/plugins/Toast$1;->val$styling:Lorg/json/JSONObject;

    const-string v5, "textSize"

    const-wide/high16 v8, -0x4010000000000000L    # -1.0

    invoke-virtual {v4, v5, v8, v9}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v4

    .line 117
    iget-object v5, v1, Lnl/xservices/plugins/Toast$1;->val$styling:Lorg/json/JSONObject;

    const-string v10, "opacity"

    const-wide v11, 0x3fe999999999999aL    # 0.8

    invoke-virtual {v5, v10, v11, v12}, Lorg/json/JSONObject;->optDouble(Ljava/lang/String;D)D

    move-result-wide v10

    .line 118
    iget-object v5, v1, Lnl/xservices/plugins/Toast$1;->val$styling:Lorg/json/JSONObject;

    const-string v12, "cornerRadius"

    const/16 v13, 0x64

    invoke-virtual {v5, v12, v13}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v5

    .line 119
    iget-object v12, v1, Lnl/xservices/plugins/Toast$1;->val$styling:Lorg/json/JSONObject;

    const-string v13, "horizontalPadding"

    const/16 v14, 0x32

    invoke-virtual {v12, v13, v14}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v12

    .line 120
    iget-object v13, v1, Lnl/xservices/plugins/Toast$1;->val$styling:Lorg/json/JSONObject;

    const-string v14, "verticalPadding"

    const/16 v15, 0x1e

    invoke-virtual {v13, v14, v15}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v13

    .line 122
    new-instance v14, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v14}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    int-to-float v5, v5

    .line 123
    invoke-virtual {v14, v5}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    const-wide v15, 0x406fe00000000000L    # 255.0

    mul-double/2addr v10, v15

    double-to-int v5, v10

    .line 124
    invoke-virtual {v14, v5}, Landroid/graphics/drawable/GradientDrawable;->setAlpha(I)V

    .line 125
    invoke-static {v2}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v14, v2}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 126
    invoke-virtual {v6}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, v14}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 129
    invoke-virtual {v6}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v2

    const v5, 0x102000b

    invoke-virtual {v2, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 130
    invoke-static {v3}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 131
    invoke-virtual {v4}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v10

    cmpl-double v3, v10, v8

    if-lez v3, :cond_5

    .line 132
    invoke-virtual {v4}, Ljava/lang/Double;->floatValue()F

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextSize(F)V

    .line 135
    :cond_5
    invoke-virtual {v6}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, v12, v13, v12, v13}, Landroid/view/View;->setPadding(IIII)V

    .line 138
    invoke-static {}, Lnl/xservices/plugins/Toast;->-$$Nest$sfgetIS_AT_LEAST_LOLLIPOP()Z

    move-result v2

    if-eqz v2, :cond_6

    .line 139
    invoke-virtual {v6}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v2

    const/high16 v3, 0x40c00000    # 6.0f

    invoke-virtual {v2, v3}, Landroid/view/View;->setElevation(F)V

    .line 143
    :cond_6
    invoke-static {}, Lnl/xservices/plugins/Toast;->-$$Nest$sfgetIS_AT_LEAST_R()Z

    move-result v2

    if-eqz v2, :cond_7

    goto :goto_3

    .line 147
    :cond_7
    invoke-static {}, Lnl/xservices/plugins/Toast;->-$$Nest$sfgetIS_AT_LEAST_LOLLIPOP()Z

    move-result v2

    if-eqz v2, :cond_8

    .line 150
    iget-object v2, v1, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    invoke-static {v2}, Lnl/xservices/plugins/Toast;->-$$Nest$mgetViewGroup(Lnl/xservices/plugins/Toast;)Landroid/view/ViewGroup;

    move-result-object v2

    new-instance v3, Lnl/xservices/plugins/Toast$1$1;

    invoke-direct {v3, v1}, Lnl/xservices/plugins/Toast$1$1;-><init>(Lnl/xservices/plugins/Toast$1;)V

    invoke-virtual {v2, v3}, Landroid/view/ViewGroup;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    goto :goto_3

    .line 194
    :cond_8
    invoke-virtual {v6}, Landroid/widget/Toast;->getView()Landroid/view/View;

    move-result-object v2

    new-instance v3, Lnl/xservices/plugins/Toast$1$2;

    invoke-direct {v3, v1}, Lnl/xservices/plugins/Toast$1$2;-><init>(Lnl/xservices/plugins/Toast$1;)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 202
    :goto_3
    new-instance v2, Lnl/xservices/plugins/Toast$1$3;

    int-to-long v3, v0

    move-object v0, v2

    move-wide v2, v3

    const-wide/16 v4, 0x9c4

    invoke-direct/range {v0 .. v6}, Lnl/xservices/plugins/Toast$1$3;-><init>(Lnl/xservices/plugins/Toast$1;JJLandroid/widget/Toast;)V

    .line 214
    invoke-virtual {v0}, Lnl/xservices/plugins/Toast$1$3;->start()Landroid/os/CountDownTimer;

    move-result-object v0

    invoke-static {v0}, Lnl/xservices/plugins/Toast;->-$$Nest$sfput_timer(Landroid/os/CountDownTimer;)V

    .line 216
    iget-object v0, v1, Lnl/xservices/plugins/Toast$1;->this$0:Lnl/xservices/plugins/Toast;

    invoke-static {v0, v6}, Lnl/xservices/plugins/Toast;->-$$Nest$fputmostRecentToast(Lnl/xservices/plugins/Toast;Landroid/widget/Toast;)V

    .line 217
    invoke-virtual {v6}, Landroid/widget/Toast;->show()V

    .line 219
    new-instance v0, Lorg/apache/cordova/PluginResult;

    sget-object v2, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {v0, v2}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;)V

    .line 220
    invoke-virtual {v0, v7}, Lorg/apache/cordova/PluginResult;->setKeepCallback(Z)V

    .line 221
    iget-object v2, v1, Lnl/xservices/plugins/Toast$1;->val$callbackContext:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v2, v0}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    return-void

    .line 105
    :cond_9
    iget-object v0, v1, Lnl/xservices/plugins/Toast$1;->val$callbackContext:Lorg/apache/cordova/CallbackContext;

    const-string v2, "invalid position. valid options are \'top\', \'center\' and \'bottom\'"

    invoke-virtual {v0, v2}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return-void
.end method
