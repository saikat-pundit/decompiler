package io.liteglue;

import java.sql.SQLException;

/* JADX INFO: loaded from: classes.dex */
public interface SQLiteConnection {
    void dispose() throws SQLException;

    long getLastInsertRowid() throws SQLException;

    int getTotalChanges() throws SQLException;

    SQLiteStatement prepareStatement(String str) throws SQLException;
}
