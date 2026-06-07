#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DIST_DIR="$SCRIPT_DIR/dist"

echo "🚀 CC Switch - Building All Platforms"
echo "======================================"
echo ""

echo "🧹 Cleaning..."
cd "$SCRIPT_DIR"
flutter clean > /dev/null 2>&1
rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

# --- macOS PKG ---
echo "🍎 Building macOS PKG..."
flutter build macos --release

# PKG staging
rm -rf pkgroot scripts 2>/dev/null
mkdir -p pkgroot/Applications
mkdir -p scripts
cp -R "build/macos/Build/Products/Release/CC Switch.app" pkgroot/Applications/

# postinstall script - auto-sign on user's machine
cat > scripts/postinstall << 'SCRIPT'
#!/bin/bash
APP_PATH="/Applications/CC Switch.app"
xattr -rd com.apple.quarantine "$APP_PATH" 2>/dev/null
# Try user's dev cert, fall back to ad-hoc
CERT=$(security find-identity -v -p codesigning 2>/dev/null | grep -o '"[^"]*"' | head -1 | tr -d '"')
if [ -n "$CERT" ]; then
    codesign --force --deep --sign "$CERT" "$APP_PATH" 2>/dev/null
else
    codesign --force --deep --sign - "$APP_PATH" 2>/dev/null
fi
echo "✅ CC Switch installed to /Applications"
exit 0
SCRIPT
chmod +x scripts/postinstall

pkgbuild \
  --root pkgroot \
  --identifier com.ccswitch.ccSwitch \
  --version 1.0.0 \
  --install-location / \
  --scripts scripts \
  --ownership preserve \
  "$DIST_DIR/CC_Switch.pkg" > /dev/null 2>&1

rm -rf pkgroot scripts
echo "   ✅ macOS: $DIST_DIR/CC_Switch.pkg"

# --- iOS ---
echo "📱 Building iOS..."
flutter build ios --release --no-codesign
mkdir -p "$DIST_DIR/ios_temp/Payload"
cp -r build/ios/iphoneos/Runner.app "$DIST_DIR/ios_temp/Payload/"
cd "$DIST_DIR/ios_temp"
zip -r "$DIST_DIR/CC_Switch_iOS.ipa" Payload > /dev/null
cd "$SCRIPT_DIR"
rm -rf "$DIST_DIR/ios_temp"
echo "   ✅ iOS: $DIST_DIR/CC_Switch_iOS.ipa"

# --- Web ---
echo "🌐 Building Web..."
flutter build web --release
cd build/web
zip -r "$DIST_DIR/CC_Switch_Web.zip" . > /dev/null
echo "   ✅ Web: $DIST_DIR/CC_Switch_Web.zip"

# --- Summary ---
echo ""
echo "📦 Done!"
ls -lh "$DIST_DIR"/*.pkg "$DIST_DIR"/*.ipa "$DIST_DIR"/*.zip 2>/dev/null | awk '{printf "   %-35s %s\n", $NF, $5}'
echo ""
echo "=== 分发方式 ==="
echo "  macOS: 双击 .pkg 安装（自动签名）"
echo "  iOS:   .ipa sideload"
echo "  Web:   解压 .zip 放服务器"
echo "  Windows/Android/Linux: flutter build 对应平台"
