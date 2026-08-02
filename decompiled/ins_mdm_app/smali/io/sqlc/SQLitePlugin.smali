.class public Lio/sqlc/SQLitePlugin;
.super Lorg/apache/cordova/CordovaPlugin;
.source "SQLitePlugin.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/sqlc/SQLitePlugin$Action;,
        Lio/sqlc/SQLitePlugin$DBQuery;,
        Lio/sqlc/SQLitePlugin$DBRunner;
    }
.end annotation


# instance fields
.field private dbrmap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lio/sqlc/SQLitePlugin$DBRunner;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static bridge synthetic -$$Nest$fgetdbrmap(Lio/sqlc/SQLitePlugin;)Ljava/util/Map;
    .locals 0

    iget-object p0, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mcloseDatabaseNow(Lio/sqlc/SQLitePlugin;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lio/sqlc/SQLitePlugin;->closeDatabaseNow(Ljava/lang/String;)V

    return-void
.end method

.method static bridge synthetic -$$Nest$mdeleteDatabaseNow(Lio/sqlc/SQLitePlugin;Ljava/lang/String;)Z
    .locals 0

    invoke-direct {p0, p1}, Lio/sqlc/SQLitePlugin;->deleteDatabaseNow(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static bridge synthetic -$$Nest$mopenDatabase(Lio/sqlc/SQLitePlugin;Ljava/lang/String;Lorg/apache/cordova/CallbackContext;Z)Lio/sqlc/SQLiteAndroidDatabase;
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lio/sqlc/SQLitePlugin;->openDatabase(Ljava/lang/String;Lorg/apache/cordova/CallbackContext;Z)Lio/sqlc/SQLiteAndroidDatabase;

    move-result-object p0

    return-object p0
.end method

.method public constructor <init>()V
    .locals 1

    .line 28
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    .line 45
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    return-void
.end method

.method private closeDatabase(Ljava/lang/String;Lorg/apache/cordova/CallbackContext;)V
    .locals 2

    .line 232
    iget-object v0, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lio/sqlc/SQLitePlugin$DBRunner;

    if-eqz p1, :cond_1

    .line 235
    :try_start_0
    iget-object p1, p1, Lio/sqlc/SQLitePlugin$DBRunner;->q:Ljava/util/concurrent/BlockingQueue;

    new-instance v0, Lio/sqlc/SQLitePlugin$DBQuery;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1, p2}, Lio/sqlc/SQLitePlugin$DBQuery;-><init>(Lio/sqlc/SQLitePlugin;ZLorg/apache/cordova/CallbackContext;)V

    invoke-interface {p1, v0}, Ljava/util/concurrent/BlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 237
    const-string v0, "couldn\'t close database"

    if-eqz p2, :cond_0

    .line 238
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    .line 240
    :cond_0
    const-string p2, "SQLitePlugin"

    invoke-static {p2, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    :cond_1
    if-eqz p2, :cond_2

    .line 244
    invoke-virtual {p2}, Lorg/apache/cordova/CallbackContext;->success()V

    :cond_2
    :goto_0
    return-void
.end method

.method private closeDatabaseNow(Ljava/lang/String;)V
    .locals 1

    .line 255
    iget-object v0, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lio/sqlc/SQLitePlugin$DBRunner;

    if-eqz p1, :cond_0

    .line 258
    iget-object p1, p1, Lio/sqlc/SQLitePlugin$DBRunner;->mydb:Lio/sqlc/SQLiteAndroidDatabase;

    if-eqz p1, :cond_0

    .line 261
    invoke-virtual {p1}, Lio/sqlc/SQLiteAndroidDatabase;->closeDatabaseNow()V

    :cond_0
    return-void
.end method

.method private deleteDatabase(Ljava/lang/String;Lorg/apache/cordova/CallbackContext;)V
    .locals 2

    .line 266
    iget-object v0, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/sqlc/SQLitePlugin$DBRunner;

    if-eqz v0, :cond_1

    .line 269
    :try_start_0
    iget-object p1, v0, Lio/sqlc/SQLitePlugin$DBRunner;->q:Ljava/util/concurrent/BlockingQueue;

    new-instance v0, Lio/sqlc/SQLitePlugin$DBQuery;

    const/4 v1, 0x1

    invoke-direct {v0, p0, v1, p2}, Lio/sqlc/SQLitePlugin$DBQuery;-><init>(Lio/sqlc/SQLitePlugin;ZLorg/apache/cordova/CallbackContext;)V

    invoke-interface {p1, v0}, Ljava/util/concurrent/BlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 271
    const-string v0, "couldn\'t close database"

    if-eqz p2, :cond_0

    .line 272
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    .line 274
    :cond_0
    const-string p2, "SQLitePlugin"

    invoke-static {p2, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void

    .line 277
    :cond_1
    invoke-direct {p0, p1}, Lio/sqlc/SQLitePlugin;->deleteDatabaseNow(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 279
    invoke-virtual {p2}, Lorg/apache/cordova/CallbackContext;->success()V

    return-void

    .line 281
    :cond_2
    const-string p1, "couldn\'t delete database"

    invoke-virtual {p2, p1}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return-void
.end method

.method private deleteDatabaseNow(Ljava/lang/String;)Z
    .locals 2

    .line 294
    iget-object v0, p0, Lio/sqlc/SQLitePlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroidx/appcompat/app/AppCompatActivity;->getDatabasePath(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    .line 297
    :try_start_0
    iget-object v0, p0, Lio/sqlc/SQLitePlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroidx/appcompat/app/AppCompatActivity;->deleteDatabase(Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 299
    const-string v0, "SQLitePlugin"

    const-string v1, "couldn\'t delete database"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 p1, 0x0

    return p1
.end method

.method private executeAndPossiblyThrow(Lio/sqlc/SQLitePlugin$Action;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 88
    sget-object v0, Lio/sqlc/SQLitePlugin$1;->$SwitchMap$io$sqlc$SQLitePlugin$Action:[I

    invoke-virtual {p1}, Lio/sqlc/SQLitePlugin$Action;->ordinal()I

    move-result p1

    aget p1, v0, p1

    const-string v0, "path"

    const/4 v1, 0x0

    const/4 v2, 0x1

    packed-switch p1, :pswitch_data_0

    goto/16 :goto_1

    .line 119
    :pswitch_0
    invoke-virtual {p2, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object p1

    .line 120
    const-string p2, "dbargs"

    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p2

    .line 121
    const-string v0, "dbname"

    invoke-virtual {p2, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 122
    const-string v0, "executes"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    .line 124
    invoke-virtual {p1, v1}, Lorg/json/JSONArray;->isNull(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 125
    const-string p1, "INTERNAL PLUGIN ERROR: missing executes list"

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return v2

    .line 127
    :cond_0
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v0

    .line 128
    new-array v3, v0, [Ljava/lang/String;

    .line 129
    new-array v4, v0, [Lorg/json/JSONArray;

    :goto_0
    if-ge v1, v0, :cond_1

    .line 132
    invoke-virtual {p1, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    .line 133
    const-string v6, "sql"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v3, v1

    .line 134
    const-string v6, "params"

    invoke-virtual {v5, v6}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v5

    aput-object v5, v4, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 138
    :cond_1
    new-instance p1, Lio/sqlc/SQLitePlugin$DBQuery;

    invoke-direct {p1, p0, v3, v4, p3}, Lio/sqlc/SQLitePlugin$DBQuery;-><init>(Lio/sqlc/SQLitePlugin;[Ljava/lang/String;[Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)V

    .line 139
    iget-object v0, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {v0, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lio/sqlc/SQLitePlugin$DBRunner;

    if-eqz p2, :cond_2

    .line 142
    :try_start_0
    iget-object p2, p2, Lio/sqlc/SQLitePlugin$DBRunner;->q:Ljava/util/concurrent/BlockingQueue;

    invoke-interface {p2, p1}, Ljava/util/concurrent/BlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v2

    :catch_0
    move-exception p1

    .line 144
    const-string p2, "SQLitePlugin"

    const-string v0, "couldn\'t add to queue"

    invoke-static {p2, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 145
    const-string p1, "INTERNAL PLUGIN ERROR: couldn\'t add to queue"

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    goto :goto_1

    .line 148
    :cond_2
    const-string p1, "INTERNAL PLUGIN ERROR: database not open"

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return v2

    .line 110
    :pswitch_1
    invoke-virtual {p2, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object p1

    .line 111
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 113
    invoke-direct {p0, p1, p3}, Lio/sqlc/SQLitePlugin;->deleteDatabase(Ljava/lang/String;Lorg/apache/cordova/CallbackContext;)V

    return v2

    .line 103
    :pswitch_2
    invoke-virtual {p2, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object p1

    .line 104
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 106
    invoke-direct {p0, p1, p3}, Lio/sqlc/SQLitePlugin;->closeDatabase(Ljava/lang/String;Lorg/apache/cordova/CallbackContext;)V

    return v2

    .line 96
    :pswitch_3
    invoke-virtual {p2, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object p1

    .line 97
    const-string p2, "name"

    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 99
    invoke-direct {p0, p2, p1, p3}, Lio/sqlc/SQLitePlugin;->startDatabase(Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)V

    return v2

    .line 90
    :pswitch_4
    invoke-virtual {p2, v1}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object p1

    .line 91
    const-string p2, "value"

    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 92
    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(Ljava/lang/String;)V

    :goto_1
    return v2

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method private openDatabase(Ljava/lang/String;Lorg/apache/cordova/CallbackContext;Z)Lio/sqlc/SQLiteAndroidDatabase;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const-string v0, "Open sqlite db: "

    .line 204
    :try_start_0
    iget-object v1, p0, Lio/sqlc/SQLitePlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroidx/appcompat/app/AppCompatActivity;->getDatabasePath(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    .line 206
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 207
    invoke-virtual {p1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 210
    :cond_0
    const-string v1, "info"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p3, :cond_1

    .line 212
    new-instance p3, Lio/sqlc/SQLiteAndroidDatabase;

    invoke-direct {p3}, Lio/sqlc/SQLiteAndroidDatabase;-><init>()V

    goto :goto_0

    :cond_1
    new-instance p3, Lio/sqlc/SQLiteConnectorDatabase;

    invoke-direct {p3}, Lio/sqlc/SQLiteConnectorDatabase;-><init>()V

    .line 213
    :goto_0
    invoke-virtual {p3, p1}, Lio/sqlc/SQLiteAndroidDatabase;->open(Ljava/io/File;)V

    if-eqz p2, :cond_2

    .line 216
    invoke-virtual {p2}, Lorg/apache/cordova/CallbackContext;->success()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    return-object p3

    :catch_0
    move-exception p1

    if-eqz p2, :cond_3

    .line 221
    new-instance p3, Ljava/lang/StringBuilder;

    const-string v0, "can\'t open database "

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    .line 222
    :cond_3
    throw p1
.end method

.method private startDatabase(Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)V
    .locals 1

    .line 183
    iget-object v0, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/sqlc/SQLitePlugin$DBRunner;

    if-eqz v0, :cond_0

    .line 187
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "INTERNAL ERROR: database already open for db name: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return-void

    .line 189
    :cond_0
    new-instance v0, Lio/sqlc/SQLitePlugin$DBRunner;

    invoke-direct {v0, p0, p1, p2, p3}, Lio/sqlc/SQLitePlugin$DBRunner;-><init>(Lio/sqlc/SQLitePlugin;Ljava/lang/String;Lorg/json/JSONObject;Lorg/apache/cordova/CallbackContext;)V

    .line 190
    iget-object p2, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {p2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 191
    iget-object p1, p0, Lio/sqlc/SQLitePlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {p1}, Lorg/apache/cordova/CordovaInterface;->getThreadPool()Ljava/util/concurrent/ExecutorService;

    move-result-object p1

    invoke-interface {p1, v0}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 3

    .line 64
    const-string v0, "unexpected error"

    const-string v1, "SQLitePlugin"

    const/4 v2, 0x0

    :try_start_0
    invoke-static {p1}, Lio/sqlc/SQLitePlugin$Action;->valueOf(Ljava/lang/String;)Lio/sqlc/SQLitePlugin$Action;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1

    .line 72
    :try_start_1
    invoke-direct {p0, p1, p2, p3}, Lio/sqlc/SQLitePlugin;->executeAndPossiblyThrow(Lio/sqlc/SQLitePlugin$Action;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z

    move-result p1
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    return p1

    :catch_0
    move-exception p1

    .line 75
    invoke-static {v1, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return v2

    :catch_1
    move-exception p1

    .line 67
    invoke-static {v1, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return v2
.end method

.method public onDestroy()V
    .locals 4

    .line 162
    :goto_0
    iget-object v0, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 163
    iget-object v0, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 165
    invoke-direct {p0, v0}, Lio/sqlc/SQLitePlugin;->closeDatabaseNow(Ljava/lang/String;)V

    .line 167
    iget-object v1, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/sqlc/SQLitePlugin$DBRunner;

    .line 170
    :try_start_0
    iget-object v1, v1, Lio/sqlc/SQLitePlugin$DBRunner;->q:Ljava/util/concurrent/BlockingQueue;

    new-instance v2, Lio/sqlc/SQLitePlugin$DBQuery;

    invoke-direct {v2, p0}, Lio/sqlc/SQLitePlugin$DBQuery;-><init>(Lio/sqlc/SQLitePlugin;)V

    invoke-interface {v1, v2}, Ljava/util/concurrent/BlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v1

    .line 172
    const-string v2, "SQLitePlugin"

    const-string v3, "INTERNAL PLUGIN CLEANUP ERROR: could not stop db thread due to exception"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 174
    :goto_1
    iget-object v1, p0, Lio/sqlc/SQLitePlugin;->dbrmap:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_0
    return-void
.end method
