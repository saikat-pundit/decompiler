package androidx.webkit.internal;

import androidx.webkit.WebNavigationClient;
import java.lang.reflect.InvocationHandler;
import java.util.concurrent.Callable;
import org.chromium.support_lib_boundary.WebViewNavigationBoundaryInterface;
import org.chromium.support_lib_boundary.WebViewNavigationClientBoundaryInterface;
import org.chromium.support_lib_boundary.WebViewPageBoundaryInterface;
import org.chromium.support_lib_boundary.util.BoundaryInterfaceReflectionUtil;

/* JADX INFO: loaded from: classes.dex */
public class WebNavigationClientAdapter implements WebViewNavigationClientBoundaryInterface {
    WebNavigationClient mWebNavigationClient;

    public WebNavigationClientAdapter(WebNavigationClient webNavigationClient) {
        this.mWebNavigationClient = webNavigationClient;
    }

    public WebNavigationClient getWebNavigationClient() {
        return this.mWebNavigationClient;
    }

    @Override // org.chromium.support_lib_boundary.WebViewNavigationClientBoundaryInterface
    public void onNavigationStarted(InvocationHandler invocationHandler) {
        final WebViewNavigationBoundaryInterface webViewNavigationBoundaryInterface = (WebViewNavigationBoundaryInterface) BoundaryInterfaceReflectionUtil.castToSuppLibClass(WebViewNavigationBoundaryInterface.class, invocationHandler);
        this.mWebNavigationClient.onNavigationStarted((NavigationAdapter) webViewNavigationBoundaryInterface.getOrCreatePeer(new Callable() { // from class: androidx.webkit.internal.WebNavigationClientAdapter$$ExternalSyntheticLambda1
            @Override // java.util.concurrent.Callable
            public final Object call() {
                return WebNavigationClientAdapter.lambda$onNavigationStarted$0(webViewNavigationBoundaryInterface);
            }
        }));
    }

    static /* synthetic */ Object lambda$onNavigationStarted$0(WebViewNavigationBoundaryInterface webViewNavigationBoundaryInterface) throws Exception {
        return new NavigationAdapter(webViewNavigationBoundaryInterface);
    }

    @Override // org.chromium.support_lib_boundary.WebViewNavigationClientBoundaryInterface
    public void onNavigationRedirected(InvocationHandler invocationHandler) {
        final WebViewNavigationBoundaryInterface webViewNavigationBoundaryInterface = (WebViewNavigationBoundaryInterface) BoundaryInterfaceReflectionUtil.castToSuppLibClass(WebViewNavigationBoundaryInterface.class, invocationHandler);
        this.mWebNavigationClient.onNavigationRedirected((NavigationAdapter) webViewNavigationBoundaryInterface.getOrCreatePeer(new Callable() { // from class: androidx.webkit.internal.WebNavigationClientAdapter$$ExternalSyntheticLambda3
            @Override // java.util.concurrent.Callable
            public final Object call() {
                return WebNavigationClientAdapter.lambda$onNavigationRedirected$1(webViewNavigationBoundaryInterface);
            }
        }));
    }

    static /* synthetic */ Object lambda$onNavigationRedirected$1(WebViewNavigationBoundaryInterface webViewNavigationBoundaryInterface) throws Exception {
        return new NavigationAdapter(webViewNavigationBoundaryInterface);
    }

    @Override // org.chromium.support_lib_boundary.WebViewNavigationClientBoundaryInterface
    public void onNavigationCompleted(InvocationHandler invocationHandler) {
        final WebViewNavigationBoundaryInterface webViewNavigationBoundaryInterface = (WebViewNavigationBoundaryInterface) BoundaryInterfaceReflectionUtil.castToSuppLibClass(WebViewNavigationBoundaryInterface.class, invocationHandler);
        this.mWebNavigationClient.onNavigationCompleted((NavigationAdapter) webViewNavigationBoundaryInterface.getOrCreatePeer(new Callable() { // from class: androidx.webkit.internal.WebNavigationClientAdapter$$ExternalSyntheticLambda6
            @Override // java.util.concurrent.Callable
            public final Object call() {
                return WebNavigationClientAdapter.lambda$onNavigationCompleted$2(webViewNavigationBoundaryInterface);
            }
        }));
    }

    static /* synthetic */ Object lambda$onNavigationCompleted$2(WebViewNavigationBoundaryInterface webViewNavigationBoundaryInterface) throws Exception {
        return new NavigationAdapter(webViewNavigationBoundaryInterface);
    }

    @Override // org.chromium.support_lib_boundary.WebViewNavigationClientBoundaryInterface
    public void onPageDeleted(InvocationHandler invocationHandler) {
        final WebViewPageBoundaryInterface webViewPageBoundaryInterface = (WebViewPageBoundaryInterface) BoundaryInterfaceReflectionUtil.castToSuppLibClass(WebViewPageBoundaryInterface.class, invocationHandler);
        this.mWebNavigationClient.onPageDeleted((PageImpl) webViewPageBoundaryInterface.getOrCreatePeer(new Callable() { // from class: androidx.webkit.internal.WebNavigationClientAdapter$$ExternalSyntheticLambda2
            @Override // java.util.concurrent.Callable
            public final Object call() {
                return WebNavigationClientAdapter.lambda$onPageDeleted$3(webViewPageBoundaryInterface);
            }
        }));
    }

    static /* synthetic */ Object lambda$onPageDeleted$3(WebViewPageBoundaryInterface webViewPageBoundaryInterface) throws Exception {
        return new PageImpl(webViewPageBoundaryInterface);
    }

    @Override // org.chromium.support_lib_boundary.WebViewNavigationClientBoundaryInterface
    public void onPageLoadEventFired(InvocationHandler invocationHandler) {
        final WebViewPageBoundaryInterface webViewPageBoundaryInterface = (WebViewPageBoundaryInterface) BoundaryInterfaceReflectionUtil.castToSuppLibClass(WebViewPageBoundaryInterface.class, invocationHandler);
        this.mWebNavigationClient.onPageLoadEventFired((PageImpl) webViewPageBoundaryInterface.getOrCreatePeer(new Callable() { // from class: androidx.webkit.internal.WebNavigationClientAdapter$$ExternalSyntheticLambda4
            @Override // java.util.concurrent.Callable
            public final Object call() {
                return WebNavigationClientAdapter.lambda$onPageLoadEventFired$4(webViewPageBoundaryInterface);
            }
        }));
    }

    static /* synthetic */ Object lambda$onPageLoadEventFired$4(WebViewPageBoundaryInterface webViewPageBoundaryInterface) throws Exception {
        return new PageImpl(webViewPageBoundaryInterface);
    }

    @Override // org.chromium.support_lib_boundary.WebViewNavigationClientBoundaryInterface
    public void onPageDOMContentLoadedEventFired(InvocationHandler invocationHandler) {
        final WebViewPageBoundaryInterface webViewPageBoundaryInterface = (WebViewPageBoundaryInterface) BoundaryInterfaceReflectionUtil.castToSuppLibClass(WebViewPageBoundaryInterface.class, invocationHandler);
        this.mWebNavigationClient.onPageDomContentLoadedEventFired((PageImpl) webViewPageBoundaryInterface.getOrCreatePeer(new Callable() { // from class: androidx.webkit.internal.WebNavigationClientAdapter$$ExternalSyntheticLambda5
            @Override // java.util.concurrent.Callable
            public final Object call() {
                return WebNavigationClientAdapter.lambda$onPageDOMContentLoadedEventFired$5(webViewPageBoundaryInterface);
            }
        }));
    }

    static /* synthetic */ Object lambda$onPageDOMContentLoadedEventFired$5(WebViewPageBoundaryInterface webViewPageBoundaryInterface) throws Exception {
        return new PageImpl(webViewPageBoundaryInterface);
    }

    @Override // org.chromium.support_lib_boundary.WebViewNavigationClientBoundaryInterface
    public void onFirstContentfulPaint(InvocationHandler invocationHandler) {
        final WebViewPageBoundaryInterface webViewPageBoundaryInterface = (WebViewPageBoundaryInterface) BoundaryInterfaceReflectionUtil.castToSuppLibClass(WebViewPageBoundaryInterface.class, invocationHandler);
        this.mWebNavigationClient.onFirstContentfulPaint((PageImpl) webViewPageBoundaryInterface.getOrCreatePeer(new Callable() { // from class: androidx.webkit.internal.WebNavigationClientAdapter$$ExternalSyntheticLambda0
            @Override // java.util.concurrent.Callable
            public final Object call() {
                return WebNavigationClientAdapter.lambda$onFirstContentfulPaint$6(webViewPageBoundaryInterface);
            }
        }));
    }

    static /* synthetic */ Object lambda$onFirstContentfulPaint$6(WebViewPageBoundaryInterface webViewPageBoundaryInterface) throws Exception {
        return new PageImpl(webViewPageBoundaryInterface);
    }

    @Override // org.chromium.support_lib_boundary.FeatureFlagHolderBoundaryInterface
    public String[] getSupportedFeatures() {
        return new String[]{"WEB_VIEW_NAVIGATION_CLIENT_BASIC_USAGE"};
    }
}
