#!/bin/bash

if [ -z "$1" ]; then
	"$2"
else 
	"$1" >/dev/null 2>&1 || "$2"
fi
