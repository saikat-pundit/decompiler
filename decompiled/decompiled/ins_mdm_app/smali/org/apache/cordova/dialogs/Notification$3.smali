.class Lorg/apache/cordova/dialogs/Notification$3;
.super Ljava/lang/Object;
.source "Notification.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/apache/cordova/dialogs/Notification;->confirm(Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/cordova/dialogs/Notification;

.field final synthetic val$buttonLabels:Lorg/json/JSONArray;

.field final synthetic val$callbackContext:Lorg/apache/cordova/CallbackContext;

.field final synthetic val$cordova:Lorg/apache/cordova/CordovaInterface;

.field final synthetic val$message:Ljava/lang/String;

.field final synthetic val$title:Ljava/lang/String;


# direct methods
.method constructor <init>(Lorg/apache/cordova/dialogs/Notification;Lorg/apache/cordova/CordovaInterface;Ljava/lang/String;Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 219
    iput-object p1, p0, Lorg/apache/cordova/dialogs/Notification$3;->this$0:Lorg/apache/cordova/dialogs/Notification;

    iput-object p2, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$cordova:Lorg/apache/cordova/CordovaInterface;

    iput-object p3, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$message:Ljava/lang/String;

    iput-object p4, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$title:Ljava/lang/String;

    iput-object p5, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$buttonLabels:Lorg/json/JSONArray;

    iput-object p6, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$callbackContext:Lorg/apache/cordova/CallbackContext;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 221
    iget-object v0, p0, Lorg/apache/cordova/dialogs/Notification$3;->this$0:Lorg/apache/cordova/dialogs/Notification;

    iget-object v1, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-static {v0, v1}, Lorg/apache/cordova/dialogs/Notification;->-$$Nest$mcreateDialog(Lorg/apache/cordova/dialogs/Notification;Lorg/apache/cordova/CordovaInterface;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 222
    iget-object v1, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$message:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 223
    iget-object v1, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$title:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    const/4 v1, 0x1

    .line 224
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    .line 227
    iget-object v2, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$buttonLabels:Lorg/json/JSONArray;

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v2

    const-string v3, "Notification"

    if-lez v2, :cond_0

    .line 229
    :try_start_0
    iget-object v2, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$buttonLabels:Lorg/json/JSONArray;

    const/4 v4, 0x0

    invoke-virtual {v2, v4}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v2

    new-instance v4, Lorg/apache/cordova/dialogs/Notification$3$1;

    invoke-direct {v4, p0}, Lorg/apache/cordova/dialogs/Notification$3$1;-><init>(Lorg/apache/cordova/dialogs/Notification$3;)V

    invoke-virtual {v0, v2, v4}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 237
    :catch_0
    const-string v2, "JSONException on first button."

    invoke-static {v3, v2}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 242
    :cond_0
    :goto_0
    iget-object v2, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$buttonLabels:Lorg/json/JSONArray;

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-le v2, v1, :cond_1

    .line 244
    :try_start_1
    iget-object v2, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$buttonLabels:Lorg/json/JSONArray;

    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lorg/apache/cordova/dialogs/Notification$3$2;

    invoke-direct {v2, p0}, Lorg/apache/cordova/dialogs/Notification$3$2;-><init>(Lorg/apache/cordova/dialogs/Notification$3;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    .line 252
    :catch_1
    const-string v1, "JSONException on second button."

    invoke-static {v3, v1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 257
    :cond_1
    :goto_1
    iget-object v1, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$buttonLabels:Lorg/json/JSONArray;

    invoke-virtual {v1}, Lorg/json/JSONArray;->length()I

    move-result v1

    const/4 v2, 0x2

    if-le v1, v2, :cond_2

    .line 259
    :try_start_2
    iget-object v1, p0, Lorg/apache/cordova/dialogs/Notification$3;->val$buttonLabels:Lorg/json/JSONArray;

    invoke-virtual {v1, v2}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lorg/apache/cordova/dialogs/Notification$3$3;

    invoke-direct {v2, p0}, Lorg/apache/cordova/dialogs/Notification$3$3;-><init>(Lorg/apache/cordova/dialogs/Notification$3;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_2

    .line 267
    :catch_2
    const-string v1, "JSONException on third button."

    invoke-static {v3, v1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 270
    :cond_2
    :goto_2
    new-instance v1, Lorg/apache/cordova/dialogs/Notification$3$4;

    invoke-direct {v1, p0}, Lorg/apache/cordova/dialogs/Notification$3$4;-><init>(Lorg/apache/cordova/dialogs/Notification$3;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroid/app/AlertDialog$Builder;

    .line 278
    iget-object v1, p0, Lorg/apache/cordova/dialogs/Notification$3;->this$0:Lorg/apache/cordova/dialogs/Notification;

    invoke-static {v1, v0}, Lorg/apache/cordova/dialogs/Notification;->-$$Nest$mchangeTextDirection(Lorg/apache/cordova/dialogs/Notification;Landroid/app/AlertDialog$Builder;)V

    return-void
.end method
