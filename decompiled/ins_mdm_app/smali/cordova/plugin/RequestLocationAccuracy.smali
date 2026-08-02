.class public Lcordova/plugin/RequestLocationAccuracy;
.super Lorg/apache/cordova/CordovaPlugin;
.source "RequestLocationAccuracy.java"

# interfaces
.implements Lcom/google/android/gms/common/api/GoogleApiClient$ConnectionCallbacks;
.implements Lcom/google/android/gms/common/api/GoogleApiClient$OnConnectionFailedListener;
.implements Lcom/google/android/gms/common/api/ResultCallback;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lorg/apache/cordova/CordovaPlugin;",
        "Lcom/google/android/gms/common/api/GoogleApiClient$ConnectionCallbacks;",
        "Lcom/google/android/gms/common/api/GoogleApiClient$OnConnectionFailedListener;",
        "Lcom/google/android/gms/common/api/ResultCallback<",
        "Lcom/google/android/gms/location/LocationSettingsResult;",
        ">;"
    }
.end annotation


# static fields
.field protected static final ERROR_CANNOT_CHANGE_ACCURACY:I = 0x3

.field protected static final ERROR_EXCEPTION:I = 0x2

.field protected static final ERROR_GOOGLE_API_CONNECTION_FAILED:I = 0x5

.field protected static final ERROR_INVALID_ACCURACY:I = 0x1

.field protected static final ERROR_INVALID_ACTION:I = 0x0

.field protected static final ERROR_USER_DISAGREED:I = 0x4

.field protected static final REQUEST_CHECK_SETTINGS:I = 0x1

.field protected static final REQUEST_PRIORITY_BALANCED_POWER_ACCURACY:I = 0x2

.field protected static final REQUEST_PRIORITY_HIGH_ACCURACY:I = 0x3

.field protected static final REQUEST_PRIORITY_LOW_POWER:I = 0x1

.field protected static final REQUEST_PRIORITY_NO_POWER:I = 0x0

.field protected static final SUCCESS_SETTINGS_SATISFIED:I = 0x0

.field protected static final SUCCESS_USER_AGREED:I = 0x1

.field public static final TAG:Ljava/lang/String; = "RequestLocationAccuracy"


# instance fields
.field protected context:Lorg/apache/cordova/CallbackContext;

.field protected googleApiAvailability:Lcom/google/android/gms/common/GoogleApiAvailability;

.field protected mGoogleApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

.field protected mLocationRequest:Lcom/google/android/gms/location/LocationRequest;

.field protected mLocationSettingsRequest:Lcom/google/android/gms/location/LocationSettingsRequest;

.field protected permanentError:Lcom/google/android/gms/common/ConnectionResult;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 159
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    const/4 v0, 0x0

    .line 61
    iput-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->mGoogleApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    .line 149
    iput-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->context:Lorg/apache/cordova/CallbackContext;

    .line 154
    iput-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->permanentError:Lcom/google/android/gms/common/ConnectionResult;

    return-void
.end method

.method private hasPermission(Ljava/lang/String;)Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v0, 0x1

    .line 258
    :try_start_0
    iget-object v1, p0, Lcordova/plugin/RequestLocationAccuracy;->cordova:Lorg/apache/cordova/CordovaInterface;

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

    .line 259
    iget-object v2, p0, Lcordova/plugin/RequestLocationAccuracy;->cordova:Lorg/apache/cordova/CordovaInterface;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    .line 260
    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    .line 262
    :catch_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Cordova v15.0.0 does not support runtime permissions so defaulting to GRANTED for "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v1, "RequestLocationAccuracy"

    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v0
.end method

.method private isLocationAuthorized()Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 249
    const-string v0, "android.permission.ACCESS_FINE_LOCATION"

    invoke-direct {p0, v0}, Lcordova/plugin/RequestLocationAccuracy;->hasPermission(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "android.permission.ACCESS_COARSE_LOCATION"

    invoke-direct {p0, v0}, Lcordova/plugin/RequestLocationAccuracy;->hasPermission(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    if-eqz v0, :cond_2

    .line 250
    const-string v1, "authorized"

    goto :goto_2

    :cond_2
    const-string v1, "unauthorized"

    :goto_2
    const-string v2, "Location permission is "

    invoke-virtual {v2, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "RequestLocationAccuracy"

    invoke-static {v2, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    return v0
.end method


# virtual methods
.method protected declared-synchronized buildGoogleApiClient()V
    .locals 2

    monitor-enter p0

    .line 300
    :try_start_0
    const-string v0, "RequestLocationAccuracy"

    const-string v1, "Building GoogleApiClient"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 301
    new-instance v0, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;

    iget-object v1, p0, Lcordova/plugin/RequestLocationAccuracy;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;-><init>(Landroid/content/Context;)V

    .line 302
    invoke-virtual {v0, p0}, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;->addConnectionCallbacks(Lcom/google/android/gms/common/api/GoogleApiClient$ConnectionCallbacks;)Lcom/google/android/gms/common/api/GoogleApiClient$Builder;

    move-result-object v0

    .line 303
    invoke-virtual {v0, p0}, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;->addOnConnectionFailedListener(Lcom/google/android/gms/common/api/GoogleApiClient$OnConnectionFailedListener;)Lcom/google/android/gms/common/api/GoogleApiClient$Builder;

    move-result-object v0

    sget-object v1, Lcom/google/android/gms/location/LocationServices;->API:Lcom/google/android/gms/common/api/Api;

    .line 304
    invoke-virtual {v0, v1}, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;->addApi(Lcom/google/android/gms/common/api/Api;)Lcom/google/android/gms/common/api/GoogleApiClient$Builder;

    move-result-object v0

    .line 305
    invoke-virtual {v0}, Lcom/google/android/gms/common/api/GoogleApiClient$Builder;->build()Lcom/google/android/gms/common/api/GoogleApiClient;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->mGoogleApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    .line 307
    const-string v0, "RequestLocationAccuracy"

    const-string v1, "Connect Google API client"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 308
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->mGoogleApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    invoke-virtual {v0}, Lcom/google/android/gms/common/api/GoogleApiClient;->connect()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 309
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method protected buildLocationSettingsRequest()V
    .locals 2

    .line 336
    const-string v0, "RequestLocationAccuracy"

    const-string v1, "Build location settings request"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 337
    new-instance v0, Lcom/google/android/gms/location/LocationSettingsRequest$Builder;

    invoke-direct {v0}, Lcom/google/android/gms/location/LocationSettingsRequest$Builder;-><init>()V

    .line 338
    iget-object v1, p0, Lcordova/plugin/RequestLocationAccuracy;->mLocationRequest:Lcom/google/android/gms/location/LocationRequest;

    invoke-virtual {v0, v1}, Lcom/google/android/gms/location/LocationSettingsRequest$Builder;->addLocationRequest(Lcom/google/android/gms/location/LocationRequest;)Lcom/google/android/gms/location/LocationSettingsRequest$Builder;

    const/4 v1, 0x1

    .line 339
    invoke-virtual {v0, v1}, Lcom/google/android/gms/location/LocationSettingsRequest$Builder;->setAlwaysShow(Z)Lcom/google/android/gms/location/LocationSettingsRequest$Builder;

    .line 340
    invoke-virtual {v0}, Lcom/google/android/gms/location/LocationSettingsRequest$Builder;->build()Lcom/google/android/gms/location/LocationSettingsRequest;

    move-result-object v0

    iput-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->mLocationSettingsRequest:Lcom/google/android/gms/location/LocationSettingsRequest;

    return-void
.end method

.method public canRequest()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 243
    invoke-direct {p0}, Lcordova/plugin/RequestLocationAccuracy;->isLocationAuthorized()Z

    move-result v0

    .line 244
    iget-object v1, p0, Lcordova/plugin/RequestLocationAccuracy;->context:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {v1, v0}, Lorg/apache/cordova/CallbackContext;->success(I)V

    const/4 v0, 0x1

    return v0
.end method

.method protected checkLocationSettings()V
    .locals 3

    .line 349
    const-string v0, "RequestLocationAccuracy"

    const-string v1, "Check location settings"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 350
    sget-object v0, Lcom/google/android/gms/location/LocationServices;->SettingsApi:Lcom/google/android/gms/location/SettingsApi;

    iget-object v1, p0, Lcordova/plugin/RequestLocationAccuracy;->mGoogleApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    iget-object v2, p0, Lcordova/plugin/RequestLocationAccuracy;->mLocationSettingsRequest:Lcom/google/android/gms/location/LocationSettingsRequest;

    .line 351
    invoke-interface {v0, v1, v2}, Lcom/google/android/gms/location/SettingsApi;->checkLocationSettings(Lcom/google/android/gms/common/api/GoogleApiClient;Lcom/google/android/gms/location/LocationSettingsRequest;)Lcom/google/android/gms/common/api/PendingResult;

    move-result-object v0

    .line 355
    invoke-virtual {v0, p0}, Lcom/google/android/gms/common/api/PendingResult;->setResultCallback(Lcom/google/android/gms/common/api/ResultCallback;)V

    return-void
.end method

.method protected createLocationRequest(I)V
    .locals 2

    .line 325
    const-string v0, "RequestLocationAccuracy"

    const-string v1, "Create location request"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 326
    new-instance v0, Lcom/google/android/gms/location/LocationRequest;

    invoke-direct {v0}, Lcom/google/android/gms/location/LocationRequest;-><init>()V

    iput-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->mLocationRequest:Lcom/google/android/gms/location/LocationRequest;

    .line 327
    invoke-virtual {v0, p1}, Lcom/google/android/gms/location/LocationRequest;->setPriority(I)Lcom/google/android/gms/location/LocationRequest;

    return-void
.end method

.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 189
    iput-object p3, p0, Lcordova/plugin/RequestLocationAccuracy;->context:Lorg/apache/cordova/CallbackContext;

    const/4 p3, 0x0

    .line 191
    :try_start_0
    const-string v0, "request"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 192
    invoke-virtual {p2, p3}, Lorg/json/JSONArray;->getInt(I)I

    move-result p1

    invoke-virtual {p0, p1}, Lcordova/plugin/RequestLocationAccuracy;->request(I)Z

    move-result p1

    return p1

    .line 193
    :cond_0
    const-string p2, "canRequest"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 194
    invoke-virtual {p0}, Lcordova/plugin/RequestLocationAccuracy;->canRequest()Z

    move-result p1

    return p1

    .line 196
    :cond_1
    const-string p1, "Invalid action"

    invoke-virtual {p0, p1, p3}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p3

    :catch_0
    move-exception p1

    .line 200
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x2

    invoke-virtual {p0, p1, p2}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    return p3
.end method

.method protected handleError(Ljava/lang/String;I)V
    .locals 3

    .line 269
    const-string v0, "RequestLocationAccuracy"

    :try_start_0
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 270
    iget-object v1, p0, Lcordova/plugin/RequestLocationAccuracy;->context:Lorg/apache/cordova/CallbackContext;

    if-eqz v1, :cond_0

    .line 271
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 272
    const-string v2, "message"

    invoke-virtual {v1, v2, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 273
    const-string p1, "code"

    invoke-virtual {v1, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 274
    iget-object p1, p0, Lcordova/plugin/RequestLocationAccuracy;->context:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {p1, v1}, Lorg/apache/cordova/CallbackContext;->error(Lorg/json/JSONObject;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 277
    invoke-virtual {p1}, Lorg/json/JSONException;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method protected handleSuccess(Ljava/lang/String;I)V
    .locals 2

    .line 283
    :try_start_0
    const-string v0, "RequestLocationAccuracy"

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 284
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->context:Lorg/apache/cordova/CallbackContext;

    if-eqz v0, :cond_0

    .line 285
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 286
    const-string v1, "message"

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 287
    const-string p1, "code"

    invoke-virtual {v0, p1, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 288
    iget-object p1, p0, Lcordova/plugin/RequestLocationAccuracy;->context:Lorg/apache/cordova/CallbackContext;

    invoke-virtual {p1, v0}, Lorg/apache/cordova/CallbackContext;->success(Lorg/json/JSONObject;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 291
    invoke-virtual {p1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x2

    invoke-virtual {p0, p1, p2}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    :cond_0
    return-void
.end method

.method public initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V
    .locals 0

    .line 170
    invoke-super {p0, p1, p2}, Lorg/apache/cordova/CordovaPlugin;->initialize(Lorg/apache/cordova/CordovaInterface;Lorg/apache/cordova/CordovaWebView;)V

    .line 172
    :try_start_0
    invoke-static {}, Lcom/google/android/gms/common/GoogleApiAvailability;->getInstance()Lcom/google/android/gms/common/GoogleApiAvailability;

    move-result-object p1

    iput-object p1, p0, Lcordova/plugin/RequestLocationAccuracy;->googleApiAvailability:Lcom/google/android/gms/common/GoogleApiAvailability;

    .line 173
    invoke-virtual {p0}, Lcordova/plugin/RequestLocationAccuracy;->buildGoogleApiClient()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 175
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x2

    invoke-virtual {p0, p1, p2}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    return-void
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    .line 395
    invoke-super {p0, p1, p2, p3}, Lorg/apache/cordova/CordovaPlugin;->onActivityResult(IILandroid/content/Intent;)V

    .line 396
    const-string p3, "onActivityResult()"

    const-string v0, "RequestLocationAccuracy"

    invoke-static {v0, p3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p3, 0x1

    if-eq p1, p3, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, -0x1

    if-eq p2, p1, :cond_2

    if-eqz p2, :cond_1

    :goto_0
    return-void

    .line 407
    :cond_1
    const-string p1, "User chose not to make required location settings changes."

    const/4 p2, 0x4

    invoke-virtual {p0, p1, p2}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    return-void

    .line 403
    :cond_2
    const-string p1, "User agreed to make required location settings changes."

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 404
    invoke-virtual {p0, p1, p3}, Lcordova/plugin/RequestLocationAccuracy;->handleSuccess(Ljava/lang/String;I)V

    return-void
.end method

.method public onConnected(Landroid/os/Bundle;)V
    .locals 1

    .line 419
    const-string p1, "RequestLocationAccuracy"

    const-string v0, "Connected to GoogleApiClient"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onConnectionFailed(Lcom/google/android/gms/common/ConnectionResult;)V
    .locals 3

    .line 450
    iput-object p1, p0, Lcordova/plugin/RequestLocationAccuracy;->permanentError:Lcom/google/android/gms/common/ConnectionResult;

    .line 452
    invoke-virtual {p1}, Lcom/google/android/gms/common/ConnectionResult;->getErrorCode()I

    move-result p1

    const-string v0, "The client attempted to connect to the service but the user is not signed in."

    packed-switch p1, :pswitch_data_0

    .line 508
    :pswitch_0
    const-string v0, "Unknown reason"

    goto :goto_0

    .line 491
    :pswitch_1
    const-string v0, "Google Play service doesn\'t have one or more required permissions."

    goto :goto_0

    .line 494
    :pswitch_2
    const-string v0, "Google Play service is currently being updated on this device."

    goto :goto_0

    .line 455
    :pswitch_3
    const-string v0, "One of the API components you attempted to connect to is not available."

    goto :goto_0

    .line 467
    :pswitch_4
    const-string v0, "An interrupt occurred while waiting for the connection complete."

    goto :goto_0

    .line 506
    :pswitch_5
    const-string v0, "The timeout was exceeded while waiting for the connection to complete."

    goto :goto_0

    .line 458
    :pswitch_6
    const-string v0, "The connection was canceled."

    goto :goto_0

    .line 473
    :pswitch_7
    const-string v0, "The application is not licensed to the user."

    goto :goto_0

    .line 461
    :pswitch_8
    const-string v0, "The application is misconfigured."

    goto :goto_0

    .line 485
    :pswitch_9
    const-string v0, "The version of the Google Play services installed on this device is not authentic."

    goto :goto_0

    .line 464
    :pswitch_a
    const-string v0, "An internal error occurred."

    goto :goto_0

    .line 476
    :pswitch_b
    const-string v0, "A network error occurred."

    goto :goto_0

    .line 479
    :pswitch_c
    const-string v0, "Completing the connection requires some form of resolution."

    goto :goto_0

    .line 470
    :pswitch_d
    const-string v0, "he client attempted to connect to the service with an invalid account name specified."

    goto :goto_0

    .line 482
    :pswitch_e
    const-string v0, "The installed version of Google Play services has been disabled on this device."

    goto :goto_0

    .line 497
    :pswitch_f
    const-string v0, "The installed version of Google Play services is out of date."

    goto :goto_0

    .line 488
    :pswitch_10
    const-string v0, "Google Play services is missing on this device."

    .line 510
    :goto_0
    :pswitch_11
    const-string p1, "Failed to connect to Google Play Services: "

    invoke-virtual {p1, v0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x5

    invoke-virtual {p0, p1, v0}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    .line 512
    iget-object p1, p0, Lcordova/plugin/RequestLocationAccuracy;->googleApiAvailability:Lcom/google/android/gms/common/GoogleApiAvailability;

    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/google/android/gms/common/GoogleApiAvailability;->isGooglePlayServicesAvailable(Landroid/content/Context;)I

    move-result p1

    .line 513
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->googleApiAvailability:Lcom/google/android/gms/common/GoogleApiAvailability;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/common/GoogleApiAvailability;->isUserResolvableError(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 514
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->googleApiAvailability:Lcom/google/android/gms/common/GoogleApiAvailability;

    iget-object v1, p0, Lcordova/plugin/RequestLocationAccuracy;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, p1, v2}, Lcom/google/android/gms/common/GoogleApiAvailability;->getErrorDialog(Landroid/app/Activity;II)Landroid/app/Dialog;

    move-result-object p1

    .line 515
    new-instance v0, Lcordova/plugin/RequestLocationAccuracy$1;

    invoke-direct {v0, p0}, Lcordova/plugin/RequestLocationAccuracy$1;-><init>(Lcordova/plugin/RequestLocationAccuracy;)V

    invoke-virtual {p1, v0}, Landroid/app/Dialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    .line 521
    invoke-virtual {p1}, Landroid/app/Dialog;->show()V

    const/4 p1, 0x0

    .line 522
    iput-object p1, p0, Lcordova/plugin/RequestLocationAccuracy;->permanentError:Lcom/google/android/gms/common/ConnectionResult;

    :cond_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_11
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_11
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public onConnectionSuspended(I)V
    .locals 1

    .line 424
    const-string p1, "RequestLocationAccuracy"

    const-string v0, "Connection suspended"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onDestroy()V
    .locals 2

    .line 435
    const-string v0, "On onDestroy"

    const-string v1, "RequestLocationAccuracy"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 436
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->mGoogleApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    if-eqz v0, :cond_0

    .line 437
    invoke-super {p0}, Lorg/apache/cordova/CordovaPlugin;->onStop()V

    .line 438
    const-string v0, "Disconnect Google API client"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 440
    :try_start_0
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->mGoogleApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    invoke-virtual {v0}, Lcom/google/android/gms/common/api/GoogleApiClient;->disconnect()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .line 442
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x2

    invoke-virtual {p0, v0, v1}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    :cond_0
    return-void
.end method

.method public bridge synthetic onResult(Lcom/google/android/gms/common/api/Result;)V
    .locals 0

    .line 52
    check-cast p1, Lcom/google/android/gms/location/LocationSettingsResult;

    invoke-virtual {p0, p1}, Lcordova/plugin/RequestLocationAccuracy;->onResult(Lcom/google/android/gms/location/LocationSettingsResult;)V

    return-void
.end method

.method public onResult(Lcom/google/android/gms/location/LocationSettingsResult;)V
    .locals 4

    .line 368
    const-string v0, "onResult()"

    const-string v1, "RequestLocationAccuracy"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 369
    invoke-virtual {p1}, Lcom/google/android/gms/location/LocationSettingsResult;->getStatus()Lcom/google/android/gms/common/api/Status;

    move-result-object p1

    .line 370
    invoke-virtual {p1}, Lcom/google/android/gms/common/api/Status;->getStatusCode()I

    move-result v0

    if-eqz v0, :cond_2

    const/4 v2, 0x6

    const/4 v3, 0x3

    if-eq v0, v2, :cond_1

    const/16 p1, 0x2136

    if-eq v0, p1, :cond_0

    goto :goto_0

    .line 388
    :cond_0
    const-string p1, "Location settings are inadequate, and cannot be fixed here. Dialog not created."

    invoke-virtual {p0, p1, v3}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    return-void

    .line 377
    :cond_1
    const-string v0, "Location settings are not satisfied. Show the user a dialog to upgrade location settings "

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 381
    :try_start_0
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0, p0}, Lorg/apache/cordova/CordovaInterface;->setActivityResultCallback(Lorg/apache/cordova/CordovaPlugin;)V

    .line 382
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/common/api/Status;->startResolutionForResult(Landroid/app/Activity;I)V
    :try_end_0
    .catch Landroid/content/IntentSender$SendIntentException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 384
    const-string v0, "PendingIntent unable to execute request: "

    invoke-virtual {p1}, Landroid/content/IntentSender$SendIntentException;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1, v3}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    :goto_0
    return-void

    .line 373
    :cond_2
    const-string p1, "All location settings are satisfied."

    invoke-static {v1, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    .line 374
    invoke-virtual {p0, p1, v0}, Lcordova/plugin/RequestLocationAccuracy;->handleSuccess(Ljava/lang/String;I)V

    return-void
.end method

.method public onStart()V
    .locals 2

    .line 429
    const-string v0, "RequestLocationAccuracy"

    const-string v1, "On start"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 430
    invoke-super {p0}, Lorg/apache/cordova/CordovaPlugin;->onStart()V

    return-void
.end method

.method public request(I)Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 207
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->permanentError:Lcom/google/android/gms/common/ConnectionResult;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 208
    invoke-virtual {p0, v0}, Lcordova/plugin/RequestLocationAccuracy;->onConnectionFailed(Lcom/google/android/gms/common/ConnectionResult;)V

    return v1

    .line 212
    :cond_0
    iget-object v0, p0, Lcordova/plugin/RequestLocationAccuracy;->mGoogleApiClient:Lcom/google/android/gms/common/api/GoogleApiClient;

    if-nez v0, :cond_1

    .line 213
    const-string p1, "Google Play Services Client failed to initialize"

    const/4 v0, 0x5

    invoke-virtual {p0, p1, v0}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    return v1

    :cond_1
    if-eqz p1, :cond_5

    if-eq p1, v1, :cond_4

    const/4 v0, 0x2

    if-eq p1, v0, :cond_3

    const/4 v0, 0x3

    if-eq p1, v0, :cond_2

    .line 232
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "\'"

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\' is not a valid accuracy constant"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1, v1}, Lcordova/plugin/RequestLocationAccuracy;->handleError(Ljava/lang/String;I)V

    const/4 p1, 0x0

    return p1

    :cond_2
    const/16 p1, 0x64

    goto :goto_0

    :cond_3
    const/16 p1, 0x66

    goto :goto_0

    :cond_4
    const/16 p1, 0x68

    goto :goto_0

    :cond_5
    const/16 p1, 0x69

    .line 236
    :goto_0
    invoke-virtual {p0, p1}, Lcordova/plugin/RequestLocationAccuracy;->createLocationRequest(I)V

    .line 237
    invoke-virtual {p0}, Lcordova/plugin/RequestLocationAccuracy;->buildLocationSettingsRequest()V

    .line 238
    invoke-virtual {p0}, Lcordova/plugin/RequestLocationAccuracy;->checkLocationSettings()V

    return v1
.end method
