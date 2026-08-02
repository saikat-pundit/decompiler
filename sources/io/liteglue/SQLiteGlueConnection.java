package io.liteglue;

import java.sql.SQLException;

/* JADX INFO: loaded from: classes.dex */
class SQLiteGlueConnection implements SQLiteConnection {
    private SQLDatabaseHandle db;

    public SQLiteGlueConnection(String str, int i) throws SQLException {
        this.db = null;
        if (str == null) {
            throw new SQLException("null argument", "failed", 21);
        }
        SQLGDatabaseHandle sQLGDatabaseHandle = new SQLGDatabaseHandle(str, i);
        int iOpen = sQLGDatabaseHandle.open();
        if (iOpen != 0) {
            throw new SQLException("sqlite3_open_v2 failure: " + sQLGDatabaseHandle.getLastErrorMessage(), "failure", iOpen);
        }
        this.db = sQLGDatabaseHandle;
    }

    @Override // io.liteglue.SQLiteConnection
    public void dispose() throws SQLException {
        SQLDatabaseHandle sQLDatabaseHandle = this.db;
        if (sQLDatabaseHandle == null) {
            throw new SQLException("already disposed", "failed", 21);
        }
        int iClose = sQLDatabaseHandle.close();
        if (iClose != 0) {
            throw new SQLException("sqlite3_close failure: " + this.db.getLastErrorMessage(), "failure", iClose);
        }
        this.db = null;
    }

    @Override // io.liteglue.SQLiteConnection
    public SQLiteStatement prepareStatement(String str) throws SQLException {
        if (this.db == null) {
            throw new SQLException("already disposed", "failed", 21);
        }
        if (str == null) {
            throw new SQLException("null argument", "failed", 21);
        }
        SQLGStatement sQLGStatement = new SQLGStatement(str);
        int iPrepare = sQLGStatement.prepare();
        if (iPrepare == 0) {
            return sQLGStatement;
        }
        throw new SQLException("sqlite3_prepare_v2 failure: " + this.db.getLastErrorMessage(), "failure", iPrepare);
    }

    @Override // io.liteglue.SQLiteConnection
    public long getLastInsertRowid() throws SQLException {
        SQLDatabaseHandle sQLDatabaseHandle = this.db;
        if (sQLDatabaseHandle == null) {
            throw new SQLException("already disposed", "failed", 21);
        }
        return sQLDatabaseHandle.getLastInsertRowid();
    }

    @Override // io.liteglue.SQLiteConnection
    public int getTotalChanges() throws SQLException {
        SQLDatabaseHandle sQLDatabaseHandle = this.db;
        if (sQLDatabaseHandle == null) {
            throw new SQLException("already disposed", "failed", 21);
        }
        return sQLDatabaseHandle.getTotalChanges();
    }

    private class SQLGStatement implements SQLiteStatement {
        private String sql;
        private SQLStatementHandle sthandle;
        private boolean hasRow = false;
        private int columnCount = 0;

        SQLGStatement(String str) {
            this.sthandle = null;
            this.sql = str;
            this.sthandle = SQLiteGlueConnection.this.db.newStatementHandle(str);
        }

        int prepare() {
            return this.sthandle.prepare();
        }

        @Override // io.liteglue.SQLiteStatement
        public void bindDouble(int i, double d) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            int iBindDouble = sQLStatementHandle.bindDouble(i, d);
            if (iBindDouble != 0) {
                throw new SQLException("sqlite3_bind_double failure: " + SQLiteGlueConnection.this.db.getLastErrorMessage(), "failure", iBindDouble);
            }
        }

        @Override // io.liteglue.SQLiteStatement
        public void bindInteger(int i, int i2) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            int iBindInteger = sQLStatementHandle.bindInteger(i, i2);
            if (iBindInteger != 0) {
                throw new SQLException("sqlite3_bind_int failure: " + SQLiteGlueConnection.this.db.getLastErrorMessage(), "failure", iBindInteger);
            }
        }

        @Override // io.liteglue.SQLiteStatement
        public void bindLong(int i, long j) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            int iBindLong = sQLStatementHandle.bindLong(i, j);
            if (iBindLong != 0) {
                throw new SQLException("sqlite3_bind_int64 (long) failure: " + SQLiteGlueConnection.this.db.getLastErrorMessage(), "failure", iBindLong);
            }
        }

        @Override // io.liteglue.SQLiteStatement
        public void bindNull(int i) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            int iBindNull = sQLStatementHandle.bindNull(i);
            if (iBindNull != 0) {
                throw new SQLException("sqlite3_bind_null failure: " + SQLiteGlueConnection.this.db.getLastErrorMessage(), "failure", iBindNull);
            }
        }

        @Override // io.liteglue.SQLiteStatement
        public void bindTextNativeString(int i, String str) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            if (str == null) {
                throw new SQLException("null argument", "failed", 21);
            }
            int iBindTextNativeString = sQLStatementHandle.bindTextNativeString(i, str);
            if (iBindTextNativeString != 0) {
                throw new SQLException("sqlite3_bind_text failure: " + SQLiteGlueConnection.this.db.getLastErrorMessage(), "failure", iBindTextNativeString);
            }
        }

        @Override // io.liteglue.SQLiteStatement
        public boolean step() throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            int iStep = sQLStatementHandle.step();
            if (iStep != 0 && iStep != 100 && iStep != 101) {
                throw new SQLException("sqlite3_step failure: " + SQLiteGlueConnection.this.db.getLastErrorMessage(), "failure", iStep);
            }
            boolean z = iStep == 100;
            this.hasRow = z;
            if (z) {
                this.columnCount = this.sthandle.getColumnCount();
            } else {
                this.columnCount = 0;
            }
            return this.hasRow;
        }

        @Override // io.liteglue.SQLiteStatement
        public int getColumnCount() throws SQLException {
            if (this.sthandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            if (!this.hasRow) {
                throw new SQLException("no result available", "failed", 21);
            }
            return this.columnCount;
        }

        @Override // io.liteglue.SQLiteStatement
        public String getColumnName(int i) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            if (!this.hasRow) {
                throw new SQLException("no result available", "failed", 21);
            }
            if (i < 0 || i >= this.columnCount) {
                throw new SQLException("no result available", "failed", 21);
            }
            return sQLStatementHandle.getColumnName(i);
        }

        @Override // io.liteglue.SQLiteStatement
        public int getColumnType(int i) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            if (!this.hasRow) {
                throw new SQLException("no result available", "failed", 21);
            }
            if (i < 0 || i >= this.columnCount) {
                throw new SQLException("no result available", "failed", 21);
            }
            return sQLStatementHandle.getColumnType(i);
        }

        @Override // io.liteglue.SQLiteStatement
        public double getColumnDouble(int i) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            if (!this.hasRow) {
                throw new SQLException("no result available", "failed", 21);
            }
            if (i < 0 || i >= this.columnCount) {
                throw new SQLException("no result available", "failed", 21);
            }
            return sQLStatementHandle.getColumnDouble(i);
        }

        @Override // io.liteglue.SQLiteStatement
        public int getColumnInteger(int i) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            if (!this.hasRow) {
                throw new SQLException("no result available", "failed", 21);
            }
            if (i < 0 || i >= this.columnCount) {
                throw new SQLException("no result available", "failed", 21);
            }
            return sQLStatementHandle.getColumnInteger(i);
        }

        @Override // io.liteglue.SQLiteStatement
        public long getColumnLong(int i) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            if (!this.hasRow) {
                throw new SQLException("no result available", "failed", 21);
            }
            if (i < 0 || i >= this.columnCount) {
                throw new SQLException("no result available", "failed", 21);
            }
            return sQLStatementHandle.getColumnLong(i);
        }

        @Override // io.liteglue.SQLiteStatement
        public String getColumnTextNativeString(int i) throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            if (!this.hasRow) {
                throw new SQLException("no result available", "failed", 21);
            }
            if (i < 0 || i >= this.columnCount) {
                throw new SQLException("no result available", "failed", 21);
            }
            return sQLStatementHandle.getColumnTextNativeString(i);
        }

        @Override // io.liteglue.SQLiteStatement
        public void dispose() throws SQLException {
            SQLStatementHandle sQLStatementHandle = this.sthandle;
            if (sQLStatementHandle == null) {
                throw new SQLException("already disposed", "failed", 21);
            }
            sQLStatementHandle.finish();
            this.sthandle = null;
        }
    }
}
