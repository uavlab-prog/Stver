@echo off

pushd
cd /d %~dp0

set PATH=%PATH%;%~dp0redist\nsis

cmake -E remove_directory build
cmake -E make_directory  build

cd build

cmake -E remove CMakeCache.txt

cmake -G Ninja ../ -DNO_BACKTRACE=ON -DCMAKE_BUILD_TYPE=Release -DMAKE_TESTS=ON -DRA_ANT_EMULATOR=ON -DGDAL_BOUND_ENABLE=OFF -DBOARD=ON -DLAND=OFF -DLANDCLIENT_ONLY=OFF -DLANDSERVER_ONLY=OFF -DCREATE_BUNDLE=ON -DINSTALL_RUNTIME_LIBS=ON -DINSTALL_PROFILES=ON -DCMAKE_INSTALL_PREFIX=./out/onboard -DPROJECTVERSION=%PRODUCT_VERSION_REL% || exit 1

ninja all || exit 1

ctest -V || exit 1

ninja install || exit 1

popd
exit /B 0
