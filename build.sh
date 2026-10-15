#!/bin/zsh
# Build AgentBoard.app (menu bar only) from the SwiftPM target. Signed with a Developer ID when the keychain
# has one, ad hoc otherwise; the app needs no special permissions.
set -e
cd "${0:A:h}"
swift build -c release
APP=build/AgentBoard.app
rm -rf $APP && mkdir -p $APP/Contents/MacOS
cp .build/release/AgentBoard $APP/Contents/MacOS/
cat > $APP/Contents/Info.plist <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleName</key><string>Agent Board</string>
<key>CFBundleIdentifier</key><string>co.tomac.agentboard</string>
<key>CFBundleExecutable</key><string>AgentBoard</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>0.1.0</string>
<key>LSMinimumSystemVersion</key><string>26.0</string>
<key>LSUIElement</key><true/>
<key>BoardRoot</key><string>$PWD</string>
</dict></plist>
PLIST
SIGNER=$(security find-identity -v -p codesigning | sed -n 's/.*"\(Developer ID Application:[^"]*\)".*/\1/p' | head -1)
codesign --force --sign "${SIGNER:--}" $APP
echo $APP
