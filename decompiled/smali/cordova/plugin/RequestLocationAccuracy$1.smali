.class Lcordova/plugin/RequestLocationAccuracy$1;
.super Ljava/lang/Object;
.source "RequestLocationAccuracy.java"

# interfaces
.implements Landroid/content/DialogInterface$OnCancelListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcordova/plugin/RequestLocationAccuracy;->onConnectionFailed(Lcom/google/android/gms/common/ConnectionResult;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcordova/plugin/RequestLocationAccuracy;


# direct methods
.method constructor <init>(Lcordova/plugin/RequestLocationAccuracy;)V
    .locals 0

    .line 515
    iput-object p1, p0, Lcordova/plugin/RequestLocationAccuracy$1;->this$0:Lcordova/plugin/RequestLocationAccuracy;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Landroid/content/DialogInterface;)V
    .locals 0

    .line 518
    iget-object p1, p0, Lcordova/plugin/RequestLocationAccuracy$1;->this$0:Lcordova/plugin/RequestLocationAccuracy;

    iget-object p1, p1, Lcordova/plugin/RequestLocationAccuracy;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {p1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p1

    invoke-virtual {p1}, Landroidx/appcompat/app/AppCompatActivity;->finish()V

    return-void
.end method
