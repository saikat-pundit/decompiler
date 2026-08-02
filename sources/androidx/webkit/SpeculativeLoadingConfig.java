package androidx.webkit;

/* JADX INFO: loaded from: classes.dex */
public class SpeculativeLoadingConfig {
    private final int mMaxPrefetches;
    private final int mMaxPrerenders;
    private final int mPrefetchTTLSeconds;

    private SpeculativeLoadingConfig(int i, int i2, int i3) {
        this.mPrefetchTTLSeconds = i;
        this.mMaxPrefetches = i2;
        this.mMaxPrerenders = i3;
    }

    public int getPrefetchTtlSeconds() {
        return this.mPrefetchTTLSeconds;
    }

    public int getMaxPrefetches() {
        return this.mMaxPrefetches;
    }

    public int getMaxPrerenders() {
        return this.mMaxPrerenders;
    }

    public static final class Builder {
        private int mMaxPrefetches;
        private int mMaxPrerenders;
        private int mPrefetchTTLSeconds;

        public Builder setPrefetchTtlSeconds(int i) {
            if (i <= 0) {
                throw new IllegalArgumentException("Prefetch TTL must be greater than 0");
            }
            this.mPrefetchTTLSeconds = i;
            return this;
        }

        public Builder setMaxPrefetches(int i) {
            if (i < 1) {
                throw new IllegalArgumentException("Max prefetches must be greater than 0");
            }
            this.mMaxPrefetches = i;
            return this;
        }

        public Builder setMaxPrerenders(int i) {
            if (i < 1) {
                throw new IllegalArgumentException("Max prerenders must be greater than 0");
            }
            this.mMaxPrerenders = i;
            return this;
        }

        public SpeculativeLoadingConfig build() {
            return new SpeculativeLoadingConfig(this.mPrefetchTTLSeconds, this.mMaxPrefetches, this.mMaxPrerenders);
        }
    }
}
