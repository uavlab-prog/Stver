#!/bin/sh

#export
cd `dirname $0`
export CPACK_OPKG_PACKAGE_DEPENDS="rootfs (>=oe4t2), rootfs (<<oe4t3)"
source ./mkrel-board-cross.sh -gen_opk -toolchain ${OE_CMAKE_TOOLCHAIN_FILE} -cmake_arg "-DGIT_EXECUTABLE=/bin/git -DUSE_QT5=ON -DINSTALL_PROFILES=ON -DINSTALL_PROFILE_DEF_SYMLINK=ON -DINSTALL_PROFILE_DEF_SYMLINK_NAME=default -DUSE_SCRSDK=ON -DBOARD_ALL_IN_ONE=ON -DCPACK_OPKG_PACKAGE_ARCHITECTURE=armv8a" "${@}"
