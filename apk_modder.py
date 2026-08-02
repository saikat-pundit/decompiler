#!/usr/bin/env python3
"""
Robust APK Modding Tool
Decompiles, applies modifications, and repackages APKs
"""

import os
import sys
import subprocess
import shutil
import json
import re
import logging
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Tuple

class APKModder:
    """Main class for APK modification operations"""
    
    def __init__(self, apk_path: str, work_dir: str = "workspace"):
        self.apk_path = Path(apk_path)
        self.work_dir = Path(work_dir)
        self.decompiled_dir = self.work_dir / "decompiled"
        self.output_dir = self.work_dir / "output"
        self.logs_dir = self.work_dir / "logs"
        self.mod_dir = Path("mods")
        
        # Setup logging
        self._setup_logging()
        
        # Check if APK exists
        if not self.apk_path.exists():
            raise FileNotFoundError(f"APK not found: {apk_path}")
    
    def _setup_logging(self):
        """Configure logging"""
        self.logs_dir.mkdir(parents=True, exist_ok=True)
        log_file = self.logs_dir / f"apk_mod_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
        
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler(sys.stdout)
            ]
        )
        self.logger = logging.getLogger(__name__)
        self.logger.info(f"🔧 APK Modder initialized - Log: {log_file}")
    
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
                self.logger.error(f"Error: {result.stderr}")
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
            'zipalign': 'zipalign -h',
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
            self.logger.info("💡 Install: apktool, android-sdk (zipalign, apksigner)")
            return False
        
        return True
    
    def decompile(self) -> bool:
        """Decompile APK using apktool"""
        self.logger.info("📦 Starting decompilation...")
        
        # Clean previous decompilation
        if self.decompiled_dir.exists():
            self.logger.info("🧹 Removing old decompiled directory")
            shutil.rmtree(self.decompiled_dir)
        
        self.decompiled_dir.mkdir(parents=True, exist_ok=True)
        
        # Run apktool decompile
        cmd = [
            'apktool',
            'd',
            str(self.apk_path),
            '-o',
            str(self.decompiled_dir),
            '-f'  # Force overwrite
        ]
        
        success, output = self._run_command(cmd, "Decompiling APK")
        
        if success:
            self.logger.info("✅ Decompilation successful!")
            self._log_decompiled_structure()
            return True
        else:
            self.logger.error("❌ Decompilation failed!")
            return False
    
    def _log_decompiled_structure(self):
        """Log the structure of decompiled files"""
        if not self.decompiled_dir.exists():
            return
        
        self.logger.info("📁 Decompiled Structure:")
        items = list(self.decompiled_dir.iterdir())
        for item in sorted(items):
            if item.is_dir():
                self.logger.info(f"  📂 {item.name}/")
            else:
                size = item.stat().st_size
                self.logger.info(f"  📄 {item.name} ({size:,} bytes)")
    
    def apply_modifications(self, mods_config: Optional[Dict] = None) -> bool:
        """Apply modifications from config or default patterns"""
        self.logger.info("🔧 Applying modifications...")
        
        if not self.decompiled_dir.exists():
            self.logger.error("❌ Decompiled directory not found!")
            return False
        
        # Load modification configuration
        if mods_config is None:
            mods_config = self._load_default_mods()
        
        success_count = 0
        total_mods = 0
        
        # Apply each type of modification
        for mod_type, config in mods_config.items():
            if mod_type == 'manifest':
                total_mods += 1
                if self._modify_manifest(config):
                    success_count += 1
            
            elif mod_type == 'strings':
                total_mods += 1
                if self._modify_strings(config):
                    success_count += 1
            
            elif mod_type == 'smali':
                total_mods += len(config.get('files', []))
                success_count += self._modify_smali(config)
            
            elif mod_type == 'copy_files':
                total_mods += 1
                if self._copy_custom_files(config):
                    success_count += 1
            
            elif mod_type == 'delete_files':
                total_mods += 1
                if self._delete_files(config):
                    success_count += 1
        
        self.logger.info(f"✅ Applied {success_count}/{total_mods} modifications")
        return success_count > 0
    
    def _load_default_mods(self) -> Dict:
        """Load default modifications from mods directory"""
        default_mods = {
            'manifest': {
                'remove_permissions': [],
                'add_permissions': [],
                'modify_attributes': {}
            },
            'strings': {
                'replacements': {}
            },
            'smali': {
                'files': []
            },
            'copy_files': {
                'source_dir': 'mods/custom_files',
                'target_dir': 'decompiled/res'
            }
        }
        
        # Check if mods directory exists
        if self.mod_dir.exists():
            mods_json = self.mod_dir / 'mods_config.json'
            if mods_json.exists():
                try:
                    with open(mods_json, 'r') as f:
                        custom_mods = json.load(f)
                        # Merge with defaults
                        for key in default_mods:
                            if key in custom_mods:
                                default_mods[key].update(custom_mods[key])
                    self.logger.info(f"📝 Loaded custom mods from {mods_json}")
                except Exception as e:
                    self.logger.warning(f"⚠️ Could not load mods config: {e}")
        
        return default_mods
    
    def _modify_manifest(self, config: Dict) -> bool:
        """Modify AndroidManifest.xml"""
        manifest_path = self.decompiled_dir / 'AndroidManifest.xml'
        if not manifest_path.exists():
            self.logger.warning("⚠️ AndroidManifest.xml not found")
            return False
        
        self.logger.info("📝 Modifying AndroidManifest.xml")
        
        try:
            with open(manifest_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Remove permissions
            for permission in config.get('remove_permissions', []):
                pattern = rf'<uses-permission\s+android:name="{permission}"\s*/>'
                content = re.sub(pattern, '', content)
                self.logger.info(f"  🗑️ Removed permission: {permission}")
            
            # Add permissions
            for permission in config.get('add_permissions', []):
                perm_line = f'<uses-permission android:name="{permission}" />'
                # Insert before closing manifest tag
                content = content.replace('</manifest>', f'    {perm_line}\n</manifest>')
                self.logger.info(f"  ➕ Added permission: {permission}")
            
            # Modify attributes
            for attr, value in config.get('modify_attributes', {}).items():
                content = re.sub(
                    rf'{attr}="[^"]*"',
                    f'{attr}="{value}"',
                    content
                )
                self.logger.info(f"  ✏️ Modified {attr} = {value}")
            
            # Write back
            with open(manifest_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            return True
            
        except Exception as e:
            self.logger.error(f"❌ Failed to modify manifest: {e}")
            return False
    
    def _modify_strings(self, config: Dict) -> bool:
        """Modify strings.xml files"""
        strings_dir = self.decompiled_dir / 'res' / 'values'
        if not strings_dir.exists():
            self.logger.warning("⚠️ strings.xml directory not found")
            return False
        
        replacements = config.get('replacements', {})
        if not replacements:
            self.logger.info("ℹ️ No string replacements defined")
            return True
        
        self.logger.info("📝 Modifying strings.xml")
        
        try:
            for strings_file in strings_dir.glob('strings*.xml'):
                self.logger.info(f"  📄 Processing: {strings_file.name}")
                
                with open(strings_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                for original, replacement in replacements.items():
                    pattern = rf'<string name="[^"]*">{re.escape(original)}</string>'
                    replacement_tag = f'<string name="\\1">{replacement}</string>'
                    content = re.sub(
                        r'<string name="([^"]*)">' + re.escape(original) + r'</string>',
                        f'<string name="\\1">{replacement}</string>',
                        content
                    )
                    self.logger.info(f"  ✏️ Replaced: '{original}' -> '{replacement}'")
                
                with open(strings_file, 'w', encoding='utf-8') as f:
                    f.write(content)
            
            return True
            
        except Exception as e:
            self.logger.error(f"❌ Failed to modify strings: {e}")
            return False
    
    def _modify_smali(self, config: Dict) -> int:
        """Modify smali files"""
        smali_dir = self.decompiled_dir / 'smali'
        if not smali_dir.exists():
            self.logger.warning("⚠️ smali directory not found")
            return 0
        
        modified_count = 0
        files_to_modify = config.get('files', [])
        self.logger.info(f"📝 Modifying {len(files_to_modify)} smali files")
        
        for file_config in files_to_modify:
            file_path = smali_dir / file_config.get('path', '')
            if not file_path.exists():
                self.logger.warning(f"  ⚠️ File not found: {file_path}")
                continue
            
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Apply replacements
                for replacement in file_config.get('replacements', []):
                    pattern = replacement.get('pattern', '')
                    replacement_text = replacement.get('replacement', '')
                    content = re.sub(pattern, replacement_text, content)
                    self.logger.info(f"  ✏️ Modified {file_path.name}: {pattern}")
                
                # Apply insertions
                for insertion in file_config.get('insertions', []):
                    before = insertion.get('before', '')
                    text = insertion.get('text', '')
                    content = content.replace(before, before + text)
                    self.logger.info(f"  ➕ Inserted into {file_path.name}")
                
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                modified_count += 1
                
            except Exception as e:
                self.logger.error(f"  ❌ Failed to modify {file_path}: {e}")
        
        return modified_count
    
    def _copy_custom_files(self, config: Dict) -> bool:
        """Copy custom files into decompiled structure"""
        source_dir = Path(config.get('source_dir', 'mods/custom_files'))
        target_dir = self.decompiled_dir / config.get('target_dir', 'res')
        
        if not source_dir.exists():
            self.logger.info(f"ℹ️ No custom files to copy from {source_dir}")
            return True
        
        self.logger.info(f"📁 Copying files from {source_dir} to {target_dir}")
        
        try:
            # Create target directory if it doesn't exist
            target_dir.mkdir(parents=True, exist_ok=True)
            
            # Copy all files
            for item in source_dir.rglob('*'):
                if item.is_file():
                    relative_path = item.relative_to(source_dir)
                    target_path = target_dir / relative_path
                    target_path.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(item, target_path)
                    self.logger.info(f"  ✅ Copied: {relative_path}")
            
            return True
            
        except Exception as e:
            self.logger.error(f"❌ Failed to copy files: {e}")
            return False
    
    def _delete_files(self, config: Dict) -> bool:
        """Delete files from decompiled structure"""
        files_to_delete = config.get('files', [])
        self.logger.info(f"🗑️ Deleting {len(files_to_delete)} files")
        
        for file_pattern in files_to_delete:
            try:
                # Support glob patterns
                for file_path in self.decompiled_dir.glob(file_pattern):
                    if file_path.is_file():
                        file_path.unlink()
                        self.logger.info(f"  🗑️ Deleted: {file_path}")
                    elif file_path.is_dir():
                        shutil.rmtree(file_path)
                        self.logger.info(f"  🗑️ Deleted directory: {file_path}")
            except Exception as e:
                self.logger.error(f"  ❌ Failed to delete {file_pattern}: {e}")
        
        return True
    
    def repackage(self) -> bool:
        """Repackage decompiled files into APK"""
        self.logger.info("📦 Repackaging APK...")
        
        if not self.decompiled_dir.exists():
            self.logger.error("❌ Decompiled directory not found!")
            return False
        
        self.output_dir.mkdir(parents=True, exist_ok=True)
        
        apk_path = self.output_dir / 'my_app_unsigned.apk'
        
        cmd = [
            'apktool',
            'b',
            str(self.decompiled_dir),
            '-o',
            str(apk_path)
        ]
        
        success, output = self._run_command(cmd, "Repackaging APK")
        
        if success:
            self.logger.info(f"✅ Repackaged successfully: {apk_path}")
            self.logger.info(f"📦 Size: {apk_path.stat().st_size:,} bytes")
            return True
        else:
            self.logger.error("❌ Repackaging failed!")
            return False
    
    def align_apk(self) -> bool:
        """Align APK using zipalign"""
        self.logger.info("📐 Aligning APK...")
        
        unsigned = self.output_dir / 'my_app_unsigned.apk'
        if not unsigned.exists():
            self.logger.error("❌ Unsigned APK not found!")
            return False
        
        aligned = self.output_dir / 'my_app_aligned.apk'
        
        cmd = [
            'zipalign',
            '-v',
            '-p',
            '4',
            str(unsigned),
            str(aligned)
        ]
        
        success, output = self._run_command(cmd, "Aligning APK")
        
        if success:
            self.logger.info(f"✅ Aligned successfully: {aligned}")
            return True
        else:
            self.logger.error("❌ Alignment failed!")
            return False
    
    def sign_apk(self, keystore_path: Optional[str] = None) -> bool:
        """Sign APK using apksigner"""
        self.logger.info("🔑 Signing APK...")
        
        aligned = self.output_dir / 'my_app_aligned.apk'
        if not aligned.exists():
            self.logger.error("❌ Aligned APK not found!")
            return False
        
        # Use provided keystore or generate debug keystore
        if keystore_path is None:
            keystore_path = self.work_dir / 'debug.keystore'
            if not keystore_path.exists():
                self._generate_debug_keystore(keystore_path)
        
        signed = self.output_dir / 'my_app_signed.apk'
        
        cmd = [
            'apksigner',
            'sign',
            '--ks',
            str(keystore_path),
            '--ks-key-alias',
            'debug',
            '--ks-pass',
            'pass:android',
            '--key-pass',
            'pass:android',
            '--out',
            str(signed),
            str(aligned)
        ]
        
        success, output = self._run_command(cmd, "Signing APK")
        
        if success:
            self.logger.info(f"✅ Signed successfully: {signed}")
            self.logger.info(f"📦 Size: {signed.stat().st_size:,} bytes")
            
            # Verify signature
            self._verify_apk(signed)
            return True
        else:
            self.logger.error("❌ Signing failed!")
            return False
    
    def _generate_debug_keystore(self, keystore_path: Path):
        """Generate a debug keystore"""
        self.logger.info("🔑 Generating debug keystore...")
        
        cmd = [
            'keytool',
            '-genkey',
            '-v',
            '-keystore',
            str(keystore_path),
            '-alias',
            'debug',
            '-keyalg',
            'RSA',
            '-keysize',
            '2048',
            '-validity',
            '10000',
            '-storepass',
            'android',
            '-keypass',
            'android',
            '-dname',
            'CN=Debug, OU=Debug, O=Debug, L=Debug, ST=Debug, C=US'
        ]
        
        success, output = self._run_command(cmd, "Generating keystore")
        return success
    
    def _verify_apk(self, apk_path: Path) -> bool:
        """Verify APK signature"""
        self.logger.info("🔍 Verifying APK signature...")
        
        cmd = ['apksigner', 'verify', str(apk_path)]
        success, output = self._run_command(cmd, "Verifying APK")
        
        if success:
            self.logger.info("✅ APK verification passed!")
            # Parse verification output
            for line in output.split('\n'):
                if 'Verified' in line:
                    self.logger.info(f"  {line.strip()}")
        else:
            self.logger.warning("⚠️ APK verification failed!")
        
        return success
    
    def create_summary(self) -> Dict:
        """Create summary of all operations"""
        summary = {
            'timestamp': datetime.now().isoformat(),
            'apk_original': str(self.apk_path),
            'apk_original_size': self.apk_path.stat().st_size,
            'decompiled_dir': str(self.decompiled_dir),
            'output_dir': str(self.output_dir),
            'files': {
                'unsigned': str(self.output_dir / 'my_app_unsigned.apk'),
                'aligned': str(self.output_dir / 'my_app_aligned.apk'),
                'signed': str(self.output_dir / 'my_app_signed.apk'),
            },
            'success': False
        }
        
        # Check if signed APK exists
        signed = self.output_dir / 'my_app_signed.apk'
        if signed.exists():
            summary['success'] = True
            summary['apk_final_size'] = signed.stat().st_size
            summary['apk_final'] = str(signed)
        
        # Save summary
        summary_file = self.logs_dir / 'summary.json'
        with open(summary_file, 'w') as f:
            json.dump(summary, f, indent=2)
        
        self.logger.info(f"📊 Summary saved: {summary_file}")
        return summary
    
    def run_full_pipeline(self, mods_config: Optional[Dict] = None) -> bool:
        """Run the complete APK modding pipeline"""
        self.logger.info("🚀 Starting full APK modding pipeline")
        self.logger.info("=" * 50)
        
        # Step 1: Check dependencies
        if not self.check_dependencies():
            return False
        
        # Step 2: Decompile
        if not self.decompile():
            return False
        
        # Step 3: Apply modifications
        if not self.apply_modifications(mods_config):
            self.logger.warning("⚠️ No modifications applied or some failed")
        
        # Step 4: Repackage
        if not self.repackage():
            return False
        
        # Step 5: Align
        if not self.align_apk():
            return False
        
        # Step 6: Sign
        if not self.sign_apk():
            return False
        
        # Step 7: Create summary
        summary = self.create_summary()
        
        self.logger.info("=" * 50)
        self.logger.info("✅ APK Modding Pipeline Completed Successfully!")
        self.logger.info(f"📦 Final APK: {summary['apk_final']}")
        self.logger.info(f"📊 Size: {summary['apk_final_size']:,} bytes")
        
        return True
    
    def cleanup(self):
        """Clean up temporary files"""
        self.logger.info("🧹 Cleaning up...")
        # Keep decompiled and output, remove any temp files
        # Implementation depends on your needs

def main():
    """Main entry point"""
    import argparse
    
    parser = argparse.ArgumentParser(description='APK Modding Tool')
    parser.add_argument('apk', help='Path to APK file', default='my.apk', nargs='?')
    parser.add_argument('--config', help='Path to mods config JSON file')
    parser.add_argument('--work-dir', help='Working directory', default='workspace')
    parser.add_argument('--no-cleanup', help='Don\'t clean up after', action='store_true')
    parser.add_argument('--skip-sign', help='Skip signing', action='store_true')
    
    args = parser.parse_args()
    
    # Load mods config if provided
    mods_config = None
    if args.config:
        with open(args.config, 'r') as f:
            mods_config = json.load(f)
    
    # Initialize and run
    modder = APKModder(args.apk, args.work_dir)
    
    try:
        success = modder.run_full_pipeline(mods_config)
        sys.exit(0 if success else 1)
    except Exception as e:
        modder.logger.error(f"❌ Fatal error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
