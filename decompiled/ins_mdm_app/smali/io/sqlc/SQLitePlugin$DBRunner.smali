.class Lio/sqlc/SQLitePlugin$DBRunner;
.super Ljava/lang/Object;
.source "SQLitePlugin.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/sqlc/SQLitePlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DBRunner"
.end annotation


# instance fields
.field private bugWorkaround:Z

.field final dbname:Ljava/lang/String;

.field mydb:Lio/sqlc/SQLiteAndroidDatabase;

.field private oldImpl:Z

.field final openCbc:Lorg/apache/cordova/CallbackContext;

.field final q:Ljava/util/concurrent/BlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/BlockingQueue<",
            "Lio/sqlc/SQLitePlugin$DBQuery;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lio/sqlc/SQLitePlugin;


# direct methods
.method constructor <init>(Lio/sqlc/SQLitePlugin;Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)V
    .locals 0

    .line 314
    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBRunner;->this$0:Lio/sqlc/SQLitePlugin;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 315
    iput-object p2, p0, Lio/sqlc/SQLitePlugin$DBRunner;->dbname:Ljava/lang/String;

    .line 316
    const-string p1, "androidOldDatabaseImplementation"

    invoke-virtual {p3, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBRunner;->oldImpl:Z

    .line 317
    const-class p1, Lio/sqlc/SQLitePlugin;

    const-string p1, "Android db implementation: built-in android.database.sqlite package"

    const-string p2, "SQLitePlugin"

    invoke-static {p2, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 318
    iget-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBRunner;->oldImpl:Z

    if-eqz p1, :cond_0

    const-string p1, "androidBugWorkaround"

    invoke-virtual {p3, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    iput-boolean p1, p0, Lio/sqlc/SQLitePlugin$DBRunner;->bugWorkaround:Z

    if-eqz p1, :cond_1

    .line 320
    const-class p1, Lio/sqlc/SQLitePlugin;

    const-string p1, "Android db closing/locking workaround applied"

    invoke-static {p2, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 322
    :cond_1
    new-instance p1, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {p1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    iput-object p1, p0, Lio/sqlc/SQLitePlugin$DBRunner;->q:Ljava/util/concurrent/BlockingQueue;

    .line 323
    iput-object p4, p0, Lio/sqlc/SQLitePlugin$DBRunner;->openCbc:Lorg/apache/cordova/CallbackContext;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .line 328
    const-string v0, "couldn\'t delete database"

    const-string v1, "SQLitePlugin"

    :try_start_0
    iget-object v2, p0, Lio/sqlc/SQLitePlugin$DBRunner;->this$0:Lio/sqlc/SQLitePlugin;

    iget-object v3, p0, Lio/sqlc/SQLitePlugin$DBRunner;->dbname:Ljava/lang/String;

    iget-object v4, p0, Lio/sqlc/SQLitePlugin$DBRunner;->openCbc:Lorg/apache/cordova/CallbackContext;

    iget-boolean v5, p0, Lio/sqlc/SQLitePlugin$DBRunner;->oldImpl:Z

    invoke-static {v2, v3, v4, v5}, Lio/sqlc/SQLitePlugin;->-$$Nest$mopenDatabase(Lio/sqlc/SQLitePlugin;Ljava/lang/String;Lorg/apache/cordova/CallbackContext;Z)Lio/sqlc/SQLiteAndroidDatabase;

    move-result-object v2

    iput-object v2, p0, Lio/sqlc/SQLitePlugin$DBRunner;->mydb:Lio/sqlc/SQLiteAndroidDatabase;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    const/4 v2, 0x0

    .line 338
    :try_start_1
    iget-object v3, p0, Lio/sqlc/SQLitePlugin$DBRunner;->q:Ljava/util/concurrent/BlockingQueue;

    invoke-interface {v3}, Ljava/util/concurrent/BlockingQueue;->take()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lio/sqlc/SQLitePlugin$DBQuery;

    :goto_0
    move-object v2, v3

    .line 340
    iget-boolean v3, v2, Lio/sqlc/SQLitePlugin$DBQuery;->stop:Z

    if-nez v3, :cond_1

    .line 341
    iget-object v3, p0, Lio/sqlc/SQLitePlugin$DBRunner;->mydb:Lio/sqlc/SQLiteAndroidDatabase;

    iget-object v4, v2, Lio/sqlc/SQLitePlugin$DBQuery;->queries:[Ljava/lang/String;

    iget-object v5, v2, Lio/sqlc/SQLitePlugin$DBQuery;->jsonparams:[Lorg/json/JSONArray;

    iget-object v6, v2, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v3, v4, v5, v6}, Lio/sqlc/SQLiteAndroidDatabase;->executeSqlBatch([Ljava/lang/String;[Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)V

    .line 343
    iget-boolean v3, p0, Lio/sqlc/SQLitePlugin$DBRunner;->bugWorkaround:Z

    if-eqz v3, :cond_0

    iget-object v3, v2, Lio/sqlc/SQLitePlugin$DBQuery;->queries:[Ljava/lang/String;

    array-length v3, v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_0

    iget-object v3, v2, Lio/sqlc/SQLitePlugin$DBQuery;->queries:[Ljava/lang/String;

    const/4 v4, 0x0

    aget-object v3, v3, v4

    const-string v4, "COMMIT"

    if-ne v3, v4, :cond_0

    .line 344
    iget-object v3, p0, Lio/sqlc/SQLitePlugin$DBRunner;->mydb:Lio/sqlc/SQLiteAndroidDatabase;

    invoke-virtual {v3}, Lio/sqlc/SQLiteAndroidDatabase;->bugWorkaround()V

    .line 346
    :cond_0
    iget-object v3, p0, Lio/sqlc/SQLitePlugin$DBRunner;->q:Ljava/util/concurrent/BlockingQueue;

    invoke-interface {v3}, Ljava/util/concurrent/BlockingQueue;->take()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lio/sqlc/SQLitePlugin$DBQuery;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v3

    .line 349
    const-class v4, Lio/sqlc/SQLitePlugin;

    const-string v4, "unexpected error"

    invoke-static {v1, v4, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    if-eqz v2, :cond_4

    .line 352
    iget-boolean v3, v2, Lio/sqlc/SQLitePlugin$DBQuery;->close:Z

    if-eqz v3, :cond_4

    .line 354
    :try_start_2
    iget-object v3, p0, Lio/sqlc/SQLitePlugin$DBRunner;->this$0:Lio/sqlc/SQLitePlugin;

    iget-object v4, p0, Lio/sqlc/SQLitePlugin$DBRunner;->dbname:Ljava/lang/String;

    invoke-static {v3, v4}, Lio/sqlc/SQLitePlugin;->-$$Nest$mcloseDatabaseNow(Lio/sqlc/SQLitePlugin;Ljava/lang/String;)V

    .line 356
    iget-object v3, p0, Lio/sqlc/SQLitePlugin$DBRunner;->this$0:Lio/sqlc/SQLitePlugin;

    invoke-static {v3}, Lio/sqlc/SQLitePlugin;->-$$Nest$fgetdbrmap(Lio/sqlc/SQLitePlugin;)Ljava/util/Map;

    move-result-object v3

    iget-object v4, p0, Lio/sqlc/SQLitePlugin$DBRunner;->dbname:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 358
    iget-boolean v3, v2, Lio/sqlc/SQLitePlugin$DBQuery;->delete:Z

    if-nez v3, :cond_2

    .line 359
    iget-object v0, v2, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v0}, Lorg/apache/cordova/CallbackContext;->success()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_1

    .line 362
    :cond_2
    :try_start_3
    iget-object v3, p0, Lio/sqlc/SQLitePlugin$DBRunner;->this$0:Lio/sqlc/SQLitePlugin;

    iget-object v4, p0, Lio/sqlc/SQLitePlugin$DBRunner;->dbname:Ljava/lang/String;

    invoke-static {v3, v4}, Lio/sqlc/SQLitePlugin;->-$$Nest$mdeleteDatabaseNow(Lio/sqlc/SQLitePlugin;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 364
    iget-object v3, v2, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto :goto_1

    .line 366
    :cond_3
    iget-object v3, v2, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v3, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_1

    :catch_1
    move-exception v3

    .line 369
    :try_start_4
    const-class v4, Lio/sqlc/SQLitePlugin;

    invoke-static {v1, v0, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 370
    iget-object v0, v2, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "couldn\'t delete database: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_1

    :catch_2
    move-exception v0

    .line 374
    const-class v3, Lio/sqlc/SQLitePlugin;

    const-string v3, "couldn\'t close database"

    invoke-static {v1, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 375
    iget-object v1, v2, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    if-eqz v1, :cond_4

    .line 376
    iget-object v1, v2, Lio/sqlc/SQLitePlugin$DBQuery;->cbc:Lorg/apache/cordova/CallbackContext;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "couldn\'t close database: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    :cond_4
    :goto_1
    return-void

    :catch_3
    move-exception v0

    .line 330
    const-class v2, Lio/sqlc/SQLitePlugin;

    const-string v2, "unexpected error, stopping db thread"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 331
    iget-object v0, p0, Lio/sqlc/SQLitePlugin$DBRunner;->this$0:Lio/sqlc/SQLitePlugin;

    invoke-static {v0}, Lio/sqlc/SQLitePlugin;->-$$Nest$fgetdbrmap(Lio/sqlc/SQLitePlugin;)Ljava/util/Map;

    move-result-object v0

    iget-object v1, p0, Lio/sqlc/SQLitePlugin$DBRunner;->dbname:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
