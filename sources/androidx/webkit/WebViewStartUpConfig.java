package androidx.webkit;

import java.util.concurrent.Executor;

/* JADX INFO: loaded from: classes.dex */
public final class WebViewStartUpConfig {
    private final Executor mExecutor;
    private final boolean mShouldRunUiThreadStartUpTasks;

    private WebViewStartUpConfig(Executor executor, boolean z) {
        this.mExecutor = executor;
        this.mShouldRunUiThreadStartUpTasks = z;
    }

    public Executor getBackgroundExecutor() {
        return this.mExecutor;
    }

    public boolean shouldRunUiThreadStartUpTasks() {
        return this.mShouldRunUiThreadStartUpTasks;
    }

    public static final class Builder {
        private final Executor mExecutor;
        private boolean mShouldRunUiThreadStartUpTasks = true;

        public Builder(Executor executor) {
            this.mExecutor = executor;
        }

        public Builder setShouldRunUiThreadStartUpTasks(boolean z) {
            this.mShouldRunUiThreadStartUpTasks = z;
            return this;
        }

        public WebViewStartUpConfig build() {
            return new WebViewStartUpConfig(this.mExecutor, this.mShouldRunUiThreadStartUpTasks);
        }
    }
}
