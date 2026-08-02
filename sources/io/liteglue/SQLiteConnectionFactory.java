package io.liteglue;

import java.sql.SQLException;

/* JADX INFO: loaded from: classes.dex */
public interface SQLiteConnectionFactory {
    SQLiteConnection newSQLiteConnection(String str, int i) throws SQLException;
}
