# Chippies

A really basic, really simple runner written in Python.

Wholly unfeatureful and mostly written for my own use - it does work pretty well!

## Installing

Make sure you have Python3!
```nu-script
# Fedora
sudo dnf install python3

# Windows 
winget install python

# MacOS
brew install python
```
Get the code first
```
# clone this repo
git clone https://github.com/Ash-Olorenshaw/Chippies.git
```
Run the install script that is relevant to your OS
```
# Linux (Bash)
./linux-install.sh

# Windows (PowerShell)
./windows-install.ps1

# MacOS (Bash)
./macos-install.sh
```
## Usage

All install scripts, except for MacOS, will automatically bind a key combination to launch Chippies.

By default it's the command `ctrl + alt + space`, however, feel free to tinker with the scripts to change it (the key combination is always in the first few lines of it).

> **Note:** On Windows the method we use can *only* bind to combinations that start with `ctrl + alt`

In addition to that, you should also get a shortcut for Chippies along with it being invokable from your shell of choice with `Chippies`.
