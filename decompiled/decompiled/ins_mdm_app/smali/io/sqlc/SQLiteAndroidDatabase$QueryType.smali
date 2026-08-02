.class final enum Lio/sqlc/SQLiteAndroidDatabase$QueryType;
.super Ljava/lang/Enum;
.source "SQLiteAndroidDatabase.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/sqlc/SQLiteAndroidDatabase;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "QueryType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lio/sqlc/SQLiteAndroidDatabase$QueryType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/sqlc/SQLiteAndroidDatabase$QueryType;

.field public static final enum begin:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

.field public static final enum commit:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

.field public static final enum delete:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

.field public static final enum insert:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

.field public static final enum other:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

.field public static final enum rollback:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

.field public static final enum select:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

.field public static final enum update:Lio/sqlc/SQLiteAndroidDatabase$QueryType;


# direct methods
.method private static synthetic $values()[Lio/sqlc/SQLiteAndroidDatabase$QueryType;
    .locals 8

    .line 590
    sget-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->update:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    sget-object v1, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->insert:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    sget-object v2, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->delete:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    sget-object v3, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->select:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    sget-object v4, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->begin:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    sget-object v5, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->commit:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    sget-object v6, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->rollback:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    sget-object v7, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->other:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    filled-new-array/range {v0 .. v7}, [Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 591
    new-instance v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    const-string v1, "update"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLiteAndroidDatabase$QueryType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->update:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    .line 592
    new-instance v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    const-string v1, "insert"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLiteAndroidDatabase$QueryType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->insert:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    .line 593
    new-instance v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    const-string v1, "delete"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLiteAndroidDatabase$QueryType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->delete:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    .line 594
    new-instance v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    const-string v1, "select"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLiteAndroidDatabase$QueryType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->select:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    .line 595
    new-instance v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    const-string v1, "begin"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLiteAndroidDatabase$QueryType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->begin:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    .line 596
    new-instance v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    const-string v1, "commit"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLiteAndroidDatabase$QueryType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->commit:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    .line 597
    new-instance v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    const-string v1, "rollback"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLiteAndroidDatabase$QueryType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->rollback:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    .line 598
    new-instance v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    const-string v1, "other"

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2}, Lio/sqlc/SQLiteAndroidDatabase$QueryType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->other:Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    .line 590
    invoke-static {}, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->$values()[Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    move-result-object v0

    sput-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->$VALUES:[Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 590
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/sqlc/SQLiteAndroidDatabase$QueryType;
    .locals 1

    .line 590
    const-class v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    return-object p0
.end method

.method public static values()[Lio/sqlc/SQLiteAndroidDatabase$QueryType;
    .locals 1

    .line 590
    sget-object v0, Lio/sqlc/SQLiteAndroidDatabase$QueryType;->$VALUES:[Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    invoke-virtual {v0}, [Lio/sqlc/SQLiteAndroidDatabase$QueryType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/sqlc/SQLiteAndroidDatabase$QueryType;

    return-object v0
.end method
