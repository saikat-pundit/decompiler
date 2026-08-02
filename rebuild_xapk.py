#!/usr/bin/env python3
"""
XAPK Rebuilder - Repackages decompiled APK(s) back into XAPK
Handles single APK, split APK, and missing apktool.yml automatically
"""

import os
import sys
import subprocess
import shutil
import json
import zipfile
import logging
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Tuple, Any

class XAPKRebuilder:
    """Rebuild XAPK from decompiled APK structure"""
    
    def __init__(self, decompiled_dir: str = "decompiled", output_dir: str = "workspace"):
        self.decompiled_dir = Path(decompiled_dir)
        self.output_dir = Path(output_dir)
        self.xapk_build_dir = self.output_dir / "xapk_build"
        self.logs_dir = self.output_dir / "logs"
        
        # Create directories
        self.xapk_build_dir.mkdir(parents=True, exist_ok=True)
        self.logs_dir.mkdir(parents=True, exist_ok=True)
        
        # Setup logging
        self._setup_logging()
        
        # Store build info
        self.build_info = {
            "success": False,
            "apks_repackaged": [],
            "apks_failed": [],
            "has_splits": False,
            "has_obb": False,
            "package_name": "unknown",
            "version_code": "1",
            "version_name": "1.0"
        }
    
    def _setup_logging(self):
        """Configure logging"""
        log_file = self.logs_dir / f"rebuild_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
        
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler(sys.stdout)
            ]
        )
        self.logger = logging.getLogger(__name__)
        self.logger.info(f"🔧 XAPK Rebuilder initialized")
        self.logger.info(f"📝 Log file: {log_file}")
    
    def _run_command(self, cmd: List[str], description: str = "") -> Tuple[bool, str]:
        """Run a shell command and return result"""
        self.logger.info(f"🔄 Running: {' '.join(cmd)}")
        if description:
            self.logger.info(f"📝 {description}")
        
        try:
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                check=False
            )
            
            output = result.stdout + result.stderr
            
            if result.returncode == 0:
                self.logger.info(f"✅ Command successful")
                return True, output
            else:
                self.logger.error(f"❌ Command failed with code {result.returncode}")
                if result.stderr:
                    self.logger.error(f"Error: {result.stderr[:500]}")
                return False, output
                
        except Exception as e:
            self.logger.error(f"❌ Exception: {str(e)}")
            return False, str(e)
    
    def check_dependencies(self) -> bool:
        """Check if required tools are installed"""
        self.logger.info("🔍 Checking dependencies...")
        
        tools = {
            'apktool': 'apktool --version',
            'java': 'java -version',
            'apksigner': 'apksigner --version'
        }
        
        missing = []
        for tool, cmd in tools.items():
            try:
                subprocess.run(cmd.split(), capture_output=True, check=True)
                self.logger.info(f"✅ {tool} found")
            except:
                self.logger.warning(f"⚠️ {tool} not found")
                missing.append(tool)
        
        if missing:
            self.logger.error(f"❌ Missing tools: {', '.join(missing)}")
            return False
        
        return True
    
    def validate_structure(self) -> bool:
        """Validate the decompiled directory structure"""
        self.logger.info("🔍 Validating decompiled structure...")
        
        if not self.decompiled_dir.exists():
            self.logger.error(f"❌ Decompiled directory not found: {self.decompiled_dir}")
            return False
        
        self.logger.info(f"📂 Checking: {self.decompiled_dir}")
        
        # Check for AndroidManifest.xml
        manifest_path = self.decompiled_dir / "AndroidManifest.xml"
        if not manifest_path.exists():
            self.logger.error("❌ AndroidManifest.xml not found!")
            return False
        self.logger.info("✅ AndroidManifest.xml found")
        
        # Extract package info
        self._extract_package_info(manifest_path)
        
        # Check for apktool.yml - create if missing
        apktool_yml = self.decompiled_dir / "apktool.yml"
        if not apktool_yml.exists():
            self.logger.warning("⚠️ apktool.yml not found! Creating it...")
            self._create_apktool_yml()
        else:
            self.logger.info("✅ apktool.yml found")
        
        # Check structure type
        self._detect_structure_type()
        
        return True
    
    def _extract_package_info(self, manifest_path: Path):
        """Extract package info from AndroidManifest.xml"""
        try:
            with open(manifest_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Extract package name
            import re
            package_match = re.search(r'package="([^"]+)"', content)
            if package_match:
                self.build_info["package_name"] = package_match.group(1)
            
            version_code_match = re.search(r'versionCode="([^"]+)"', content)
            if version_code_match:
                self.build_info["version_code"] = version_code_match.group(1)
            
            version_name_match = re.search(r'versionName="([^"]+)"', content)
            if version_name_match:
                self.build_info["version_name"] = version_name_match.group(1)
            
            self.logger.info(f"📊 Package: {self.build_info['package_name']}")
            self.logger.info(f"📊 Version: {self.build_info['version_name']} ({self.build_info['version_code']})")
            
        except Exception as e:
            self.logger.warning(f"⚠️ Could not extract package info: {e}")
    
    def _create_apktool_yml(self):
        """Create apktool.yml from AndroidManifest.xml"""
        manifest_path = self.decompiled_dir / "AndroidManifest.xml"
        
        try:
            with open(manifest_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            import re
            min_sdk = re.search(r'minSdkVersion="([^"]+)"', content)
            target_sdk = re.search(r'targetSdkVersion="([^"]+)"', content)
            
            apktool_yml_content = f"""version: 2.0.0
apkFileName: app.apk
isFrameworkApk: false
usesFramework:
  ids:
  - 1
sdkInfo:
  minSdkVersion: '{min_sdk.group(1) if min_sdk else '21'}'
  targetSdkVersion: '{target_sdk.group(1) if target_sdk else '30'}'
packageInfo:
  forcedPackageId: '127'
  renameManifestPackage: null
versionInfo:
  versionCode: '{self.build_info['version_code']}'
  versionName: '{self.build_info['version_name']}'
compressionType: false
sharedLibrary: false
unknownFiles: {{}}
doNotCompress: null
"""
            
            apktool_yml_path = self.decompiled_dir / "apktool.yml"
            with open(apktool_yml_path, 'w', encoding='utf-8') as f:
                f.write(apktool_yml_content)
            
            self.logger.info("✅ apktool.yml created successfully!")
            
        except Exception as e:
            self.logger.error(f"❌ Failed to create apktool.yml: {e}")
    
    def _detect_structure_type(self):
        """Detect if this is a split APK structure"""
        # Check for splits directory
        splits_dir = self.decompiled_dir / "splits"
        if splits_dir.exists() and any(splits_dir.iterdir()):
            self.build_info["has_splits"] = True
            self.logger.info("🔄 Split APK structure detected (splits/)")
            return
        
        # Check for split_* directories
        split_dirs = list(self.decompiled_dir.glob("split_*"))
        if split_dirs:
            self.build_info["has_splits"] = True
            self.logger.info(f"🔄 Split APK structure detected ({len(split_dirs)} splits)")
            return
        
        # Check for architecture-specific libs
        lib_dir = self.decompiled_dir / "lib"
        if lib_dir.exists():
            archs = [d.name for d in lib_dir.iterdir() if d.is_dir()]
            if len(archs) > 1:
                self.logger.info(f"📚 Multi-architecture libraries found: {', '.join(archs)}")
            elif len(archs) == 1:
                self.logger.info(f"📚 Single architecture: {archs[0]}")
            else:
                self.logger.info("ℹ️ No native libraries found")
        
        self.logger.info("📱 Single APK structure detected")
    
    def repackage_apks(self) -> bool:
        """Repackage all APKs in the decompiled structure"""
        self.logger.info("📦 Repackaging APKs...")
        
        # Clean build directory
        shutil.rmtree(self.xapk_build_dir, ignore_errors=True)
        self.xapk_build_dir.mkdir(parents=True, exist_ok=True)
        
        if self.build_info["has_splits"]:
            return self._repackage_splits()
        else:
            return self._repackage_single()
    
    def _repackage_single(self) -> bool:
        """Repackage a single APK"""
        self.logger.info("📦 Repackaging single APK...")
        
        apktool_yml = self.decompiled_dir / "apktool.yml"
        if not apktool_yml.exists():
            self.logger.error("❌ apktool.yml not found!")
            return False
        
        cmd = [
            'apktool', 'b',
            str(self.decompiled_dir),
            '-o',
            str(self.xapk_build_dir / 'base.apk')
        ]
        
        success, output = self._run_command(cmd, "Repackaging APK")
        
        if success:
            self.build_info["apks_repackaged"].append("base.apk")
            self.logger.info("✅ Single APK repackaged successfully")
            return True
        else:
            self.logger.error("❌ Failed to repackage APK")
            return False
    
    def _repackage_splits(self) -> bool:
        """Repackage split APKs"""
        self.logger.info("📦 Repackaging split APKs...")
        
        success_count = 0
        total_count = 0
        
        # Check for splits directory
        splits_dir = self.decompiled_dir / "splits"
        if splits_dir.exists():
            for split_dir in splits_dir.iterdir():
                if split_dir.is_dir():
                    total_count += 1
                    split_name = split_dir.name
                    self.logger.info(f"  📦 Repackaging split: {split_name}")
                    
                    # Check for apktool.yml
                    if not (split_dir / "apktool.yml").exists():
                        self.logger.warning(f"  ⚠️ Skipping {split_name} (no apktool.yml)")
                        continue
                    
                    cmd = [
                        'apktool', 'b',
                        str(split_dir),
                        '-o',
                        str(self.xapk_build_dir / f'{split_name}.apk')
                    ]
                    
                    success, output = self._run_command(cmd, f"Repackaging {split_name}")
                    
                    if success:
                        self.build_info["apks_repackaged"].append(f"{split_name}.apk")
                        success_count += 1
                    else:
                        self.build_info["apks_failed"].append(split_name)
            
            # Repackage base
            if (self.decompiled_dir / "apktool.yml").exists():
                self.logger.info("  📦 Repackaging base APK")
                cmd = [
                    'apktool', 'b',
                    str(self.decompiled_dir),
                    '-o',
                    str(self.xapk_build_dir / 'base.apk')
                ]
                success, output = self._run_command(cmd, "Repackaging base")
                if success:
                    self.build_info["apks_repackaged"].append("base.apk")
                    success_count += 1
        
        # Check for split_* directories
        split_dirs = list(self.decompiled_dir.glob("split_*"))
        if split_dirs:
            for split_dir in split_dirs:
                if split_dir.is_dir():
                    total_count += 1
                    split_name = split_dir.name
                    self.logger.info(f"  📦 Repackaging split: {split_name}")
                    
                    if not (split_dir / "apktool.yml").exists():
                        self.logger.warning(f"  ⚠️ Skipping {split_name} (no apktool.yml)")
                        continue
                    
                    cmd = [
                        'apktool', 'b',
                        str(split_dir),
                        '-o',
                        str(self.xapk_build_dir / f'{split_name}.apk')
                    ]
                    
                    success, output = self._run_command(cmd, f"Repackaging {split_name}")
                    
                    if success:
                        self.build_info["apks_repackaged"].append(f"{split_name}.apk")
                        success_count += 1
                    else:
                        self.build_info["apks_failed"].append(split_name)
        
        self.logger.info(f"✅ Repackaged {success_count}/{total_count} splits")
        return success_count > 0
    
    def sign_apks(self) -> bool:
        """Sign all repackaged APKs"""
        self.logger.info("🔑 Signing APKs...")
        
        apks = list(self.xapk_build_dir.glob("*.apk"))
        if not apks:
            self.logger.error("❌ No APKs to sign!")
            return False
        
        # Generate keystore if needed
        keystore_path = self.output_dir / "debug.keystore"
        if not keystore_path.exists():
            self._generate_keystore(keystore_path)
        
        success_count = 0
        for apk in apks:
            self.logger.info(f"  Signing: {apk.name}")
            cmd = [
                'apksigner', 'sign',
                '--ks', str(keystore_path),
                '--ks-key-alias', 'debug',
                '--ks-pass', 'pass:android',
                '--key-pass', 'pass:android',
                str(apk)
            ]
            
            success, output = self._run_command(cmd, f"Signing {apk.name}")
            if success:
                success_count += 1
        
        self.logger.info(f"✅ Signed {success_count}/{len(apks)} APKs")
        return success_count == len(apks)
    
    def _generate_keystore(self, keystore_path: Path):
        """Generate debug keystore"""
        self.logger.info("🔑 Generating debug keystore...")
        
        cmd = [
            'keytool', '-genkey', '-v',
            '-keystore', str(keystore_path),
            '-alias', 'debug',
            '-keyalg', 'RSA',
            '-keysize', '2048',
            '-validity', '10000',
            '-storepass', 'android',
            '-keypass', 'android',
            '-dname', 'CN=Debug, OU=Debug, O=Debug, L=Debug, ST=Debug, C=US'
        ]
        
        success, output = self._run_command(cmd, "Generating keystore")
        return success
    
    def create_manifest(self) -> bool:
        """Create XAPK manifest.json"""
        self.logger.info("📝 Creating XAPK manifest...")
        
        manifest_data = {
            "package": self.build_info["package_name"],
            "version_code": int(self.build_info["version_code"]),
            "version_name": self.build_info["version_name"],
            "splits": [],
            "obb": []
        }
        
        # Add splits
        apks = list(self.xapk_build_dir.glob("*.apk"))
        for apk in apks:
            if apk.name != "base.apk":
                manifest_data["splits"].append(apk.name)
        
        # Check for OBB files
        obb_files = list(self.xapk_build_dir.glob("*.obb"))
        if obb_files:
            manifest_data["obb"] = [f.name for f in obb_files]
            self.build_info["has_obb"] = True
            self.logger.info(f"🎮 Found {len(obb_files)} OBB files")
        
        # Write manifest
        manifest_path = self.xapk_build_dir / "manifest.json"
        with open(manifest_path, 'w', encoding='utf-8') as f:
            json.dump(manifest_data, f, indent=2)
        
        self.logger.info("✅ Manifest created")
        self.logger.info(json.dumps(manifest_data, indent=2))
        return True
    
    def build_xapk(self, xapk_name: str = "modded_app.xapk") -> bool:
        """Build the final XAPK file"""
        self.logger.info(f"📦 Building XAPK: {xapk_name}")
        
        # Check if we have files to package
        files = list(self.xapk_build_dir.glob("*"))
        if not files:
            self.logger.error("❌ No files to package!")
            return False
        
        # Create XAPK
        try:
            with zipfile.ZipFile(xapk_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
                for file_path in self.xapk_build_dir.rglob("*"):
                    if file_path.is_file():
                        arcname = file_path.relative_to(self.xapk_build_dir)
                        zipf.write(file_path, arcname)
            
            self.logger.info(f"✅ XAPK built successfully: {xapk_name}")
            self.logger.info(f"📊 Size: {os.path.getsize(xapk_name):,} bytes")
            return True
            
        except Exception as e:
            self.logger.error(f"❌ Failed to build XAPK: {e}")
            return False
    
    def verify_xapk(self, xapk_name: str) -> bool:
        """Verify the XAPK file"""
        self.logger.info("🔍 Verifying XAPK...")
        
        if not os.path.exists(xapk_name):
            self.logger.error("❌ XAPK file not found!")
            return False
        
        try:
            with zipfile.ZipFile(xapk_name, 'r') as zipf:
                contents = zipf.namelist()
                self.logger.info(f"📂 XAPK contains {len(contents)} files:")
                for f in sorted(contents):
                    self.logger.info(f"  - {f}")
                
                # Check for manifest
                if "manifest.json" in contents:
                    self.logger.info("✅ manifest.json found")
                else:
                    self.logger.warning("⚠️ manifest.json not found!")
                
                # Check for APKs
                apks = [f for f in contents if f.endswith('.apk')]
                if apks:
                    self.logger.info(f"✅ {len(apks)} APK(s) found")
                else:
                    self.logger.warning("⚠️ No APKs found!")
            
            return True
            
        except Exception as e:
            self.logger.error(f"❌ Verification failed: {e}")
            return False
    
    def create_summary(self) -> Dict[str, Any]:
        """Create build summary"""
        summary = {
            "timestamp": datetime.now().isoformat(),
            "package": self.build_info["package_name"],
            "version": self.build_info["version_name"],
            "version_code": self.build_info["version_code"],
            "has_splits": self.build_info["has_splits"],
            "apks_repackaged": self.build_info["apks_repackaged"],
            "apks_failed": self.build_info["apks_failed"],
            "success": len(self.build_info["apks_failed"]) == 0
        }
        
        # Save summary
        summary_file = self.logs_dir / "build_summary.json"
        with open(summary_file, 'w') as f:
            json.dump(summary, f, indent=2)
        
        self.logger.info(f"📊 Summary saved: {summary_file}")
        return summary
    
    def run_full_pipeline(self, xapk_name: str = "modded_app.xapk") -> bool:
        """Run the complete XAPK rebuild pipeline"""
        self.logger.info("=" * 50)
        self.logger.info("🚀 Starting XAPK Rebuild Pipeline")
        self.logger.info("=" * 50)
        
        # Step 1: Check dependencies
        if not self.check_dependencies():
            self.logger.error("❌ Dependencies check failed!")
            return False
        
        # Step 2: Validate structure
        if not self.validate_structure():
            self.logger.error("❌ Structure validation failed!")
            return False
        
        # Step 3: Repackage APKs
        if not self.repackage_apks():
            self.logger.error("❌ Repackaging failed!")
            return False
        
        # Step 4: Sign APKs
        if not self.sign_apks():
            self.logger.warning("⚠️ Signing had issues, continuing...")
        
        # Step 5: Create manifest
        if not self.create_manifest():
            self.logger.error("❌ Manifest creation failed!")
            return False
        
        # Step 6: Build XAPK
        if not self.build_xapk(xapk_name):
            self.logger.error("❌ XAPK build failed!")
            return False
        
        # Step 7: Verify XAPK
        if not self.verify_xapk(xapk_name):
            self.logger.warning("⚠️ Verification had issues")
        
        # Step 8: Create summary
        summary = self.create_summary()
        
        self.logger.info("=" * 50)
        self.logger.info("✅ XAPK Rebuild Complete!")
        self.logger.info("=" * 50)
        self.logger.info(f"📦 Output: {xapk_name}")
        self.logger.info(f"📊 Status: {'✅ Success' if summary['success'] else '⚠️ Partial Success'}")
        self.logger.info(f"📱 Package: {summary['package']}")
        self.logger.info(f"📚 APKs: {len(summary['apks_repackaged'])} repackaged")
        
        return summary['success']

def main():
    """Main entry point"""
    import argparse
    
    parser = argparse.ArgumentParser(description='XAPK Rebuilder Tool')
    parser.add_argument('--decompiled-dir', help='Decompiled directory', default='decompiled')
    parser.add_argument('--output', help='Output XAPK name', default='modded_app.xapk')
    parser.add_argument('--work-dir', help='Working directory', default='workspace')
    
    args = parser.parse_args()
    
    # Run rebuilder
    rebuilder = XAPKRebuilder(args.decompiled_dir, args.work_dir)
    
    try:
        success = rebuilder.run_full_pipeline(args.output)
        sys.exit(0 if success else 1)
    except Exception as e:
        print(f"❌ Fatal error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
