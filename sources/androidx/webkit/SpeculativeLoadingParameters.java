package androidx.webkit;

import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public final class SpeculativeLoadingParameters {
    private final Map<String, String> mAdditionalHeaders;
    private final NoVarySearchHeader mExpectedNoVarySearchHeader;
    private final boolean mIsJavaScriptEnabled;

    private SpeculativeLoadingParameters(Map<String, String> map, NoVarySearchHeader noVarySearchHeader, boolean z) {
        this.mAdditionalHeaders = map;
        this.mExpectedNoVarySearchHeader = noVarySearchHeader;
        this.mIsJavaScriptEnabled = z;
    }

    public Map<String, String> getAdditionalHeaders() {
        return this.mAdditionalHeaders;
    }

    public NoVarySearchHeader getExpectedNoVarySearchData() {
        return this.mExpectedNoVarySearchHeader;
    }

    public boolean isJavaScriptEnabled() {
        return this.mIsJavaScriptEnabled;
    }

    public static final class Builder {
        private final Map<String, String> mAdditionalHeaders = new HashMap();
        private NoVarySearchHeader mExpectedNoVarySearchHeader = null;
        private boolean mIsJavaScriptEnabled = false;

        public SpeculativeLoadingParameters build() {
            return new SpeculativeLoadingParameters(this.mAdditionalHeaders, this.mExpectedNoVarySearchHeader, this.mIsJavaScriptEnabled);
        }

        public Builder addAdditionalHeader(String str, String str2) {
            this.mAdditionalHeaders.put(str, str2);
            return this;
        }

        public Builder addAdditionalHeaders(Map<String, String> map) {
            this.mAdditionalHeaders.putAll(map);
            return this;
        }

        public Builder setExpectedNoVarySearchData(NoVarySearchHeader noVarySearchHeader) {
            this.mExpectedNoVarySearchHeader = noVarySearchHeader;
            return this;
        }

        public Builder setJavaScriptEnabled(boolean z) {
            this.mIsJavaScriptEnabled = z;
            return this;
        }
    }
}
