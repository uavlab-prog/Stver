#!/bin/sh
cd `dirname $0`

cmakeargs="-DPROTOBUF_PREFER_STATIC_LIB=ON -DTURBOJPEG_PREFER_STATIC_LIB=ON -DQTAV_INSTALL_LIBS_FORCE=ON"
source ./mkrel-astraO211_noserv.sh ${cmakeargs} $@
