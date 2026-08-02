.class Lorg/apache/cordova/dialogs/Notification$1;
.super Ljava/lang/Object;
.source "Notification.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/apache/cordova/dialogs/Notification;->beep(J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/cordova/dialogs/Notification;

.field final synthetic val$count:J


# direct methods
.method constructor <init>(Lorg/apache/cordova/dialogs/Notification;J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 144
    iput-object p1, p0, Lorg/apache/cordova/dialogs/Notification$1;->this$0:Lorg/apache/cordova/dialogs/Notification;

    iput-wide p2, p0, Lorg/apache/cordova/dialogs/Notification$1;->val$count:J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    const/4 v0, 0x2

    .line 146
    invoke-static {v0}, Landroid/media/RingtoneManager;->getDefaultUri(I)Landroid/net/Uri;

    move-result-object v0

    .line 147
    iget-object v1, p0, Lorg/apache/cordova/dialogs/Notification$1;->this$0:Lorg/apache/cordova/dialogs/Notification;

    iget-object v1, v1, Lorg/apache/cordova/dialogs/Notification;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/appcompat/app/AppCompatActivity;->getBaseContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1, v0}, Landroid/media/RingtoneManager;->getRingtone(Landroid/content/Context;Landroid/net/Uri;)Landroid/media/Ringtone;

    move-result-object v0

    if-eqz v0, :cond_1

    const-wide/16 v1, 0x0

    move-wide v3, v1

    .line 151
    :goto_0
    iget-wide v5, p0, Lorg/apache/cordova/dialogs/Notification$1;->val$count:J

    cmp-long v5, v3, v5

    if-gez v5, :cond_1

    .line 152
    invoke-virtual {v0}, Landroid/media/Ringtone;->play()V

    const-wide/16 v5, 0x1388

    .line 154
    :goto_1
    invoke-virtual {v0}, Landroid/media/Ringtone;->isPlaying()Z

    move-result v7

    if-eqz v7, :cond_0

    cmp-long v7, v5, v1

    if-lez v7, :cond_0

    const-wide/16 v7, 0x64

    sub-long/2addr v5, v7

    .line 157
    :try_start_0
    invoke-static {v7, v8}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 159
    :catch_0
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Thread;->interrupt()V

    goto :goto_1

    :cond_0
    const-wide/16 v5, 0x1

    add-long/2addr v3, v5

    goto :goto_0

    :cond_1
    return-void
.end method
