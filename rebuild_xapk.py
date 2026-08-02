#!/usr/bin/env python3
"""
XAPK Rebuilder - Complete working version
"""

import os
import sys
import subprocess
import shutil
import json
import zipfile
import re
from pathlib import Path

class XAPKRebuilder:
    def __init__(self, decompiled_dir="decompiled", output_dir="workspace"):
        self.decompiled_dir = Path(decompiled_dir)
        self.output_dir = Path(output_dir)
        self.build_dir = self.output_dir / "xapk_build"
        self.build_dir.mkdir(parents=True, exist_ok=True)
        
        self.package = "unknown"
        self.version_code = "1"
        self.version_name = "1.0"
        self.apks_repackaged = []
        self.apks_failed = []
    
    def _run_cmd(self, cmd, desc=""):
        try:
            result = subprocess.run(cmd, capture_output=True, text=True)
            if result.returncode != 0:
                print(f"❌ {desc} failed")
                if result.stderr:
                    error_lines = result.stderr.strip().split('\n')[:3]
                    for line in error_lines:
                        print(f"   {line}")
                return False
            return True
        except Exception as e:
            print(f"❌ {desc} error: {e}")
            return False
    
    def find_apk_dirs(self):
        dirs = []
        for item in self.decompiled_dir.iterdir():
            if item.is_dir() and (item / "AndroidManifest.xml").exists():
                dirs.append(item)
        return dirs
    
    def extract_package_info(self):
        apk_dirs = self.find_apk_dirs()
        if not apk_dirs:
            return
        
        main_dir = None
        for d in apk_dirs:
            if d.name == "ins_mdm_app" or d.name == "base":
                main_dir = d
                break
        
        if not main_dir:
            main_dir = apk_dirs[0]
        
        manifest = main_dir / "AndroidManifest.xml"
        if manifest.exists():
            with open(manifest, 'r') as f:
                content = f.read()
                pkg = re.search(r'package="([^"]+)"', content)
                if pkg:
                    self.package = pkg.group(1)
                vc = re.search(r'versionCode="([^"]+)"', content)
                if vc:
                    self.version_code = vc.group(1)
                vn = re.search(r'versionName="([^"]+)"', content)
                if vn:
                    self.version_name = vn.group(1)
        
        print(f"   Package: {self.package}")
        print(f"   Version: {self.version_name} ({self.version_code})")
    
    def create_apktool_yml(self, dir_path):
        """Create apktool.yml with proper numeric values (no quotes around numbers)"""
        yml_file = dir_path / "apktool.yml"
        if yml_file.exists():
            return True
        
        manifest = dir_path / "AndroidManifest.xml"
        min_sdk = 21
        target_sdk = 30
        
        if manifest.exists():
            with open(manifest, 'r') as f:
                content = f.read()
                ms = re.search(r'minSdkVersion="([^"]+)"', content)
                if ms:
                    min_sdk = ms.group(1)
                ts = re.search(r'targetSdkVersion="([^"]+)"', content)
                if ts:
                    target_sdk = ts.group(1)
        
        # IMPORTANT: NO quotes around numeric values!
        yml_content = f"""version: 2.0.0
apkFileName: {dir_path.name}.apk
isFrameworkApk: false
usesFramework:
  ids:
  - 1
sdkInfo:
  minSdkVersion: {min_sdk}
  targetSdkVersion: {target_sdk}
packageInfo:
  forcedPackageId: 127
versionInfo:
  versionCode: {self.version_code}
  versionName: "{self.version_name}"
compressionType: false
sharedLibrary: false
unknownFiles: {{}}
doNotCompress: null
"""
        
        with open(yml_file, 'w') as f:
            f.write(yml_content)
        return True
    
    def fix_armv7_manifest_force(self):
        """Force replace armv7_split/AndroidManifest.xml with working version"""
        manifest_path = self.decompiled_dir / "armv7_split" / "AndroidManifest.xml"
        
        if not manifest_path.exists():
            print("   ⚠️ armv7_split/AndroidManifest.xml not found")
            return False
        
        fixed_content = '''<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="ins.mdm.app"
    android:versionCode="1"
    android:versionName="1.0">
    
    <application
        android:extractNativeLibs="true"
        android:hasCode="true">
        
        <meta-data
            android:name="com.android.vending.derived.apk.id"
            android:value="2"/>
    </application>
</manifest>'''
        
        with open(manifest_path, 'w', encoding='utf-8') as f:
            f.write(fixed_content)
        
        # Also fix apktool.yml for armv7_split
        yml_path = self.decompiled_dir / "armv7_split" / "apktool.yml"
        yml_content = '''version: 2.0.0
apkFileName: armv7_split.apk
isFrameworkApk: false
usesFramework:
  ids:
  - 1
sdkInfo:
  minSdkVersion: 21
  targetSdkVersion: 30
packageInfo:
  forcedPackageId: 127
versionInfo:
  versionCode: 1
  versionName: "1.0"
compressionType: false
sharedLibrary: false
unknownFiles: {}
doNotCompress: null
'''
        with open(yml_path, 'w') as f:
            f.write(yml_content)
        
        print("   ✅ Force-replaced armv7_split/AndroidManifest.xml and apktool.yml")
        return True
    
    def clean_manifest(self, dir_path):
        manifest = dir_path / "AndroidManifest.xml"
        if not manifest.exists():
            return
        
        with open(manifest, 'r', encoding='utf-8') as f:
            content = f.read()
        
        content = re.sub(r'\s+android:splitTypes="[^"]*"', '', content)
        content = re.sub(r'\s+android:isSplitRequired="[^"]*"', '', content)
        content = re.sub(r'\s+android:splitName="[^"]*"', '', content)
        content = re.sub(r'\s+android:configForSplit="[^"]*"', '', content)
        content = re.sub(r'\s+split="[^"]*"', '', content)
        
        if 'android:versionCode' not in content:
            content = re.sub(
                r'<manifest\s+',
                f'<manifest android:versionCode="{self.version_code}" ',
                content
            )
        if 'android:versionName' not in content:
            if 'android:versionCode="' + self.version_code + '"' in content and 'android:versionName' not in content:
                content = re.sub(
                    r'android:versionCode="[^"]*"',
                    f'android:versionCode="{self.version_code}" android:versionName="{self.version_name}"',
                    content
                )
            else:
                content = re.sub(
                    r'<manifest\s+',
                    f'<manifest android:versionName="{self.version_name}" ',
                    content
                )
        
        if 'android:extractNativeLibs' not in content:
            content = content.replace('<application ', '<application android:extractNativeLibs="true" ')
        
        with open(manifest, 'w', encoding='utf-8') as f:
            f.write(content)
        
        self.create_apktool_yml(dir_path)
    
    def repackage(self):
        print("📦 Repackaging APKs...")
        
        apk_dirs = self.find_apk_dirs()
        if not apk_dirs:
            print("❌ No decompiled directories found!")
            return False
        
        print(f"   Found {len(apk_dirs)} APK(s)")
        
        self.extract_package_info()
        
        # FORCE FIX armv7_split
        if (self.decompiled_dir / "armv7_split").exists():
            self.fix_armv7_manifest_force()
        
        for dir_path in apk_dirs:
            name = dir_path.name
            output = self.build_dir / f"{name}.apk"
            
            print(f"   📦 {name}...", end=" ", flush=True)
            
            if name != "armv7_split":
                self.clean_manifest(dir_path)
            
            # Make sure apktool.yml exists
            self.create_apktool_yml(dir_path)
            
            cmd = ['apktool', 'b', str(dir_path), '-o', str(output)]
            success = self._run_cmd(cmd, f"Building {name}")
            
            if success and output.exists() and output.stat().st_size > 0:
                print("✅")
                self.apks_repackaged.append(f"{name}.apk")
            else:
                print("❌")
                self.apks_failed.append(name)
        
        if self.apks_repackaged:
            print(f"   ✅ Repackaged {len(self.apks_repackaged)} APKs")
        if self.apks_failed:
            print(f"   ⚠️ Failed: {', '.join(self.apks_failed)}")
        
        return len(self.apks_repackaged) > 0
    
    def sign_apks(self):
        print("🔑 Signing APKs...")
        
        apks = list(self.build_dir.glob("*.apk"))
        if not apks:
            return False
        
        keystore = self.output_dir / "debug.keystore"
        if not keystore.exists():
            cmd = [
                'keytool', '-genkey', '-v',
                '-keystore', str(keystore),
                '-alias', 'debug',
                '-keyalg', 'RSA',
                '-keysize', '2048',
                '-validity', '10000',
                '-storepass', 'android',
                '-keypass', 'android',
                '-dname', 'CN=Debug, OU=Debug, O=Debug, L=Debug, ST=Debug, C=US'
            ]
            subprocess.run(cmd, capture_output=True)
        
        signed = 0
        for apk in apks:
            cmd = [
                'apksigner', 'sign',
                '--ks', str(keystore),
                '--ks-key-alias', 'debug',
                '--ks-pass', 'pass:android',
                '--key-pass', 'pass:android',
                str(apk)
            ]
            if self._run_cmd(cmd, f"Signing {apk.name}"):
                signed += 1
        
        print(f"   ✅ Signed {signed}/{len(apks)} APKs")
        return signed > 0
    
    def build_xapk(self, output_name="modded_app.xapk"):
        print(f"📦 Building XAPK: {output_name}")
        
        apk_files = list(self.build_dir.glob("*.apk"))
        if not apk_files:
            print("❌ No APKs to package!")
            return False
        
        splits = []
        for apk in apk_files:
            if apk.name != "ins_mdm_app.apk" and apk.name != "base.apk":
                splits.append(apk.name)
        
        manifest_data = {
            "package": self.package,
            "version_code": int(self.version_code) if self.version_code.isdigit() else 1,
            "version_name": self.version_name,
            "splits": splits,
            "obb": []
        }
        
        manifest_file = self.build_dir / "manifest.json"
        with open(manifest_file, 'w') as f:
            json.dump(manifest_data, f, indent=2)
        
        print(f"   📋 Manifest: {len(splits)} splits")
        
        try:
            with zipfile.ZipFile(output_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
                for file_path in self.build_dir.rglob("*"):
                    if file_path.is_file():
                        if file_path.name.endswith('.idsig'):
                            continue
                        arcname = file_path.relative_to(self.build_dir)
                        zipf.write(file_path, arcname)
            
            size = os.path.getsize(output_name)
            print(f"   ✅ XAPK created: {output_name} ({size:,} bytes)")
            return True
        except Exception as e:
            print(f"❌ Failed to build XAPK: {e}")
            return False
    
    def run(self, output_name="modded_app.xapk"):
        print("=" * 40)
        print("🚀 XAPK Rebuilder")
        print("=" * 40)
        
        if not self.decompiled_dir.exists():
            print(f"❌ Directory not found: {self.decompiled_dir}")
            return False
        
        apk_dirs = self.find_apk_dirs()
        print(f"📂 Found {len(apk_dirs)} decompiled APK directories")
        for d in apk_dirs:
            print(f"   - {d.name}")
        
        if not self.repackage():
            print("❌ Repackaging failed completely")
            return False
        
        if self.apks_repackaged:
            if not self.sign_apks():
                print("⚠️ Signing had issues, continuing...")
        
        if not self.build_xapk(output_name):
            return False
        
        print("=" * 40)
        print("✅ Done!")
        print(f"📦 Output: {output_name}")
        print(f"📱 Package: {self.package}")
        print(f"📚 APKs repackaged: {len(self.apks_repackaged)}")
        if self.apks_failed:
            print(f"⚠️ Failed: {', '.join(self.apks_failed)}")
        print("=" * 40)
        
        return True

def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--decompiled-dir', default='decompiled')
    parser.add_argument('--output', default='modded_app.xapk')
    args = parser.parse_args()
    
    rebuilder = XAPKRebuilder(args.decompiled_dir)
    success = rebuilder.run(args.output)
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
