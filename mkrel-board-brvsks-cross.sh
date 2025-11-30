#!/bin/sh

#export
cd `dirname $0`
export CPACK_OPKG_PACKAGE_DEPENDS="rootfs (>=br11), rootfs (<<br12)"
#-cmake_arg "-DCPACK_OPKG_PACKAGE_ARCHITECTURE=armhfvsks
source ./mkrel-board-cross.sh -gen_opk -toolchain /opt/br-vsks/host/usr/share/buildroot/toolchainfile.cmake -cmake_arg "-DGIT_EXECUTABLE=/bin/git -DUSE_QT5=ON -DINSTALL_PROFILES=ON -DINSTALL_RUNTIME_PATH=ON -DINSTALL_PROFILE_DEF_SYMLINK=ON -DINSTALL_PROFILE_DEF_SYMLINK_NAME=default -DBOARD_ALL_IN_ONE=ON -DUSE_SCRSDK=ON -DCPACK_OPKG_PACKAGE_ARCHITECTURE=armhfvsks" "$@"
