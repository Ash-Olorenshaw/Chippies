# Chippies

A simple runner for MacOS written in C and Raylib.

## Building

I'm a Linux user at heart, so I've only tested building using `gcc` from `brew` and that's what the build script uses.

First, clone this repo:

```sh
git clone https://github.com/ash-olorenshaw/Chippies.git
```

Download Raylib's latest release from [here](https://github.com/raysan5/raylib/releases). Untar the relevant archive to a directory named 'raylib' in the root of the project.

To build, run the build script: 

```sh
chmod +x ./build.sh
./build.sh build
./build.sh run # 'run' target will also build
```
