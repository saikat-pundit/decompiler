.class final Lio/sqlc/SQLitePlugin$DBQuery;
.super Ljava/lang/Object;
.source "SQLitePlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/sqlc/SQLitePlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "DBQuery"
.end annotation


# instance fields
.field final cbc:Lorg/apache/cordova/CallbackContext;

.field final close:Z

.field final delete:Z

.field final jsonparams:[Lorg/json/JSONArray;

.field final queries:[Ljava/lang/String;

.field final stop:Z

.field final synthetic this$0:Lio/sqlc/SQLitePlugin;


# direct methods
.method constructor <init>(Lio/sqlc/SQLitePlugin;)V
    .locals 0

    .line 411
    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->this$0:Lio/sqlc/SQLitePlugin;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x1

    .line 412
    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->stop:Z

    const/4 p1, 0x0

    .line 413
    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->close:Z

    .line 414
    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->delete:Z

    const/4 p1, 0x0

    .line 415
    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->queries:[Ljava/lang/String;

    .line 416
    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->jsonparams:[Lorg/json/JSONArray;

    .line 417
    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    return-void
.end method

.method constructor <init>(Lio/sqlc/SQLitePlugin;ZLorg/apache/cordova/CallbackContext;)V
    .locals 0

    .line 401
    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->this$0:Lio/sqlc/SQLitePlugin;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x1

    .line 402
    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->stop:Z

    .line 403
    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->close:Z

    .line 404
    iput-boolean p2, p0, Lio/sqlc/SQLitePlugin$DBQuery;->delete:Z

    const/4 p1, 0x0

    .line 405
    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->queries:[Ljava/lang/String;

    .line 406
    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->jsonparams:[Lorg/json/JSONArray;

    .line 407
    iput-object p3, p0, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    return-void
.end method

.method constructor <init>(Lio/sqlc/SQLitePlugin;[Ljava/lang/String;[Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)V
    .locals 0

    .line 392
    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->this$0:Lio/sqlc/SQLitePlugin;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    .line 393
    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->stop:Z

    .line 394
    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->close:Z

    .line 395
    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBQuery;->delete:Z

    .line 396
    iput-object p2, p0, Lio/sqlc/SQLitePlugin$DBQuery;->queries:[Ljava/lang/String;

    .line 397
    iput-object p3, p0, Lio/sqlc/SQLitePlugin$DBQuery;->jsonparams:[Lorg/json/JSONArray;

    .line 398
    iput-object p4, p0, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    return-void
.end method
