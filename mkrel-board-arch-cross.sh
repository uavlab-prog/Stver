#!/bin/sh

#export
cd `dirname $0`
source ./mkrel-arch-cross.sh -cmake_arg "-DCONF_SUB_PATH=sky" ${@}

