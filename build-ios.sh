#!/bin/sh
set -e

export ARC=${1:-armv7}

if [ $ARC != "armv7" -a $ARC != "arm64" ]; then
    echo "not support architecture $ARC";
    exit 1;
fi

make -f Makefile.ios clean
make -f Makefile.ios

set -x
mkdir -p local_iPhoneOS/lib
lipo -create local_iPhoneOS_*/lib/libficl.a -output local_iPhoneOS/lib/libficl.a
