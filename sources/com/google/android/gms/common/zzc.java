package com.google.android.gms.common;

import android.content.Context;
import android.os.RemoteException;
import android.os.StrictMode;
import android.util.Log;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.dynamite.DynamiteModule;
import java.util.concurrent.Callable;
import javax.annotation.CheckReturnValue;

/* JADX INFO: loaded from: classes.dex */
@CheckReturnValue
final class zzc {
    private static volatile com.google.android.gms.common.internal.zzm zzn;
    private static final Object zzo = new Object();
    private static Context zzp;

    static synchronized void zza(Context context) {
        if (zzp != null) {
            Log.w("GoogleCertificates", "GoogleCertificates has been initialized already");
        } else if (context != null) {
            zzp = context.getApplicationContext();
        }
    }

    static zzm zza(String str, zze zzeVar, boolean z) {
        StrictMode.ThreadPolicy threadPolicyAllowThreadDiskReads = StrictMode.allowThreadDiskReads();
        try {
            return zzb(str, zzeVar, z);
        } finally {
            StrictMode.setThreadPolicy(threadPolicyAllowThreadDiskReads);
        }
    }

    private static zzm zzb(final String str, final zze zzeVar, final boolean z) {
        try {
            if (zzn == null) {
                Preconditions.checkNotNull(zzp);
                synchronized (zzo) {
                    if (zzn == null) {
                        zzn = com.google.android.gms.common.internal.zzn.zzc(DynamiteModule.load(zzp, DynamiteModule.PREFER_HIGHEST_OR_LOCAL_VERSION_NO_FORCE_STAGING, "com.google.android.gms.googlecertificates").instantiate("com.google.android.gms.common.GoogleCertificatesImpl"));
                    }
                }
            }
            Preconditions.checkNotNull(zzp);
            try {
                if (zzn.zza(new zzk(str, zzeVar, z), ObjectWrapper.wrap(zzp.getPackageManager()))) {
                    return zzm.zze();
                }
                return zzm.zza(new Callable(z, str, zzeVar) { // from class: com.google.android.gms.common.zzd
                    private final boolean zzq;
                    private final String zzr;
                    private final zze zzs;

                    {
                        this.zzq = z;
                        this.zzr = str;
                        this.zzs = zzeVar;
                    }

                    @Override // java.util.concurrent.Callable
                    public final Object call() {
                        return zzc.zza(this.zzq, this.zzr, this.zzs);
                    }
                });
            } catch (RemoteException e) {
                Log.e("GoogleCertificates", "Failed to get Google certificates from remote", e);
                return zzm.zza("module call", e);
            }
        } catch (DynamiteModule.LoadingException e2) {
            Log.e("GoogleCertificates", "Failed to get Google certificates from remote", e2);
            String strValueOf = String.valueOf(e2.getMessage());
            return zzm.zza(strValueOf.length() != 0 ? "module init: ".concat(strValueOf) : new String("module init: "), e2);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:6:0x000c  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    static final /* synthetic */ java.lang.String zza(boolean r2, java.lang.String r3, com.google.android.gms.common.zze r4) throws java.lang.Exception {
        /*
            if (r2 != 0) goto Lc
            r0 = 1
            com.google.android.gms.common.zzm r1 = zzb(r3, r4, r0)
            boolean r1 = r1.zzac
            if (r1 == 0) goto Lc
            goto Ld
        Lc:
            r0 = 0
        Ld:
            java.lang.String r2 = com.google.android.gms.common.zzm.zza(r3, r4, r2, r0)
            return r2
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.common.zzc.zza(boolean, java.lang.String, com.google.android.gms.common.zze):java.lang.String");
    }
}
