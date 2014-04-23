#!/bin/bash

VERSION_zope2=${VERSION_zope2:-2.13}
URL_zope2=http://github.com/zopefoundation/Zope/archive/$VERSION_zope2.zip
BUILD_zope2=$BUILD_PATH/zope2/$(get_directory $URL_zope2)
RECIPE_zope2=$RECIPES_PATH/zope2

function prebuild_zope2() {
    true
}

function build_zope2() {
    cd $BUILD_zope2

    push_arm

    export LDFLAGS="$LDFLAGS -L$LIBS_PATH"
    export LDSHARED="$LIBLINK"

    HOSTPYTHON=/home/marco/src/python-for-android/build/hostpython/Python-2.7.2/hostpython
    try $HOSTPYTHON bootstrap.py
    try bin/buildout
        
    unset LDSHARED
    pop_arm
}

function postbuild_zope2() {
    true
}

