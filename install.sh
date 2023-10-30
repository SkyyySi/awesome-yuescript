#!/usr/bin/env bash

function log_info() {
	printf '\e[1;34mINFO:\e[0m %s\n' "$1"
}

function log_warning() {
	printf '\e[1;32mWARNING:\e[0m %s\n' "$1"
}

function log_error() {
	printf '\e[1;31mERROR:\e[0m %s\n' "$1"
}

function command_exists() {
	command -v "$1" &> '/dev/null'
}

if ! command_exists paru; then
	log_error 'You need to install the `paru` AUR-helper before you can use this script!'
	exit 1
fi

log_info 'Fetching system updates'
paru -Syu

log_info 'Installing aweomse-git'
paru -S luajit luarocks awesome-luajit-git

eval "$(luarocks --lua-version=5.1 path)"

log_info 'Installing the Yuescript compiler'
MAKEFLAGS='-j16' luarocks --local install --lua-version=5.1 yuescript

log_info 'Installing lpeglabel (parsing library)'
MAKEFLAGS='-j16' luarocks --local install --lua-version=5.1 lpeglabel

log_info 'Installing gnome-flashback'
paru -S gnome-flashback gnome-shell gnome-control-center upower network-manager-applet blueman-applet flameshot picom-git

sudo systemctl install
