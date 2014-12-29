#!/bin/bash

VERSION_openssl=${VERSION_openssl:-1.0.1g}
URL_openssl=http://www.openssl.org/source/openssl-$VERSION_openssl.tar.gz
DEPS_openssl=()
MD5_openssl=de62b43dfcd858e66a74bee1c834e959
BUILD_openssl=$BUILD_PATH/openssl/$(get_directory $URL_openssl)
RECIPE_openssl=$RECIPES_PATH/openssl

function prebuild_openssl() {
	true
}

function shouldbuild_openssl() {
	if [ -f "$BUILD_openssl/libssl.a" ]; then
		DO_BUILD=0
	fi
}

function build_openssl() {
	cd $BUILD_openssl

	push_arm

	if [ "X$ARCH" == "Xx86" ]; then
		OPENSSL_ARCH="android-x86"
	elif [[ "X$ARCH" == Xarmeabi* ]]; then
		OPENSSL_ARCH="linux-armv4"
	else
		error "Unsupported architecture $ARCH"
		exit -1
	fi

	try ./Configure no-dso no-krb5 $OPENSSL_ARCH
	try make build_libs

	pop_arm
}

function postbuild_openssl() {
	true
}
