#!/bin/sh
set -e

CMDLINE_ARGS="-Lraylib/lib/ -lraylib -I. -framework CoreVideo -framework IOKit -framework Cocoa -framework OpenGL"
BUILD_DIR="./build"
BINARY="./build/result"

run_program() {
	echo "Running program: '$BINARY'"
	$BINARY
	echo "Program '$BINARY' executed successfully"
}

build_program() {
	echo "Building program: '$BINARY'"
	gcc main.c sys.c strings.c -o build/result $CMDLINE_ARGS
	echo "Produced: '$BINARY'"
}

if [ ! -d "$BUILD_DIR" ]; then
	mkdir "$BUILD_DIR"
fi

if [ ! -d "./raylib" ] || [ ! -f "./raylib/include/raylib.h" ] || [ ! -f "./raylib/lib/libraylib.a" ]; then
	echo "Err - raylib not found."
	echo "Please download the latest release of Raylib (5.5) and extract it the directory 'raylib' at the root of the project."
	exit 1
fi

if [[ "$1" == "run" ]]; then
	build_program
	run_program
elif [[ "$1" == "build" ]]; then
	build_program
else
	echo "Unknown build command: '$1'"
fi
