package androidx.webkit.internal;

import java.util.concurrent.Executor;
import org.chromium.support_lib_boundary.WebStorageBoundaryInterface;

/* JADX INFO: loaded from: classes.dex */
public class WebStorageAdapter implements WebStorageBoundaryInterface {
    final WebStorageBoundaryInterface mImpl;

    public WebStorageAdapter(WebStorageBoundaryInterface webStorageBoundaryInterface) {
        this.mImpl = webStorageBoundaryInterface;
    }

    @Override // org.chromium.support_lib_boundary.WebStorageBoundaryInterface
    public void deleteBrowsingData(Executor executor, Runnable runnable) {
        this.mImpl.deleteBrowsingData(executor, runnable);
    }

    @Override // org.chromium.support_lib_boundary.WebStorageBoundaryInterface
    public String deleteBrowsingDataForSite(String str, Executor executor, Runnable runnable) {
        return this.mImpl.deleteBrowsingDataForSite(str, executor, runnable);
    }
}
