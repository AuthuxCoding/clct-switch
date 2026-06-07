#!/bin/bash
set -e

APP_NAME="CLCT Switch.app"
APP_SOURCE="dist/$APP_NAME"
PKG_ROOT="pkgroot"
SCRIPTS_DIR="scripts"
PKG_NAME="CLCT Switch Installer.pkg"
IDENTIFIER="com.clctswitch.installer"
VERSION="1.0.0"

if [ ! -d "$APP_SOURCE" ]; then
  echo "找不到 $APP_SOURCE"
  exit 1
fi

rm -rf "$PKG_ROOT" "$SCRIPTS_DIR" "$PKG_NAME"
mkdir -p "$PKG_ROOT/Applications"
mkdir -p "$SCRIPTS_DIR"

cp -R "$APP_SOURCE" "$PKG_ROOT/Applications/"

cat > "$SCRIPTS_DIR/postinstall" <<'EOF'
#!/bin/bash

APP="/Applications/CLCT Switch.app"

/usr/bin/xattr -dr com.apple.quarantine "$APP" 2>/dev/null || true
/usr/bin/codesign --remove-signature "$APP" 2>/dev/null || true
/usr/bin/codesign --force --deep --sign - "$APP" 2>/dev/null || true
/usr/bin/codesign --verify --deep --strict --verbose=2 "$APP" 2>/dev/null || true

exit 0
EOF

chmod +x "$SCRIPTS_DIR/postinstall"

pkgbuild \
  --root "$PKG_ROOT" \
  --scripts "$SCRIPTS_DIR" \
  --identifier "$IDENTIFIER" \
  --version "$VERSION" \
  --install-location / \
  "$PKG_NAME"

echo "已生成: $PKG_NAME"
