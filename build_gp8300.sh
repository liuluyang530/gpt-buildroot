#!/bin/bash
SHELL_FILE=$(readlink -f $0)
BUILDROOT_ROOT=$(dirname $SHELL_FILE)
BUILD_DIR=$ROOTFS_ROOT/build
CONFIG_FILE=gpt_polaris_dvb_mini_tools_defconfig
LOCAL_TOOLCHAIN_PATH=$(which gpt-gcc)

if [ "$1" = ""  ]
then
	echo "===null===="
else
	CONFIG_FILE=$1
fi

echo ===============================================
echo ==== update toolchain location ================
echo ===============================================

sub_dir=${LOCAL_TOOLCHAIN_PATH%/*}
dir=${sub_dir%/*}
#cd $BUILD_DIR"/"$BUILDROOT_DIR
#sed -i "s#gpt_toolchain_path#$dir#g" ./configs/gpt_polaris_dvb_mini_tools_defconfig

#CONFIG_FILE=$1
echo ===============================================
echo ==== build buildroot file $CONFIG_FILE ==========
echo ===============================================
make $CONFIG_FILE
make -j8

echo ===============================================
echo === buildroot build $CONFIG_FILE finished!!! ===============
echo ===============================================
