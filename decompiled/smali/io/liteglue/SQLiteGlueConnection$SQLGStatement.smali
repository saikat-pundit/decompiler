.class Lio/liteglue/SQLiteGlueConnection$SQLGStatement;
.super Ljava/lang/Object;
.source "SQLiteGlueConnection.java"

# interfaces
.implements Lio/liteglue/SQLiteStatement;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/liteglue/SQLiteGlueConnection;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SQLGStatement"
.end annotation


# instance fields
.field private columnCount:I

.field private hasRow:Z

.field private sql:Ljava/lang/String;

.field private sthandle:Lio/liteglue/SQLStatementHandle;

.field final synthetic this$0:Lio/liteglue/SQLiteGlueConnection;


# direct methods
.method constructor <init>(Lio/liteglue/SQLiteGlueConnection;Ljava/lang/String;)V
    .locals 1

    .line 61
    iput-object p1, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->this$0:Lio/liteglue/SQLiteGlueConnection;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 216
    iput-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    const/4 v0, 0x0

    .line 218
    iput-boolean v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    .line 219
    iput v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    .line 62
    iput-object p2, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sql:Ljava/lang/String;

    .line 63
    invoke-static {p1}, Lio/liteglue/SQLiteGlueConnection;->access$000(Lio/liteglue/SQLiteGlueConnection;)Lio/liteglue/SQLDatabaseHandle;

    move-result-object p1

    invoke-interface {p1, p2}, Lio/liteglue/SQLDatabaseHandle;->newStatementHandle(Ljava/lang/String;)Lio/liteglue/SQLStatementHandle;

    move-result-object p1

    iput-object p1, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    return-void
.end method


# virtual methods
.method public bindDouble(ID)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 74
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    if-eqz v0, :cond_1

    .line 76
    invoke-interface {v0, p1, p2, p3}, Lio/liteglue/SQLStatementHandle;->bindDouble(ID)I

    move-result p1

    if-nez p1, :cond_0

    return-void

    .line 77
    :cond_0
    new-instance p2, Ljava/sql/SQLException;

    new-instance p3, Ljava/lang/StringBuilder;

    const-string v0, "sqlite3_bind_double failure: "

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->this$0:Lio/liteglue/SQLiteGlueConnection;

    invoke-static {v0}, Lio/liteglue/SQLiteGlueConnection;->access$000(Lio/liteglue/SQLiteGlueConnection;)Lio/liteglue/SQLDatabaseHandle;

    move-result-object v0

    invoke-interface {v0}, Lio/liteglue/SQLDatabaseHandle;->getLastErrorMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    const-string v0, "failure"

    invoke-direct {p2, p3, v0, p1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p2

    .line 74
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    const-string p2, "failed"

    const/16 p3, 0x15

    const-string v0, "already disposed"

    invoke-direct {p1, v0, p2, p3}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public bindInteger(II)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 83
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    if-eqz v0, :cond_1

    .line 85
    invoke-interface {v0, p1, p2}, Lio/liteglue/SQLStatementHandle;->bindInteger(II)I

    move-result p1

    if-nez p1, :cond_0

    return-void

    .line 86
    :cond_0
    new-instance p2, Ljava/sql/SQLException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "sqlite3_bind_int failure: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->this$0:Lio/liteglue/SQLiteGlueConnection;

    invoke-static {v1}, Lio/liteglue/SQLiteGlueConnection;->access$000(Lio/liteglue/SQLiteGlueConnection;)Lio/liteglue/SQLDatabaseHandle;

    move-result-object v1

    invoke-interface {v1}, Lio/liteglue/SQLDatabaseHandle;->getLastErrorMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "failure"

    invoke-direct {p2, v0, v1, p1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p2

    .line 83
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    const-string p2, "failed"

    const/16 v0, 0x15

    const-string v1, "already disposed"

    invoke-direct {p1, v1, p2, v0}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public bindLong(IJ)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 92
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    if-eqz v0, :cond_1

    .line 94
    invoke-interface {v0, p1, p2, p3}, Lio/liteglue/SQLStatementHandle;->bindLong(IJ)I

    move-result p1

    if-nez p1, :cond_0

    return-void

    .line 95
    :cond_0
    new-instance p2, Ljava/sql/SQLException;

    new-instance p3, Ljava/lang/StringBuilder;

    const-string v0, "sqlite3_bind_int64 (long) failure: "

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->this$0:Lio/liteglue/SQLiteGlueConnection;

    invoke-static {v0}, Lio/liteglue/SQLiteGlueConnection;->access$000(Lio/liteglue/SQLiteGlueConnection;)Lio/liteglue/SQLDatabaseHandle;

    move-result-object v0

    invoke-interface {v0}, Lio/liteglue/SQLDatabaseHandle;->getLastErrorMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    const-string v0, "failure"

    invoke-direct {p2, p3, v0, p1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p2

    .line 92
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    const-string p2, "failed"

    const/16 p3, 0x15

    const-string v0, "already disposed"

    invoke-direct {p1, v0, p2, p3}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public bindNull(I)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 101
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    if-eqz v0, :cond_1

    .line 103
    invoke-interface {v0, p1}, Lio/liteglue/SQLStatementHandle;->bindNull(I)I

    move-result p1

    if-nez p1, :cond_0

    return-void

    .line 104
    :cond_0
    new-instance v0, Ljava/sql/SQLException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "sqlite3_bind_null failure: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->this$0:Lio/liteglue/SQLiteGlueConnection;

    invoke-static {v2}, Lio/liteglue/SQLiteGlueConnection;->access$000(Lio/liteglue/SQLiteGlueConnection;)Lio/liteglue/SQLDatabaseHandle;

    move-result-object v2

    invoke-interface {v2}, Lio/liteglue/SQLDatabaseHandle;->getLastErrorMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "failure"

    invoke-direct {v0, v1, v2, p1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 101
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    const-string v0, "failed"

    const/16 v1, 0x15

    const-string v2, "already disposed"

    invoke-direct {p1, v2, v0, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public bindTextNativeString(ILjava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 110
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    const/16 v1, 0x15

    const-string v2, "failed"

    if-eqz v0, :cond_2

    if-eqz p2, :cond_1

    .line 115
    invoke-interface {v0, p1, p2}, Lio/liteglue/SQLStatementHandle;->bindTextNativeString(ILjava/lang/String;)I

    move-result p1

    if-nez p1, :cond_0

    return-void

    .line 116
    :cond_0
    new-instance p2, Ljava/sql/SQLException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "sqlite3_bind_text failure: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->this$0:Lio/liteglue/SQLiteGlueConnection;

    invoke-static {v1}, Lio/liteglue/SQLiteGlueConnection;->access$000(Lio/liteglue/SQLiteGlueConnection;)Lio/liteglue/SQLDatabaseHandle;

    move-result-object v1

    invoke-interface {v1}, Lio/liteglue/SQLDatabaseHandle;->getLastErrorMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "failure"

    invoke-direct {p2, v0, v1, p1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p2

    .line 113
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    const-string p2, "null argument"

    invoke-direct {p1, p2, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 110
    :cond_2
    new-instance p1, Ljava/sql/SQLException;

    const-string p2, "already disposed"

    invoke-direct {p1, p2, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public dispose()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 209
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    if-eqz v0, :cond_0

    .line 212
    invoke-interface {v0}, Lio/liteglue/SQLStatementHandle;->finish()I

    const/4 v0, 0x0

    .line 213
    iput-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    return-void

    .line 209
    :cond_0
    new-instance v0, Ljava/sql/SQLException;

    const-string v1, "failed"

    const/16 v2, 0x15

    const-string v3, "already disposed"

    invoke-direct {v0, v3, v1, v2}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0
.end method

.method public getColumnCount()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 140
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    const/16 v1, 0x15

    const-string v2, "failed"

    if-eqz v0, :cond_1

    .line 141
    iget-boolean v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    if-eqz v0, :cond_0

    .line 143
    iget v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    return v0

    .line 141
    :cond_0
    new-instance v0, Ljava/sql/SQLException;

    const-string v3, "no result available"

    invoke-direct {v0, v3, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0

    .line 140
    :cond_1
    new-instance v0, Ljava/sql/SQLException;

    const-string v3, "already disposed"

    invoke-direct {v0, v3, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0
.end method

.method public getColumnDouble(I)D
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 169
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    const/16 v1, 0x15

    const-string v2, "failed"

    if-eqz v0, :cond_2

    .line 170
    iget-boolean v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    const-string v4, "no result available"

    if-eqz v3, :cond_1

    if-ltz p1, :cond_0

    .line 171
    iget v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    if-ge p1, v3, :cond_0

    .line 173
    invoke-interface {v0, p1}, Lio/liteglue/SQLStatementHandle;->getColumnDouble(I)D

    move-result-wide v0

    return-wide v0

    .line 171
    :cond_0
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 170
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 169
    :cond_2
    new-instance p1, Ljava/sql/SQLException;

    const-string v0, "already disposed"

    invoke-direct {p1, v0, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public getColumnInteger(I)I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 179
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    const/16 v1, 0x15

    const-string v2, "failed"

    if-eqz v0, :cond_2

    .line 180
    iget-boolean v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    const-string v4, "no result available"

    if-eqz v3, :cond_1

    if-ltz p1, :cond_0

    .line 181
    iget v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    if-ge p1, v3, :cond_0

    .line 183
    invoke-interface {v0, p1}, Lio/liteglue/SQLStatementHandle;->getColumnInteger(I)I

    move-result p1

    return p1

    .line 181
    :cond_0
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 180
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 179
    :cond_2
    new-instance p1, Ljava/sql/SQLException;

    const-string v0, "already disposed"

    invoke-direct {p1, v0, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public getColumnLong(I)J
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 189
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    const/16 v1, 0x15

    const-string v2, "failed"

    if-eqz v0, :cond_2

    .line 190
    iget-boolean v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    const-string v4, "no result available"

    if-eqz v3, :cond_1

    if-ltz p1, :cond_0

    .line 191
    iget v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    if-ge p1, v3, :cond_0

    .line 193
    invoke-interface {v0, p1}, Lio/liteglue/SQLStatementHandle;->getColumnLong(I)J

    move-result-wide v0

    return-wide v0

    .line 191
    :cond_0
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 190
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 189
    :cond_2
    new-instance p1, Ljava/sql/SQLException;

    const-string v0, "already disposed"

    invoke-direct {p1, v0, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public getColumnName(I)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 149
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    const/16 v1, 0x15

    const-string v2, "failed"

    if-eqz v0, :cond_2

    .line 150
    iget-boolean v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    const-string v4, "no result available"

    if-eqz v3, :cond_1

    if-ltz p1, :cond_0

    .line 151
    iget v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    if-ge p1, v3, :cond_0

    .line 153
    invoke-interface {v0, p1}, Lio/liteglue/SQLStatementHandle;->getColumnName(I)Ljava/lang/String;

    move-result-object p1

    return-object p1

    .line 151
    :cond_0
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 150
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 149
    :cond_2
    new-instance p1, Ljava/sql/SQLException;

    const-string v0, "already disposed"

    invoke-direct {p1, v0, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public getColumnTextNativeString(I)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 199
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    const/16 v1, 0x15

    const-string v2, "failed"

    if-eqz v0, :cond_2

    .line 200
    iget-boolean v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    const-string v4, "no result available"

    if-eqz v3, :cond_1

    if-ltz p1, :cond_0

    .line 201
    iget v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    if-ge p1, v3, :cond_0

    .line 203
    invoke-interface {v0, p1}, Lio/liteglue/SQLStatementHandle;->getColumnTextNativeString(I)Ljava/lang/String;

    move-result-object p1

    return-object p1

    .line 201
    :cond_0
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 200
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 199
    :cond_2
    new-instance p1, Ljava/sql/SQLException;

    const-string v0, "already disposed"

    invoke-direct {p1, v0, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method public getColumnType(I)I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 159
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    const/16 v1, 0x15

    const-string v2, "failed"

    if-eqz v0, :cond_2

    .line 160
    iget-boolean v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    const-string v4, "no result available"

    if-eqz v3, :cond_1

    if-ltz p1, :cond_0

    .line 161
    iget v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    if-ge p1, v3, :cond_0

    .line 163
    invoke-interface {v0, p1}, Lio/liteglue/SQLStatementHandle;->getColumnType(I)I

    move-result p1

    return p1

    .line 161
    :cond_0
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 160
    :cond_1
    new-instance p1, Ljava/sql/SQLException;

    invoke-direct {p1, v4, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1

    .line 159
    :cond_2
    new-instance p1, Ljava/sql/SQLException;

    const-string v0, "already disposed"

    invoke-direct {p1, v0, v2, v1}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw p1
.end method

.method prepare()I
    .locals 1

    .line 68
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    invoke-interface {v0}, Lio/liteglue/SQLStatementHandle;->prepare()I

    move-result v0

    return v0
.end method

.method public step()Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/sql/SQLException;
        }
    .end annotation

    .line 122
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    if-eqz v0, :cond_4

    .line 124
    invoke-interface {v0}, Lio/liteglue/SQLStatementHandle;->step()I

    move-result v0

    const/16 v1, 0x64

    if-eqz v0, :cond_1

    if-eq v0, v1, :cond_1

    const/16 v2, 0x65

    if-ne v0, v2, :cond_0

    goto :goto_0

    .line 126
    :cond_0
    new-instance v1, Ljava/sql/SQLException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "sqlite3_step failure: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->this$0:Lio/liteglue/SQLiteGlueConnection;

    invoke-static {v3}, Lio/liteglue/SQLiteGlueConnection;->access$000(Lio/liteglue/SQLiteGlueConnection;)Lio/liteglue/SQLDatabaseHandle;

    move-result-object v3

    invoke-interface {v3}, Lio/liteglue/SQLDatabaseHandle;->getLastErrorMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "failure"

    invoke-direct {v1, v2, v3, v0}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v1

    :cond_1
    :goto_0
    const/4 v2, 0x0

    if-ne v0, v1, :cond_2

    const/4 v0, 0x1

    goto :goto_1

    :cond_2
    move v0, v2

    .line 129
    :goto_1
    iput-boolean v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    if-eqz v0, :cond_3

    .line 131
    iget-object v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->sthandle:Lio/liteglue/SQLStatementHandle;

    invoke-interface {v0}, Lio/liteglue/SQLStatementHandle;->getColumnCount()I

    move-result v0

    iput v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    goto :goto_2

    .line 132
    :cond_3
    iput v2, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->columnCount:I

    .line 134
    :goto_2
    iget-boolean v0, p0, Lio/liteglue/SQLiteGlueConnection$SQLGStatement;->hasRow:Z

    return v0

    .line 122
    :cond_4
    new-instance v0, Ljava/sql/SQLException;

    const-string v1, "failed"

    const/16 v2, 0x15

    const-string v3, "already disposed"

    invoke-direct {v0, v3, v1, v2}, Ljava/sql/SQLException;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    throw v0
.end method
