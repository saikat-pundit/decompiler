.class public Lorg/apache/cordova/SystemBarPlugin;
.super Lorg/apache/cordova/CordovaPlugin;
.source "SystemBarPlugin.java"


# static fields
.field static final INVALID_COLOR:I = -0x1

.field static final PLUGIN_NAME:Ljava/lang/String; = "SystemBarPlugin"


# instance fields
.field private canEdgeToEdge:Z

.field private context:Landroid/content/Context;

.field private overrideStatusBarBackgroundColor:I

.field private resources:Landroid/content/res/Resources;


# direct methods
.method public static synthetic $r8$lambda$4vDW5RKc95Y_4Cej23QuFXf91Qs(Lorg/apache/cordova/SystemBarPlugin;)V
    .locals 0

    invoke-direct {p0}, Lorg/apache/cordova/SystemBarPlugin;->updateSystemBars()V

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 42
    invoke-direct {p0}, Lorg/apache/cordova/CordovaPlugin;-><init>()V

    const/4 v0, -0x1

    .line 50
    iput v0, p0, Lorg/apache/cordova/SystemBarPlugin;->overrideStatusBarBackgroundColor:I

    const/4 v0, 0x0

    .line 52
    iput-boolean v0, p0, Lorg/apache/cordova/SystemBarPlugin;->canEdgeToEdge:Z

    return-void
.end method

.method private getPreferenceBackgroundColor()I
    .locals 3

    const/4 v0, -0x1

    .line 289
    :try_start_0
    iget-object v1, p0, Lorg/apache/cordova/SystemBarPlugin;->preferences:Lorg/apache/cordova/CordovaPreferences;

    const-string v2, "BackgroundColor"

    invoke-virtual {v1, v2, v0}, Lorg/apache/cordova/CordovaPreferences;->getInteger(Ljava/lang/String;I)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 291
    :catch_0
    const-string v1, "SystemBarPlugin"

    const-string v2, "Invalid background color argument. Example valid string: \'0x00000000\'"

    invoke-static {v1, v2}, Lorg/apache/cordova/LOG;->e(Ljava/lang/String;Ljava/lang/String;)V

    return v0
.end method

.method private getPreferenceStatusBarBackgroundColor()I
    .locals 3

    .line 273
    iget-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->preferences:Lorg/apache/cordova/CordovaPreferences;

    const-string v1, "StatusBarBackgroundColor"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/CordovaPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 275
    invoke-direct {p0, v0}, Lorg/apache/cordova/SystemBarPlugin;->parseColorFromString(Ljava/lang/String;)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    return v0

    .line 278
    :cond_0
    invoke-direct {p0}, Lorg/apache/cordova/SystemBarPlugin;->getUiModeColor()I

    move-result v0

    return v0
.end method

.method private getRootLayout(Lorg/apache/cordova/CordovaWebView;)Landroid/widget/FrameLayout;
    .locals 1

    .line 303
    invoke-interface {p1}, Lorg/apache/cordova/CordovaWebView;->getView()Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p1

    .line 304
    instance-of v0, p1, Landroid/widget/FrameLayout;

    if-eqz v0, :cond_0

    .line 305
    check-cast p1, Landroid/widget/FrameLayout;

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private getStatusBarView(Lorg/apache/cordova/CordovaWebView;)Landroid/view/View;
    .locals 5

    .line 318
    invoke-direct {p0, p1}, Lorg/apache/cordova/SystemBarPlugin;->getRootLayout(Lorg/apache/cordova/CordovaWebView;)Landroid/widget/FrameLayout;

    move-result-object p1

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    const/4 v1, 0x0

    .line 323
    :goto_0
    invoke-virtual {p1}, Landroid/widget/FrameLayout;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 324
    invoke-virtual {p1, v1}, Landroid/widget/FrameLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    .line 325
    invoke-virtual {v2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v3

    .line 326
    const-string v4, "statusBarView"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    return-object v2

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    return-object v0
.end method

.method private getUiModeColor()I
    .locals 5

    .line 349
    iget-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->resources:Landroid/content/res/Resources;

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->uiMode:I

    and-int/lit8 v0, v0, 0x30

    const/16 v1, 0x20

    if-ne v0, v1, :cond_0

    .line 350
    const-string v0, "#121318"

    goto :goto_0

    :cond_0
    const-string v0, "#FAF8FF"

    .line 351
    :goto_0
    iget-object v1, p0, Lorg/apache/cordova/SystemBarPlugin;->resources:Landroid/content/res/Resources;

    iget-object v2, p0, Lorg/apache/cordova/SystemBarPlugin;->context:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "cdv_background_color"

    const-string v4, "color"

    invoke-virtual {v1, v3, v4, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_1

    .line 353
    iget-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->context:Landroid/content/Context;

    invoke-static {v0, v1}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v0

    return v0

    .line 354
    :cond_1
    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private static isColorLight(I)Z
    .locals 8

    .line 257
    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v0

    int-to-double v0, v0

    const-wide v2, 0x406fe00000000000L    # 255.0

    div-double/2addr v0, v2

    .line 258
    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v4

    int-to-double v4, v4

    div-double/2addr v4, v2

    .line 259
    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

    move-result p0

    int-to-double v6, p0

    div-double/2addr v6, v2

    const-wide v2, 0x3fd322d0e5604189L    # 0.299

    mul-double/2addr v0, v2

    const-wide v2, 0x3fe2c8b439581062L    # 0.587

    mul-double/2addr v4, v2

    add-double/2addr v0, v4

    const-wide v2, 0x3fbd2f1a9fbe76c9L    # 0.114

    mul-double/2addr v6, v2

    add-double/2addr v0, v6

    const-wide/high16 v2, 0x3fe0000000000000L    # 0.5

    cmpl-double p0, v0, v2

    if-lez p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method private parseColorFromString(Ljava/lang/String;)I
    .locals 2

    .line 365
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    return v1

    .line 368
    :cond_0
    :try_start_0
    invoke-static {p1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result p1
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    .line 370
    :catch_0
    const-string p1, "SystemBarPlugin"

    const-string v0, "Invalid color hex code. Valid format: #RRGGBB or #AARRGGBB"

    invoke-static {p1, v0}, Lorg/apache/cordova/LOG;->e(Ljava/lang/String;Ljava/lang/String;)V

    return v1
.end method

.method private setStatusBarBackgroundColor(Lorg/json/JSONArray;)V
    .locals 4

    const/4 v0, 0x0

    .line 129
    :try_start_0
    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->getInt(I)I

    move-result v0

    const/4 v1, 0x1

    .line 130
    invoke-virtual {p1, v1}, Lorg/json/JSONArray;->getInt(I)I

    move-result v1

    const/4 v2, 0x2

    .line 131
    invoke-virtual {p1, v2}, Lorg/json/JSONArray;->getInt(I)I

    move-result v2

    const/4 v3, 0x3

    .line 132
    invoke-virtual {p1, v3}, Lorg/json/JSONArray;->getInt(I)I

    move-result p1

    .line 133
    const-string v3, "#%02X%02X%02X%02X"

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    filled-new-array {v0, v1, v2, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v3, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    .line 135
    invoke-direct {p0, p1}, Lorg/apache/cordova/SystemBarPlugin;->parseColorFromString(Ljava/lang/String;)I

    move-result p1

    const/4 v0, -0x1

    if-ne p1, v0, :cond_0

    goto :goto_0

    .line 138
    :cond_0
    iput p1, p0, Lorg/apache/cordova/SystemBarPlugin;->overrideStatusBarBackgroundColor:I

    .line 139
    invoke-direct {p0, p1}, Lorg/apache/cordova/SystemBarPlugin;->updateStatusBar(I)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    return-void
.end method

.method private setStatusBarVisible(Z)V
    .locals 1

    .line 109
    iget-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->webView:Lorg/apache/cordova/CordovaWebView;

    invoke-direct {p0, v0}, Lorg/apache/cordova/SystemBarPlugin;->getStatusBarView(Lorg/apache/cordova/CordovaWebView;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_1

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    .line 111
    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    .line 113
    iget-object p1, p0, Lorg/apache/cordova/SystemBarPlugin;->webView:Lorg/apache/cordova/CordovaWebView;

    invoke-direct {p0, p1}, Lorg/apache/cordova/SystemBarPlugin;->getRootLayout(Lorg/apache/cordova/CordovaWebView;)Landroid/widget/FrameLayout;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 115
    invoke-static {p1}, Landroidx/core/view/ViewCompat;->requestApplyInsets(Landroid/view/View;)V

    :cond_1
    return-void
.end method

.method private updateRootView(I)V
    .locals 5

    .line 190
    iget-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 193
    iget-object v1, p0, Lorg/apache/cordova/SystemBarPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    const v2, 0x1020002

    invoke-virtual {v1, v2}, Landroidx/appcompat/app/AppCompatActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 194
    invoke-virtual {v1, p1}, Landroid/view/View;->setBackgroundColor(I)V

    :cond_0
    if-nez p1, :cond_1

    .line 199
    invoke-direct {p0}, Lorg/apache/cordova/SystemBarPlugin;->getUiModeColor()I

    move-result v1

    invoke-static {v1}, Lorg/apache/cordova/SystemBarPlugin;->isColorLight(I)Z

    move-result v1

    goto :goto_0

    .line 201
    :cond_1
    invoke-static {p1}, Lorg/apache/cordova/SystemBarPlugin;->isColorLight(I)Z

    move-result v1

    .line 203
    :goto_0
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1e

    if-lt v2, v3, :cond_3

    .line 204
    invoke-virtual {v0}, Landroid/view/Window;->getInsetsController()Landroid/view/WindowInsetsController;

    move-result-object v2

    if-eqz v2, :cond_3

    const/16 v3, 0x8

    if-eqz v1, :cond_2

    const/4 v4, 0x0

    .line 208
    invoke-interface {v2, v4, v3}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V

    goto :goto_1

    .line 210
    :cond_2
    invoke-interface {v2, v3, v3}, Landroid/view/WindowInsetsController;->setSystemBarsAppearance(II)V

    .line 214
    :cond_3
    :goto_1
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    invoke-static {v0, v2}, Landroidx/core/view/WindowCompat;->getInsetsController(Landroid/view/Window;Landroid/view/View;)Landroidx/core/view/WindowInsetsControllerCompat;

    move-result-object v2

    .line 215
    invoke-virtual {v2, v1}, Landroidx/core/view/WindowInsetsControllerCompat;->setAppearanceLightNavigationBars(Z)V

    .line 217
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_4

    .line 218
    invoke-virtual {v0, p1}, Landroid/view/Window;->setNavigationBarColor(I)V

    return-void

    :cond_4
    const/high16 p1, -0x1000000

    .line 220
    invoke-virtual {v0, p1}, Landroid/view/Window;->setNavigationBarColor(I)V

    return-void
.end method

.method private updateStatusBar(I)V
    .locals 2

    .line 232
    iget-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 234
    iget-object v1, p0, Lorg/apache/cordova/SystemBarPlugin;->webView:Lorg/apache/cordova/CordovaWebView;

    invoke-direct {p0, v1}, Lorg/apache/cordova/SystemBarPlugin;->getStatusBarView(Lorg/apache/cordova/CordovaWebView;)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 236
    invoke-virtual {v1, p1}, Landroid/view/View;->setBackgroundColor(I)V

    :cond_0
    if-nez p1, :cond_1

    .line 242
    invoke-direct {p0}, Lorg/apache/cordova/SystemBarPlugin;->getUiModeColor()I

    move-result p1

    invoke-static {p1}, Lorg/apache/cordova/SystemBarPlugin;->isColorLight(I)Z

    move-result p1

    goto :goto_0

    .line 244
    :cond_1
    invoke-static {p1}, Lorg/apache/cordova/SystemBarPlugin;->isColorLight(I)Z

    move-result p1

    .line 246
    :goto_0
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-static {v0, v1}, Landroidx/core/view/WindowCompat;->getInsetsController(Landroid/view/Window;Landroid/view/View;)Landroidx/core/view/WindowInsetsControllerCompat;

    move-result-object v0

    .line 247
    invoke-virtual {v0, p1}, Landroidx/core/view/WindowInsetsControllerCompat;->setAppearanceLightStatusBars(Z)V

    return-void
.end method

.method private updateSystemBars()V
    .locals 4

    .line 155
    invoke-direct {p0}, Lorg/apache/cordova/SystemBarPlugin;->getPreferenceBackgroundColor()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, -0x1

    if-ne v0, v2, :cond_1

    .line 157
    iget-boolean v0, p0, Lorg/apache/cordova/SystemBarPlugin;->canEdgeToEdge:Z

    if-eqz v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lorg/apache/cordova/SystemBarPlugin;->getUiModeColor()I

    move-result v0

    .line 159
    :cond_1
    :goto_0
    invoke-direct {p0, v0}, Lorg/apache/cordova/SystemBarPlugin;->updateRootView(I)V

    .line 163
    iget v3, p0, Lorg/apache/cordova/SystemBarPlugin;->overrideStatusBarBackgroundColor:I

    if-eq v3, v2, :cond_2

    move v0, v3

    goto :goto_2

    .line 165
    :cond_2
    iget-object v2, p0, Lorg/apache/cordova/SystemBarPlugin;->preferences:Lorg/apache/cordova/CordovaPreferences;

    const-string v3, "StatusBarBackgroundColor"

    invoke-virtual {v2, v3}, Lorg/apache/cordova/CordovaPreferences;->contains(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 166
    invoke-direct {p0}, Lorg/apache/cordova/SystemBarPlugin;->getPreferenceStatusBarBackgroundColor()I

    move-result v0

    goto :goto_2

    .line 167
    :cond_3
    iget-object v2, p0, Lorg/apache/cordova/SystemBarPlugin;->preferences:Lorg/apache/cordova/CordovaPreferences;

    const-string v3, "BackgroundColor"

    invoke-virtual {v2, v3}, Lorg/apache/cordova/CordovaPreferences;->contains(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    goto :goto_2

    .line 170
    :cond_4
    iget-boolean v0, p0, Lorg/apache/cordova/SystemBarPlugin;->canEdgeToEdge:Z

    if-eqz v0, :cond_5

    goto :goto_1

    :cond_5
    invoke-direct {p0}, Lorg/apache/cordova/SystemBarPlugin;->getUiModeColor()I

    move-result v1

    :goto_1
    move v0, v1

    .line 173
    :goto_2
    invoke-direct {p0, v0}, Lorg/apache/cordova/SystemBarPlugin;->updateStatusBar(I)V

    return-void
.end method


# virtual methods
.method public execute(Ljava/lang/String;Lorg/json/JSONArray;Lorg/apache/cordova/CallbackContext;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 84
    iget-boolean v0, p0, Lorg/apache/cordova/SystemBarPlugin;->canEdgeToEdge:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 88
    :cond_0
    const-string v0, "setStatusBarVisible"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 89
    invoke-virtual {p2, v1}, Lorg/json/JSONArray;->getBoolean(I)Z

    move-result p1

    .line 90
    iget-object p2, p0, Lorg/apache/cordova/SystemBarPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {p2}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p2

    new-instance v0, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0, p1}, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda0;-><init>(Lorg/apache/cordova/SystemBarPlugin;Z)V

    invoke-virtual {p2, v0}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_0

    .line 91
    :cond_1
    const-string v0, "setStatusBarBackgroundColor"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 92
    iget-object p1, p0, Lorg/apache/cordova/SystemBarPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {p1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p1

    new-instance v0, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0, p2}, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda1;-><init>(Lorg/apache/cordova/SystemBarPlugin;Lorg/json/JSONArray;)V

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 97
    :goto_0
    invoke-virtual {p3}, Lorg/apache/cordova/CallbackContext;->success()V

    const/4 p1, 0x1

    return p1

    :cond_2
    return v1
.end method

.method synthetic lambda$execute$0$org-apache-cordova-SystemBarPlugin(Z)V
    .locals 0

    .line 90
    invoke-direct {p0, p1}, Lorg/apache/cordova/SystemBarPlugin;->setStatusBarVisible(Z)V

    return-void
.end method

.method synthetic lambda$execute$1$org-apache-cordova-SystemBarPlugin(Lorg/json/JSONArray;)V
    .locals 0

    .line 92
    invoke-direct {p0, p1}, Lorg/apache/cordova/SystemBarPlugin;->setStatusBarBackgroundColor(Lorg/json/JSONArray;)V

    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 1

    .line 64
    invoke-super {p0, p1}, Lorg/apache/cordova/CordovaPlugin;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 65
    iget-object p1, p0, Lorg/apache/cordova/SystemBarPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {p1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p1

    new-instance v0, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda2;-><init>(Lorg/apache/cordova/SystemBarPlugin;)V

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onMessage(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 76
    const-string p2, "updateSystemBars"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 77
    iget-object p1, p0, Lorg/apache/cordova/SystemBarPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {p1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p1

    new-instance p2, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda2;

    invoke-direct {p2, p0}, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda2;-><init>(Lorg/apache/cordova/SystemBarPlugin;)V

    invoke-virtual {p1, p2}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public onResume(Z)V
    .locals 1

    .line 70
    invoke-super {p0, p1}, Lorg/apache/cordova/CordovaPlugin;->onResume(Z)V

    .line 71
    iget-object p1, p0, Lorg/apache/cordova/SystemBarPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {p1}, Lorg/apache/cordova/CordovaInterface;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p1

    new-instance v0, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lorg/apache/cordova/SystemBarPlugin$$ExternalSyntheticLambda2;-><init>(Lorg/apache/cordova/SystemBarPlugin;)V

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AppCompatActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method protected pluginInitialize()V
    .locals 3

    .line 56
    iget-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->cordova:Lorg/apache/cordova/CordovaInterface;

    invoke-interface {v0}, Lorg/apache/cordova/CordovaInterface;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->context:Landroid/content/Context;

    .line 57
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->resources:Landroid/content/res/Resources;

    .line 58
    iget-object v0, p0, Lorg/apache/cordova/SystemBarPlugin;->preferences:Lorg/apache/cordova/CordovaPreferences;

    const-string v1, "AndroidEdgeToEdge"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/apache/cordova/CordovaPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x23

    if-lt v0, v1, :cond_0

    const/4 v2, 0x1

    :cond_0
    iput-boolean v2, p0, Lorg/apache/cordova/SystemBarPlugin;->canEdgeToEdge:Z

    return-void
.end method
