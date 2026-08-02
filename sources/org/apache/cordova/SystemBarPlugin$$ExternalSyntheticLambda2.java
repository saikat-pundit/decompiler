package org.apache.cordova;

/* JADX INFO: compiled from: D8$$SyntheticClass */
/* JADX INFO: loaded from: classes.dex */
public final /* synthetic */ class SystemBarPlugin$$ExternalSyntheticLambda2 implements Runnable {
    public final /* synthetic */ SystemBarPlugin f$0;

    public /* synthetic */ SystemBarPlugin$$ExternalSyntheticLambda2(SystemBarPlugin systemBarPlugin) {
        this.f$0 = systemBarPlugin;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.f$0.updateSystemBars();
    }
}
