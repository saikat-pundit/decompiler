package io.sqlc;

import android.util.Log;
import java.io.File;
import java.util.Map;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.LinkedBlockingQueue;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class SQLitePlugin extends CordovaPlugin {
    private Map<String, DBRunner> dbrmap = new ConcurrentHashMap();

    private enum Action {
        echoStringValue,
        open,
        close,
        delete,
        executeSqlBatch,
        backgroundExecuteSqlBatch
    }

    @Override // org.apache.cordova.CordovaPlugin
    public boolean execute(String str, JSONArray jSONArray, CallbackContext callbackContext) {
        try {
            try {
                return executeAndPossiblyThrow(Action.valueOf(str), jSONArray, callbackContext);
            } catch (JSONException e) {
                Log.e("SQLitePlugin", "unexpected error", e);
                return false;
            }
        } catch (IllegalArgumentException e2) {
            Log.e("SQLitePlugin", "unexpected error", e2);
            return false;
        }
    }

    /* JADX INFO: renamed from: io.sqlc.SQLitePlugin$1, reason: invalid class name */
    static /* synthetic */ class AnonymousClass1 {
        static final /* synthetic */ int[] $SwitchMap$io$sqlc$SQLitePlugin$Action;

        static {
            int[] iArr = new int[Action.values().length];
            $SwitchMap$io$sqlc$SQLitePlugin$Action = iArr;
            try {
                iArr[Action.echoStringValue.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                $SwitchMap$io$sqlc$SQLitePlugin$Action[Action.open.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                $SwitchMap$io$sqlc$SQLitePlugin$Action[Action.close.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
            try {
                $SwitchMap$io$sqlc$SQLitePlugin$Action[Action.delete.ordinal()] = 4;
            } catch (NoSuchFieldError unused4) {
            }
            try {
                $SwitchMap$io$sqlc$SQLitePlugin$Action[Action.executeSqlBatch.ordinal()] = 5;
            } catch (NoSuchFieldError unused5) {
            }
            try {
                $SwitchMap$io$sqlc$SQLitePlugin$Action[Action.backgroundExecuteSqlBatch.ordinal()] = 6;
            } catch (NoSuchFieldError unused6) {
            }
        }
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    private boolean executeAndPossiblyThrow(Action action, JSONArray jSONArray, CallbackContext callbackContext) throws JSONException {
        switch (AnonymousClass1.$SwitchMap$io$sqlc$SQLitePlugin$Action[action.ordinal()]) {
            case 1:
                callbackContext.success(jSONArray.getJSONObject(0).getString("value"));
                return true;
            case 2:
                JSONObject jSONObject = jSONArray.getJSONObject(0);
                startDatabase(jSONObject.getString("name"), jSONObject, callbackContext);
                return true;
            case 3:
                closeDatabase(jSONArray.getJSONObject(0).getString("path"), callbackContext);
                return true;
            case 4:
                deleteDatabase(jSONArray.getJSONObject(0).getString("path"), callbackContext);
                return true;
            case 5:
            case 6:
                JSONObject jSONObject2 = jSONArray.getJSONObject(0);
                String string = jSONObject2.getJSONObject("dbargs").getString("dbname");
                JSONArray jSONArray2 = jSONObject2.getJSONArray("executes");
                if (jSONArray2.isNull(0)) {
                    callbackContext.error("INTERNAL PLUGIN ERROR: missing executes list");
                    return true;
                }
                int length = jSONArray2.length();
                String[] strArr = new String[length];
                JSONArray[] jSONArrayArr = new JSONArray[length];
                for (int i = 0; i < length; i++) {
                    JSONObject jSONObject3 = jSONArray2.getJSONObject(i);
                    strArr[i] = jSONObject3.getString("sql");
                    jSONArrayArr[i] = jSONObject3.getJSONArray("params");
                }
                DBQuery dBQuery = new DBQuery(strArr, jSONArrayArr, callbackContext);
                DBRunner dBRunner = this.dbrmap.get(string);
                if (dBRunner != null) {
                    try {
                        dBRunner.q.put(dBQuery);
                        return true;
                    } catch (Exception e) {
                        Log.e("SQLitePlugin", "couldn't add to queue", e);
                        callbackContext.error("INTERNAL PLUGIN ERROR: couldn't add to queue");
                    }
                } else {
                    callbackContext.error("INTERNAL PLUGIN ERROR: database not open");
                    return true;
                }
                break;
                break;
            default:
                return true;
        }
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onDestroy() {
        while (!this.dbrmap.isEmpty()) {
            String next = this.dbrmap.keySet().iterator().next();
            closeDatabaseNow(next);
            try {
                this.dbrmap.get(next).q.put(new DBQuery());
            } catch (Exception e) {
                Log.e("SQLitePlugin", "INTERNAL PLUGIN CLEANUP ERROR: could not stop db thread due to exception", e);
            }
            this.dbrmap.remove(next);
        }
    }

    private void startDatabase(String str, JSONObject jSONObject, CallbackContext callbackContext) {
        if (this.dbrmap.get(str) != null) {
            callbackContext.error("INTERNAL ERROR: database already open for db name: " + str);
            return;
        }
        DBRunner dBRunner = new DBRunner(str, jSONObject, callbackContext);
        this.dbrmap.put(str, dBRunner);
        this.f4cordova.getThreadPool().execute(dBRunner);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public SQLiteAndroidDatabase openDatabase(String str, CallbackContext callbackContext, boolean z) throws Exception {
        try {
            File databasePath = this.f4cordova.getActivity().getDatabasePath(str);
            if (!databasePath.exists()) {
                databasePath.getParentFile().mkdirs();
            }
            Log.v("info", "Open sqlite db: " + databasePath.getAbsolutePath());
            SQLiteAndroidDatabase sQLiteAndroidDatabase = z ? new SQLiteAndroidDatabase() : new SQLiteConnectorDatabase();
            sQLiteAndroidDatabase.open(databasePath);
            if (callbackContext != null) {
                callbackContext.success();
            }
            return sQLiteAndroidDatabase;
        } catch (Exception e) {
            if (callbackContext != null) {
                callbackContext.error("can't open database " + e);
            }
            throw e;
        }
    }

    private void closeDatabase(String str, CallbackContext callbackContext) {
        DBRunner dBRunner = this.dbrmap.get(str);
        if (dBRunner == null) {
            if (callbackContext != null) {
                callbackContext.success();
            }
        } else {
            try {
                dBRunner.q.put(new DBQuery(false, callbackContext));
            } catch (Exception e) {
                if (callbackContext != null) {
                    callbackContext.error("couldn't close database" + e);
                }
                Log.e("SQLitePlugin", "couldn't close database", e);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void closeDatabaseNow(String str) {
        SQLiteAndroidDatabase sQLiteAndroidDatabase;
        DBRunner dBRunner = this.dbrmap.get(str);
        if (dBRunner == null || (sQLiteAndroidDatabase = dBRunner.mydb) == null) {
            return;
        }
        sQLiteAndroidDatabase.closeDatabaseNow();
    }

    private void deleteDatabase(String str, CallbackContext callbackContext) {
        DBRunner dBRunner = this.dbrmap.get(str);
        if (dBRunner != null) {
            try {
                dBRunner.q.put(new DBQuery(true, callbackContext));
                return;
            } catch (Exception e) {
                if (callbackContext != null) {
                    callbackContext.error("couldn't close database" + e);
                }
                Log.e("SQLitePlugin", "couldn't close database", e);
                return;
            }
        }
        if (deleteDatabaseNow(str)) {
            callbackContext.success();
        } else {
            callbackContext.error("couldn't delete database");
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean deleteDatabaseNow(String str) {
        try {
            return this.f4cordova.getActivity().deleteDatabase(this.f4cordova.getActivity().getDatabasePath(str).getAbsolutePath());
        } catch (Exception e) {
            Log.e("SQLitePlugin", "couldn't delete database", e);
            return false;
        }
    }

    private class DBRunner implements Runnable {
        private boolean bugWorkaround;
        final String dbname;
        SQLiteAndroidDatabase mydb;
        private boolean oldImpl;
        final CallbackContext openCbc;
        final BlockingQueue<DBQuery> q;

        DBRunner(String str, JSONObject jSONObject, CallbackContext callbackContext) {
            this.dbname = str;
            this.oldImpl = jSONObject.has("androidOldDatabaseImplementation");
            Log.v("SQLitePlugin", "Android db implementation: built-in android.database.sqlite package");
            boolean z = this.oldImpl && jSONObject.has("androidBugWorkaround");
            this.bugWorkaround = z;
            if (z) {
                Log.v("SQLitePlugin", "Android db closing/locking workaround applied");
            }
            this.q = new LinkedBlockingQueue();
            this.openCbc = callbackContext;
        }

        @Override // java.lang.Runnable
        public void run() {
            try {
                this.mydb = SQLitePlugin.this.openDatabase(this.dbname, this.openCbc, this.oldImpl);
                DBQuery dBQuery = null;
                try {
                    DBQuery dBQueryTake = this.q.take();
                    while (true) {
                        dBQuery = dBQueryTake;
                        if (dBQuery.stop) {
                            break;
                        }
                        this.mydb.executeSqlBatch(dBQuery.queries, dBQuery.jsonparams, dBQuery.cbc);
                        if (this.bugWorkaround && dBQuery.queries.length == 1 && dBQuery.queries[0] == "COMMIT") {
                            this.mydb.bugWorkaround();
                        }
                        dBQueryTake = this.q.take();
                    }
                } catch (Exception e) {
                    Log.e("SQLitePlugin", "unexpected error", e);
                }
                if (dBQuery == null || !dBQuery.close) {
                    return;
                }
                try {
                    SQLitePlugin.this.closeDatabaseNow(this.dbname);
                    SQLitePlugin.this.dbrmap.remove(this.dbname);
                    if (!dBQuery.delete) {
                        dBQuery.cbc.success();
                    } else {
                        try {
                            if (!SQLitePlugin.this.deleteDatabaseNow(this.dbname)) {
                                dBQuery.cbc.error("couldn't delete database");
                            } else {
                                dBQuery.cbc.success();
                            }
                        } catch (Exception e2) {
                            Log.e("SQLitePlugin", "couldn't delete database", e2);
                            dBQuery.cbc.error("couldn't delete database: " + e2);
                        }
                    }
                } catch (Exception e3) {
                    Log.e("SQLitePlugin", "couldn't close database", e3);
                    if (dBQuery.cbc != null) {
                        dBQuery.cbc.error("couldn't close database: " + e3);
                    }
                }
            } catch (Exception e4) {
                Log.e("SQLitePlugin", "unexpected error, stopping db thread", e4);
                SQLitePlugin.this.dbrmap.remove(this.dbname);
            }
        }
    }

    private final class DBQuery {
        final CallbackContext cbc;
        final boolean close;
        final boolean delete;
        final JSONArray[] jsonparams;
        final String[] queries;
        final boolean stop;

        DBQuery(String[] strArr, JSONArray[] jSONArrayArr, CallbackContext callbackContext) {
            this.stop = false;
            this.close = false;
            this.delete = false;
            this.queries = strArr;
            this.jsonparams = jSONArrayArr;
            this.cbc = callbackContext;
        }

        DBQuery(boolean z, CallbackContext callbackContext) {
            this.stop = true;
            this.close = true;
            this.delete = z;
            this.queries = null;
            this.jsonparams = null;
            this.cbc = callbackContext;
        }

        DBQuery() {
            this.stop = true;
            this.close = false;
            this.delete = false;
            this.queries = null;
            this.jsonparams = null;
            this.cbc = null;
        }
    }
}
