#!/bin/sh
set -e

# android : http://d.hatena.ne.jp/tmash06/20110501/1304247426
#           http://d.hatena.ne.jp/yukoba/20121012/p1

NDK_ROOT=/Applications/ndk
ANDROID_VERSION=android-15
TO_ARM_DIR=$NDK_ROOT/standalone-ct/${ANDROID_VERSION}-arm
ANDROID_TOOLCHAIN=$TO_ARM_DIR
BUILD_HOST=arm-linux-androideabi

if [ ! -d $TO_ARM_DIR ]; then
    $NDK_ROOT/build/tools/make-standalone-toolchain.sh --platform=${ANDROID_VERSION} --toolchain=arm-linux-androideabi-4.8 --install-dir=$TO_ARM_DIR
fi
export PATH=$ANDROID_TOOLCHAIN/bin:$PATH
export CC=$BUILD_HOST-gcc
export LIB="$BUILD_HOST-ar cr"
export RANLIB=$BUILD_HOST-ranlib
export CFLAGS="-mthumb -march=armv7-a -mfloat-abi=softfp -I$ANDROID_TOOLCHAIN/include"
export LDFLAGS="-Wl,--fix-cortex-a8"

make -f Makefile.android clean
make -f Makefile.android
