.class public Lnl/xservices/plugins/Toast;
.super Lorg/apache/cordova/CordovaPlugin;
.source "Toast.java"


# static fields
.field private static final ACTION_HIDE_EVENT:Ljava/lang/String; = "hide"

.field private static final ACTION_SHOW_EVENT:Ljava/lang/String; = "show"

.field private static final BASE_TOP_BOTTOM_OFFSET:I = 0x14

.field private static final GRAVITY_BOTTOM:I = 0x51

.field private static final GRAVITY_CENTER:I = 0x11

.field private static final GRAVITY_TOP:I = 0x31

.field private static final IS_AT_LEAST_JELLY_BEAN:Z

.field private static final IS_AT_LEAST_LOLLIPOP:Z

.field private static final IS_AT_LEAST_PIE:Z

.field private static final IS_AT_LEAST_R:Z

.field private static _timer:Landroid/os/CountDownTimer;


# instance fields
.field private currentData:Lorg/json/JSONObject;

.field private currentMessage:Ljava/lang/String;

.field private isPaused:Z

.field private mostRecentToast:Landroid/widget/Toast;

.field private viewGroup:Landroid/view/ViewGroup;


# direct methods
.method static bridge synthetic -$$Nest$fgetmostRecentToast(Lnl/xservices/plugins/Toast;)Landroid/widget/Toast;
    .locals 0

    iget-object p0, p0, Lnl/xservices/plugins/Toast;->mostRecentToast:Landroid/widget/Toast;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fputmostRecentToast(Lnl/xservices/plugins/Toast;Landroid/widget/Toast;)V
    .locals 0

    iput-object p1, p0, Lnl/xservices/plugins/Toast;->mostRecentToast:Landroid/widget/Toast;

    return-void
.end method

.method static bridge synthetic -$$Nest$mgetViewGroup(Lnl/xservices/plugins/Toast;)Landroid/view/ViewGroup;
    .locals 0

    invoke-direct {p0}, Lnl/xservices/plugins/Toast;->getViewGroup()Landroid/view/ViewGroup;

    move-result-object p0

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mreturnTapEvent(Lnl/xservices/plugins/Toast;Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)Z
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lnl/xservices/plugins/Toast;->returnTapEvent(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$sfgetIS_AT_LEAST_JELLY_BEAN()Z
    .locals 1

    sget-boolean v0, Lnl/xservices/plugins/Toast;->IS_AT_LEAST_JELLY_BEAN:Z

    return v0
.end method

.method static bridge synthetic -$$Nest$sfgetIS_AT_LEAST_LOLLIPOP()Z
    .locals 1

    sget-boolean v0, Lnl/xservices/plugins/Toast;->IS_AT_LEAST_LOLLIPOP:Z

    return v0
.end method

.method static bridge synthetic -$$Nest$sfgetIS_AT_LEAST_R()Z
    .locals 1

    sget-boolean v0, Lnl/xservices/plugins/Toast;->IS_AT_LEAST_R:Z

    return v0
.end method

.method static bridge synthetic -$$Nest$sfput_timer(Landroid/os/CountDownTimer;)V
    .locals 0

    sput-object p0, Lnl/xservices/plugins/Toast;->_timer:Landroid/os/CountDownTimer;

    return-void
.end method

.method static constructor <clinit>()V
    .locals 4

    const/4 v0, 0x1

    .line 38
    sput-boolean v0, Lnl/xservices/plugins/Toast;->IS_AT_LEAST_JELLY_BEAN:Z

    .line 39
    sput-boolean v0, Lnl/xservices/plugins/Toast;->IS_AT_LEAST_LOLLIPOP:Z

    .line 40
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1c

    const/4 v3, 0x0

    if-lt v1, v2, :cond_0

    move v1, v0

    goto :goto_0

    :cond_0
    move v1, v3

    :goto_0
    sput-boolean v1, Lnl/xservices/plugins/Toast;->IS_AT_LEAST_PIE:Z

    .line 41
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1e

    if-lt v1, v2, :cond_1

    goto :goto_1

    :cond_1
    move v0, v3

    :goto_1
    sput-boolean v0, Lnl/xservices/plugins/Toast;->IS_AT_LEAST_R:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    return-void
.end method

.method private getViewGroup()Landroid/view/ViewGroup;
    .locals 2

    .line 258
    iget-object v0, p0, Lnl/xservices/plugins/Toast;->viewGroup:Landroid/view/ViewGroup;

    if-nez v0, :cond_0

    .line 259
    iget-object v0, p0, Lnl/xservices/plugins/Toast;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    const v1, 0x1020002

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    iput-object v0, p0, Lnl/xservices/plugins/Toast;->viewGroup:Landroid/view/ViewGroup;

    .line 261
    :cond_0
    iget-object v0, p0, Lnl/xservices/plugins/Toast;->viewGroup:Landroid/view/ViewGroup;

    return-object v0
.end method

.method private hide()V
    .locals 2

    .line 234
    iget-object v0, p0, Lnl/xservices/plugins/Toast;->mostRecentToast:Landroid/widget/Toast;

    if-eqz v0, :cond_0

    .line 235
    invoke-virtual {v0}, Landroid/widget/Toast;->cancel()V

    .line 236
    invoke-direct {p0}, Lnl/xservices/plugins/Toast;->getViewGroup()Landroid/view/ViewGroup;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 238
    :cond_0
    sget-object v0, Lnl/xservices/plugins/Toast;->_timer:Landroid/os/CountDownTimer;

    if-eqz v0, :cond_1

    .line 239
    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    :cond_1
    return-void
.end method

.method private returnTapEvent(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)Z
    .locals 2

    .line 244
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 246
    :try_start_0
    const-string v1, "event"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 247
    const-string p1, "message"

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 248
    const-string p1, "data"

    invoke-virtual {v0, p1, p3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 250
    invoke-virtual {p1}, Lorg/json/JSONException;->printStackTrace()V

    .line 252
    :goto_0
    invoke-virtual {p4, v0}, Lorg/apache/cordova/CallbackContext;->success(Lorg/json/JSONObject;)V

    const/4 p1, 0x1

    return p1
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    move-object v6, p3

    .line 52
    const-string v2, "hide"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    const/4 v10, 0x1

    if-eqz v3, :cond_0

    .line 53
    iget-object v0, p0, Lnl/xservices/plugins/Toast;->currentMessage:Ljava/lang/String;

    iget-object v3, p0, Lnl/xservices/plugins/Toast;->currentData:Lorg/json/JSONObject;

    invoke-direct {p0, v2, v0, v3, p3}, Lnl/xservices/plugins/Toast;->returnTapEvent(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)Z

    .line 54
    invoke-direct {p0}, Lnl/xservices/plugins/Toast;->hide()V

    .line 55
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    return v10

    .line 58
    :cond_0
    const-string v2, "show"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_4

    .line 59
    iget-boolean v0, p0, Lnl/xservices/plugins/Toast;->isPaused:Z

    if-eqz v0, :cond_1

    return v10

    .line 63
    :cond_1
    invoke-virtual {p2, v3}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v0

    .line 64
    const-string v2, "message"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 65
    new-instance v2, Landroid/text/SpannableString;

    invoke-direct {v2, v8}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 66
    new-instance v4, Landroid/text/style/AlignmentSpan$Standard;

    sget-object v5, Landroid/text/Layout$Alignment;->ALIGN_CENTER:Landroid/text/Layout$Alignment;

    invoke-direct {v4, v5}, Landroid/text/style/AlignmentSpan$Standard;-><init>(Landroid/text/Layout$Alignment;)V

    .line 69
    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v5

    sub-int/2addr v5, v10

    const/16 v7, 0x12

    .line 66
    invoke-interface {v2, v4, v3, v5, v7}, Landroid/text/Spannable;->setSpan(Ljava/lang/Object;III)V

    .line 72
    const-string v4, "duration"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 73
    const-string v5, "position"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 74
    const-string v7, "addPixelsY"

    invoke-virtual {v0, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_2

    invoke-virtual {v0, v7}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    .line 75
    :cond_2
    const-string v7, "data"

    invoke-virtual {v0, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_3

    invoke-virtual {v0, v7}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v7

    goto :goto_0

    :cond_3
    const/4 v7, 0x0

    :goto_0
    move-object v9, v7

    .line 76
    const-string v7, "styling"

    invoke-virtual {v0, v7}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v7

    .line 78
    iput-object v8, p0, Lnl/xservices/plugins/Toast;->currentMessage:Ljava/lang/String;

    .line 79
    iput-object v9, p0, Lnl/xservices/plugins/Toast;->currentData:Lorg/json/JSONObject;

    .line 81
    iget-object v0, p0, Lnl/xservices/plugins/Toast;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v11

    new-instance v0, Lnl/xservices/plugins/Toast$1;

    move v1, v3

    move-object v3, v2

    move-object v2, v4

    move-object v4, v5

    move v5, v1

    move-object v1, p0

    invoke-direct/range {v0 .. v9}, Lnl/xservices/plugins/Toast$1;-><init>(Lnl/xservices/plugins/Toast;Ljava/lang/String;Landroid/text/Spannable;Ljava/lang/String;ILorg/apache/cordova/CallbackContext;Lorg/json/JSONObject;Ljava/lang/String;Lorg/json/JSONObject;)V

    invoke-virtual {v11, v0}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return v10

    .line 227
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "toast."

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " is not a supported function. Did you mean \'show\'?"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return v3
.end method

.method public onPause(Z)V
    .locals 0

    .line 266
    invoke-direct {p0}, Lnl/xservices/plugins/Toast;->hide()V

    const/4 p1, 0x1

    .line 267
    iput-boolean p1, p0, Lnl/xservices/plugins/Toast;->isPaused:Z

    return-void
.end method

.method public onResume(Z)V
    .locals 0

    const/4 p1, 0x0

    .line 272
    iput-boolean p1, p0, Lnl/xservices/plugins/Toast;->isPaused:Z

    return-void
.end method
