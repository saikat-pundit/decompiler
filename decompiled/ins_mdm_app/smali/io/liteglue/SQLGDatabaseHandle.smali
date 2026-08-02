.class Lio/liteglue/SQLGDatabaseHandle;
.super Ljava/lang/Object;
.source "SQLGDatabaseHandle.java"

# interfaces
.implements Lio/liteglue/SQLDatabaseHandle;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;
    }
.end annotation


# instance fields
.field dbfilename:Ljava/lang/String;

.field private dbhandle:J

.field openflags:I


# direct methods
.method public constructor <init>(Ljava/lang/String;I)V
    .locals 2

    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    .line 209
    iput-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    .line 5
    iput-object p1, p0, Lio/liteglue/SQLGDatabaseHandle;->dbfilename:Ljava/lang/String;

    .line 6
    iput p2, p0, Lio/liteglue/SQLGDatabaseHandle;->openflags:I

    return-void
.end method

.method static synthetic access$100(Lio/liteglue/SQLGDatabaseHandle;)J
    .locals 2

    .line 3
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    return-wide v0
.end method


# virtual methods
.method public close()I
    .locals 4

    .line 26
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/16 v0, 0x15

    return v0

    .line 28
    :cond_0
    invoke-static {v0, v1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_db_close(J)I

    move-result v0

    return v0
.end method

.method public getLastErrorMessage()Ljava/lang/String;
    .locals 4

    .line 63
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 64
    :cond_0
    invoke-static {v0, v1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_db_errmsg_native(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLastInsertRowid()J
    .locals 4

    .line 47
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const-wide/16 v0, -0x1

    return-wide v0

    .line 49
    :cond_0
    invoke-static {v0, v1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_db_last_insert_rowid(J)J

    move-result-wide v0

    return-wide v0
.end method

.method public getTotalChanges()I
    .locals 4

    .line 55
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/4 v0, -0x1

    return v0

    .line 57
    :cond_0
    invoke-static {v0, v1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_db_total_changes(J)I

    move-result v0

    return v0
.end method

.method public isOpen()Z
    .locals 4

    .line 33
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public newStatementHandle(Ljava/lang/String;)Lio/liteglue/SQLStatementHandle;
    .locals 4

    .line 39
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    .line 41
    :cond_0
    new-instance v0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;

    invoke-direct {v0, p0, p1, v1}, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;-><init>(Lio/liteglue/SQLGDatabaseHandle;Ljava/lang/String;Lio/liteglue/SQLGDatabaseHandle$1;)V

    return-object v0
.end method

.method public open()I
    .locals 5

    .line 12
    iget-object v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbfilename:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-wide v1, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-eqz v1, :cond_0

    goto :goto_0

    .line 14
    :cond_0
    iget v1, p0, Lio/liteglue/SQLGDatabaseHandle;->openflags:I

    invoke-static {v0, v1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_db_open(Ljava/lang/String;I)Lio/liteglue/SQLiteNativeResponse;

    move-result-object v0

    .line 15
    invoke-virtual {v0}, Lio/liteglue/SQLiteNativeResponse;->getResult()I

    move-result v1

    if-eqz v1, :cond_1

    .line 16
    invoke-virtual {v0}, Lio/liteglue/SQLiteNativeResponse;->getResult()I

    move-result v0

    neg-int v0, v0

    return v0

    .line 19
    :cond_1
    invoke-virtual {v0}, Lio/liteglue/SQLiteNativeResponse;->getHandle()J

    move-result-wide v0

    iput-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle;->dbhandle:J

    const/4 v0, 0x0

    return v0

    :cond_2
    :goto_0
    const/16 v0, 0x15

    return v0
.end method
