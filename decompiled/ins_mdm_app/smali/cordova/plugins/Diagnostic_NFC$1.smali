.class Lcordova/plugins/Diagnostic_NFC$1;
.super Landroid/content/BroadcastReceiver;
.source "Diagnostic_NFC.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcordova/plugins/Diagnostic_NFC;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcordova/plugins/Diagnostic_NFC;


# direct methods
.method constructor <init>(Lcordova/plugins/Diagnostic_NFC;)V
    .locals 0

    .line 254
    iput-object p1, p0, Lcordova/plugins/Diagnostic_NFC$1;->this$0:Lcordova/plugins/Diagnostic_NFC;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    .line 258
    :try_start_0
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    .line 259
    sget-object v0, Lcordova/plugins/Diagnostic_NFC;->instance:Lcordova/plugins/Diagnostic_NFC;

    if-eqz v0, :cond_0

    const-string v0, "android.nfc.action.ADAPTER_STATE_CHANGED"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 261
    const-string p1, "Diagnostic_NFC"

    const-string v0, "onReceiveNFCStateChange"

    invoke-static {p1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 262
    const-string p1, "android.nfc.extra.ADAPTER_STATE"

    const/4 v0, -0x1

    invoke-virtual {p2, p1, v0}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    .line 263
    sget-object p2, Lcordova/plugins/Diagnostic_NFC;->instance:Lcordova/plugins/Diagnostic_NFC;

    invoke-virtual {p2, p1}, Lcordova/plugins/Diagnostic_NFC;->notifyNFCStateChange(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 266
    iget-object p2, p0, Lcordova/plugins/Diagnostic_NFC$1;->this$0:Lcordova/plugins/Diagnostic_NFC;

    invoke-static {p2}, Lcordova/plugins/Diagnostic_NFC;->-$$Nest$fgetdiagnostic(Lcordova/plugins/Diagnostic_NFC;)Lcordova/plugins/Diagnostic;

    move-result-object p2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Error receiving NFC state change: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcordova/plugins/Diagnostic;->logError(Ljava/lang/String;)V

    :cond_0
    return-void
.end method
