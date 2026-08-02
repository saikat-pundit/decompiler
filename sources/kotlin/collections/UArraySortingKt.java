package kotlin.collections;

import kotlin.Metadata;
import kotlin.UByte;
import kotlin.UByteArray;
import kotlin.UIntArray;
import kotlin.ULongArray;
import kotlin.UShort;
import kotlin.UShortArray;
import kotlin.jvm.internal.Intrinsics;

/* JADX INFO: compiled from: UArraySorting.kt */
/* JADX INFO: loaded from: classes.dex */
@Metadata(d1 = {"\u00000\n\u0000\n\u0002\u0010\b\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0005\n\u0002\u0010\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0004\n\u0002\u0018\u0002\n\u0002\b\u0004\n\u0002\u0018\u0002\n\u0002\b\f\u001a'\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0001H\u0003¢\u0006\u0004\b\u0006\u0010\u0007\u001a'\u0010\b\u001a\u00020\t2\u0006\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0001H\u0003¢\u0006\u0004\b\n\u0010\u000b\u001a'\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\f2\u0006\u0010\u0004\u001a\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0001H\u0003¢\u0006\u0004\b\r\u0010\u000e\u001a'\u0010\b\u001a\u00020\t2\u0006\u0010\u0002\u001a\u00020\f2\u0006\u0010\u0004\u001a\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0001H\u0003¢\u0006\u0004\b\u000f\u0010\u0010\u001a'\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u00112\u0006\u0010\u0004\u001a\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0001H\u0003¢\u0006\u0004\b\u0012\u0010\u0013\u001a'\u0010\b\u001a\u00020\t2\u0006\u0010\u0002\u001a\u00020\u00112\u0006\u0010\u0004\u001a\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0001H\u0003¢\u0006\u0004\b\u0014\u0010\u0015\u001a'\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u00162\u0006\u0010\u0004\u001a\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0001H\u0003¢\u0006\u0004\b\u0017\u0010\u0018\u001a'\u0010\b\u001a\u00020\t2\u0006\u0010\u0002\u001a\u00020\u00162\u0006\u0010\u0004\u001a\u00020\u00012\u0006\u0010\u0005\u001a\u00020\u0001H\u0003¢\u0006\u0004\b\u0019\u0010\u001a\u001a'\u0010\u001b\u001a\u00020\t2\u0006\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u001c\u001a\u00020\u00012\u0006\u0010\u001d\u001a\u00020\u0001H\u0001¢\u0006\u0004\b\u001e\u0010\u000b\u001a'\u0010\u001b\u001a\u00020\t2\u0006\u0010\u0002\u001a\u00020\f2\u0006\u0010\u001c\u001a\u00020\u00012\u0006\u0010\u001d\u001a\u00020\u0001H\u0001¢\u0006\u0004\b\u001f\u0010\u0010\u001a'\u0010\u001b\u001a\u00020\t2\u0006\u0010\u0002\u001a\u00020\u00112\u0006\u0010\u001c\u001a\u00020\u00012\u0006\u0010\u001d\u001a\u00020\u0001H\u0001¢\u0006\u0004\b \u0010\u0015\u001a'\u0010\u001b\u001a\u00020\t2\u0006\u0010\u0002\u001a\u00020\u00162\u0006\u0010\u001c\u001a\u00020\u00012\u0006\u0010\u001d\u001a\u00020\u0001H\u0001¢\u0006\u0004\b!\u0010\u001a¨\u0006\""}, d2 = {"partition", "", "array", "Lkotlin/UByteArray;", "left", "right", "partition-4UcCI2c", "([BII)I", "quickSort", "", "quickSort-4UcCI2c", "([BII)V", "Lkotlin/UShortArray;", "partition-Aa5vz7o", "([SII)I", "quickSort-Aa5vz7o", "([SII)V", "Lkotlin/UIntArray;", "partition-oBK06Vg", "([III)I", "quickSort-oBK06Vg", "([III)V", "Lkotlin/ULongArray;", "partition--nroSd4", "([JII)I", "quickSort--nroSd4", "([JII)V", "sortArray", "fromIndex", "toIndex", "sortArray-4UcCI2c", "sortArray-Aa5vz7o", "sortArray-oBK06Vg", "sortArray--nroSd4", "kotlin-stdlib"}, k = 2, mv = {2, 1, 0}, xi = 48)
public final class UArraySortingKt {
    /* JADX INFO: renamed from: partition-4UcCI2c, reason: not valid java name */
    private static final int m532partition4UcCI2c(byte[] bArr, int i, int i2) {
        int i3;
        byte bM148getw2LRezQ = UByteArray.m148getw2LRezQ(bArr, (i + i2) / 2);
        while (i <= i2) {
            while (true) {
                int iM148getw2LRezQ = UByteArray.m148getw2LRezQ(bArr, i) & UByte.MAX_VALUE;
                i3 = bM148getw2LRezQ & UByte.MAX_VALUE;
                if (Intrinsics.compare(iM148getw2LRezQ, i3) >= 0) {
                    break;
                }
                i++;
            }
            while (Intrinsics.compare(UByteArray.m148getw2LRezQ(bArr, i2) & UByte.MAX_VALUE, i3) > 0) {
                i2--;
            }
            if (i <= i2) {
                byte bM148getw2LRezQ2 = UByteArray.m148getw2LRezQ(bArr, i);
                UByteArray.m153setVurrAj0(bArr, i, UByteArray.m148getw2LRezQ(bArr, i2));
                UByteArray.m153setVurrAj0(bArr, i2, bM148getw2LRezQ2);
                i++;
                i2--;
            }
        }
        return i;
    }

    /* JADX INFO: renamed from: quickSort-4UcCI2c, reason: not valid java name */
    private static final void m536quickSort4UcCI2c(byte[] bArr, int i, int i2) {
        int iM532partition4UcCI2c = m532partition4UcCI2c(bArr, i, i2);
        int i3 = iM532partition4UcCI2c - 1;
        if (i < i3) {
            m536quickSort4UcCI2c(bArr, i, i3);
        }
        if (iM532partition4UcCI2c < i2) {
            m536quickSort4UcCI2c(bArr, iM532partition4UcCI2c, i2);
        }
    }

    /* JADX INFO: renamed from: partition-Aa5vz7o, reason: not valid java name */
    private static final int m533partitionAa5vz7o(short[] sArr, int i, int i2) {
        int i3;
        short sM411getMh2AYeg = UShortArray.m411getMh2AYeg(sArr, (i + i2) / 2);
        while (i <= i2) {
            while (true) {
                int iM411getMh2AYeg = UShortArray.m411getMh2AYeg(sArr, i) & UShort.MAX_VALUE;
                i3 = sM411getMh2AYeg & UShort.MAX_VALUE;
                if (Intrinsics.compare(iM411getMh2AYeg, i3) >= 0) {
                    break;
                }
                i++;
            }
            while (Intrinsics.compare(UShortArray.m411getMh2AYeg(sArr, i2) & UShort.MAX_VALUE, i3) > 0) {
                i2--;
            }
            if (i <= i2) {
                short sM411getMh2AYeg2 = UShortArray.m411getMh2AYeg(sArr, i);
                UShortArray.m416set01HTLdE(sArr, i, UShortArray.m411getMh2AYeg(sArr, i2));
                UShortArray.m416set01HTLdE(sArr, i2, sM411getMh2AYeg2);
                i++;
                i2--;
            }
        }
        return i;
    }

    /* JADX INFO: renamed from: quickSort-Aa5vz7o, reason: not valid java name */
    private static final void m537quickSortAa5vz7o(short[] sArr, int i, int i2) {
        int iM533partitionAa5vz7o = m533partitionAa5vz7o(sArr, i, i2);
        int i3 = iM533partitionAa5vz7o - 1;
        if (i < i3) {
            m537quickSortAa5vz7o(sArr, i, i3);
        }
        if (iM533partitionAa5vz7o < i2) {
            m537quickSortAa5vz7o(sArr, iM533partitionAa5vz7o, i2);
        }
    }

    /* JADX INFO: renamed from: partition-oBK06Vg, reason: not valid java name */
    private static final int m534partitionoBK06Vg(int[] iArr, int i, int i2) {
        int iM227getpVg5ArA = UIntArray.m227getpVg5ArA(iArr, (i + i2) / 2);
        while (i <= i2) {
            while (Integer.compare(UIntArray.m227getpVg5ArA(iArr, i) ^ Integer.MIN_VALUE, iM227getpVg5ArA ^ Integer.MIN_VALUE) < 0) {
                i++;
            }
            while (Integer.compare(UIntArray.m227getpVg5ArA(iArr, i2) ^ Integer.MIN_VALUE, iM227getpVg5ArA ^ Integer.MIN_VALUE) > 0) {
                i2--;
            }
            if (i <= i2) {
                int iM227getpVg5ArA2 = UIntArray.m227getpVg5ArA(iArr, i);
                UIntArray.m232setVXSXFK8(iArr, i, UIntArray.m227getpVg5ArA(iArr, i2));
                UIntArray.m232setVXSXFK8(iArr, i2, iM227getpVg5ArA2);
                i++;
                i2--;
            }
        }
        return i;
    }

    /* JADX INFO: renamed from: quickSort-oBK06Vg, reason: not valid java name */
    private static final void m538quickSortoBK06Vg(int[] iArr, int i, int i2) {
        int iM534partitionoBK06Vg = m534partitionoBK06Vg(iArr, i, i2);
        int i3 = iM534partitionoBK06Vg - 1;
        if (i < i3) {
            m538quickSortoBK06Vg(iArr, i, i3);
        }
        if (iM534partitionoBK06Vg < i2) {
            m538quickSortoBK06Vg(iArr, iM534partitionoBK06Vg, i2);
        }
    }

    /* JADX INFO: renamed from: partition--nroSd4, reason: not valid java name */
    private static final int m531partitionnroSd4(long[] jArr, int i, int i2) {
        long jM306getsVKNKU = ULongArray.m306getsVKNKU(jArr, (i + i2) / 2);
        while (i <= i2) {
            while (Long.compare(ULongArray.m306getsVKNKU(jArr, i) ^ Long.MIN_VALUE, jM306getsVKNKU ^ Long.MIN_VALUE) < 0) {
                i++;
            }
            while (Long.compare(ULongArray.m306getsVKNKU(jArr, i2) ^ Long.MIN_VALUE, jM306getsVKNKU ^ Long.MIN_VALUE) > 0) {
                i2--;
            }
            if (i <= i2) {
                long jM306getsVKNKU2 = ULongArray.m306getsVKNKU(jArr, i);
                ULongArray.m311setk8EXiF4(jArr, i, ULongArray.m306getsVKNKU(jArr, i2));
                ULongArray.m311setk8EXiF4(jArr, i2, jM306getsVKNKU2);
                i++;
                i2--;
            }
        }
        return i;
    }

    /* JADX INFO: renamed from: quickSort--nroSd4, reason: not valid java name */
    private static final void m535quickSortnroSd4(long[] jArr, int i, int i2) {
        int iM531partitionnroSd4 = m531partitionnroSd4(jArr, i, i2);
        int i3 = iM531partitionnroSd4 - 1;
        if (i < i3) {
            m535quickSortnroSd4(jArr, i, i3);
        }
        if (iM531partitionnroSd4 < i2) {
            m535quickSortnroSd4(jArr, iM531partitionnroSd4, i2);
        }
    }

    /* JADX INFO: renamed from: sortArray-4UcCI2c, reason: not valid java name */
    public static final void m540sortArray4UcCI2c(byte[] array, int i, int i2) {
        Intrinsics.checkNotNullParameter(array, "array");
        m536quickSort4UcCI2c(array, i, i2 - 1);
    }

    /* JADX INFO: renamed from: sortArray-Aa5vz7o, reason: not valid java name */
    public static final void m541sortArrayAa5vz7o(short[] array, int i, int i2) {
        Intrinsics.checkNotNullParameter(array, "array");
        m537quickSortAa5vz7o(array, i, i2 - 1);
    }

    /* JADX INFO: renamed from: sortArray-oBK06Vg, reason: not valid java name */
    public static final void m542sortArrayoBK06Vg(int[] array, int i, int i2) {
        Intrinsics.checkNotNullParameter(array, "array");
        m538quickSortoBK06Vg(array, i, i2 - 1);
    }

    /* JADX INFO: renamed from: sortArray--nroSd4, reason: not valid java name */
    public static final void m539sortArraynroSd4(long[] array, int i, int i2) {
        Intrinsics.checkNotNullParameter(array, "array");
        m535quickSortnroSd4(array, i, i2 - 1);
    }
}
