.class Lio/sqlc/SQLiteConnectorDatabase;
.super Lio/sqlc/SQLiteAndroidDatabase;
.source "SQLiteConnectorDatabase.java"


# static fields
.field static connector:Lio/liteglue/SQLiteConnector;


# instance fields
.field mydb:Lio/liteglue/SQLiteConnection;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 35
    new-instance v0, Lio/liteglue/SQLiteConnector;

    invoke-direct {v0}, Lio/liteglue/SQLiteConnector;-><init>()V

    sput-object v0, Lio/sqlc/SQLiteConnectorDatabase;->connector:Lio/liteglue/SQLiteConnector;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 33
    invoke-direct {p0}, Lio/sqlc/SQLiteAndroidDatabase;-><init>()V

    return-void
.end method

.method private executeSQLiteStatement(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Lorg/json/JSONObject;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;,
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 183
    const-string p3, "SQLitePlugin.executeSql[Batch](): Error="

    const-string v0, "executeSqlBatch"

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 187
    iget-object v2, p0, Lio/sqlc/SQLiteConnectorDatabase;->mydb:Lio/liteglue/SQLiteConnection;

    invoke-interface {v2, p1}, Lio/liteglue/SQLiteConnection;->prepareStatement(Ljava/lang/String;)Lio/liteglue/SQLiteStatement;

    move-result-object p1

    .line 192
    :try_start_0
    invoke-virtual {p2}, Lorg/json/JSONArray;->length()I

    move-result v2

    new-array v2, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    move v3, v2

    .line 194
    :goto_0
    invoke-virtual {p2}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-ge v3, v4, :cond_4

    .line 195
    invoke-virtual {p2, v3}, Lorg/json/JSONArray;->isNull(I)Z

    move-result v4

    if-eqz v4, :cond_0

    add-int/lit8 v4, v3, 0x1

    .line 196
    invoke-interface {p1, v4}, Lio/liteglue/SQLiteStatement;->bindNull(I)V

    goto :goto_2

    .line 198
    :cond_0
    invoke-virtual {p2, v3}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;

    move-result-object v4

    .line 199
    instance-of v5, v4, Ljava/lang/Float;

    if-nez v5, :cond_3

    instance-of v5, v4, Ljava/lang/Double;

    if-eqz v5, :cond_1

    goto :goto_1

    .line 201
    :cond_1
    instance-of v4, v4, Ljava/lang/Number;

    if-eqz v4, :cond_2

    add-int/lit8 v4, v3, 0x1

    .line 202
    invoke-virtual {p2, v3}, Lorg/json/JSONArray;->getLong(I)J

    move-result-wide v5

    invoke-interface {p1, v4, v5, v6}, Lio/liteglue/SQLiteStatement;->bindLong(IJ)V

    goto :goto_2

    :cond_2
    add-int/lit8 v4, v3, 0x1

    .line 204
    invoke-virtual {p2, v3}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-interface {p1, v4, v5}, Lio/liteglue/SQLiteStatement;->bindTextNativeString(ILjava/lang/String;)V

    goto :goto_2

    :cond_3
    :goto_1
    add-int/lit8 v4, v3, 0x1

    .line 200
    invoke-virtual {p2, v3}, Lorg/json/JSONArray;->getDouble(I)D

    move-result-wide v5

    invoke-interface {p1, v4, v5, v6}, Lio/liteglue/SQLiteStatement;->bindDouble(ID)V

    :goto_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 208
    :cond_4
    invoke-interface {p1}, Lio/liteglue/SQLiteStatement;->step()Z

    move-result p2
    :try_end_0
    .catch Ljava/sql/SQLException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_2

    if-eqz p2, :cond_a

    .line 229
    new-instance p2, Lorg/json/JSONArray;

    invoke-direct {p2}, Lorg/json/JSONArray;-><init>()V

    .line 231
    invoke-interface {p1}, Lio/liteglue/SQLiteStatement;->getColumnCount()I

    move-result p3

    .line 235
    :cond_5
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    move v3, v2

    :goto_3
    if-ge v3, p3, :cond_9

    .line 238
    :try_start_1
    invoke-interface {p1, v3}, Lio/liteglue/SQLiteStatement;->getColumnName(I)Ljava/lang/String;

    move-result-object v4

    .line 240
    invoke-interface {p1, v3}, Lio/liteglue/SQLiteStatement;->getColumnType(I)I

    move-result v5

    const/4 v6, 0x1

    if-eq v5, v6, :cond_8

    const/4 v6, 0x2

    if-eq v5, v6, :cond_7

    const/4 v6, 0x5

    if-eq v5, v6, :cond_6

    .line 256
    invoke-interface {p1, v3}, Lio/liteglue/SQLiteStatement;->getColumnTextNativeString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_4

    .line 242
    :cond_6
    sget-object v5, Lorg/json/JSONObject;->NULL:Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_4

    .line 246
    :cond_7
    invoke-interface {p1, v3}, Lio/liteglue/SQLiteStatement;->getColumnDouble(I)D

    move-result-wide v5

    invoke-virtual {v0, v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    goto :goto_4

    .line 250
    :cond_8
    invoke-interface {p1, v3}, Lio/liteglue/SQLiteStatement;->getColumnLong(I)J

    move-result-wide v5

    invoke-virtual {v0, v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    :goto_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 261
    :cond_9
    invoke-virtual {p2, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_5

    :catch_0
    move-exception v0

    .line 264
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 266
    :goto_5
    invoke-interface {p1}, Lio/liteglue/SQLiteStatement;->step()Z

    move-result v0

    if-nez v0, :cond_5

    .line 269
    :try_start_2
    const-string p3, "rows"

    invoke-virtual {v1, p3, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_6

    :catch_1
    move-exception p2

    .line 271
    invoke-virtual {p2}, Lorg/json/JSONException;->printStackTrace()V

    .line 275
    :cond_a
    :goto_6
    invoke-interface {p1}, Lio/liteglue/SQLiteStatement;->dispose()V

    return-object v1

    :catch_2
    move-exception p2

    .line 218
    invoke-virtual {p2}, Lorg/json/JSONException;->printStackTrace()V

    .line 219
    invoke-virtual {p2}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v1

    .line 220
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, p3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-static {v0, p3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 223
    invoke-interface {p1}, Lio/liteglue/SQLiteStatement;->dispose()V

    .line 224
    throw p2

    :catch_3
    move-exception p2

    .line 210
    invoke-virtual {p2}, Ljava/sql/SQLException;->printStackTrace()V

    .line 211
    invoke-virtual {p2}, Ljava/sql/SQLException;->getMessage()Ljava/lang/String;

    move-result-object v1

    .line 212
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, p3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-static {v0, p3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 215
    invoke-interface {p1}, Lio/liteglue/SQLiteStatement;->dispose()V

    .line 216
    throw p2
.end method


# virtual methods
.method bugWorkaround()V
    .locals 0

    return-void
.end method

.method closeDatabaseNow()V
    .locals 3

    .line 61
    :try_start_0
    iget-object v0, p0, Lio/sqlc/SQLiteConnectorDatabase;->mydb:Lio/liteglue/SQLiteConnection;

    if-eqz v0, :cond_0

    .line 62
    invoke-interface {v0}, Lio/liteglue/SQLiteConnection;->dispose()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .line 64
    const-class v1, Lio/sqlc/SQLitePlugin;

    const-string v1, "SQLitePlugin"

    const-string v2, "couldn\'t close database, ignoring"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    return-void
.end method

.method executeSqlBatch([Ljava/lang/String;[Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)V
    .locals 11

    .line 85
    const-string v0, "executeSqlBatch"

    iget-object v1, p0, Lio/sqlc/SQLiteConnectorDatabase;->mydb:Lio/liteglue/SQLiteConnection;

    if-nez v1, :cond_0

    .line 87
    const-string p1, "database has been closed"

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V

    return-void

    .line 91
    :cond_0
    array-length v1, p1

    .line 92
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    if-ge v4, v1, :cond_6

    const/4 v5, 0x0

    .line 105
    :try_start_0
    aget-object v6, p1, v4

    .line 107
    iget-object v7, p0, Lio/sqlc/SQLiteConnectorDatabase;->mydb:Lio/liteglue/SQLiteConnection;

    invoke-interface {v7}, Lio/liteglue/SQLiteConnection;->getTotalChanges()I

    move-result v7

    int-to-long v7, v7

    .line 108
    aget-object v9, p2, v4

    invoke-direct {p0, v6, v9, p3}, Lio/sqlc/SQLiteConnectorDatabase;->executeSQLiteStatement(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Lorg/json/JSONObject;

    move-result-object v5

    .line 109
    iget-object v6, p0, Lio/sqlc/SQLiteConnectorDatabase;->mydb:Lio/liteglue/SQLiteConnection;

    invoke-interface {v6}, Lio/liteglue/SQLiteConnection;->getTotalChanges()I

    move-result v6

    int-to-long v9, v6

    sub-long/2addr v9, v7

    .line 112
    const-string v6, "rowsAffected"

    invoke-virtual {v5, v6, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-wide/16 v6, 0x0

    cmp-long v8, v9, v6

    if-lez v8, :cond_1

    .line 114
    iget-object v8, p0, Lio/sqlc/SQLiteConnectorDatabase;->mydb:Lio/liteglue/SQLiteConnection;

    invoke-interface {v8}, Lio/liteglue/SQLiteConnection;->getLastInsertRowid()J

    move-result-wide v8

    cmp-long v6, v8, v6

    if-lez v6, :cond_1

    .line 116
    const-string v6, "insertId"

    invoke-virtual {v5, v6, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/sql/SQLException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 144
    :cond_1
    const-string v6, "unknown"

    goto :goto_1

    :catch_0
    move-exception v6

    .line 140
    invoke-virtual {v6}, Lorg/json/JSONException;->printStackTrace()V

    .line 141
    invoke-virtual {v6}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v6

    .line 143
    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "SQLitePlugin.executeSql[Batch](): UNEXPECTED JSON Error="

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v0, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    move v7, v3

    goto :goto_2

    :catch_1
    move-exception v6

    .line 120
    invoke-virtual {v6}, Ljava/sql/SQLException;->printStackTrace()V

    .line 121
    invoke-virtual {v6}, Ljava/sql/SQLException;->getErrorCode()I

    move-result v7

    .line 122
    invoke-virtual {v6}, Ljava/sql/SQLException;->getMessage()Ljava/lang/String;

    move-result-object v6

    .line 123
    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "SQLitePlugin.executeSql[Batch](): SQL Error code = "

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " message = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v0, v8}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v8, 0x1

    if-eq v7, v8, :cond_4

    const/16 v8, 0xd

    if-eq v7, v8, :cond_3

    const/16 v8, 0x13

    if-eq v7, v8, :cond_2

    goto :goto_1

    :cond_2
    const/4 v7, 0x6

    goto :goto_2

    :cond_3
    const/4 v7, 0x4

    goto :goto_2

    :cond_4
    const/4 v7, 0x5

    .line 147
    :goto_2
    const-string v8, "result"

    const-string v9, "type"

    if-eqz v5, :cond_5

    .line 148
    :try_start_1
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 150
    const-string v7, "success"

    invoke-virtual {v6, v9, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 151
    invoke-virtual {v6, v8, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 153
    invoke-virtual {v2, v6}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_3

    .line 155
    :cond_5
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 156
    const-string v10, "error"

    invoke-virtual {v5, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 158
    new-instance v9, Lorg/json/JSONObject;

    invoke-direct {v9}, Lorg/json/JSONObject;-><init>()V

    .line 159
    const-string v10, "message"

    invoke-virtual {v9, v10, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 160
    const-string v6, "code"

    invoke-virtual {v9, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 161
    invoke-virtual {v5, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 163
    invoke-virtual {v2, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_2

    goto :goto_3

    :catch_2
    move-exception v5

    .line 166
    invoke-virtual {v5}, Lorg/json/JSONException;->printStackTrace()V

    .line 167
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "SQLitePlugin.executeSql[Batch](): Error="

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_3
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_0

    .line 172
    :cond_6
    invoke-virtual {p3, v2}, Lorg/apache/cordova/CallbackContext;->success(Lorg/json/JSONArray;)V

    return-void
.end method

.method open(Ljava/io/File;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 51
    sget-object v0, Lio/sqlc/SQLiteConnectorDatabase;->connector:Lio/liteglue/SQLiteConnector;

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x6

    invoke-virtual {v0, p1, v1}, Lio/liteglue/SQLiteConnector;->newSQLiteConnection(Ljava/lang/String;I)Lio/liteglue/SQLiteConnection;

    move-result-object p1

    iput-object p1, p0, Lio/sqlc/SQLiteConnectorDatabase;->mydb:Lio/liteglue/SQLiteConnection;

    return-void
.end method
