package io.liteglue;

/* JADX INFO: loaded from: classes.dex */
interface SQLDatabaseHandle {
    int close();

    String getLastErrorMessage();

    long getLastInsertRowid();

    int getTotalChanges();

    boolean isOpen();

    SQLStatementHandle newStatementHandle(String str);

    int open();
}
