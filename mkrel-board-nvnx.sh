#!/bin/sh

#export
cd `dirname $0`
source ./mkrel-board.sh -cmake_arg "-DCPACK_GENERATOR_ADD=DEB -DUSE_QT5=ON -DINSTALL_PROFILES=ON -DUSE_SCRSDK=ON -DBOARD_ALL_IN_ONE=ON" "${@}"
