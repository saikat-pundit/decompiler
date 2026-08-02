package io.sqlc;

import android.util.Log;
import io.liteglue.SQLiteConnection;
import io.liteglue.SQLiteConnector;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
class SQLiteConnectorDatabase extends SQLiteAndroidDatabase {
    static SQLiteConnector connector = new SQLiteConnector();
    SQLiteConnection mydb;

    @Override // io.sqlc.SQLiteAndroidDatabase
    void bugWorkaround() {
    }

    SQLiteConnectorDatabase() {
    }

    @Override // io.sqlc.SQLiteAndroidDatabase
    void open(File file) throws Exception {
        this.mydb = connector.newSQLiteConnection(file.getAbsolutePath(), 6);
    }

    @Override // io.sqlc.SQLiteAndroidDatabase
    void closeDatabaseNow() {
        try {
            SQLiteConnection sQLiteConnection = this.mydb;
            if (sQLiteConnection != null) {
                sQLiteConnection.dispose();
            }
        } catch (Exception e) {
            Log.e("SQLitePlugin", "couldn't close database, ignoring", e);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:32:0x00b7 A[Catch: JSONException -> 0x00d7, TRY_LEAVE, TryCatch #0 {JSONException -> 0x00d7, blocks: (B:31:0x00a6, B:32:0x00b7), top: B:39:0x00a6 }] */
    /* JADX WARN: Removed duplicated region for block: B:39:0x00a6 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    @Override // io.sqlc.SQLiteAndroidDatabase
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    void executeSqlBatch(java.lang.String[] r12, org.json.JSONArray[] r13, org.apache.cordova.CallbackContext r14) {
        /*
            Method dump skipped, instruction units count: 249
            To view this dump change 'Code comments level' option to 'DEBUG'
        */
        throw new UnsupportedOperationException("Method not decompiled: io.sqlc.SQLiteConnectorDatabase.executeSqlBatch(java.lang.String[], org.json.JSONArray[], org.apache.cordova.CallbackContext):void");
    }

    /* JADX WARN: Code restructure failed: missing block: B:44:0x00b6, code lost:
    
        r9 = move-exception;
     */
    /* JADX WARN: Code restructure failed: missing block: B:45:0x00b7, code lost:
    
        r9.printStackTrace();
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    private org.json.JSONObject executeSQLiteStatement(java.lang.String r8, org.json.JSONArray r9, org.apache.cordova.CallbackContext r10) throws java.sql.SQLException, org.json.JSONException {
        /*
            Method dump skipped, instruction units count: 246
            To view this dump change 'Code comments level' option to 'DEBUG'
        */
        throw new UnsupportedOperationException("Method not decompiled: io.sqlc.SQLiteConnectorDatabase.executeSQLiteStatement(java.lang.String, org.json.JSONArray, org.apache.cordova.CallbackContext):org.json.JSONObject");
    }
}
