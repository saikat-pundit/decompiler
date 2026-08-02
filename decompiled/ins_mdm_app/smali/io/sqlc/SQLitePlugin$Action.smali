.class final enum Lio/sqlc/SQLitePlugin$Action;
.super Ljava/lang/Enum;
.source "SQLitePlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/sqlc/SQLitePlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "Action"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/sqlc/SQLitePlugin$Action;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/sqlc/SQLitePlugin$Action;

.field public static final enum backgroundExecuteSqlBatch:Lio/sqlc/SQLitePlugin$Action;

.field public static final enum close:Lio/sqlc/SQLitePlugin$Action;

.field public static final enum delete:Lio/sqlc/SQLitePlugin$Action;

.field public static final enum echoStringValue:Lio/sqlc/SQLitePlugin$Action;

.field public static final enum executeSqlBatch:Lio/sqlc/SQLitePlugin$Action;

.field public static final enum open:Lio/sqlc/SQLitePlugin$Action;


# direct methods
.method private static synthetic $values()[Lio/sqlc/SQLitePlugin$Action;
    .locals 6

    .line 421
    sget-object v0, Lio/sqlc/SQLitePlugin$Action;->echoStringValue:Lio/sqlc/SQLitePlugin$Action;

    sget-object v1, Lio/sqlc/SQLitePlugin$Action;->open:Lio/sqlc/SQLitePlugin$Action;

    sget-object v2, Lio/sqlc/SQLitePlugin$Action;->close:Lio/sqlc/SQLitePlugin$Action;

    sget-object v3, Lio/sqlc/SQLitePlugin$Action;->delete:Lio/sqlc/SQLitePlugin$Action;

    sget-object v4, Lio/sqlc/SQLitePlugin$Action;->executeSqlBatch:Lio/sqlc/SQLitePlugin$Action;

    sget-object v5, Lio/sqlc/SQLitePlugin$Action;->backgroundExecuteSqlBatch:Lio/sqlc/SQLitePlugin$Action;

    filled-new-array/range {v0 .. v5}, [Lio/sqlc/SQLitePlugin$Action;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 422
    new-instance v0, Lio/sqlc/SQLitePlugin$Action;

    const-string v1, "echoStringValue"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLitePlugin$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLitePlugin$Action;->echoStringValue:Lio/sqlc/SQLitePlugin$Action;

    .line 423
    new-instance v0, Lio/sqlc/SQLitePlugin$Action;

    const-string v1, "open"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLitePlugin$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLitePlugin$Action;->open:Lio/sqlc/SQLitePlugin$Action;

    .line 424
    new-instance v0, Lio/sqlc/SQLitePlugin$Action;

    const-string v1, "close"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLitePlugin$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLitePlugin$Action;->close:Lio/sqlc/SQLitePlugin$Action;

    .line 425
    new-instance v0, Lio/sqlc/SQLitePlugin$Action;

    const-string v1, "delete"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLitePlugin$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLitePlugin$Action;->delete:Lio/sqlc/SQLitePlugin$Action;

    .line 426
    new-instance v0, Lio/sqlc/SQLitePlugin$Action;

    const-string v1, "executeSqlBatch"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLitePlugin$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLitePlugin$Action;->executeSqlBatch:Lio/sqlc/SQLitePlugin$Action;

    .line 427
    new-instance v0, Lio/sqlc/SQLitePlugin$Action;

    const-string v1, "backgroundExecuteSqlBatch"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLitePlugin$Action;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLitePlugin$Action;->backgroundExecuteSqlBatch:Lio/sqlc/SQLitePlugin$Action;

    .line 421
    invoke-static {}, Lio/sqlc/SQLitePlugin$Action;->$values()[Lio/sqlc/SQLitePlugin$Action;

    move-result-object v0

    sput-object v0, Lio/sqlc/SQLitePlugin$Action;->$VALUES:[Lio/sqlc/SQLitePlugin$Action;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 421
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/sqlc/SQLitePlugin$Action;
    .locals 1

    .line 421
    const-class v0, Lio/sqlc/SQLitePlugin$Action;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lio/sqlc/SQLitePlugin$Action;

    return-object p0
.end method

.method public static values()[Lio/sqlc/SQLitePlugin$Action;
    .locals 1

    .line 421
    sget-object v0, Lio/sqlc/SQLitePlugin$Action;->$VALUES:[Lio/sqlc/SQLitePlugin$Action;

    invoke-virtual {v0}, [Lio/sqlc/SQLitePlugin$Action;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/sqlc/SQLitePlugin$Action;

    return-object v0
.end method
