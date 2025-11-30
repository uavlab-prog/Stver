#!/bin/sh
cd `dirname $0`

#export

rm -rf build

cmake -H./ -Bbuild -G Ninja -DCMAKE_BUILD_TYPE=Release -DMAKE_TESTS=OFF -DPROJECT_NAME_LOW=landserver -DBOARD=OFF -DLAND=ON -DLANDSERVER_ONLY=ON -DLANDCLIENT_ONLY=OFF -DLANDFFMPEG=OFF -DLANDSERVER_H264TOJPEG=ON -DLANDSERVER_CLIENTEAPI=OFF -DLANDSERVER_INTERNAL=OFF -DINSTALL_RUNTIME_LIBS=ON -DINSTALL_RUNTIME_PATH=ON -DCMAKE_INSTALL_PREFIX=/usr -DPROJECTVERSION=$PRODUCT_VERSION_REL || exit 1
cmake --build build --target all || exit 1
DESTDIR=out cmake --build build --target install || exit 1
cmake --build build --target package || exit 1

exit 0
