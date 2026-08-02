.class public Lcordova/plugins/Diagnostic;
.super Lorg/apache/cordova/CordovaPlugin;
.source "Diagnostic.java"


# static fields
.field public static final CPU_ARCH_ARMv6:Ljava/lang/String; = "ARMv6"

.field public static final CPU_ARCH_ARMv7:Ljava/lang/String; = "ARMv7"

.field public static final CPU_ARCH_ARMv8:Ljava/lang/String; = "ARMv8"

.field public static final CPU_ARCH_MIPS:Ljava/lang/String; = "MIPS"

.field public static final CPU_ARCH_MIPS_64:Ljava/lang/String; = "MIPS_64"

.field public static final CPU_ARCH_UNKNOWN:Ljava/lang/String; = "unknown"

.field public static final CPU_ARCH_X86:Ljava/lang/String; = "X86"

.field public static final CPU_ARCH_X86_64:Ljava/lang/String; = "X86_64"

.field protected static final GET_EXTERNAL_SD_CARD_DETAILS_PERMISSION_REQUEST:Ljava/lang/Integer;

.field protected static final STATUS_DENIED_ALWAYS:Ljava/lang/String; = "DENIED_ALWAYS"

.field protected static final STATUS_DENIED_ONCE:Ljava/lang/String; = "DENIED_ONCE"

.field protected static final STATUS_GRANTED:Ljava/lang/String; = "GRANTED"

.field protected static final STATUS_NOT_REQUESTED:Ljava/lang/String; = "NOT_REQUESTED"

.field public static final TAG:Ljava/lang/String; = "Diagnostic"

.field protected static final externalStorageClassName:Ljava/lang/String; = "cordova.plugins.Diagnostic_External_Storage"

.field public static instance:Lcordova/plugins/Diagnostic;

.field protected static final permissionsMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field protected applicationContext:Landroid/content/Context;

.field protected callbackContexts:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Lorg/apache/cordova/CallbackContext;",
            ">;"
        }
    .end annotation
.end field

.field protected currentContext:Lorg/apache/cordova/CallbackContext;

.field debugEnabled:Z

.field protected editor:Landroid/content/SharedPreferences$Editor;

.field protected permissionStatuses:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Lorg/json/JSONObject;",
            ">;"
        }
    .end annotation
.end field

.field protected sharedPref:Landroid/content/SharedPreferences;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 84
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 85
    const-string v1, "READ_CALENDAR"

    const-string v2, "android.permission.READ_CALENDAR"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 86
    const-string v1, "WRITE_CALENDAR"

    const-string v2, "android.permission.WRITE_CALENDAR"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 87
    const-string v1, "CAMERA"

    const-string v2, "android.permission.CAMERA"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 88
    const-string v1, "READ_CONTACTS"

    const-string v2, "android.permission.READ_CONTACTS"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 89
    const-string v1, "WRITE_CONTACTS"

    const-string v2, "android.permission.WRITE_CONTACTS"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 90
    const-string v1, "GET_ACCOUNTS"

    const-string v2, "android.permission.GET_ACCOUNTS"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 91
    const-string v1, "ACCESS_FINE_LOCATION"

    const-string v2, "android.permission.ACCESS_FINE_LOCATION"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 92
    const-string v1, "ACCESS_COARSE_LOCATION"

    const-string v2, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 94
    const-string v1, "ACCESS_BACKGROUND_LOCATION"

    const-string v2, "android.permission.ACCESS_BACKGROUND_LOCATION"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 95
    const-string v1, "RECORD_AUDIO"

    const-string v2, "android.permission.RECORD_AUDIO"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 96
    const-string v1, "READ_PHONE_STATE"

    const-string v2, "android.permission.READ_PHONE_STATE"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 97
    const-string v1, "CALL_PHONE"

    const-string v2, "android.permission.CALL_PHONE"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 98
    const-string v1, "ADD_VOICEMAIL"

    const-string v2, "com.android.voicemail.permission.ADD_VOICEMAIL"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 99
    const-string v1, "USE_SIP"

    const-string v2, "android.permission.USE_SIP"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 100
    const-string v1, "PROCESS_OUTGOING_CALLS"

    const-string v2, "android.permission.PROCESS_OUTGOING_CALLS"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 101
    const-string v1, "SEND_SMS"

    const-string v2, "android.permission.SEND_SMS"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 102
    const-string v1, "RECEIVE_SMS"

    const-string v2, "android.permission.RECEIVE_SMS"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 103
    const-string v1, "READ_SMS"

    const-string v2, "android.permission.READ_SMS"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 104
    const-string v1, "RECEIVE_WAP_PUSH"

    const-string v2, "android.permission.RECEIVE_WAP_PUSH"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 105
    const-string v1, "RECEIVE_MMS"

    const-string v2, "android.permission.RECEIVE_MMS"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 106
    const-string v1, "WRITE_EXTERNAL_STORAGE"

    const-string v2, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 107
    const-string v1, "READ_CALL_LOG"

    const-string v2, "android.permission.READ_CALL_LOG"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 108
    const-string v1, "WRITE_CALL_LOG"

    const-string v2, "android.permission.WRITE_CALL_LOG"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 109
    const-string v1, "READ_EXTERNAL_STORAGE"

    const-string v2, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 110
    const-string v1, "BODY_SENSORS"

    const-string v2, "android.permission.BODY_SENSORS"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 112
    const-string v1, "ACTIVITY_RECOGNITION"

    const-string v2, "android.permission.ACTIVITY_RECOGNITION"

    invoke-static {v0, v1, v2}, Lcordova/plugins/Diagnostic;->addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 113
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcordova/plugins/Diagnostic;->permissionsMap:Ljava/util/Map;

    const/16 v0, 0x3e8

    .line 158
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sput-object v0, Lcordova/plugins/Diagnostic;->GET_EXTERNAL_SD_CARD_DETAILS_PERMISSION_REQUEST:Ljava/lang/Integer;

    const/4 v0, 0x0

    .line 167
    sput-object v0, Lcordova/plugins/Diagnostic;->instance:Lcordova/plugins/Diagnostic;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 189
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    .line 120
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    .line 125
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcordova/plugins/Diagnostic;->permissionStatuses:Ljava/util/HashMap;

    const/4 v0, 0x0

    .line 169
    iput-boolean v0, p0, Lcordova/plugins/Diagnostic;->debugEnabled:Z

    return-void
.end method

.method protected static addBiDirMapEntry(Ljava/util/Map;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    .line 628
    invoke-interface {p0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 629
    invoke-interface {p0, p2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public static getInstance()Lcordova/plugins/Diagnostic;
    .locals 1

    .line 192
    sget-object v0, Lcordova/plugins/Diagnostic;->instance:Lcordova/plugins/Diagnostic;

    return-object v0
.end method


# virtual methods
.method protected _getPermissionsAuthorizationStatus([Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 495
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const/4 v1, 0x0

    .line 496
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_6

    .line 497
    aget-object v2, p1, v1

    .line 498
    sget-object v3, Lcordova/plugins/Diagnostic;->permissionsMap:Ljava/util/Map;

    invoke-interface {v3, v2}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 501
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x1d

    if-ge v4, v5, :cond_0

    const-string v4, "ACCESS_BACKGROUND_LOCATION"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 503
    const-string v2, "ACCESS_COARSE_LOCATION"

    .line 505
    :cond_0
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v4, v5, :cond_1

    const-string v4, "ACTIVITY_RECOGNITION"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 507
    const-string v2, "BODY_SENSORS"

    .line 509
    :cond_1
    invoke-interface {v3, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 510
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "Get authorisation status for "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, "Diagnostic"

    invoke-static {v5, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 511
    invoke-virtual {p0, v3}, Lcordova/plugins/Diagnostic;->hasPermission(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 513
    const-string v3, "GRANTED"

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 515
    :cond_2
    iget-object v4, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v4}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v4

    invoke-virtual {p0, v4, v3}, Lcordova/plugins/Diagnostic;->shouldShowRequestPermissionRationale(Landroid/app/Activity;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 517
    invoke-virtual {p0, v2}, Lcordova/plugins/Diagnostic;->isPermissionRequested(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 518
    const-string v3, "DENIED_ALWAYS"

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 520
    :cond_3
    const-string v3, "NOT_REQUESTED"

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 523
    :cond_4
    const-string v3, "DENIED_ONCE"

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 499
    :cond_5
    new-instance p1, Ljava/lang/Exception;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Permission name \'"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\' is not a valid permission"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_6
    return-object v0
.end method

.method protected _requestRuntimePermissions(Lorg/json/JSONArray;I)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 531
    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->jsonArrayToStringArray(Lorg/json/JSONArray;)[Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->_getPermissionsAuthorizationStatus([Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    .line 532
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    const/4 v1, 0x0

    .line 533
    :goto_0
    invoke-virtual {p1}, Lorg/json/JSONObject;->names()Lorg/json/JSONArray;

    move-result-object v2

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v2

    const-string v3, "Diagnostic"

    if-ge v1, v2, :cond_1

    .line 534
    invoke-virtual {p1}, Lorg/json/JSONObject;->names()Lorg/json/JSONArray;

    move-result-object v2

    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 535
    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "GRANTED"

    if-ne v4, v5, :cond_0

    .line 537
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v6, "Permission already granted for "

    invoke-direct {v4, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 538
    iget-object v3, p0, Lcordova/plugins/Diagnostic;->permissionStatuses:Ljava/util/HashMap;

    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/json/JSONObject;

    .line 539
    invoke-virtual {v3, v2, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 540
    iget-object v2, p0, Lcordova/plugins/Diagnostic;->permissionStatuses:Ljava/util/HashMap;

    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 542
    :cond_0
    sget-object v4, Lcordova/plugins/Diagnostic;->permissionsMap:Ljava/util/Map;

    invoke-interface {v4, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 543
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "Requesting permission for "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 544
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 547
    :cond_1
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result p1

    if-lez p1, :cond_2

    .line 548
    const-string p1, "Requesting permissions"

    invoke-static {v3, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 549
    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->jsonArrayToStringArray(Lorg/json/JSONArray;)[Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p0, p2, p1}, Lcordova/plugins/Diagnostic;->requestPermissions(Lorg/apache/cordova/CordovaPlugin;I[Ljava/lang/String;)V

    return-void

    .line 552
    :cond_2
    const-string p1, "No permissions to request: returning result"

    invoke-static {v3, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 553
    invoke-virtual {p0, p2}, Lcordova/plugins/Diagnostic;->sendRuntimeRequestResult(I)V

    return-void
.end method

.method protected clearRequest(I)V
    .locals 1

    .line 613
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    .line 614
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 617
    :cond_0
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 618
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->permissionStatuses:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method protected doColdRestart()V
    .locals 6

    .line 706
    :try_start_0
    const-string v0, "Cold restarting application"

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->logInfo(Ljava/lang/String;)V

    .line 707
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->applicationContext:Landroid/content/Context;

    if-eqz v0, :cond_2

    .line 712
    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 717
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    .line 716
    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    if-eqz v1, :cond_0

    const v2, 0x36870

    const/high16 v3, 0x10000000

    .line 725
    invoke-static {v0, v2, v1, v3}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 727
    const-string v2, "alarm"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 728
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const-wide/16 v4, 0x64

    add-long/2addr v2, v4

    const/4 v4, 0x1

    invoke-virtual {v0, v4, v2, v3, v1}, Landroid/app/AlarmManager;->set(IJLandroid/app/PendingIntent;)V

    .line 729
    const-string v0, "Diagnostic"

    const-string v1, "Killing application for cold restart"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    .line 731
    invoke-static {v0}, Ljava/lang/System;->exit(I)V

    return-void

    .line 733
    :cond_0
    const-string v0, "Unable to cold restart application: StartActivity is null"

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    return-void

    .line 736
    :cond_1
    const-string v0, "Unable to cold restart application: PackageManager is null"

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    return-void

    .line 739
    :cond_2
    const-string v0, "Unable to cold restart application: Context is null"

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .line 742
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Unable to cold restart application: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    return-void
.end method

.method protected doWarmRestart()V
    .locals 2

    .line 686
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    new-instance v1, Lcordova/plugins/Diagnostic$2;

    invoke-direct {v1, p0}, Lcordova/plugins/Diagnostic$2;-><init>(Lcordova/plugins/Diagnostic;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public escapeDoubleQuotes(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 447
    const-string v0, "\""

    const-string v1, "\\\""

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 448
    const-string v0, "%22"

    const-string v1, "\\%22"

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 222
    iput-object p3, p0, Lcordova/plugins/Diagnostic;->currentContext:Lorg/apache/cordova/CallbackContext;

    const/4 v0, 0x0

    .line 225
    :try_start_0
    const-string v1, "enableDebug"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    .line 226
    iput-boolean v2, p0, Lcordova/plugins/Diagnostic;->debugEnabled:Z

    .line 227
    const-string p1, "Debug enabled"

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 228
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_0

    .line 229
    :cond_0
    const-string v1, "switchToSettings"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 230
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->switchToAppSettings()V

    .line 231
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_0

    .line 232
    :cond_1
    const-string v1, "switchToMobileDataSettings"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 233
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->switchToMobileDataSettings()V

    .line 234
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_0

    .line 235
    :cond_2
    const-string v1, "switchToWirelessSettings"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 236
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->switchToWirelessSettings()V

    .line 237
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    goto/16 :goto_0

    .line 238
    :cond_3
    const-string v1, "isDataRoamingEnabled"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 239
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->isDataRoamingEnabled()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto/16 :goto_0

    .line 240
    :cond_4
    const-string v1, "getPermissionAuthorizationStatus"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 241
    invoke-virtual {p0, p2}, Lcordova/plugins/Diagnostic;->getPermissionAuthorizationStatus(Lorg/json/JSONArray;)V

    goto/16 :goto_0

    .line 242
    :cond_5
    const-string v1, "getPermissionsAuthorizationStatus"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 243
    invoke-virtual {p0, p2}, Lcordova/plugins/Diagnostic;->getPermissionsAuthorizationStatus(Lorg/json/JSONArray;)V

    goto :goto_0

    .line 244
    :cond_6
    const-string v1, "requestRuntimePermission"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 245
    invoke-virtual {p0, p2}, Lcordova/plugins/Diagnostic;->requestRuntimePermission(Lorg/json/JSONArray;)V

    goto :goto_0

    .line 246
    :cond_7
    const-string v1, "requestRuntimePermissions"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 247
    invoke-virtual {p0, p2}, Lcordova/plugins/Diagnostic;->requestRuntimePermissions(Lorg/json/JSONArray;)V

    goto :goto_0

    .line 248
    :cond_8
    const-string v1, "isADBModeEnabled"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 249
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->isADBModeEnabled()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 250
    :cond_9
    const-string v1, "isDeviceRooted"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_a

    .line 251
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->isDeviceRooted()Z

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    goto :goto_0

    .line 252
    :cond_a
    const-string v1, "restart"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_b

    .line 253
    invoke-virtual {p0, p2}, Lcordova/plugins/Diagnostic;->restart(Lorg/json/JSONArray;)V

    goto :goto_0

    .line 254
    :cond_b
    const-string p2, "getArchitecture"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_c

    .line 255
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->getCPUArchitecture()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(Ljava/lang/String;)V

    goto :goto_0

    .line 256
    :cond_c
    const-string p2, "getCurrentBatteryLevel"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_d

    .line 257
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->getCurrentBatteryLevel()I

    move-result p1

    invoke-virtual {p3, p1}, Lorg/apache/cordova/CallbackContext;->success(I)V

    :goto_0
    return v2

    .line 259
    :cond_d
    const-string p1, "Invalid action"

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception p1

    .line 263
    const-string p2, "Exception occurred: "

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    return v0
.end method

.method public executeGlobalJavascript(Ljava/lang/String;)V
    .locals 2

    .line 670
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    new-instance v1, Lcordova/plugins/Diagnostic$1;

    invoke-direct {v1, p0, p1}, Lcordova/plugins/Diagnostic$1;-><init>(Lcordova/plugins/Diagnostic;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public executePluginJavascript(Ljava/lang/String;)V
    .locals 2

    .line 679
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "cordova.plugins.diagnostic."

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->executeGlobalJavascript(Ljava/lang/String;)V

    return-void
.end method

.method protected generateRandom()Ljava/lang/String;
    .locals 2

    .line 589
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    const v1, 0xf4240

    .line 590
    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    .line 591
    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected generateRandomRequestId()Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    :goto_0
    move-object v1, v0

    :cond_0
    if-nez v1, :cond_1

    .line 580
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->generateRandom()Ljava/lang/String;

    move-result-object v1

    .line 581
    iget-object v2, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    :cond_1
    return-object v1
.end method

.method public getADBMode()I
    .locals 3

    .line 350
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->applicationContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "adb_enabled"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method protected getCPUArchitecture()Ljava/lang/String;
    .locals 2

    .line 754
    sget-object v0, Landroid/os/Build;->SUPPORTED_ABIS:[Ljava/lang/String;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    .line 758
    const-string v1, "armeabi"

    if-ne v0, v1, :cond_0

    .line 759
    const-string v0, "ARMv6"

    return-object v0

    .line 760
    :cond_0
    const-string v1, "armeabi-v7a"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 761
    const-string v0, "ARMv7"

    return-object v0

    .line 762
    :cond_1
    const-string v1, "arm64-v8a"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 763
    const-string v0, "ARMv8"

    return-object v0

    .line 764
    :cond_2
    const-string v1, "x86"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 765
    const-string v0, "X86"

    return-object v0

    .line 766
    :cond_3
    const-string v1, "x86_64"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 767
    const-string v0, "X86_64"

    return-object v0

    .line 768
    :cond_4
    const-string v1, "mips"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 769
    const-string v0, "MIPS"

    return-object v0

    .line 770
    :cond_5
    const-string v1, "mips64"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 771
    const-string v0, "MIPS_64"

    return-object v0

    .line 774
    :cond_6
    const-string v0, "unknown"

    return-object v0
.end method

.method protected getContextById(Ljava/lang/String;)Lorg/apache/cordova/CallbackContext;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 606
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 609
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/apache/cordova/CallbackContext;

    return-object p1

    .line 607
    :cond_0
    new-instance v0, Ljava/lang/Exception;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "No context found for request id="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected getCurrentBatteryLevel()I
    .locals 2

    .line 790
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "batterymanager"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/BatteryManager;

    const/4 v1, 0x4

    .line 791
    invoke-virtual {v0, v1}, Landroid/os/BatteryManager;->getIntProperty(I)I

    move-result v0

    return v0
.end method

.method public getPermissionAuthorizationStatus(Lorg/json/JSONArray;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x0

    .line 317
    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object p1

    .line 318
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 319
    invoke-virtual {v0, p1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 320
    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->jsonArrayToStringArray(Lorg/json/JSONArray;)[Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->_getPermissionsAuthorizationStatus([Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 321
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->currentContext:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lorg/apache/cordova/CallbackContext;->success(Ljava/lang/String;)V

    return-void
.end method

.method public getPermissionsAuthorizationStatus(Lorg/json/JSONArray;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x0

    .line 311
    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->getJSONArray(I)Lorg/json/JSONArray;

    move-result-object p1

    .line 312
    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->jsonArrayToStringArray(Lorg/json/JSONArray;)[Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->_getPermissionsAuthorizationStatus([Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    .line 313
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->currentContext:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v0, p1}, Lorg/apache/cordova/CallbackContext;->success(Lorg/json/JSONObject;)V

    return-void
.end method

.method public handleError(Ljava/lang/String;)V
    .locals 1

    .line 472
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->currentContext:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {p0, p1, v0}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;Lorg/apache/cordova/CallbackContext;)V

    return-void
.end method

.method public handleError(Ljava/lang/String;I)V
    .locals 2

    .line 484
    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 485
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 486
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/apache/cordova/CallbackContext;

    goto :goto_0

    .line 488
    :cond_0
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->currentContext:Lorg/apache/cordova/CallbackContext;

    .line 490
    :goto_0
    invoke-virtual {p0, p1, v0}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;Lorg/apache/cordova/CallbackContext;)V

    .line 491
    invoke-virtual {p0, p2}, Lcordova/plugins/Diagnostic;->clearRequest(I)V

    return-void
.end method

.method public handleError(Ljava/lang/String;Lorg/apache/cordova/CallbackContext;)V
    .locals 0

    .line 459
    :try_start_0
    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->logError(Ljava/lang/String;)V

    .line 460
    invoke-virtual {p2, p1}, Lorg/apache/cordova/CallbackContext;->error(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 462
    invoke-virtual {p1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->logError(Ljava/lang/String;)V

    return-void
.end method

.method protected hasPermission(Ljava/lang/String;)Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x1

    .line 636
    :try_start_0
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "hasPermission"

    new-array v3, v0, [Ljava/lang/Class;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 637
    iget-object v2, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    .line 638
    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    .line 640
    :catch_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Cordova v15.0.0 does not support runtime permissions so defaulting to GRANTED for "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->logWarning(Ljava/lang/String;)V

    return v0
.end method

.method public initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V
    .locals 3

    .line 203
    const-string v0, "initialize()"

    const-string v1, "Diagnostic"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    sput-object p0, Lcordova/plugins/Diagnostic;->instance:Lcordova/plugins/Diagnostic;

    .line 206
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic;->applicationContext:Landroid/content/Context;

    .line 207
    invoke-interface {p1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroidx/appcompat/app/AppCompatActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic;->sharedPref:Landroid/content/SharedPreferences;

    .line 208
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic;->editor:Landroid/content/SharedPreferences$Editor;

    .line 210
    invoke-super {p0, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    return-void
.end method

.method public isADBModeEnabled()Z
    .locals 3

    const/4 v0, 0x0

    .line 364
    :try_start_0
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->getADBMode()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    move v0, v2

    goto :goto_0

    :catch_0
    move-exception v1

    .line 366
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcordova/plugins/Diagnostic;->logError(Ljava/lang/String;)V

    .line 368
    :cond_0
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "ADB mode enabled: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    return v0
.end method

.method public isDataRoamingEnabled()Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 284
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "data_roaming"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    return v1

    :cond_0
    return v2
.end method

.method public isDeviceRooted()Z
    .locals 8

    .line 378
    sget-object v0, Landroid/os/Build;->TAGS:Ljava/lang/String;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 379
    const-string v2, "test-keys"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x2

    const/4 v2, 0x0

    const/16 v3, 0x9

    .line 385
    :try_start_0
    new-array v4, v3, [Ljava/lang/String;

    const-string v5, "/system/app/Superuser.apk"

    aput-object v5, v4, v2

    const-string v5, "/sbin/su"

    aput-object v5, v4, v1

    const-string v5, "/system/bin/su"

    aput-object v5, v4, v0

    const-string v5, "/system/xbin/su"

    const/4 v6, 0x3

    aput-object v5, v4, v6

    const-string v5, "/data/local/xbin/su"

    const/4 v6, 0x4

    aput-object v5, v4, v6

    const-string v5, "/data/local/bin/su"

    const/4 v6, 0x5

    aput-object v5, v4, v6

    const-string v5, "/system/sd/xbin/su"

    const/4 v6, 0x6

    aput-object v5, v4, v6

    const-string v5, "/system/bin/failsafe/su"

    const/4 v6, 0x7

    aput-object v5, v4, v6

    const-string v5, "/data/local/su"

    const/16 v6, 0x8

    aput-object v5, v4, v6

    move v5, v2

    :goto_0
    if-ge v5, v3, :cond_2

    .line 387
    aget-object v6, v4, v5

    .line 388
    new-instance v7, Ljava/io/File;

    invoke-direct {v7, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v7}, Ljava/io/File;->exists()Z

    move-result v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v6, :cond_1

    return v1

    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :catch_0
    move-exception v3

    .line 393
    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    :cond_2
    const/4 v3, 0x0

    .line 399
    :try_start_1
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v4

    new-array v0, v0, [Ljava/lang/String;

    const-string v5, "/system/xbin/which"

    aput-object v5, v0, v2

    const-string v5, "su"

    aput-object v5, v0, v1

    invoke-virtual {v4, v0}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v3

    .line 400
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v4, Ljava/io/InputStreamReader;

    invoke-virtual {v3}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v0, v4}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 401
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v0, :cond_4

    if-eqz v3, :cond_3

    .line 407
    invoke-virtual {v3}, Ljava/lang/Process;->destroy()V

    :cond_3
    return v1

    :cond_4
    if-eqz v3, :cond_5

    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    .line 405
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v3, :cond_5

    .line 407
    :goto_1
    invoke-virtual {v3}, Ljava/lang/Process;->destroy()V

    :cond_5
    return v2

    :goto_2
    if-eqz v3, :cond_6

    invoke-virtual {v3}, Ljava/lang/Process;->destroy()V

    .line 408
    :cond_6
    throw v0
.end method

.method protected isPermissionRequested(Ljava/lang/String;)Z
    .locals 2

    .line 786
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->sharedPref:Landroid/content/SharedPreferences;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    return p1
.end method

.method protected jsonArrayToStringArray(Lorg/json/JSONArray;)[Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 598
    :cond_0
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v0

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_1

    .line 600
    invoke-virtual {p1, v2}, Lorg/json/JSONArray;->optString(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    return-object v1
.end method

.method public logDebug(Ljava/lang/String;)V
    .locals 2

    .line 419
    iget-boolean v0, p0, Lcordova/plugins/Diagnostic;->debugEnabled:Z

    if-eqz v0, :cond_0

    .line 420
    const-string v0, "Diagnostic"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 421
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "console.log(\"Diagnostic[native]: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->escapeDoubleQuotes(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\")"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->executeGlobalJavascript(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public logError(Ljava/lang/String;)V
    .locals 2

    .line 440
    const-string v0, "Diagnostic"

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 441
    iget-boolean v0, p0, Lcordova/plugins/Diagnostic;->debugEnabled:Z

    if-eqz v0, :cond_0

    .line 442
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "console.error(\"Diagnostic[native]: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->escapeDoubleQuotes(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\")"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->executeGlobalJavascript(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public logInfo(Ljava/lang/String;)V
    .locals 2

    .line 426
    const-string v0, "Diagnostic"

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 427
    iget-boolean v0, p0, Lcordova/plugins/Diagnostic;->debugEnabled:Z

    if-eqz v0, :cond_0

    .line 428
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "console.info(\"Diagnostic[native]: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->escapeDoubleQuotes(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\")"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->executeGlobalJavascript(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public logWarning(Ljava/lang/String;)V
    .locals 2

    .line 433
    const-string v0, "Diagnostic"

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 434
    iget-boolean v0, p0, Lcordova/plugins/Diagnostic;->debugEnabled:Z

    if-eqz v0, :cond_0

    .line 435
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "console.warn(\"Diagnostic[native]: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->escapeDoubleQuotes(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\")"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->executeGlobalJavascript(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onRequestPermissionResult(I[Ljava/lang/String;[I)V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 810
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 811
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Received result for permissions request id="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Diagnostic"

    invoke-static {v2, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 814
    :try_start_0
    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->getContextById(Ljava/lang/String;)Lorg/apache/cordova/CallbackContext;

    move-result-object v1

    .line 815
    iget-object v3, p0, Lcordova/plugins/Diagnostic;->permissionStatuses:Ljava/util/HashMap;

    invoke-virtual {v3, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/json/JSONObject;

    .line 817
    array-length v3, p2

    const/4 v4, 0x0

    move v5, v4

    :goto_0
    if-ge v5, v3, :cond_5

    .line 818
    aget-object v6, p2, v5

    .line 819
    sget-object v7, Lcordova/plugins/Diagnostic;->permissionsMap:Ljava/util/Map;

    invoke-interface {v7, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 820
    sget v8, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v9, 0x1d

    if-ge v8, v9, :cond_0

    const-string v8, "ACCESS_BACKGROUND_LOCATION"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_0

    .line 822
    const-string v7, "ACCESS_COARSE_LOCATION"

    .line 824
    :cond_0
    sget v8, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v8, v9, :cond_1

    const-string v8, "ACTIVITY_RECOGNITION"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 826
    const-string v7, "BODY_SENSORS"

    .line 829
    :cond_1
    aget v8, p3, v5

    const/4 v9, -0x1

    if-ne v8, v9, :cond_4

    .line 830
    iget-object v8, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v8}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v8

    invoke-virtual {p0, v8, v6}, Lcordova/plugins/Diagnostic;->shouldShowRequestPermissionRationale(Landroid/app/Activity;Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_3

    .line 832
    invoke-virtual {p0, v7}, Lcordova/plugins/Diagnostic;->isPermissionRequested(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 834
    const-string v6, "DENIED_ALWAYS"

    goto :goto_1

    .line 837
    :cond_2
    const-string v6, "NOT_REQUESTED"

    goto :goto_1

    .line 841
    :cond_3
    const-string v6, "DENIED_ONCE"

    goto :goto_1

    .line 845
    :cond_4
    const-string v6, "GRANTED"

    .line 847
    :goto_1
    invoke-virtual {v0, v7, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 848
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Authorisation for "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, " is "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v0, v7}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v2, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 849
    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->clearRequest(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_5
    const/4 p2, 0x0

    .line 854
    :try_start_1
    const-string p3, "cordova.plugins.Diagnostic_External_Storage"

    invoke-static {p3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p3
    :try_end_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_0
    move-object p3, p2

    .line 857
    :goto_2
    :try_start_2
    sget-object v2, Lcordova/plugins/Diagnostic;->GET_EXTERNAL_SD_CARD_DETAILS_PERMISSION_REQUEST:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-ne p1, v2, :cond_6

    if-eqz p3, :cond_6

    .line 858
    const-string v0, "onReceivePermissionResult"

    new-array v1, v4, [Ljava/lang/Class;

    invoke-virtual {p3, v0, v1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p3

    .line 859
    new-array v0, v4, [Ljava/lang/Object;

    invoke-virtual {p3, p2, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    .line 861
    :cond_6
    invoke-virtual {v1, v0}, Lorg/apache/cordova/CallbackContext;->success(Lorg/json/JSONObject;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_3

    :catch_1
    move-exception p2

    .line 864
    const-string p3, "Exception occurred onRequestPermissionsResult: "

    invoke-virtual {p2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p3, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2, p1}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;I)V

    :goto_3
    return-void
.end method

.method protected requestPermissions(Lorg/apache/cordova/CordovaPlugin;I[Ljava/lang/String;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 647
    :try_start_0
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v1, "requestPermissions"

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Class;

    const-class v3, Lorg/apache/cordova/CordovaPlugin;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v5, 0x1

    aput-object v3, v2, v5

    const-class v3, [Ljava/lang/String;

    const/4 v5, 0x2

    aput-object v3, v2, v5

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 648
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    filled-new-array {p1, p2, p3}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 649
    array-length p1, p3

    :goto_0
    if-ge v4, p1, :cond_0

    aget-object p2, p3, v4

    .line 650
    sget-object v0, Lcordova/plugins/Diagnostic;->permissionsMap:Ljava/util/Map;

    invoke-interface {v0, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    invoke-virtual {p0, p2}, Lcordova/plugins/Diagnostic;->setPermissionRequested(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_0
    return-void

    .line 653
    :catch_0
    new-instance p1, Ljava/lang/Exception;

    const-string p2, "requestPermissions() method not found in CordovaInterface implementation of Cordova v15.0.0"

    invoke-direct {p1, p2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public requestRuntimePermission(Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 335
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->storeContextByRequestId()I

    move-result v0

    invoke-virtual {p0, p1, v0}, Lcordova/plugins/Diagnostic;->requestRuntimePermission(Ljava/lang/String;I)V

    return-void
.end method

.method public requestRuntimePermission(Ljava/lang/String;I)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 339
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 340
    invoke-virtual {v0, p1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 341
    invoke-virtual {p0, v0, p2}, Lcordova/plugins/Diagnostic;->_requestRuntimePermissions(Lorg/json/JSONArray;I)V

    return-void
.end method

.method public requestRuntimePermission(Lorg/json/JSONArray;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x0

    .line 331
    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->requestRuntimePermission(Ljava/lang/String;)V

    return-void
.end method

.method public requestRuntimePermissions(Lorg/json/JSONArray;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x0

    .line 325
    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->getJSONArray(I)Lorg/json/JSONArray;

    move-result-object p1

    .line 326
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->storeContextByRequestId()I

    move-result v0

    .line 327
    invoke-virtual {p0, p1, v0}, Lcordova/plugins/Diagnostic;->_requestRuntimePermissions(Lorg/json/JSONArray;I)V

    return-void
.end method

.method public restart(Lorg/json/JSONArray;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x0

    .line 270
    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->getBoolean(I)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 272
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->doColdRestart()V

    return-void

    .line 274
    :cond_0
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->doWarmRestart()V

    return-void
.end method

.method protected sendRuntimeRequestResult(I)V
    .locals 4

    .line 558
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    .line 559
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/apache/cordova/CallbackContext;

    .line 560
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->permissionStatuses:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/json/JSONObject;

    .line 561
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Sending runtime request result for id="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v2, "Diagnostic"

    invoke-static {v2, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 562
    invoke-virtual {v0, v1}, Lorg/apache/cordova/CallbackContext;->success(Lorg/json/JSONObject;)V

    return-void
.end method

.method protected setPermissionRequested(Ljava/lang/String;)V
    .locals 2

    .line 778
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->editor:Landroid/content/SharedPreferences$Editor;

    const/4 v1, 0x1

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 779
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    move-result v0

    if-nez v0, :cond_0

    .line 781
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Failed to set permission requested flag for "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method protected shouldShowRequestPermissionRationale(Landroid/app/Activity;Ljava/lang/String;)Z
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 660
    :try_start_0
    const-class v0, Landroidx/core/app/ActivityCompat;

    const-string v1, "shouldShowRequestPermissionRationale"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Class;

    const-class v3, Landroid/app/Activity;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const-class v3, Ljava/lang/String;

    const/4 v4, 0x1

    aput-object v3, v2, v4

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 661
    filled-new-array {p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {v0, p2, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Boolean;

    .line 662
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    .line 664
    :catch_0
    new-instance p1, Ljava/lang/Exception;

    const-string p2, "shouldShowRequestPermissionRationale() method not found in ActivityCompat class."

    invoke-direct {p1, p2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method protected storeContextByRequestId()I
    .locals 1

    .line 566
    iget-object v0, p0, Lcordova/plugins/Diagnostic;->currentContext:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->storeContextByRequestId(Lorg/apache/cordova/CallbackContext;)I

    move-result v0

    return v0
.end method

.method protected storeContextByRequestId(Lorg/apache/cordova/CallbackContext;)I
    .locals 2

    .line 570
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic;->generateRandomRequestId()Ljava/lang/String;

    move-result-object v0

    .line 571
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->callbackContexts:Ljava/util/HashMap;

    invoke-virtual {v1, v0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 572
    iget-object p1, p0, Lcordova/plugins/Diagnostic;->permissionStatuses:Ljava/util/HashMap;

    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    invoke-virtual {p1, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 573
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    return p1
.end method

.method public switchToAppSettings()V
    .locals 4

    .line 290
    const-string v0, "Switch to App Settings"

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 291
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.APPLICATION_DETAILS_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 292
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/appcompat/app/AppCompatActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const-string v3, "package"

    invoke-static {v3, v1, v2}, Landroid/net/Uri;->fromParts(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    .line 293
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 294
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method public switchToMobileDataSettings()V
    .locals 2

    .line 299
    const-string v0, "Switch to Mobile Data Settings"

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 300
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.DATA_ROAMING_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 301
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method public switchToWirelessSettings()V
    .locals 2

    .line 305
    const-string v0, "Switch to wireless Settings"

    invoke-virtual {p0, v0}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    .line 306
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.WIRELESS_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 307
    iget-object v1, p0, Lcordova/plugins/Diagnostic;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
