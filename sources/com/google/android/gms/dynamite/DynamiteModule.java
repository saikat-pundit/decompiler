package com.google.android.gms.dynamite;

import android.content.Context;
import android.database.Cursor;
import android.os.IBinder;
import android.os.IInterface;
import android.os.RemoteException;
import android.util.Log;
import com.google.android.gms.common.GoogleApiAvailabilityLight;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.CrashUtils;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;

/* JADX INFO: loaded from: classes.dex */
public final class DynamiteModule {
    private static Boolean zzid = null;
    private static zzi zzie = null;
    private static zzk zzif = null;
    private static String zzig = null;
    private static int zzih = -1;
    private final Context zzim;
    private static final ThreadLocal<zza> zzii = new ThreadLocal<>();
    private static final VersionPolicy.zza zzij = new com.google.android.gms.dynamite.zza();
    public static final VersionPolicy PREFER_REMOTE = new com.google.android.gms.dynamite.zzb();
    private static final VersionPolicy zzik = new zzc();
    public static final VersionPolicy PREFER_HIGHEST_OR_LOCAL_VERSION = new zzd();
    public static final VersionPolicy PREFER_HIGHEST_OR_LOCAL_VERSION_NO_FORCE_STAGING = new zze();
    public static final VersionPolicy PREFER_HIGHEST_OR_REMOTE_VERSION = new zzf();
    private static final VersionPolicy zzil = new zzg();

    public static class DynamiteLoaderClassLoader {
        public static ClassLoader sClassLoader;
    }

    public interface VersionPolicy {

        public interface zza {
            int getLocalVersion(Context context, String str);

            int zza(Context context, String str, boolean z) throws LoadingException;
        }

        public static class zzb {
            public int zziq = 0;
            public int zzir = 0;
            public int zzis = 0;
        }

        zzb zza(Context context, String str, zza zzaVar) throws LoadingException;
    }

    private static class zza {
        public Cursor zzin;

        private zza() {
        }

        /* synthetic */ zza(com.google.android.gms.dynamite.zza zzaVar) {
            this();
        }
    }

    public static DynamiteModule load(Context context, VersionPolicy versionPolicy, String str) throws LoadingException {
        ThreadLocal<zza> threadLocal = zzii;
        zza zzaVar = threadLocal.get();
        com.google.android.gms.dynamite.zza zzaVar2 = null;
        zza zzaVar3 = new zza(zzaVar2);
        threadLocal.set(zzaVar3);
        try {
            VersionPolicy.zzb zzbVarZza = versionPolicy.zza(context, str, zzij);
            Log.i("DynamiteModule", new StringBuilder(String.valueOf(str).length() + 68 + String.valueOf(str).length()).append("Considering local module ").append(str).append(":").append(zzbVarZza.zziq).append(" and remote module ").append(str).append(":").append(zzbVarZza.zzir).toString());
            if (zzbVarZza.zzis == 0 || ((zzbVarZza.zzis == -1 && zzbVarZza.zziq == 0) || (zzbVarZza.zzis == 1 && zzbVarZza.zzir == 0))) {
                throw new LoadingException(new StringBuilder(91).append("No acceptable module found. Local version is ").append(zzbVarZza.zziq).append(" and remote version is ").append(zzbVarZza.zzir).append(".").toString(), zzaVar2);
            }
            if (zzbVarZza.zzis == -1) {
                DynamiteModule dynamiteModuleZze = zze(context, str);
                if (zzaVar3.zzin != null) {
                    zzaVar3.zzin.close();
                }
                threadLocal.set(zzaVar);
                return dynamiteModuleZze;
            }
            if (zzbVarZza.zzis != 1) {
                throw new LoadingException(new StringBuilder(47).append("VersionPolicy returned invalid code:").append(zzbVarZza.zzis).toString(), zzaVar2);
            }
            try {
                DynamiteModule dynamiteModuleZza = zza(context, str, zzbVarZza.zzir);
                if (zzaVar3.zzin != null) {
                    zzaVar3.zzin.close();
                }
                threadLocal.set(zzaVar);
                return dynamiteModuleZza;
            } catch (LoadingException e) {
                String strValueOf = String.valueOf(e.getMessage());
                Log.w("DynamiteModule", strValueOf.length() != 0 ? "Failed to load remote module: ".concat(strValueOf) : new String("Failed to load remote module: "));
                if (zzbVarZza.zziq == 0 || versionPolicy.zza(context, str, new zzb(zzbVarZza.zziq, 0)).zzis != -1) {
                    throw new LoadingException("Remote load failed. No local fallback found.", e, zzaVar2);
                }
                DynamiteModule dynamiteModuleZze2 = zze(context, str);
                if (zzaVar3.zzin != null) {
                    zzaVar3.zzin.close();
                }
                zzii.set(zzaVar);
                return dynamiteModuleZze2;
            }
        } catch (Throwable th) {
            if (zzaVar3.zzin != null) {
                zzaVar3.zzin.close();
            }
            zzii.set(zzaVar);
            throw th;
        }
    }

    public static class LoadingException extends Exception {
        private LoadingException(String str) {
            super(str);
        }

        private LoadingException(String str, Throwable th) {
            super(str, th);
        }

        /* synthetic */ LoadingException(String str, com.google.android.gms.dynamite.zza zzaVar) {
            this(str);
        }

        /* synthetic */ LoadingException(String str, Throwable th, com.google.android.gms.dynamite.zza zzaVar) {
            this(str, th);
        }
    }

    private static class zzb implements VersionPolicy.zza {
        private final int zzio;
        private final int zzip = 0;

        public zzb(int i, int i2) {
            this.zzio = i;
        }

        @Override // com.google.android.gms.dynamite.DynamiteModule.VersionPolicy.zza
        public final int zza(Context context, String str, boolean z) {
            return 0;
        }

        @Override // com.google.android.gms.dynamite.DynamiteModule.VersionPolicy.zza
        public final int getLocalVersion(Context context, String str) {
            return this.zzio;
        }
    }

    public static int getLocalVersion(Context context, String str) {
        try {
            Class<?> clsLoadClass = context.getApplicationContext().getClassLoader().loadClass(new StringBuilder(String.valueOf(str).length() + 61).append("com.google.android.gms.dynamite.descriptors.").append(str).append(".ModuleDescriptor").toString());
            Field declaredField = clsLoadClass.getDeclaredField("MODULE_ID");
            Field declaredField2 = clsLoadClass.getDeclaredField("MODULE_VERSION");
            if (!declaredField.get(null).equals(str)) {
                String strValueOf = String.valueOf(declaredField.get(null));
                Log.e("DynamiteModule", new StringBuilder(String.valueOf(strValueOf).length() + 51 + String.valueOf(str).length()).append("Module descriptor id '").append(strValueOf).append("' didn't match expected id '").append(str).append("'").toString());
                return 0;
            }
            return declaredField2.getInt(null);
        } catch (ClassNotFoundException unused) {
            Log.w("DynamiteModule", new StringBuilder(String.valueOf(str).length() + 45).append("Local module descriptor class for ").append(str).append(" not found.").toString());
            return 0;
        } catch (Exception e) {
            String strValueOf2 = String.valueOf(e.getMessage());
            Log.e("DynamiteModule", strValueOf2.length() != 0 ? "Failed to load module descriptor class: ".concat(strValueOf2) : new String("Failed to load module descriptor class: "));
            return 0;
        }
    }

    public static int zza(Context context, String str, boolean z) {
        Class<?> clsLoadClass;
        Field declaredField;
        Boolean bool;
        try {
            synchronized (DynamiteModule.class) {
                Boolean bool2 = zzid;
                if (bool2 == null) {
                    try {
                        clsLoadClass = context.getApplicationContext().getClassLoader().loadClass(DynamiteLoaderClassLoader.class.getName());
                        declaredField = clsLoadClass.getDeclaredField("sClassLoader");
                    } catch (ClassNotFoundException | IllegalAccessException | NoSuchFieldException e) {
                        String strValueOf = String.valueOf(e);
                        Log.w("DynamiteModule", new StringBuilder(String.valueOf(strValueOf).length() + 30).append("Failed to load module via V2: ").append(strValueOf).toString());
                        bool2 = Boolean.FALSE;
                    }
                    synchronized (clsLoadClass) {
                        ClassLoader classLoader = (ClassLoader) declaredField.get(null);
                        if (classLoader != null) {
                            if (classLoader == ClassLoader.getSystemClassLoader()) {
                                bool = Boolean.FALSE;
                            } else {
                                try {
                                    zza(classLoader);
                                } catch (LoadingException unused) {
                                }
                                bool = Boolean.TRUE;
                            }
                        } else if ("com.google.android.gms".equals(context.getApplicationContext().getPackageName())) {
                            declaredField.set(null, ClassLoader.getSystemClassLoader());
                            bool = Boolean.FALSE;
                        } else {
                            try {
                                int iZzc = zzc(context, str, z);
                                String str2 = zzig;
                                if (str2 != null && !str2.isEmpty()) {
                                    zzh zzhVar = new zzh(zzig, ClassLoader.getSystemClassLoader());
                                    zza(zzhVar);
                                    declaredField.set(null, zzhVar);
                                    zzid = Boolean.TRUE;
                                    return iZzc;
                                }
                                return iZzc;
                            } catch (LoadingException unused2) {
                                declaredField.set(null, ClassLoader.getSystemClassLoader());
                                bool = Boolean.FALSE;
                            }
                        }
                        bool2 = bool;
                        zzid = bool2;
                    }
                }
                if (bool2.booleanValue()) {
                    try {
                        return zzc(context, str, z);
                    } catch (LoadingException e2) {
                        String strValueOf2 = String.valueOf(e2.getMessage());
                        Log.w("DynamiteModule", strValueOf2.length() != 0 ? "Failed to retrieve remote module version: ".concat(strValueOf2) : new String("Failed to retrieve remote module version: "));
                        return 0;
                    }
                }
                return zzb(context, str, z);
            }
        } catch (Throwable th) {
            CrashUtils.addDynamiteErrorToDropBox(context, th);
            throw th;
        }
    }

    private static int zzb(Context context, String str, boolean z) {
        zzi zziVarZzj = zzj(context);
        if (zziVarZzj == null) {
            return 0;
        }
        try {
            if (zziVarZzj.zzaj() < 2) {
                Log.w("DynamiteModule", "IDynamite loader version < 2, falling back to getModuleVersion2");
                return zziVarZzj.zza(ObjectWrapper.wrap(context), str, z);
            }
            return zziVarZzj.zzb(ObjectWrapper.wrap(context), str, z);
        } catch (RemoteException e) {
            String strValueOf = String.valueOf(e.getMessage());
            Log.w("DynamiteModule", strValueOf.length() != 0 ? "Failed to retrieve remote module version: ".concat(strValueOf) : new String("Failed to retrieve remote module version: "));
            return 0;
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:30:0x0085  */
    /* JADX WARN: Removed duplicated region for block: B:52:0x00be  */
    /* JADX WARN: Removed duplicated region for block: B:60:? A[SYNTHETIC] */
    /* JADX WARN: Type inference failed for: r1v0, types: [com.google.android.gms.dynamite.zza] */
    /* JADX WARN: Type inference failed for: r1v1, types: [android.database.Cursor] */
    /* JADX WARN: Type inference failed for: r1v2 */
    /* JADX WARN: Type inference failed for: r1v3 */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    private static int zzc(android.content.Context r9, java.lang.String r10, boolean r11) throws java.lang.Throwable {
        /*
            r1 = 0
            android.content.ContentResolver r2 = r9.getContentResolver()     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            if (r11 == 0) goto La
            java.lang.String r9 = "api_force_staging"
            goto Lc
        La:
            java.lang.String r9 = "api"
        Lc:
            java.lang.String r11 = java.lang.String.valueOf(r9)     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            int r11 = r11.length()     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            int r11 = r11 + 42
            java.lang.String r0 = java.lang.String.valueOf(r10)     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            int r0 = r0.length()     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            int r11 = r11 + r0
            java.lang.StringBuilder r0 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            r0.<init>(r11)     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            java.lang.String r11 = "content://com.google.android.gms.chimera/"
            java.lang.StringBuilder r11 = r0.append(r11)     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            java.lang.StringBuilder r9 = r11.append(r9)     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            java.lang.String r11 = "/"
            java.lang.StringBuilder r9 = r9.append(r11)     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            java.lang.StringBuilder r9 = r9.append(r10)     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            java.lang.String r9 = r9.toString()     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            android.net.Uri r3 = android.net.Uri.parse(r9)     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            r6 = 0
            r7 = 0
            r4 = 0
            r5 = 0
            android.database.Cursor r9 = r2.query(r3, r4, r5, r6, r7)     // Catch: java.lang.Throwable -> La6 java.lang.Exception -> La9
            if (r9 == 0) goto L8c
            boolean r10 = r9.moveToFirst()     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            if (r10 == 0) goto L8c
            r10 = 0
            int r10 = r9.getInt(r10)     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            if (r10 <= 0) goto L85
            java.lang.Class<com.google.android.gms.dynamite.DynamiteModule> r11 = com.google.android.gms.dynamite.DynamiteModule.class
            monitor-enter(r11)     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            r0 = 2
            java.lang.String r0 = r9.getString(r0)     // Catch: java.lang.Throwable -> L81
            com.google.android.gms.dynamite.DynamiteModule.zzig = r0     // Catch: java.lang.Throwable -> L81
            java.lang.String r0 = "loaderVersion"
            int r0 = r9.getColumnIndex(r0)     // Catch: java.lang.Throwable -> L81
            if (r0 < 0) goto L6f
            int r0 = r9.getInt(r0)     // Catch: java.lang.Throwable -> L81
            com.google.android.gms.dynamite.DynamiteModule.zzih = r0     // Catch: java.lang.Throwable -> L81
        L6f:
            monitor-exit(r11)     // Catch: java.lang.Throwable -> L81
            java.lang.ThreadLocal<com.google.android.gms.dynamite.DynamiteModule$zza> r11 = com.google.android.gms.dynamite.DynamiteModule.zzii     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            java.lang.Object r11 = r11.get()     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            com.google.android.gms.dynamite.DynamiteModule$zza r11 = (com.google.android.gms.dynamite.DynamiteModule.zza) r11     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            if (r11 == 0) goto L85
            android.database.Cursor r0 = r11.zzin     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            if (r0 != 0) goto L85
            r11.zzin = r9     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            goto L86
        L81:
            r0 = move-exception
            r10 = r0
            monitor-exit(r11)     // Catch: java.lang.Throwable -> L81
            throw r10     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
        L85:
            r1 = r9
        L86:
            if (r1 == 0) goto L8b
            r1.close()
        L8b:
            return r10
        L8c:
            java.lang.String r10 = "DynamiteModule"
            java.lang.String r11 = "Failed to retrieve remote module version."
            android.util.Log.w(r10, r11)     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            com.google.android.gms.dynamite.DynamiteModule$LoadingException r10 = new com.google.android.gms.dynamite.DynamiteModule$LoadingException     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            java.lang.String r11 = "Failed to connect to dynamite module ContentResolver."
            r10.<init>(r11, r1)     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
            throw r10     // Catch: java.lang.Throwable -> L9b java.lang.Exception -> La0
        L9b:
            r0 = move-exception
            r10 = r0
            r1 = r9
            r9 = r10
            goto Lbc
        La0:
            r0 = move-exception
            r10 = r0
            r8 = r10
            r10 = r9
            r9 = r8
            goto Lac
        La6:
            r0 = move-exception
            r9 = r0
            goto Lbc
        La9:
            r0 = move-exception
            r9 = r0
            r10 = r1
        Lac:
            boolean r11 = r9 instanceof com.google.android.gms.dynamite.DynamiteModule.LoadingException     // Catch: java.lang.Throwable -> Lb9
            if (r11 == 0) goto Lb1
            throw r9     // Catch: java.lang.Throwable -> Lb9
        Lb1:
            com.google.android.gms.dynamite.DynamiteModule$LoadingException r11 = new com.google.android.gms.dynamite.DynamiteModule$LoadingException     // Catch: java.lang.Throwable -> Lb9
            java.lang.String r0 = "V2 version check failed"
            r11.<init>(r0, r9, r1)     // Catch: java.lang.Throwable -> Lb9
            throw r11     // Catch: java.lang.Throwable -> Lb9
        Lb9:
            r0 = move-exception
            r9 = r0
            r1 = r10
        Lbc:
            if (r1 == 0) goto Lc1
            r1.close()
        Lc1:
            throw r9
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.dynamite.DynamiteModule.zzc(android.content.Context, java.lang.String, boolean):int");
    }

    public static int getRemoteVersion(Context context, String str) {
        return zza(context, str, false);
    }

    private static DynamiteModule zze(Context context, String str) {
        String strValueOf = String.valueOf(str);
        Log.i("DynamiteModule", strValueOf.length() != 0 ? "Selected local version of ".concat(strValueOf) : new String("Selected local version of "));
        return new DynamiteModule(context.getApplicationContext());
    }

    private static DynamiteModule zza(Context context, String str, int i) throws LoadingException {
        Boolean bool;
        try {
            synchronized (DynamiteModule.class) {
                bool = zzid;
            }
            if (bool == null) {
                throw new LoadingException("Failed to determine which loading route to use.", (com.google.android.gms.dynamite.zza) null);
            }
            if (bool.booleanValue()) {
                return zzc(context, str, i);
            }
            return zzb(context, str, i);
        } catch (Throwable th) {
            CrashUtils.addDynamiteErrorToDropBox(context, th);
            throw th;
        }
    }

    private static DynamiteModule zzb(Context context, String str, int i) throws LoadingException {
        IObjectWrapper iObjectWrapperZza;
        String str2 = "Failed to load remote module.";
        Log.i("DynamiteModule", new StringBuilder(String.valueOf(str).length() + 51).append("Selected remote version of ").append(str).append(", version >= ").append(i).toString());
        zzi zziVarZzj = zzj(context);
        com.google.android.gms.dynamite.zza zzaVar = null;
        if (zziVarZzj == null) {
            throw new LoadingException("Failed to create IDynamiteLoader.", zzaVar);
        }
        try {
            if (zziVarZzj.zzaj() >= 2) {
                iObjectWrapperZza = zziVarZzj.zzb(ObjectWrapper.wrap(context), str, i);
            } else {
                Log.w("DynamiteModule", "Dynamite loader version < 2, falling back to createModuleContext");
                iObjectWrapperZza = zziVarZzj.zza(ObjectWrapper.wrap(context), str, i);
            }
            if (ObjectWrapper.unwrap(iObjectWrapperZza) == null) {
                throw new LoadingException(str2, zzaVar);
            }
            return new DynamiteModule((Context) ObjectWrapper.unwrap(iObjectWrapperZza));
        } catch (RemoteException e) {
            throw new LoadingException(str2, e, zzaVar);
        }
    }

    private static zzi zzj(Context context) {
        zzi zzjVar;
        synchronized (DynamiteModule.class) {
            zzi zziVar = zzie;
            if (zziVar != null) {
                return zziVar;
            }
            if (GoogleApiAvailabilityLight.getInstance().isGooglePlayServicesAvailable(context) != 0) {
                return null;
            }
            try {
                IBinder iBinder = (IBinder) context.createPackageContext("com.google.android.gms", 3).getClassLoader().loadClass("com.google.android.gms.chimera.container.DynamiteLoaderImpl").newInstance();
                if (iBinder == null) {
                    zzjVar = null;
                } else {
                    IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.dynamite.IDynamiteLoader");
                    if (iInterfaceQueryLocalInterface instanceof zzi) {
                        zzjVar = (zzi) iInterfaceQueryLocalInterface;
                    } else {
                        zzjVar = new zzj(iBinder);
                    }
                }
                if (zzjVar != null) {
                    zzie = zzjVar;
                    return zzjVar;
                }
            } catch (Exception e) {
                String strValueOf = String.valueOf(e.getMessage());
                Log.e("DynamiteModule", strValueOf.length() != 0 ? "Failed to load IDynamiteLoader from GmsCore: ".concat(strValueOf) : new String("Failed to load IDynamiteLoader from GmsCore: "));
            }
            return null;
        }
    }

    public final Context getModuleContext() {
        return this.zzim;
    }

    private static DynamiteModule zzc(Context context, String str, int i) throws LoadingException {
        zzk zzkVar;
        Log.i("DynamiteModule", new StringBuilder(String.valueOf(str).length() + 51).append("Selected remote version of ").append(str).append(", version >= ").append(i).toString());
        synchronized (DynamiteModule.class) {
            zzkVar = zzif;
        }
        com.google.android.gms.dynamite.zza zzaVar = null;
        if (zzkVar == null) {
            throw new LoadingException("DynamiteLoaderV2 was not cached.", zzaVar);
        }
        zza zzaVar2 = zzii.get();
        if (zzaVar2 == null || zzaVar2.zzin == null) {
            throw new LoadingException("No result cursor", zzaVar);
        }
        Context contextZza = zza(context.getApplicationContext(), str, i, zzaVar2.zzin, zzkVar);
        if (contextZza == null) {
            throw new LoadingException("Failed to get module context", zzaVar);
        }
        return new DynamiteModule(contextZza);
    }

    private static Boolean zzai() {
        Boolean boolValueOf;
        synchronized (DynamiteModule.class) {
            boolValueOf = Boolean.valueOf(zzih >= 2);
        }
        return boolValueOf;
    }

    private static Context zza(Context context, String str, int i, Cursor cursor, zzk zzkVar) {
        IObjectWrapper iObjectWrapperZza;
        try {
            ObjectWrapper.wrap(null);
            if (zzai().booleanValue()) {
                Log.v("DynamiteModule", "Dynamite loader version >= 2, using loadModule2NoCrashUtils");
                iObjectWrapperZza = zzkVar.zzb(ObjectWrapper.wrap(context), str, i, ObjectWrapper.wrap(cursor));
            } else {
                Log.w("DynamiteModule", "Dynamite loader version < 2, falling back to loadModule2");
                iObjectWrapperZza = zzkVar.zza(ObjectWrapper.wrap(context), str, i, ObjectWrapper.wrap(cursor));
            }
            return (Context) ObjectWrapper.unwrap(iObjectWrapperZza);
        } catch (Exception e) {
            String strValueOf = String.valueOf(e.toString());
            Log.e("DynamiteModule", strValueOf.length() != 0 ? "Failed to load DynamiteLoader: ".concat(strValueOf) : new String("Failed to load DynamiteLoader: "));
            return null;
        }
    }

    private static void zza(ClassLoader classLoader) throws LoadingException {
        zzk zzlVar;
        com.google.android.gms.dynamite.zza zzaVar = null;
        try {
            IBinder iBinder = (IBinder) classLoader.loadClass("com.google.android.gms.dynamiteloader.DynamiteLoaderV2").getConstructor(new Class[0]).newInstance(new Object[0]);
            if (iBinder == null) {
                zzlVar = null;
            } else {
                IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.dynamite.IDynamiteLoaderV2");
                if (iInterfaceQueryLocalInterface instanceof zzk) {
                    zzlVar = (zzk) iInterfaceQueryLocalInterface;
                } else {
                    zzlVar = new zzl(iBinder);
                }
            }
            zzif = zzlVar;
        } catch (ClassNotFoundException | IllegalAccessException | InstantiationException | NoSuchMethodException | InvocationTargetException e) {
            throw new LoadingException("Failed to instantiate dynamite loader", e, zzaVar);
        }
    }

    public final IBinder instantiate(String str) throws LoadingException {
        try {
            return (IBinder) this.zzim.getClassLoader().loadClass(str).newInstance();
        } catch (ClassNotFoundException | IllegalAccessException | InstantiationException e) {
            String strValueOf = String.valueOf(str);
            throw new LoadingException(strValueOf.length() != 0 ? "Failed to instantiate module class: ".concat(strValueOf) : new String("Failed to instantiate module class: "), e, null);
        }
    }

    private DynamiteModule(Context context) {
        this.zzim = (Context) Preconditions.checkNotNull(context);
    }
}
