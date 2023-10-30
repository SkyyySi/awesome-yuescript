#!/usr/bin/env bash

function compile() {
	clear
	meson compile -C "$PWD/builddir"
}

compile

while inotifywait -e close_write native.c -qq; do
	compile
done
