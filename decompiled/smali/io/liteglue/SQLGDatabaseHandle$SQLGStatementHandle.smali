.class Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;
.super Ljava/lang/Object;
.source "SQLGDatabaseHandle.java"

# interfaces
.implements Lio/liteglue/SQLStatementHandle;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/liteglue/SQLGDatabaseHandle;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SQLGStatementHandle"
.end annotation


# instance fields
.field sql:Ljava/lang/String;

.field private sthandle:J

.field final synthetic this$0:Lio/liteglue/SQLGDatabaseHandle;


# direct methods
.method private constructor <init>(Lio/liteglue/SQLGDatabaseHandle;Ljava/lang/String;)V
    .locals 2

    .line 69
    iput-object p1, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->this$0:Lio/liteglue/SQLGDatabaseHandle;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    .line 204
    iput-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    .line 70
    iput-object p2, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sql:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Lio/liteglue/SQLGDatabaseHandle;Ljava/lang/String;Lio/liteglue/SQLGDatabaseHandle$1;)V
    .locals 0

    .line 68
    invoke-direct {p0, p1, p2}, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;-><init>(Lio/liteglue/SQLGDatabaseHandle;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public bindDouble(ID)I
    .locals 4

    .line 90
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/16 p1, 0x15

    return p1

    .line 92
    :cond_0
    invoke-static {v0, v1, p1, p2, p3}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_bind_double(JID)I

    move-result p1

    return p1
.end method

.method public bindInteger(II)I
    .locals 4

    .line 98
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/16 p1, 0x15

    return p1

    .line 100
    :cond_0
    invoke-static {v0, v1, p1, p2}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_bind_int(JII)I

    move-result p1

    return p1
.end method

.method public bindLong(IJ)I
    .locals 4

    .line 106
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/16 p1, 0x15

    return p1

    .line 108
    :cond_0
    invoke-static {v0, v1, p1, p2, p3}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_bind_long(JIJ)I

    move-result p1

    return p1
.end method

.method public bindNull(I)I
    .locals 4

    .line 114
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/16 p1, 0x15

    return p1

    .line 116
    :cond_0
    invoke-static {v0, v1, p1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_bind_null(JI)I

    move-result p1

    return p1
.end method

.method public bindTextNativeString(ILjava/lang/String;)I
    .locals 4

    .line 122
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/16 p1, 0x15

    return p1

    .line 124
    :cond_0
    invoke-static {v0, v1, p1, p2}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_bind_text_native(JILjava/lang/String;)I

    move-result p1

    return p1
.end method

.method public finish()I
    .locals 5

    .line 194
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-nez v4, :cond_0

    const/16 v0, 0x15

    return v0

    :cond_0
    const/4 v4, 0x0

    .line 197
    iput-object v4, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sql:Ljava/lang/String;

    .line 198
    iput-wide v2, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    .line 200
    invoke-static {v0, v1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_finish(J)I

    move-result v0

    return v0
.end method

.method public getColumnCount()I
    .locals 4

    .line 138
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/4 v0, -0x1

    return v0

    .line 140
    :cond_0
    invoke-static {v0, v1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_column_count(J)I

    move-result v0

    return v0
.end method

.method public getColumnDouble(I)D
    .locals 4

    .line 162
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const-wide/high16 v0, -0x4010000000000000L    # -1.0

    return-wide v0

    .line 164
    :cond_0
    invoke-static {v0, v1, p1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_column_double(JI)D

    move-result-wide v0

    return-wide v0
.end method

.method public getColumnInteger(I)I
    .locals 4

    .line 170
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/4 p1, -0x1

    return p1

    .line 172
    :cond_0
    invoke-static {v0, v1, p1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_column_int(JI)I

    move-result p1

    return p1
.end method

.method public getColumnLong(I)J
    .locals 4

    .line 178
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const-wide/16 v0, -0x1

    return-wide v0

    .line 180
    :cond_0
    invoke-static {v0, v1, p1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_column_long(JI)J

    move-result-wide v0

    return-wide v0
.end method

.method public getColumnName(I)Ljava/lang/String;
    .locals 4

    .line 146
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 148
    :cond_0
    invoke-static {v0, v1, p1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_column_name(JI)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public getColumnTextNativeString(I)Ljava/lang/String;
    .locals 4

    .line 186
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 188
    :cond_0
    invoke-static {v0, v1, p1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_column_text_native(JI)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public getColumnType(I)I
    .locals 4

    .line 154
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/4 p1, -0x1

    return p1

    .line 156
    :cond_0
    invoke-static {v0, v1, p1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_column_type(JI)I

    move-result p1

    return p1
.end method

.method public prepare()I
    .locals 4

    .line 76
    iget-object v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sql:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    goto :goto_0

    .line 78
    :cond_0
    iget-object v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->this$0:Lio/liteglue/SQLGDatabaseHandle;

    invoke-static {v0}, Lio/liteglue/SQLGDatabaseHandle;->access$100(Lio/liteglue/SQLGDatabaseHandle;)J

    move-result-wide v0

    iget-object v2, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sql:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_db_prepare_st(JLjava/lang/String;)Lio/liteglue/SQLiteNativeResponse;

    move-result-object v0

    .line 79
    invoke-virtual {v0}, Lio/liteglue/SQLiteNativeResponse;->getResult()I

    move-result v1

    if-eqz v1, :cond_1

    .line 80
    invoke-virtual {v0}, Lio/liteglue/SQLiteNativeResponse;->getResult()I

    move-result v0

    neg-int v0, v0

    return v0

    .line 83
    :cond_1
    invoke-virtual {v0}, Lio/liteglue/SQLiteNativeResponse;->getHandle()J

    move-result-wide v0

    iput-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const/4 v0, 0x0

    return v0

    :cond_2
    :goto_0
    const/16 v0, 0x15

    return v0
.end method

.method public step()I
    .locals 4

    .line 130
    iget-wide v0, p0, Lio/liteglue/SQLGDatabaseHandle$SQLGStatementHandle;->sthandle:J

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-nez v2, :cond_0

    const/16 v0, 0x15

    return v0

    .line 132
    :cond_0
    invoke-static {v0, v1}, Lio/liteglue/SQLiteNDKNativeDriver;->sqlc_st_step(J)I

    move-result v0

    return v0
.end method
