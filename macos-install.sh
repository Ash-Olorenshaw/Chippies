#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please rerun this script as root."
	exit
fi

APP_NAME="Chippies"
APP_PATH="$HOME/.local/opt/Chippies"
EXECUTABLE="$APP_PATH/Chippies"
HOTKEY="cmd shift space"

mkdir -p "$APP_PATH"
cp -r ./* "$APP_PATH/"
echo "Chippies installed to $APP_PATH"

if [ ! -d "/usr/local/bin" ]; then
	printf "\n'/usr/local/bin' does not exist. Creating the directory..."
	mkdir /usr/local/bin
fi

ln -sf "$EXECUTABLE" /usr/local/bin/Chippies
printf "Executable successfully symlinked to /usr/local/bin/Chippies\n"

APP_BUNDLE="$HOME/Applications/Chippies.app"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
printf "\nCreating macOS App Bundle at $APP_BUNDLE"

cp "$EXECUTABLE" "$APP_BUNDLE/Contents/MacOS/Chippies"
chmod +x "$APP_BUNDLE/Contents/MacOS/Chippies"

cat > "$APP_BUNDLE/Contents/Info.plist" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>Chippies</string>
    <key>CFBundleIdentifier</key>
    <string>com.github.Chippies</string>
    <key>CFBundleName</key>
    <string>Chippies</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
</dict>
</plist>
EOL

printf "\nApp bundle created at $APP_BUNDLE\n\n"

echo "To set a hotkey manually, go to System Settings > Keyboard > Shortcuts"
echo "Alternatively, use Automator or AppleScript to trigger the app."

exit 0

