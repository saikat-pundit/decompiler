package com.google.android.gms.common.api.internal;

import android.app.Activity;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zaa extends ActivityLifecycleObserver {
    private final WeakReference<C0002zaa> zack;

    public zaa(Activity activity) {
        this(C0002zaa.zaa(activity));
    }

    private zaa(C0002zaa c0002zaa) {
        this.zack = new WeakReference<>(c0002zaa);
    }

    @Override // com.google.android.gms.common.api.internal.ActivityLifecycleObserver
    public final ActivityLifecycleObserver onStopCallOnce(Runnable runnable) {
        C0002zaa c0002zaa = this.zack.get();
        if (c0002zaa == null) {
            throw new IllegalStateException("The target activity has already been GC'd");
        }
        c0002zaa.zaa(runnable);
        return this;
    }

    /* JADX INFO: renamed from: com.google.android.gms.common.api.internal.zaa$zaa, reason: collision with other inner class name */
    static class C0002zaa extends LifecycleCallback {
        private List<Runnable> zacl;

        /* JADX INFO: Access modifiers changed from: private */
        public static C0002zaa zaa(Activity activity) {
            C0002zaa c0002zaa;
            synchronized (activity) {
                LifecycleFragment fragment = getFragment(activity);
                c0002zaa = (C0002zaa) fragment.getCallbackOrNull("LifecycleObserverOnStop", C0002zaa.class);
                if (c0002zaa == null) {
                    c0002zaa = new C0002zaa(fragment);
                }
            }
            return c0002zaa;
        }

        private C0002zaa(LifecycleFragment lifecycleFragment) {
            super(lifecycleFragment);
            this.zacl = new ArrayList();
            this.mLifecycleFragment.addCallback("LifecycleObserverOnStop", this);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final synchronized void zaa(Runnable runnable) {
            this.zacl.add(runnable);
        }

        @Override // com.google.android.gms.common.api.internal.LifecycleCallback
        public void onStop() {
            List<Runnable> list;
            synchronized (this) {
                list = this.zacl;
                this.zacl = new ArrayList();
            }
            Iterator<Runnable> it = list.iterator();
            while (it.hasNext()) {
                it.next().run();
            }
        }
    }
}
