#!/bin/sh
set -e

CMDLINE_ARGS_MACOS="-rpath raylib/lib/ -framework CoreVideo -framework IOKit -framework Cocoa -framework OpenGL"
CMDLINE_ARGS="-Lraylib/lib/ -lraylib -Iraylib/lib/"
BUILD_DIR="./build"
BINARY_FILE="$BUILD_DIR/Chippies"
APP_FILE="$BUILD_DIR/Chippies.app"
ICNS_ICON_FILE="./chippies.icns"

raise_err() {
	echo $1
	exit 1
}

run_program() {
	echo "Running program: '$BINARY_FILE'"
	$BINARY_FILE
	echo "Program '$BINARY_FILE' executed successfully"
}

build_program() {
	echo "Building program: '$BINARY_FILE'"
	gcc main.c sys.c strings.c -o $BINARY_FILE $CMDLINE_ARGS $CMDLINE_ARGS_MACOS
	echo "Produced: '$BINARY_FILE'"
}

build_app_file() {
	local launcher_file="$APP_FILE/Contents/MacOS/launcher"
	local bundle_executable="$APP_FILE/Contents/MacOS/Chippies"

	if [ ! -f "$BINARY_FILE" ]; then
		raise_err "Binary file does not exist: '$BINARY_FILE'\nTry first building the project."
	fi

	echo "Generating directories..."
	mkdir -p "$APP_FILE"
	mkdir -p "$APP_FILE/Contents"
	mkdir -p "$APP_FILE/Contents/MacOS"
	mkdir -p "$APP_FILE/Contents/Resources"

	echo "Generating files..."
	cp "$BINARY_FILE" "$bundle_executable"

	cat <<EOF > "$APP_FILE/Contents/Info.plist" 
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>CFBundleGetInfoString</key>
		<string>Chippies</string>
		<key>CFBundleExecutable</key>
		<string>launcher</string>
		<key>CFBundleIdentifier</key>
		<string>cc.chippies</string>
		<key>CFBundleName</key>
		<string>Chippies</string>
		<key>CFBundleIconFile</key>
		<string>chippies.icns</string>
		<key>CFBundleShortVersionString</key>
		<string>0.01</string>
		<key>CFBundleInfoDictionaryVersion</key>
		<string>6.0</string>
		<key>CFBundlePackageType</key>
		<string>APPL</string>
		<key>IFMajorVersion</key>
		<integer>0</integer>
		<key>IFMinorVersion</key>
		<integer>1</integer>
	</dict>
</plist>
EOF

	if [[ ! -f $ICNS_ICON_FILE ]]; then
		raise_err "Err - icon file '$ICNS_ICON_FILE' not found."
	fi
	
	echo "Copying Raylib..."
	cp -r "./raylib/" "$APP_FILE/Contents/MacOS/raylib"
	cat <<'EOF' > "$launcher_file"
#!/bin/sh
cd "${0%/*}"
./Chippies
EOF
	chmod +x "$launcher_file"
	chmod +x "$bundle_executable"
	echo "Done: $APP_FILE"
}

if [ ! -d "$BUILD_DIR" ]; then
	mkdir "$BUILD_DIR"
fi

if [ ! -d "./raylib" ] || [ ! -f "./raylib/include/raylib.h" ] || [ ! -f "./raylib/lib/libraylib.a" ]; then
	raise_err "Err - raylib not found.\nPlease download the latest release of Raylib (5.5) and extract it the directory 'raylib' at the root of the project."
fi

if [[ "$1" == "run" ]]; then
	build_program
	run_program
elif [[ "$1" == "build" ]]; then
	build_program
elif [[ "$1" == "bundle" ]]; then
	if [[ "$2" == "macos" ]]; then
		build_app_file
	fi
else
	raise_err "Unknown build command: '$1'\nAvailable options: 'build', 'run'"
fi
