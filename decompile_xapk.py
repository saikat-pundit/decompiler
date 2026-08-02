#!/usr/bin/env python3
"""
XAPK Decompiler - Extract and decompile XAPK files properly
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
from typing import List, Dict, Optional, Tuple

class XAPKDecompiler:
    """Complete XAPK decompiler with split APK support"""
    
    def __init__(self, xapk_path: str, output_dir: str = "decompiled_output"):
        self.xapk_path = Path(xapk_path)
        self.output_dir = Path(output_dir)
        self.extract_dir = self.output_dir / "extracted"
        self.decompiled_dir = self.output_dir / "decompiled"
        self.logs_dir = self.output_dir / "logs"
        
        # Create directories
        self.extract_dir.mkdir(parents=True, exist_ok=True)
        self.decompiled_dir.mkdir(parents=True, exist_ok=True)
        self.logs_dir.mkdir(parents=True, exist_ok=True)
        
        # Setup logging
        self._setup_logging()
        
        # Check if XAPK exists
        if not self.xapk_path.exists():
            raise FileNotFoundError(f"XAPK not found: {xapk_path}")
    
    def _setup_logging(self):
        """Configure logging"""
        log_file = self.logs_dir / f"xapk_decompile_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
        
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler(sys.stdout)
            ]
        )
        self.logger = logging.getLogger(__name__)
        self.logger.info(f"🔧 XAPK Decompiler initialized")
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
    
    def extract_xapk(self) -> bool:
        """Extract XAPK file"""
        self.logger.info("📦 Extracting XAPK...")
        
        try:
            with zipfile.ZipFile(self.xapk_path, 'r') as zip_ref:
                zip_ref.extractall(self.extract_dir)
            
            self.logger.info(f"✅ XAPK extracted to: {self.extract_dir}")
            
            # List contents
            self.logger.info("📁 Extracted contents:")
            for item in sorted(self.extract_dir.iterdir()):
                if item.is_dir():
                    self.logger.info(f"  📂 {item.name}/")
                else:
                    size = item.stat().st_size
                    self.logger.info(f"  📄 {item.name} ({size:,} bytes)")
            
            return True
            
        except Exception as e:
            self.logger.error(f"❌ Failed to extract XAPK: {e}")
            return False
    
    def find_apk_files(self) -> List[Path]:
        """Find all APK files in extracted contents"""
        apk_files = list(self.extract_dir.glob("*.apk"))
        self.logger.info(f"📱 Found {len(apk_files)} APK files:")
        for apk in apk_files:
            size = apk.stat().st_size
            self.logger.info(f"  - {apk.name} ({size:,} bytes)")
        return apk_files
    
    def decompile_apk(self, apk_path: Path, output_name: str = None) -> bool:
        """Decompile a single APK using apktool"""
        if output_name is None:
            output_name = apk_path.stem
        
        output_dir = self.decompiled_dir / output_name
        
        # Clean previous decompilation
        if output_dir.exists():
            self.logger.info(f"🧹 Removing old decompiled: {output_dir}")
            shutil.rmtree(output_dir)
        
        self.logger.info(f"🔍 Decompiling: {apk_path.name}")
        
        cmd = [
            'apktool',
            'd',
            str(apk_path),
            '-o',
            str(output_dir),
            '-f'
        ]
        
        success, output = self._run_command(cmd, f"Decompiling {apk_path.name}")
        
        if success:
            self.logger.info(f"✅ Decompiled to: {output_dir}")
            return True
        else:
            self.logger.error(f"❌ Failed to decompile: {apk_path.name}")
            return False
    
    def decompile_all_apks(self) -> Dict[str, bool]:
        """Decompile all APK files found in extracted XAPK"""
        apk_files = self.find_apk_files()
        
        if not apk_files:
            self.logger.error("❌ No APK files found in extracted XAPK!")
            return {}
        
        results = {}
        for apk_path in apk_files:
            # Special handling for architecture splits
            if 'arm64' in apk_path.name.lower() or 'v8a' in apk_path.name.lower():
                output_name = "arm64_split"
            elif 'armeabi' in apk_path.name.lower() or 'v7a' in apk_path.name.lower():
                output_name = "armv7_split"
            elif 'x86' in apk_path.name.lower():
                output_name = "x86_split"
            elif 'base' in apk_path.name.lower():
                output_name = "base"
            else:
                output_name = apk_path.stem.replace('.', '_')
            
            results[apk_path.name] = self.decompile_apk(apk_path, output_name)
        
        return results
    
    def analyze_structure(self) -> Dict:
        """Analyze the decompiled structure"""
        self.logger.info("🔍 Analyzing decompiled structure...")
        
        analysis = {
            "total_apks": 0,
            "architectures": [],
            "libraries": {},
            "has_resources": False,
            "has_smali": False
        }
        
        for item in self.decompiled_dir.iterdir():
            if item.is_dir():
                analysis["total_apks"] += 1
                
                # Check for libs
                lib_dir = item / "lib"
                if lib_dir.exists():
                    for arch in lib_dir.iterdir():
                        if arch.is_dir():
                            arch_name = arch.name
                            if arch_name not in analysis["architectures"]:
                                analysis["architectures"].append(arch_name)
                            
                            so_files = list(arch.glob("*.so"))
                            if arch_name not in analysis["libraries"]:
                                analysis["libraries"][arch_name] = []
                            analysis["libraries"][arch_name].extend([f.name for f in so_files])
                
                # Check for resources
                if (item / "res").exists():
                    analysis["has_resources"] = True
                
                # Check for smali
                if (item / "smali").exists():
                    analysis["has_smali"] = True
        
        # Log analysis
        self.logger.info("📊 Analysis Results:")
        self.logger.info(f"  Total APKs decompiled: {analysis['total_apks']}")
        self.logger.info(f"  Architectures found: {', '.join(analysis['architectures']) if analysis['architectures'] else 'None'}")
        
        for arch, libs in analysis["libraries"].items():
            self.logger.info(f"  {arch}: {len(libs)} .so files")
        
        self.logger.info(f"  Has resources: {analysis['has_resources']}")
        self.logger.info(f"  Has smali: {analysis['has_smali']}")
        
        return analysis
    
    def create_summary(self, results: Dict) -> Dict:
        """Create a summary of the decompilation process"""
        summary = {
            "timestamp": datetime.now().isoformat(),
            "xapk_file": str(self.xapk_path),
            "xapk_size": self.xapk_path.stat().st_size,
            "extract_dir": str(self.extract_dir),
            "decompiled_dir": str(self.decompiled_dir),
            "results": results,
            "success": all(results.values())
        }
        
        # Save summary
        summary_file = self.logs_dir / "summary.json"
        with open(summary_file, 'w') as f:
            json.dump(summary, f, indent=2)
        
        self.logger.info(f"📊 Summary saved to: {summary_file}")
        return summary
    
    def run_full_pipeline(self) -> bool:
        """Run the complete XAPK decompilation pipeline"""
        self.logger.info("=" * 50)
        self.logger.info("🚀 Starting XAPK Decompilation Pipeline")
        self.logger.info("=" * 50)
        
        # Step 1: Extract XAPK
        if not self.extract_xapk():
            self.logger.error("❌ Failed to extract XAPK")
            return False
        
        # Step 2: Decompile all APKs
        results = self.decompile_all_apks()
        
        if not results:
            self.logger.error("❌ No APKs were decompiled")
            return False
        
        # Step 3: Analyze structure
        analysis = self.analyze_structure()
        
        # Step 4: Create summary
        summary = self.create_summary(results)
        
        # Step 5: Final output
        self.logger.info("=" * 50)
        self.logger.info("✅ XAPK Decompilation Complete!")
        self.logger.info("=" * 50)
        self.logger.info(f"📁 Decompiled files: {self.decompiled_dir}")
        self.logger.info(f"📊 Analysis: {analysis['total_apks']} APKs, {len(analysis['architectures'])} architectures")
        self.logger.info("=" * 50)
        
        return summary['success']

def main():
    """Main entry point"""
    import argparse
    
    parser = argparse.ArgumentParser(description='XAPK Decompiler Tool')
    parser.add_argument('xapk', help='Path to XAPK file', default='my.xapk', nargs='?')
    parser.add_argument('--output-dir', help='Output directory', default='decompiled_output')
    parser.add_argument('--verbose', help='Verbose output', action='store_true')
    
    args = parser.parse_args()
    
    # Check if apktool is available
    try:
        subprocess.run(['apktool', '--version'], capture_output=True, check=True)
    except:
        print("❌ apktool not found! Please install apktool first.")
        print("   sudo wget -O /usr/local/bin/apktool.jar https://github.com/iBotPeaches/Apktool/releases/download/v3.0.3/apktool_3.0.3.jar")
        print("   sudo wget -O /usr/local/bin/apktool https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool")
        print("   sudo chmod +x /usr/local/bin/apktool /usr/local/bin/apktool.jar")
        sys.exit(1)
    
    # Run decompiler
    decompiler = XAPKDecompiler(args.xapk, args.output_dir)
    
    try:
        success = decompiler.run_full_pipeline()
        sys.exit(0 if success else 1)
    except Exception as e:
        print(f"❌ Fatal error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
