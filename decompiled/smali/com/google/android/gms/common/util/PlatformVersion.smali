.class public final Lcom/google/android/gms/common/util/PlatformVersion;
.super Ljava/lang/Object;


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isAtLeastHoneycomb()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastHoneycombMR1()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastIceCreamSandwich()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastIceCreamSandwichMR1()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastJellyBean()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastJellyBeanMR1()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastJellyBeanMR2()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastKitKat()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastKitKatWatch()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastLollipop()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastLollipopMR1()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastM()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastN()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public static isAtLeastO()Z
    .locals 2

    .line 16
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public static isAtLeastP()Z
    .locals 2

    .line 17
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method
