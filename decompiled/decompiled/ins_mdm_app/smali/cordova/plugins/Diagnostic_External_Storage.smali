.class public Lcordova/plugins/Diagnostic_External_Storage;
.super Lorg/apache/cordova/CordovaPlugin;
.source "Diagnostic_External_Storage.java"


# static fields
.field public static final TAG:Ljava/lang/String; = "Diagnostic_External_Storage"

.field protected static externalStoragePermission:Ljava/lang/String; = "READ_EXTERNAL_STORAGE"

.field public static instance:Lcordova/plugins/Diagnostic_External_Storage;


# instance fields
.field protected currentContext:Lorg/apache/cordova/CallbackContext;

.field private diagnostic:Lcordova/plugins/Diagnostic;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 87
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    return-void
.end method

.method public static onReceivePermissionResult()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 131
    sget-object v0, Lcordova/plugins/Diagnostic_External_Storage;->instance:Lcordova/plugins/Diagnostic_External_Storage;

    invoke-virtual {v0}, Lcordova/plugins/Diagnostic_External_Storage;->_getExternalSdCardDetails()V

    return-void
.end method


# virtual methods
.method protected _getExternalSdCardDetails()V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 149
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_External_Storage;->getStorageDirectories()[Ljava/lang/String;

    move-result-object v0

    .line 151
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    const/4 v2, 0x0

    .line 152
    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_2

    .line 153
    aget-object v3, v0, v2

    .line 154
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 155
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 156
    invoke-virtual {v4}, Ljava/io/File;->canRead()Z

    move-result v6

    if-eqz v6, :cond_1

    .line 157
    const-string v6, "path"

    invoke-virtual {v5, v6, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 158
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "file://"

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const-string v7, "filePath"

    invoke-virtual {v5, v7, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 159
    const-string v6, "canWrite"

    invoke-virtual {v4}, Ljava/io/File;->canWrite()Z

    move-result v4

    invoke-virtual {v5, v6, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 160
    const-string v4, "freeSpace"

    invoke-virtual {p0, v3}, Lcordova/plugins/Diagnostic_External_Storage;->getFreeSpaceInBytes(Ljava/lang/String;)J

    move-result-wide v6

    invoke-virtual {v5, v4, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 161
    const-string v4, "Android"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    const-string v4, "type"

    if-eqz v3, :cond_0

    .line 162
    const-string v3, "application"

    invoke-virtual {v5, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    .line 164
    :cond_0
    const-string v3, "root"

    invoke-virtual {v5, v4, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 166
    :goto_1
    invoke-virtual {v1, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 169
    :cond_2
    iget-object v0, p0, Lcordova/plugins/Diagnostic_External_Storage;->currentContext:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v0, v1}, Lorg/apache/cordova/CallbackContext;->success(Lorg/json/JSONArray;)V

    return-void
.end method

.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 114
    iput-object p3, p0, Lcordova/plugins/Diagnostic_External_Storage;->currentContext:Lorg/apache/cordova/CallbackContext;

    const/4 p2, 0x0

    .line 117
    :try_start_0
    const-string p3, "getExternalSdCardDetails"

    invoke-virtual {p1, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 118
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_External_Storage;->getExternalSdCardDetails()V

    const/4 p1, 0x1

    return p1

    .line 120
    :cond_0
    iget-object p1, p0, Lcordova/plugins/Diagnostic_External_Storage;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string p3, "Invalid action"

    invoke-virtual {p1, p3}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p2

    :catch_0
    move-exception p1

    .line 124
    iget-object p3, p0, Lcordova/plugins/Diagnostic_External_Storage;->diagnostic:Lcordova/plugins/Diagnostic;

    const-string v0, "Exception occurred: "

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Lcordova/plugins/Diagnostic;->handleError(Ljava/lang/String;)V

    return p2
.end method

.method protected getExternalSdCardDetails()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 139
    sget-object v0, Lcordova/plugins/Diagnostic;->permissionsMap:Ljava/util/Map;

    sget-object v1, Lcordova/plugins/Diagnostic_External_Storage;->externalStoragePermission:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 140
    iget-object v1, p0, Lcordova/plugins/Diagnostic_External_Storage;->diagnostic:Lcordova/plugins/Diagnostic;

    invoke-virtual {v1, v0}, Lcordova/plugins/Diagnostic;->hasPermission(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 141
    invoke-virtual {p0}, Lcordova/plugins/Diagnostic_External_Storage;->_getExternalSdCardDetails()V

    return-void

    .line 143
    :cond_0
    iget-object v1, p0, Lcordova/plugins/Diagnostic_External_Storage;->diagnostic:Lcordova/plugins/Diagnostic;

    sget-object v2, Lcordova/plugins/Diagnostic;->GET_EXTERNAL_SD_CARD_DETAILS_PERMISSION_REQUEST:Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-virtual {v1, v0, v2}, Lcordova/plugins/Diagnostic;->requestRuntimePermission(Ljava/lang/String;I)V

    return-void
.end method

.method protected getFreeSpaceInBytes(Ljava/lang/String;)J
    .locals 5

    .line 180
    :try_start_0
    new-instance v0, Landroid/os/StatFs;

    invoke-direct {v0, p1}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 181
    invoke-virtual {v0}, Landroid/os/StatFs;->getBlockSize()I

    move-result p1

    int-to-long v1, p1

    .line 182
    invoke-virtual {v0}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    int-to-long v3, p1

    mul-long/2addr v3, v1

    return-wide v3

    :catch_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method protected getStorageDirectories()[Ljava/lang/String;
    .locals 8

    .line 198
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 201
    iget-object v1, p0, Lcordova/plugins/Diagnostic_External_Storage;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/content/Context;->getExternalFilesDirs(Ljava/lang/String;)[Ljava/io/File;

    move-result-object v1

    .line 203
    array-length v2, v1

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    if-ge v4, v2, :cond_2

    aget-object v5, v1, v4

    if-nez v5, :cond_0

    goto :goto_1

    .line 207
    :cond_0
    invoke-virtual {v5}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    .line 208
    const-string v7, "/Android"

    invoke-virtual {v6, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v7

    aget-object v7, v7, v3

    .line 213
    invoke-static {v5}, Landroid/os/Environment;->isExternalStorageRemovable(Ljava/io/File;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 220
    invoke-interface {v0, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 221
    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    :goto_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 226
    :cond_2
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_4

    .line 228
    const-string v1, ""

    .line 230
    :try_start_0
    new-instance v4, Ljava/lang/ProcessBuilder;

    new-array v5, v3, [Ljava/lang/String;

    invoke-direct {v4, v5}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    new-array v5, v2, [Ljava/lang/String;

    const-string v6, "mount | grep /dev/block/vold"

    aput-object v6, v5, v3

    invoke-virtual {v4, v5}, Ljava/lang/ProcessBuilder;->command([Ljava/lang/String;)Ljava/lang/ProcessBuilder;

    move-result-object v4

    .line 231
    invoke-virtual {v4, v2}, Ljava/lang/ProcessBuilder;->redirectErrorStream(Z)Ljava/lang/ProcessBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object v4

    .line 232
    invoke-virtual {v4}, Ljava/lang/Process;->waitFor()I

    .line 233
    invoke-virtual {v4}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    const/16 v5, 0x400

    .line 234
    new-array v5, v5, [B

    .line 235
    :goto_2
    invoke-virtual {v4, v5}, Ljava/io/InputStream;->read([B)I

    move-result v6

    const/4 v7, -0x1

    if-eq v6, v7, :cond_3

    .line 236
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    new-instance v7, Ljava/lang/String;

    invoke-direct {v7, v5}, Ljava/lang/String;-><init>([B)V

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 238
    :cond_3
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    :catch_0
    move-exception v4

    .line 240
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V

    .line 242
    :goto_3
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_4

    .line 243
    const-string v4, "\n"

    invoke-virtual {v1, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 244
    array-length v4, v1

    move v5, v3

    :goto_4
    if-ge v5, v4, :cond_4

    aget-object v6, v1, v5

    .line 245
    const-string v7, " "

    invoke-virtual {v6, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x2

    aget-object v6, v6, v7

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v5, v5, 0x1

    goto :goto_4

    :cond_4
    move v1, v3

    .line 252
    :goto_5
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v4

    if-ge v1, v4, :cond_6

    .line 253
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v4

    const-string v5, ".*[0-9a-f]{4}[-][0-9a-f]{4}.*"

    invoke-virtual {v4, v5}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_5

    .line 254
    iget-object v4, p0, Lcordova/plugins/Diagnostic_External_Storage;->diagnostic:Lcordova/plugins/Diagnostic;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " might not be extSDcard"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcordova/plugins/Diagnostic;->logDebug(Ljava/lang/String;)V

    add-int/lit8 v4, v1, -0x1

    .line 255
    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move v1, v4

    :cond_5
    add-int/2addr v1, v2

    goto :goto_5

    .line 267
    :cond_6
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    .line 268
    :goto_6
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-ge v3, v2, :cond_7

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    aput-object v2, v1, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_6

    :cond_7
    return-object v1
.end method

.method public initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V
    .locals 2

    .line 97
    const-string v0, "Diagnostic_External_Storage"

    const-string v1, "initialize()"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 98
    sput-object p0, Lcordova/plugins/Diagnostic_External_Storage;->instance:Lcordova/plugins/Diagnostic_External_Storage;

    .line 99
    invoke-static {}, Lcordova/plugins/Diagnostic;->getInstance()Lcordova/plugins/Diagnostic;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugins/Diagnostic_External_Storage;->diagnostic:Lcordova/plugins/Diagnostic;

    .line 101
    invoke-super {p0, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    return-void
.end method
