package org.apache.cordova.camera;

import android.content.ActivityNotFoundException;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.system.Os;
import android.system.OsConstants;
import android.util.Base64;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.LOG;
import org.apache.cordova.PermissionHelper;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

/* JADX INFO: loaded from: classes.dex */
public class CameraLauncher extends CordovaPlugin implements MediaScannerConnection.MediaScannerConnectionClient {
    private static final int ALLMEDIA = 2;
    private static final int CAMERA = 1;
    private static final String CROPPED_URI_KEY = "croppedUri";
    private static final int CROP_CAMERA = 100;
    private static final int DATA_URL = 0;
    private static final int FILE_URI = 1;
    private static final String GET_All = "Get All";
    private static final String GET_PICTURE = "Get Picture";
    private static final String GET_VIDEO = "Get Video";
    private static final String HEIC_MIME_TYPE = "image/heic";
    private static final String IMAGE_URI_KEY = "imageUri";
    private static final int JPEG = 0;
    private static final String JPEG_EXTENSION = ".jpg";
    private static final String JPEG_MIME_TYPE = "image/jpeg";
    private static final String JPEG_TYPE = "jpg";
    private static final String LOG_TAG = "CameraLauncher";
    public static final int PERMISSION_DENIED_ERROR = 20;
    private static final int PHOTOLIBRARY = 0;
    private static final int PICTURE = 0;
    private static final int PNG = 1;
    private static final String PNG_EXTENSION = ".png";
    private static final String PNG_MIME_TYPE = "image/png";
    private static final String PNG_TYPE = "png";
    private static final int SAVEDPHOTOALBUM = 2;
    public static final int SAVE_TO_ALBUM_SEC = 1;
    private static final String TAKE_PICTURE_ACTION = "takePicture";
    public static final int TAKE_PIC_SEC = 0;
    private static final String TIME_FORMAT = "yyyyMMdd_HHmmss";
    private static final int VIDEO = 1;
    private boolean allowEdit;
    private String applicationId;
    public CallbackContext callbackContext;
    private MediaScannerConnection conn;
    private boolean correctOrientation;
    private String croppedFilePath;
    private Uri croppedUri;
    private int destType;
    private int encodingType;
    private ExifHelper exifData;
    private Uri imageUri;
    private int mQuality;
    private int mediaType;
    private boolean orientationCorrected;
    private boolean saveToPhotoAlbum;
    private Uri scanMe;
    private int srcType;
    private int targetHeight;
    private int targetWidth;

    private int exifToDegrees(int i) {
        if (i == 6) {
            return 90;
        }
        if (i == 3) {
            return 180;
        }
        return i == 8 ? 270 : 0;
    }

    @Override // org.apache.cordova.CordovaPlugin
    public boolean execute(String str, JSONArray jSONArray, CallbackContext callbackContext) throws JSONException {
        this.callbackContext = callbackContext;
        this.applicationId = this.f4cordova.getContext().getPackageName();
        this.applicationId = this.preferences.getString("applicationId", this.applicationId);
        if (!str.equals(TAKE_PICTURE_ACTION)) {
            return false;
        }
        this.srcType = 0;
        this.destType = 1;
        this.saveToPhotoAlbum = false;
        this.targetHeight = 0;
        this.targetWidth = 0;
        this.encodingType = 0;
        this.mediaType = 0;
        this.mQuality = 50;
        this.destType = jSONArray.getInt(1);
        this.srcType = jSONArray.getInt(2);
        this.mQuality = jSONArray.getInt(0);
        this.targetWidth = jSONArray.getInt(3);
        this.targetHeight = jSONArray.getInt(4);
        this.encodingType = jSONArray.getInt(5);
        this.mediaType = jSONArray.getInt(6);
        this.allowEdit = jSONArray.getBoolean(7);
        this.correctOrientation = jSONArray.getBoolean(8);
        this.saveToPhotoAlbum = jSONArray.getBoolean(9);
        if (this.targetWidth < 1) {
            this.targetWidth = -1;
        }
        if (this.targetHeight < 1) {
            this.targetHeight = -1;
        }
        if (this.targetHeight == -1 && this.targetWidth == -1 && this.mQuality == 100 && !this.correctOrientation && this.encodingType == 1 && this.srcType == 0) {
            this.encodingType = 0;
        }
        try {
            int i = this.srcType;
            if (i == 1) {
                callTakePicture(this.destType, this.encodingType);
            } else if (i == 0 || i == 2) {
                getImage(i, this.destType);
            }
            PluginResult pluginResult = new PluginResult(PluginResult.Status.NO_RESULT);
            pluginResult.setKeepCallback(true);
            callbackContext.sendPluginResult(pluginResult);
            return true;
        } catch (IllegalArgumentException unused) {
            callbackContext.error("Illegal Argument Exception");
            callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.ERROR));
            return true;
        } catch (IllegalStateException e) {
            callbackContext.error(e.getLocalizedMessage());
            callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.ERROR));
            return true;
        }
    }

    private String getTempDirectoryPath() {
        File cacheDir = this.f4cordova.getActivity().getCacheDir();
        cacheDir.mkdirs();
        return cacheDir.getAbsolutePath();
    }

    public void callTakePicture(int i, int i2) throws IllegalStateException {
        boolean z;
        boolean z2;
        String[] strArr;
        boolean zHasPermission = PermissionHelper.hasPermission(this, "android.permission.CAMERA");
        boolean zHasPermission2 = Build.VERSION.SDK_INT <= 28 ? PermissionHelper.hasPermission(this, "android.permission.WRITE_EXTERNAL_STORAGE") : true;
        try {
            strArr = this.f4cordova.getActivity().getPackageManager().getPackageInfo(this.f4cordova.getActivity().getPackageName(), 4096).requestedPermissions;
        } catch (PackageManager.NameNotFoundException unused) {
        }
        if (strArr != null) {
            z = false;
            z2 = false;
            for (String str : strArr) {
                try {
                    if (str.equals("android.permission.CAMERA")) {
                        z = true;
                    } else if (str.equals("android.permission.WRITE_EXTERNAL_STORAGE")) {
                        z2 = true;
                    }
                } catch (PackageManager.NameNotFoundException unused2) {
                }
            }
        } else {
            z = false;
            z2 = false;
        }
        ArrayList arrayList = new ArrayList();
        if (z && !zHasPermission) {
            arrayList.add("android.permission.CAMERA");
        }
        if (this.saveToPhotoAlbum && !zHasPermission2) {
            if (!z2) {
                throw new IllegalStateException("WRITE_EXTERNAL_STORAGE permission not declared in AndroidManifest");
            }
            arrayList.add("android.permission.WRITE_EXTERNAL_STORAGE");
        }
        if (!arrayList.isEmpty()) {
            PermissionHelper.requestPermissions(this, 0, (String[]) arrayList.toArray(new String[0]));
        } else {
            takePicture(i, i2);
        }
    }

    public void takePicture(int i, int i2) {
        Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
        Uri uriForFile = androidx.core.content.FileProvider.getUriForFile(this.f4cordova.getActivity(), this.applicationId + ".cordova.plugin.camera.provider", createCaptureFile(i2));
        this.imageUri = uriForFile;
        intent.putExtra("output", uriForFile);
        intent.addFlags(2);
        if (this.f4cordova != null) {
            if (intent.resolveActivity(this.f4cordova.getActivity().getPackageManager()) != null) {
                this.f4cordova.startActivityForResult(this, intent, i + 33);
            } else {
                LOG.d(LOG_TAG, "Error: You don't have a default camera.  Your device may not be CTS complaint.");
            }
        }
    }

    private File createCaptureFile(int i) {
        return createCaptureFile(i, "");
    }

    private File createCaptureFile(int i, String str) {
        String str2;
        if (str.isEmpty()) {
            str = ".Pic";
        }
        if (i == 0) {
            str2 = str + JPEG_EXTENSION;
        } else if (i == 1) {
            str2 = str + PNG_EXTENSION;
        } else {
            throw new IllegalArgumentException("Invalid Encoding Type: " + i);
        }
        File file = new File(getTempDirectoryPath(), "org.apache.cordova.camera");
        file.mkdir();
        return new File(file, str2);
    }

    /* JADX WARN: Removed duplicated region for block: B:28:0x0093  */
    /* JADX WARN: Removed duplicated region for block: B:30:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    public void getImage(int r7, int r8) {
        /*
            r6 = this;
            android.content.Intent r0 = new android.content.Intent
            r0.<init>()
            r1 = 0
            r6.croppedUri = r1
            r6.croppedFilePath = r1
            int r1 = r6.mediaType
            java.lang.String r2 = "android.intent.category.OPENABLE"
            java.lang.String r3 = "android.intent.action.GET_CONTENT"
            r4 = 1
            if (r1 != 0) goto L6c
            java.lang.String r1 = "image/*"
            r0.setType(r1)
            boolean r1 = r6.allowEdit
            if (r1 == 0) goto L65
            java.lang.String r1 = "android.intent.action.PICK"
            r0.setAction(r1)
            java.lang.String r1 = "crop"
            java.lang.String r2 = "true"
            r0.putExtra(r1, r2)
            int r1 = r6.targetWidth
            if (r1 <= 0) goto L31
            java.lang.String r2 = "outputX"
            r0.putExtra(r2, r1)
        L31:
            int r1 = r6.targetHeight
            if (r1 <= 0) goto L3a
            java.lang.String r2 = "outputY"
            r0.putExtra(r2, r1)
        L3a:
            int r1 = r6.targetHeight
            if (r1 <= 0) goto L4e
            int r2 = r6.targetWidth
            if (r2 <= 0) goto L4e
            if (r2 != r1) goto L4e
            java.lang.String r1 = "aspectX"
            r0.putExtra(r1, r4)
            java.lang.String r1 = "aspectY"
            r0.putExtra(r1, r4)
        L4e:
            r1 = 0
            java.io.File r1 = r6.createCaptureFile(r1)
            java.lang.String r2 = r1.getAbsolutePath()
            r6.croppedFilePath = r2
            android.net.Uri r1 = android.net.Uri.fromFile(r1)
            r6.croppedUri = r1
            java.lang.String r2 = "output"
            r0.putExtra(r2, r1)
            goto L8d
        L65:
            r0.setAction(r3)
            r0.addCategory(r2)
            goto L8d
        L6c:
            if (r1 != r4) goto L7c
            java.lang.String r1 = "video/*"
            r0.setType(r1)
            r0.setAction(r3)
            r0.addCategory(r2)
            java.lang.String r1 = "Get Video"
            goto L8f
        L7c:
            r5 = 2
            if (r1 != r5) goto L8d
        */
        //  java.lang.String r1 = "*/*"
        /*
            r0.setType(r1)
            r0.setAction(r3)
            r0.addCategory(r2)
            java.lang.String r1 = "Get All"
            goto L8f
        L8d:
            java.lang.String r1 = "Get Picture"
        L8f:
            org.apache.cordova.CordovaInterface r2 = r6.f4cordova
            if (r2 == 0) goto La6
            org.apache.cordova.CordovaInterface r2 = r6.f4cordova
            java.lang.String r3 = new java.lang.String
            r3.<init>(r1)
            android.content.Intent r0 = android.content.Intent.createChooser(r0, r3)
            int r7 = r7 + r4
            int r7 = r7 * 16
            int r7 = r7 + r8
            int r7 = r7 + r4
            r2.startActivityForResult(r6, r0, r7)
        La6:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: org.apache.cordova.camera.CameraLauncher.getImage(int, int):void");
    }

    private void performCrop(Uri uri, int i, Intent intent) throws Exception {
        int i2;
        try {
            Intent intent2 = new Intent("com.android.camera.action.CROP");
            intent2.setDataAndType(uri, "image/*");
            intent2.putExtra("crop", "true");
            int i3 = this.targetWidth;
            if (i3 > 0) {
                intent2.putExtra("outputX", i3);
            }
            int i4 = this.targetHeight;
            if (i4 > 0) {
                intent2.putExtra("outputY", i4);
            }
            int i5 = this.targetHeight;
            if (i5 > 0 && (i2 = this.targetWidth) > 0 && i2 == i5) {
                intent2.putExtra("aspectX", 1);
                intent2.putExtra("aspectY", 1);
            }
            String absolutePath = createCaptureFile(this.encodingType, System.currentTimeMillis() + "").getAbsolutePath();
            this.croppedFilePath = absolutePath;
            this.croppedUri = Uri.parse(absolutePath);
            intent2.addFlags(1);
            intent2.addFlags(2);
            intent2.putExtra("output", this.croppedUri);
            if (this.f4cordova != null) {
                this.f4cordova.startActivityForResult(this, intent2, i + 100);
            }
        } catch (ActivityNotFoundException unused) {
            LOG.e(LOG_TAG, "Crop operation not supported on this device");
            try {
                processResultFromCamera(i, intent);
            } catch (IOException e) {
                e.printStackTrace();
                LOG.e(LOG_TAG, "Unable to write to file");
            }
        }
    }

    private void processResultFromCamera(int i, Intent intent) throws Exception {
        InputStream inputStreamOpenInputStream;
        String mimeType;
        int orientation;
        Uri uriFromFile;
        Uri uri;
        ExifHelper exifHelper = new ExifHelper();
        if (this.allowEdit && this.croppedUri != null) {
            inputStreamOpenInputStream = new FileInputStream(this.croppedFilePath);
            mimeType = FileHelper.getMimeTypeForExtension(this.croppedFilePath);
        } else {
            inputStreamOpenInputStream = this.f4cordova.getActivity().getContentResolver().openInputStream(this.imageUri);
            mimeType = FileHelper.getMimeType(this.imageUri.toString(), this.f4cordova);
        }
        if (inputStreamOpenInputStream == null) {
            throw new IOException("Unable to open result source.");
        }
        byte[] data = readData(inputStreamOpenInputStream);
        try {
            if (this.encodingType == 0) {
                try {
                    exifHelper.createInFile(new ByteArrayInputStream(data));
                    exifHelper.readExifData();
                    orientation = exifHelper.getOrientation();
                } catch (IOException e) {
                    e.printStackTrace();
                    orientation = 0;
                }
            } else {
                orientation = 0;
            }
            Bitmap scaledAndRotatedBitmap = null;
            if (this.saveToPhotoAlbum) {
                GalleryPathVO picturesPath = getPicturesPath();
                uriFromFile = Uri.fromFile(new File(picturesPath.getGalleryPath()));
                if (this.allowEdit && (uri = this.croppedUri) != null) {
                    writeUncompressedImage(uri, uriFromFile);
                } else if (Build.VERSION.SDK_INT <= 28) {
                    writeTakenPictureToGalleryLowerThanAndroidQ(uriFromFile);
                } else {
                    writeTakenPictureToGalleryStartingFromAndroidQ(picturesPath);
                }
            } else {
                uriFromFile = null;
            }
            if (i == 0) {
                Bitmap scaledAndRotatedBitmap2 = getScaledAndRotatedBitmap(data, mimeType);
                if (scaledAndRotatedBitmap2 == null) {
                    scaledAndRotatedBitmap2 = (Bitmap) intent.getExtras().get("data");
                }
                scaledAndRotatedBitmap = scaledAndRotatedBitmap2;
                if (scaledAndRotatedBitmap == null) {
                    LOG.d(LOG_TAG, "I either have an unreadable imageUri or null bitmap");
                    failPicture("Unable to create bitmap!");
                    return;
                }
                processPicture(scaledAndRotatedBitmap, this.encodingType);
            } else if (i == 1) {
                if (this.targetHeight == -1 && this.targetWidth == -1 && this.mQuality == 100 && !this.correctOrientation) {
                    if (this.saveToPhotoAlbum) {
                        this.callbackContext.success(uriFromFile.toString());
                    } else {
                        Uri uriFromFile2 = Uri.fromFile(createCaptureFile(this.encodingType, System.currentTimeMillis() + ""));
                        if (this.allowEdit && this.croppedUri != null) {
                            writeUncompressedImage(Uri.parse(this.croppedFilePath), uriFromFile2);
                        } else {
                            writeUncompressedImage(this.imageUri, uriFromFile2);
                        }
                        this.callbackContext.success(uriFromFile2.toString());
                    }
                } else {
                    Uri uriFromFile3 = Uri.fromFile(createCaptureFile(this.encodingType, System.currentTimeMillis() + ""));
                    scaledAndRotatedBitmap = getScaledAndRotatedBitmap(data, mimeType);
                    if (scaledAndRotatedBitmap == null) {
                        LOG.d(LOG_TAG, "I either have an unreadable imageUri or null bitmap");
                        failPicture("Unable to create bitmap!");
                        return;
                    }
                    OutputStream outputStreamOpenOutputStream = this.f4cordova.getActivity().getContentResolver().openOutputStream(uriFromFile3);
                    scaledAndRotatedBitmap.compress(getCompressFormatForEncodingType(this.encodingType), this.mQuality, outputStreamOpenOutputStream);
                    outputStreamOpenOutputStream.close();
                    if (this.encodingType == 0) {
                        String path = uriFromFile3.getPath();
                        if (orientation != 1) {
                            exifHelper.resetOrientation();
                        }
                        exifHelper.createOutFile(path);
                        exifHelper.writeExifData();
                    }
                    this.callbackContext.success(uriFromFile3.toString());
                }
            } else {
                throw new IllegalStateException();
            }
            cleanup(this.imageUri, uriFromFile, scaledAndRotatedBitmap);
            inputStreamOpenInputStream.close();
        } catch (Exception e2) {
            inputStreamOpenInputStream.close();
            throw e2;
        }
    }

    private void writeTakenPictureToGalleryLowerThanAndroidQ(Uri uri) throws IOException {
        writeUncompressedImage(this.imageUri, uri);
        refreshGallery(uri);
    }

    private void writeTakenPictureToGalleryStartingFromAndroidQ(GalleryPathVO galleryPathVO) throws IOException {
        ContentResolver contentResolver = this.f4cordova.getActivity().getContentResolver();
        ContentValues contentValues = new ContentValues();
        contentValues.put("_display_name", galleryPathVO.getGalleryFileName());
        contentValues.put("mime_type", getMimetypeForEncodingType());
        writeUncompressedImage(FileHelper.getInputStreamFromUriString(this.imageUri.toString(), this.f4cordova), contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, contentValues));
    }

    private Bitmap.CompressFormat getCompressFormatForEncodingType(int i) {
        return i == 0 ? Bitmap.CompressFormat.JPEG : Bitmap.CompressFormat.PNG;
    }

    private GalleryPathVO getPicturesPath() {
        String str = "IMG_" + new SimpleDateFormat(TIME_FORMAT).format(new Date()) + getExtensionForEncodingType();
        File externalStoragePublicDirectory = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES);
        externalStoragePublicDirectory.mkdirs();
        return new GalleryPathVO(externalStoragePublicDirectory.getAbsolutePath(), str);
    }

    private void refreshGallery(Uri uri) {
        Intent intent = new Intent("android.intent.action.MEDIA_SCANNER_SCAN_FILE");
        intent.setData(uri);
        this.f4cordova.getActivity().sendBroadcast(intent);
    }

    private String getMimetypeForEncodingType() {
        int i = this.encodingType;
        if (i == 1) {
            return PNG_MIME_TYPE;
        }
        if (i == 0) {
            return JPEG_MIME_TYPE;
        }
        return "";
    }

    private String outputModifiedBitmap(Bitmap bitmap, Uri uri, String str) throws IOException {
        String str2 = getTempDirectoryPath() + "/" + calculateModifiedBitmapOutputFileName(str, FileHelper.getRealPath(uri, this.f4cordova));
        FileOutputStream fileOutputStream = new FileOutputStream(str2);
        bitmap.compress(getCompressFormatForEncodingType(this.encodingType), this.mQuality, fileOutputStream);
        fileOutputStream.close();
        ExifHelper exifHelper = this.exifData;
        if (exifHelper != null && this.encodingType == 0) {
            try {
                if (this.correctOrientation && this.orientationCorrected) {
                    exifHelper.resetOrientation();
                }
                this.exifData.createOutFile(str2);
                this.exifData.writeExifData();
                this.exifData = null;
                return str2;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return str2;
    }

    private String calculateModifiedBitmapOutputFileName(String str, String str2) {
        if (str2 == null) {
            return "modified" + getExtensionForEncodingType();
        }
        String strSubstring = str2.substring(str2.lastIndexOf(47) + 1);
        return getMimetypeForEncodingType().equals(str) ? strSubstring : strSubstring.substring(strSubstring.lastIndexOf(".") + 1) + getExtensionForEncodingType();
    }

    private String getExtensionForEncodingType() {
        return this.encodingType == 0 ? JPEG_EXTENSION : PNG_EXTENSION;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:108:0x00b3 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:113:0x0074 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:66:0x0105 A[Catch: Exception -> 0x0192, TryCatch #7 {Exception -> 0x0192, blocks: (B:69:0x0111, B:71:0x011b, B:90:0x0181, B:91:0x0184, B:93:0x018e, B:74:0x0124, B:76:0x0128, B:87:0x0162, B:78:0x012c, B:80:0x0130, B:82:0x0134, B:88:0x017a, B:66:0x0105, B:67:0x010a, B:62:0x00df, B:63:0x00f7, B:92:0x0188, B:84:0x013e), top: B:121:0x003c, inners: #8 }] */
    /* JADX WARN: Type inference failed for: r8v0 */
    /* JADX WARN: Type inference failed for: r8v1 */
    /* JADX WARN: Type inference failed for: r8v14 */
    /* JADX WARN: Type inference failed for: r8v15 */
    /* JADX WARN: Type inference failed for: r8v16 */
    /* JADX WARN: Type inference failed for: r8v17 */
    /* JADX WARN: Type inference failed for: r8v18 */
    /* JADX WARN: Type inference failed for: r8v19 */
    /* JADX WARN: Type inference failed for: r8v2, types: [java.io.InputStream] */
    /* JADX WARN: Type inference failed for: r8v3 */
    /* JADX WARN: Type inference failed for: r8v4 */
    /* JADX WARN: Type inference failed for: r8v5 */
    /* JADX WARN: Type inference failed for: r8v6, types: [java.io.InputStream] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    public void processResultFromGallery(int r18, android.content.Intent r19) throws java.io.IOException {
        /*
            Method dump skipped, instruction units count: 427
            To view this dump change 'Code comments level' option to 'DEBUG'
        */
        throw new UnsupportedOperationException("Method not decompiled: org.apache.cordova.camera.CameraLauncher.processResultFromGallery(int, android.content.Intent):void");
    }

    private boolean isImageMimeTypeProcessable(String str) {
        return JPEG_MIME_TYPE.equalsIgnoreCase(str) || PNG_MIME_TYPE.equalsIgnoreCase(str) || HEIC_MIME_TYPE.equalsIgnoreCase(str);
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onActivityResult(int i, int i2, final Intent intent) throws Exception {
        int i3 = (i / 16) - 1;
        final int i4 = (i % 16) - 1;
        if (i >= 100) {
            if (i2 != -1) {
                if (i2 == 0) {
                    failPicture("No Image Selected");
                    return;
                } else {
                    failPicture("Did not complete!");
                    return;
                }
            }
            try {
                processResultFromCamera(i - 100, intent);
                return;
            } catch (IOException e) {
                e.printStackTrace();
                LOG.e(LOG_TAG, "Unable to write to file");
                return;
            }
        }
        if (i3 != 1) {
            if (i3 == 0 || i3 == 2) {
                if (i2 == -1 && intent != null) {
                    this.f4cordova.getThreadPool().execute(new Runnable() { // from class: org.apache.cordova.camera.CameraLauncher.1
                        @Override // java.lang.Runnable
                        public void run() throws IOException {
                            CameraLauncher.this.processResultFromGallery(i4, intent);
                        }
                    });
                    return;
                } else if (i2 == 0) {
                    failPicture("No Image Selected");
                    return;
                } else {
                    failPicture("Selection did not complete!");
                    return;
                }
            }
            return;
        }
        if (i2 != -1) {
            if (i2 == 0) {
                failPicture("No Image Selected");
                return;
            } else {
                failPicture("Did not complete!");
                return;
            }
        }
        try {
            if (this.allowEdit) {
                performCrop(androidx.core.content.FileProvider.getUriForFile(this.f4cordova.getActivity(), this.applicationId + ".cordova.plugin.camera.provider", createCaptureFile(this.encodingType)), i4, intent);
            } else {
                processResultFromCamera(i4, intent);
            }
        } catch (IOException e2) {
            e2.printStackTrace();
            failPicture("Error capturing image: " + e2.getLocalizedMessage());
        }
    }

    private void writeUncompressedImage(InputStream inputStream, Uri uri) throws IOException {
        OutputStream outputStreamOpenOutputStream = null;
        try {
            outputStreamOpenOutputStream = this.f4cordova.getActivity().getContentResolver().openOutputStream(uri);
            byte[] bArr = new byte[4096];
            while (true) {
                int i = inputStream.read(bArr);
                if (i == -1) {
                    break;
                } else {
                    outputStreamOpenOutputStream.write(bArr, 0, i);
                }
            }
            outputStreamOpenOutputStream.flush();
            if (outputStreamOpenOutputStream != null) {
                try {
                    outputStreamOpenOutputStream.close();
                } catch (IOException unused) {
                    LOG.d(LOG_TAG, "Exception while closing output stream.");
                }
            }
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException unused2) {
                    LOG.d(LOG_TAG, "Exception while closing file input stream.");
                }
            }
        } finally {
        }
    }

    private void writeUncompressedImage(Uri uri, Uri uri2) throws IOException {
        writeUncompressedImage(FileHelper.getInputStreamFromUriString(uri.toString(), this.f4cordova), uri2);
    }

    /* JADX WARN: Removed duplicated region for block: B:25:0x007f  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct code enable 'Show inconsistent code' option in preferences
    */
    private android.graphics.Bitmap getScaledAndRotatedBitmap(byte[] r13, java.lang.String r14) throws java.io.IOException {
        /*
            Method dump skipped, instruction units count: 303
            To view this dump change 'Code comments level' option to 'DEBUG'
        */
        throw new UnsupportedOperationException("Method not decompiled: org.apache.cordova.camera.CameraLauncher.getScaledAndRotatedBitmap(byte[], java.lang.String):android.graphics.Bitmap");
    }

    public int[] calculateAspectRatio(int i, int i2) {
        int i3 = this.targetWidth;
        int i4 = this.targetHeight;
        if (i3 > 0 || i4 > 0) {
            if (i3 <= 0 || i4 > 0) {
                if (i3 > 0 || i4 <= 0) {
                    double d = ((double) i3) / ((double) i4);
                    double d2 = ((double) i) / ((double) i2);
                    if (d2 > d) {
                        i2 = (i2 * i3) / i;
                    } else {
                        i = d2 < d ? (i * i4) / i2 : i3;
                    }
                } else {
                    i = (int) ((((double) i4) / ((double) i2)) * ((double) i));
                }
                i2 = i4;
            } else {
                i2 = (int) ((((double) i3) / ((double) i)) * ((double) i2));
            }
            i = i3;
        }
        return new int[]{i, i2};
    }

    public static int calculateSampleSize(int i, int i2, int i3, int i4) {
        if (i / i2 > i3 / i4) {
            return i / i3;
        }
        return i2 / i4;
    }

    private void cleanup(Uri uri, Uri uri2, Bitmap bitmap) {
        if (bitmap != null) {
            bitmap.recycle();
        }
        new File(FileHelper.stripFileProtocol(uri.toString())).delete();
        if (this.saveToPhotoAlbum && uri2 != null) {
            scanForGallery(uri2);
        }
        System.gc();
    }

    private Uri whichContentStore() {
        if (Environment.getExternalStorageState().equals("mounted")) {
            return MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
        }
        return MediaStore.Images.Media.INTERNAL_CONTENT_URI;
    }

    public void processPicture(Bitmap bitmap, int i) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            if (bitmap.compress(getCompressFormatForEncodingType(i), this.mQuality, byteArrayOutputStream)) {
                StringBuilder sbAppend = new StringBuilder("data:").append(i == 1 ? PNG_MIME_TYPE : JPEG_MIME_TYPE).append(";base64,");
                sbAppend.append(new String(Base64.encode(byteArrayOutputStream.toByteArray(), 2)));
                this.callbackContext.success(sbAppend.toString());
            }
        } catch (Exception e) {
            failPicture("Error compressing image: " + e.getLocalizedMessage());
        }
    }

    public void failPicture(String str) {
        this.callbackContext.error(str);
    }

    private void scanForGallery(Uri uri) {
        this.scanMe = uri;
        MediaScannerConnection mediaScannerConnection = this.conn;
        if (mediaScannerConnection != null) {
            mediaScannerConnection.disconnect();
        }
        MediaScannerConnection mediaScannerConnection2 = new MediaScannerConnection(this.f4cordova.getActivity().getApplicationContext(), this);
        this.conn = mediaScannerConnection2;
        mediaScannerConnection2.connect();
    }

    @Override // android.media.MediaScannerConnection.MediaScannerConnectionClient
    public void onMediaScannerConnected() {
        try {
            this.conn.scanFile(this.scanMe.toString(), "image/*");
        } catch (IllegalStateException unused) {
            LOG.e(LOG_TAG, "Can't scan file in MediaScanner after taking picture");
        }
    }

    @Override // android.media.MediaScannerConnection.OnScanCompletedListener
    public void onScanCompleted(String str, Uri uri) {
        this.conn.disconnect();
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onRequestPermissionResult(int i, String[] strArr, int[] iArr) {
        for (int i2 : iArr) {
            if (i2 == -1) {
                this.callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.ERROR, 20));
                return;
            }
        }
        if (i == 0) {
            takePicture(this.destType, this.encodingType);
        } else {
            if (i != 1) {
                return;
            }
            getImage(this.srcType, this.destType);
        }
    }

    @Override // org.apache.cordova.CordovaPlugin
    public Bundle onSaveInstanceState() {
        Bundle bundle = new Bundle();
        bundle.putInt("destType", this.destType);
        bundle.putInt("srcType", this.srcType);
        bundle.putInt("mQuality", this.mQuality);
        bundle.putInt("targetWidth", this.targetWidth);
        bundle.putInt("targetHeight", this.targetHeight);
        bundle.putInt("encodingType", this.encodingType);
        bundle.putInt("mediaType", this.mediaType);
        bundle.putBoolean("allowEdit", this.allowEdit);
        bundle.putBoolean("correctOrientation", this.correctOrientation);
        bundle.putBoolean("saveToPhotoAlbum", this.saveToPhotoAlbum);
        if (this.croppedUri != null) {
            bundle.putString(CROPPED_URI_KEY, this.croppedFilePath);
        }
        Uri uri = this.imageUri;
        if (uri != null) {
            bundle.putString(IMAGE_URI_KEY, uri.toString());
        }
        return bundle;
    }

    @Override // org.apache.cordova.CordovaPlugin
    public void onRestoreStateForActivityResult(Bundle bundle, CallbackContext callbackContext) {
        this.destType = bundle.getInt("destType");
        this.srcType = bundle.getInt("srcType");
        this.mQuality = bundle.getInt("mQuality");
        this.targetWidth = bundle.getInt("targetWidth");
        this.targetHeight = bundle.getInt("targetHeight");
        this.encodingType = bundle.getInt("encodingType");
        this.mediaType = bundle.getInt("mediaType");
        this.allowEdit = bundle.getBoolean("allowEdit");
        this.correctOrientation = bundle.getBoolean("correctOrientation");
        this.saveToPhotoAlbum = bundle.getBoolean("saveToPhotoAlbum");
        if (bundle.containsKey(CROPPED_URI_KEY)) {
            this.croppedUri = Uri.parse(bundle.getString(CROPPED_URI_KEY));
        }
        if (bundle.containsKey(IMAGE_URI_KEY)) {
            this.imageUri = Uri.parse(bundle.getString(IMAGE_URI_KEY));
        }
        this.callbackContext = callbackContext;
    }

    private int getPageSize() {
        long jSysconf = Os.sysconf(OsConstants._SC_PAGE_SIZE);
        if (jSysconf > 2147483647L) {
            jSysconf = 2147483647L;
        }
        return (int) jSysconf;
    }

    private byte[] readData(InputStream inputStream) throws IOException {
        if (inputStream == null) {
            return null;
        }
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        byte[] bArr = new byte[getPageSize()];
        while (true) {
            int i = inputStream.read(bArr);
            if (i != -1) {
                byteArrayOutputStream.write(bArr, 0, i);
            } else {
                return byteArrayOutputStream.toByteArray();
            }
        }
    }
}
