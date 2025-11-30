#!/bin/sh

#export
cd `dirname $0`
source ./mkrel-board-cross.sh -gen_opk -toolchain /opt/buildroot-2016.08.10.6/host/usr/share/buildroot/toolchainfile.cmake -cmake_arg "-DGIT_EXECUTABLE=/bin/git -DUSE_QT5=ON -DINSTALL_PROFILES=ON -DINSTALL_PROFILE_DEF_SYMLINK=ON -DINSTALL_PROFILE_DEF_SYMLINK_NAME=orange5_odometry -DBOARD_ALL_IN_ONE=ON -DREGULAR_SYSTEM=ON" "${@}"
