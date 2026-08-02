#!/usr/bin/env python3
"""
XAPK Rebuilder - Simple version
"""

import os
import sys
import subprocess
import shutil
import json
import zipfile
from pathlib import Path

class XAPKRebuilder:
    def __init__(self, decompiled_dir="decompiled", output_dir="workspace"):
        self.decompiled_dir = Path(decompiled_dir)
        self.output_dir = Path(output_dir)
        self.build_dir = self.output_dir / "xapk_build"
        self.build_dir.mkdir(parents=True, exist_ok=True)
        
        # Store build info
        self.package = "unknown"
        self.version_code = "1"
        self.version_name = "1.0"
        self.apks_repackaged = []
        self.apks_failed = []
    
    def _run_cmd(self, cmd, desc=""):
        """Run command and return success"""
        try:
            result = subprocess.run(cmd, capture_output=True, text=True)
            if result.returncode != 0:
                print(f"❌ {desc} failed")
                if result.stderr:
                    print(f"   Error: {result.stderr[:300]}")
                return False
            return True
        except Exception as e:
            print(f"❌ {desc} error: {e}")
            return False
    
    def find_apk_dirs(self):
        """Find all directories with AndroidManifest.xml"""
        dirs = []
        for item in self.decompiled_dir.iterdir():
            if item.is_dir() and (item / "AndroidManifest.xml").exists():
                dirs.append(item)
        return dirs
    
    def fix_split_manifest(self, dir_path):
        """Fix AndroidManifest.xml for split APKs (remove split-specific attributes)"""
        manifest = dir_path / "AndroidManifest.xml"
        if not manifest.exists():
            return
        
        with open(manifest, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Remove split-specific attributes that cause errors
        content = content.replace('android:splitTypes="', 'android:splitTypes_removed="')
        content = content.replace('android:isSplitRequired="', 'android:isSplitRequired_removed="')
        
        # Ensure extractNativeLibs is present
        if 'android:extractNativeLibs' not in content:
            content = content.replace('<application ', '<application android:extractNativeLibs="true" ')
        
        with open(manifest, 'w', encoding='utf-8') as f:
            f.write(content)
    
    def repackage(self):
        """Repackage all APKs"""
        print("📦 Repackaging APKs...")
        
        # Find all decompiled directories
        apk_dirs = self.find_apk_dirs()
        if not apk_dirs:
            print("❌ No decompiled directories found!")
            return False
        
        print(f"   Found {len(apk_dirs)} APK(s)")
        
        # Extract package info from first dir
        first_manifest = apk_dirs[0] / "AndroidManifest.xml"
        if first_manifest.exists():
            with open(first_manifest, 'r') as f:
                content = f.read()
                import re
                pkg = re.search(r'package="([^"]+)"', content)
                if pkg:
                    self.package = pkg.group(1)
                vc = re.search(r'versionCode="([^"]+)"', content)
                if vc:
                    self.version_code = vc.group(1)
                vn = re.search(r'versionName="([^"]+)"', content)
                if vn:
                    self.version_name = vn.group(1)
        
        # Repackage each
        for dir_path in apk_dirs:
            name = dir_path.name
            output = self.build_dir / f"{name}.apk"
            
            # Fix manifest for split APKs
            self.fix_split_manifest(dir_path)
            
            # Check for apktool.yml
            if not (dir_path / "apktool.yml").exists():
                print(f"   ⚠️ Skipping {name} (no apktool.yml)")
                self.apks_failed.append(name)
                continue
            
            print(f"   📦 {name}...", end=" ", flush=True)
            
            # Repackage
            cmd = ['apktool', 'b', str(dir_path), '-o', str(output)]
            success = self._run_cmd(cmd, f"Building {name}")
            
            if success and output.exists():
                print("✅")
                self.apks_repackaged.append(f"{name}.apk")
            else:
                print("❌")
                self.apks_failed.append(name)
        
        return len(self.apks_repackaged) > 0
    
    def sign_apks(self):
        """Sign all APKs"""
        print("🔑 Signing APKs...")
        
        apks = list(self.build_dir.glob("*.apk"))
        if not apks:
            return False
        
        # Generate keystore
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
        
        # Sign each
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
        
        print(f"   Signed {signed}/{len(apks)} APKs")
        return signed > 0
    
    def build_xapk(self, output_name="modded_app.xapk"):
        """Build XAPK"""
        print(f"📦 Building XAPK: {output_name}")
        
        # Create manifest
        manifest = {
            "package": self.package,
            "version_code": int(self.version_code),
            "version_name": self.version_name,
            "splits": [f for f in self.apks_repackaged if f != "ins_mdm_app.apk" and f != "base.apk"],
            "obb": []
        }
        
        manifest_file = self.build_dir / "manifest.json"
        with open(manifest_file, 'w') as f:
            json.dump(manifest, f, indent=2)
        
        # Create XAPK
        try:
            with zipfile.ZipFile(output_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
                for file_path in self.build_dir.rglob("*"):
                    if file_path.is_file() and not file_path.name.endswith('.idsig'):
                        arcname = file_path.relative_to(self.build_dir)
                        zipf.write(file_path, arcname)
            
            size = os.path.getsize(output_name)
            print(f"   ✅ XAPK created: {output_name} ({size:,} bytes)")
            return True
        except Exception as e:
            print(f"❌ Failed to build XAPK: {e}")
            return False
    
    def run(self, output_name="modded_app.xapk"):
        """Run full pipeline"""
        print("=" * 40)
        print("🚀 XAPK Rebuilder")
        print("=" * 40)
        
        # Check decompiled dir
        if not self.decompiled_dir.exists():
            print(f"❌ Directory not found: {self.decompiled_dir}")
            return False
        
        # Repackage
        if not self.repackage():
            print("❌ Repackaging failed")
            return False
        
        # Sign
        if not self.sign_apks():
            print("⚠️ Signing had issues, continuing...")
        
        # Build XAPK
        if not self.build_xapk(output_name):
            return False
        
        # Summary
        print("=" * 40)
        print("✅ Done!")
        print(f"📦 Output: {output_name}")
        print(f"📱 Package: {self.package}")
        print(f"📚 APKs: {len(self.apks_repackaged)} repackaged")
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
