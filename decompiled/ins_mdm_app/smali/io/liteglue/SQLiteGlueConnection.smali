.class Lio/liteglue/SQLiteGlueConnection;
.super Ljava/lang/Object;
.source "SQLiteGlueConnection.java"

# interfaces
.implements Lio/liteglue/SQLiteConnection;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/liteglue/SQLiteGlueConnection$SQLGStatement;
    }
.end annotation


# instance fields
.field private db:Lio/liteglue/SQLDatabaseHandle;


# direct methods
.method public constructor <init>(Ljava/lang/String;I)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 222
    iput-object v0, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    if-eqz p1, :cond_1

    .line 9
    new-instance v0, Lio/liteglue/SQLGDatabaseHandle;

    invoke-direct {v0, p1, p2}, Lio/liteglue/SQLGDatabaseHandle;-><init>(Ljava/lang/String;I)V

    .line 10
    invoke-interface {v0}, Lio/liteglue/SQLDatabaseHandle;->open()I

    move-result p1

    if-nez p1, :cond_0

    .line 13
    iput-object v0, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    return-void

    .line 12
    :cond_0
    new-instance p2, Ljava/sql/SQLException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sqlite3_open_v2 failure: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v0}, Lio/liteglue/SQLDatabaseHandle;->getLastErrorMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "failure"

    invoke-direct {p2, v0, v1, p1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p2

    .line 7
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    const-string p2, "failed"

    const/16 v0, 0x15

    const-string v1, "null argument"

    invoke-direct {p1, v1, p2, v0}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method static synthetic access$000(Lio/liteglue/SQLiteGlueConnection;)Lio/liteglue/SQLDatabaseHandle;
    .locals 0

    .line 3
    iget-object p0, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    return-object p0
.end method


# virtual methods
.method public dispose()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 19
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    if-eqz v0, :cond_1

    .line 21
    invoke-interface {v0}, Lio/liteglue/SQLDatabaseHandle;->close()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 23
    iput-object v0, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    return-void

    .line 22
    :cond_0
    new-instance v1, Ljava/sql/SQLException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "sqlite3_close failure: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    invoke-interface {v3}, Lio/liteglue/SQLDatabaseHandle;->getLastErrorMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "failure"

    invoke-direct {v1, v2, v3, v0}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v1

    .line 19
    :cond_1
    new-instance v0, Ljava/sql/SQLException;

    const-string v1, "failed"

    const/16 v2, 0x15

    const-string v3, "already disposed"

    invoke-direct {v0, v3, v1, v2}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0
.end method

.method public getLastInsertRowid()J
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 46
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    if-eqz v0, :cond_0

    .line 48
    invoke-interface {v0}, Lio/liteglue/SQLDatabaseHandle;->getLastInsertRowid()J

    move-result-wide v0

    return-wide v0

    .line 46
    :cond_0
    new-instance v0, Ljava/sql/SQLException;

    const-string v1, "failed"

    const/16 v2, 0x15

    const-string v3, "already disposed"

    invoke-direct {v0, v3, v1, v2}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0
.end method

.method public getTotalChanges()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 54
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    if-eqz v0, :cond_0

    .line 56
    invoke-interface {v0}, Lio/liteglue/SQLDatabaseHandle;->getTotalChanges()I

    move-result v0

    return v0

    .line 54
    :cond_0
    new-instance v0, Ljava/sql/SQLException;

    const-string v1, "failed"

    const/16 v2, 0x15

    const-string v3, "already disposed"

    invoke-direct {v0, v3, v1, v2}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0
.end method

.method public prepareStatement(Ljava/lang/String;)Lio/liteglue/SQLiteStatement;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 29
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    const/16 v1, 0x15

    const-string v2, "failed"

    if-eqz v0, :cond_2

    if-eqz p1, :cond_1

    .line 34
    new-instance v0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;

    invoke-direct {v0, p0, p1}, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;-><init>(Lio/liteglue/SQLiteGlueConnection;Ljava/lang/String;)V

    .line 35
    invoke-virtual {v0}, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->prepare()I

    move-result p1

    if-nez p1, :cond_0

    return-object v0

    .line 37
    :cond_0
    new-instance v0, Ljava/sql/SQLException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sqlite3_prepare_v2 failure: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lio/liteglue/SQLiteGlueConnection;->db:Lio/liteglue/SQLDatabaseHandle;

    invoke-interface {v2}, Lio/liteglue/SQLDatabaseHandle;->getLastErrorMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "failure"

    invoke-direct {v0, v1, v2, p1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 32
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    const-string v0, "null argument"

    invoke-direct {p1, v0, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 29
    :cond_2
    new-instance p1, Ljava/sql/SQLException;

    const-string v0, "already disposed"

    invoke-direct {p1, v0, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method
