package androidx.webkit;

import android.os.Handler;
import android.os.Looper;
import android.webkit.WebStorage;
import androidx.webkit.internal.WebStorageAdapter;
import androidx.webkit.internal.WebViewFeatureInternal;
import androidx.webkit.internal.WebViewGlueCommunicator;
import java.util.concurrent.Executor;

/* JADX INFO: loaded from: classes.dex */
public final class WebStorageCompat {
    private WebStorageCompat() {
    }

    public static void deleteBrowsingData(WebStorage webStorage, Executor executor, Runnable runnable) {
        if (WebViewFeatureInternal.DELETE_BROWSING_DATA.isSupportedByWebView()) {
            getAdapter(webStorage).deleteBrowsingData(executor, runnable);
            return;
        }
        throw WebViewFeatureInternal.getUnsupportedOperationException();
    }

    public static void deleteBrowsingData(WebStorage webStorage, Runnable runnable) {
        deleteBrowsingData(webStorage, new Executor() { // from class: androidx.webkit.WebStorageCompat$$ExternalSyntheticLambda1
            @Override // java.util.concurrent.Executor
            public final void execute(Runnable runnable2) {
                new Handler(Looper.getMainLooper()).post(runnable2);
            }
        }, runnable);
    }

    public static String deleteBrowsingDataForSite(WebStorage webStorage, String str, Executor executor, Runnable runnable) {
        if (WebViewFeatureInternal.DELETE_BROWSING_DATA.isSupportedByWebView()) {
            return getAdapter(webStorage).deleteBrowsingDataForSite(str, executor, runnable);
        }
        throw WebViewFeatureInternal.getUnsupportedOperationException();
    }

    public static String deleteBrowsingDataForSite(WebStorage webStorage, String str, Runnable runnable) {
        return deleteBrowsingDataForSite(webStorage, str, new Executor() { // from class: androidx.webkit.WebStorageCompat$$ExternalSyntheticLambda0
            @Override // java.util.concurrent.Executor
            public final void execute(Runnable runnable2) {
                new Handler(Looper.getMainLooper()).post(runnable2);
            }
        }, runnable);
    }

    private static WebStorageAdapter getAdapter(WebStorage webStorage) {
        return WebViewGlueCommunicator.getCompatConverter().convertWebStorage(webStorage);
    }
}
