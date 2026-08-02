.class public Lorg/apache/cordova/geolocation/Geolocation;
.super Lorg/apache/cordova/CordovaPlugin;
.source "Geolocation.java"


# instance fields
.field TAG:Ljava/lang/String;

.field context:Lorg/apache/cordova/CallbackContext;

.field highAccuracyPermissions:[Ljava/lang/String;

.field lowAccuracyPermissions:[Ljava/lang/String;

.field permissionsToCheck:[Ljava/lang/String;

.field permissionsToRequest:[Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 5

    .line 34
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    .line 36
    const-string v0, "GeolocationPlugin"

    iput-object v0, p0, Lorg/apache/cordova/geolocation/Geolocation;->TAG:Ljava/lang/String;

    const/4 v0, 0x2

    .line 40
    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "android.permission.ACCESS_COARSE_LOCATION"

    aput-object v2, v0, v1

    const-string v3, "android.permission.ACCESS_FINE_LOCATION"

    const/4 v4, 0x1

    aput-object v3, v0, v4

    iput-object v0, p0, Lorg/apache/cordova/geolocation/Geolocation;->highAccuracyPermissions:[Ljava/lang/String;

    .line 41
    new-array v0, v4, [Ljava/lang/String;

    aput-object v2, v0, v1

    iput-object v0, p0, Lorg/apache/cordova/geolocation/Geolocation;->lowAccuracyPermissions:[Ljava/lang/String;

    return-void
.end method

.method private arrayContains([Ljava/lang/Object;Ljava/lang/Object;)Z
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([TT;TT;)Z"
        }
    .end annotation

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-nez p2, :cond_1

    .line 119
    array-length p2, p1

    move v2, v0

    :goto_0
    if-ge v2, p2, :cond_4

    aget-object v3, p1, v2

    if-nez v3, :cond_0

    return v1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 124
    :cond_1
    array-length v2, p1

    move v3, v0

    :goto_1
    if-ge v3, v2, :cond_4

    aget-object v4, p1, v3

    if-eq v4, p2, :cond_3

    .line 125
    invoke-virtual {p2, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    goto :goto_2

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_3
    :goto_2
    return v1

    :cond_4
    return v0
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 47
    iget-object v0, p0, Lorg/apache/cordova/geolocation/Geolocation;->TAG:Ljava/lang/String;

    const-string v1, "We are entering execute"

    invoke-static {v0, v1}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 48
    iput-object p3, p0, Lorg/apache/cordova/geolocation/Geolocation;->context:Lorg/apache/cordova/CallbackContext;

    .line 49
    const-string p3, "getPermission"

    invoke-virtual {p1, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const/4 p3, 0x0

    if-eqz p1, :cond_3

    .line 51
    invoke-virtual {p2, p3}, Lorg/json/JSONArray;->getBoolean(I)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 52
    iget-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->highAccuracyPermissions:[Ljava/lang/String;

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->lowAccuracyPermissions:[Ljava/lang/String;

    :goto_0
    iput-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->permissionsToCheck:[Ljava/lang/String;

    .line 56
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 p2, 0x1f

    if-gt p1, p2, :cond_1

    iget-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->highAccuracyPermissions:[Ljava/lang/String;

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->permissionsToCheck:[Ljava/lang/String;

    :goto_1
    iput-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->permissionsToRequest:[Ljava/lang/String;

    .line 58
    iget-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->permissionsToCheck:[Ljava/lang/String;

    invoke-virtual {p0, p1}, Lorg/apache/cordova/geolocation/Geolocation;->hasPermisssion([Ljava/lang/String;)Z

    move-result p1

    const/4 p2, 0x1

    if-eqz p1, :cond_2

    .line 60
    new-instance p1, Lorg/apache/cordova/PluginResult;

    sget-object p3, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-direct {p1, p3, v0}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;I)V

    .line 61
    iget-object p3, p0, Lorg/apache/cordova/geolocation/Geolocation;->context:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    return p2

    .line 65
    :cond_2
    iget-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->permissionsToRequest:[Ljava/lang/String;

    invoke-static {p0, p3, p1}, Lorg/apache/cordova/PermissionHelper;->requestPermissions(Lorg/apache/cordova/CordovaPlugin;I[Ljava/lang/String;)V

    return p2

    :cond_3
    return p3
.end method

.method public hasPermisssion([Ljava/lang/String;)Z
    .locals 4

    .line 96
    array-length v0, p1

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_1

    aget-object v3, p1, v2

    .line 98
    invoke-static {p0, v3}, Lorg/apache/cordova/PermissionHelper;->hasPermission(Lorg/apache/cordova/CordovaPlugin;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    return v1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    const/4 p1, 0x1

    return p1
.end method

.method public onRequestPermissionResult(I[Ljava/lang/String;[I)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 78
    iget-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->context:Lorg/apache/cordova/CallbackContext;

    if-eqz p1, :cond_2

    const/4 p1, 0x0

    .line 79
    :goto_0
    array-length v0, p3

    if-ge p1, v0, :cond_1

    .line 80
    aget v0, p3, p1

    .line 81
    aget-object v1, p2, p1

    const/4 v2, -0x1

    if-ne v0, v2, :cond_0

    .line 82
    iget-object v0, p0, Lorg/apache/cordova/geolocation/Geolocation;->permissionsToCheck:[Ljava/lang/String;

    invoke-direct {p0, v0, v1}, Lorg/apache/cordova/geolocation/Geolocation;->arrayContains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 83
    iget-object p1, p0, Lorg/apache/cordova/geolocation/Geolocation;->TAG:Ljava/lang/String;

    const-string p2, "Permission Denied!"

    invoke-static {p1, p2}, Lorg/apache/cordova/LOG;->d(Ljava/lang/String;Ljava/lang/String;)V

    .line 84
    new-instance p1, Lorg/apache/cordova/PluginResult;

    sget-object p2, Lorg/apache/cordova/PluginResult$Status;->ILLEGAL_ACCESS_EXCEPTION:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {p1, p2}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;)V

    .line 85
    iget-object p2, p0, Lorg/apache/cordova/geolocation/Geolocation;->context:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {p2, p1}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    return-void

    :cond_0
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 90
    :cond_1
    new-instance p1, Lorg/apache/cordova/PluginResult;

    sget-object p2, Lorg/apache/cordova/PluginResult$Status;->OK:Lorg/apache/cordova/PluginResult$Status;

    invoke-direct {p1, p2}, Lorg/apache/cordova/PluginResult;-><init>(Lorg/apache/cordova/PluginResult$Status;)V

    .line 91
    iget-object p2, p0, Lorg/apache/cordova/geolocation/Geolocation;->context:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {p2, p1}, Lorg/apache/cordova/CallbackContext;->sendPluginResult(Lorg/apache/cordova/PluginResult;)V

    :cond_2
    return-void
.end method

.method public requestPermissions(I)V
    .locals 1

    .line 113
    iget-object v0, p0, Lorg/apache/cordova/geolocation/Geolocation;->permissionsToRequest:[Ljava/lang/String;

    invoke-static {p0, p1, v0}, Lorg/apache/cordova/PermissionHelper;->requestPermissions(Lorg/apache/cordova/CordovaPlugin;I[Ljava/lang/String;)V

    return-void
.end method
