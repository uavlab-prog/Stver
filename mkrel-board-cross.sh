#!/bin/sh

cd `dirname $0`

start_dir=$(pwd)
build_dir=build
build_mode=Release
soft=board
gen_opk=no
only_conf=no

testbuild=no
cmake_arg="-DROHC=OFF -DLAND=OFF"
cmake_add_args=""
toolchain=${start_dir}/cmake/armtoolchain.cmake
prefix=/usr

while [ $# -gt 0 ]; do
	arg=$1
	case "$arg" in
	-mode) build_mode="${2}"
		shift
		;;
	-soft) soft="${2,,}"
		shift
		;;
	-b_dir) build_dir="${2}"
		shift
		;;
	-toolchain) toolchain="${2}"
		shift
		;;
	-prefix) prefix="${2}"
		shift
		;;
	-gen_opk) gen_opk=yes; cmake_add_args="${cmake_add_args} -DGENERATE_OPK=ON"
		;;
	-test) testbuild=yes
		;;
	-cmake_arg) cmake_add_args="${cmake_add_args} ${2}"
		shift
		;;
	-only_conf) only_conf=yes
		;;
	*)
		;;
	esac
	shift
done

if [ "x${testbuild}" == "xyes" ]; then
build_dir=${build_dir}-test
fi

rm -rf "${build_dir}"
mkdir -p "${build_dir}"
cd "${build_dir}"
#-DCMAKE_C_FLAGS_RELEASE="-O2 -DNDEBUG" -DCMAKE_CXX_FLAGS_RELEASE="-O2 -DNDEBUG"

echo cmake -Wno-dev -G Ninja -DCMAKE_INSTALL_PREFIX=${prefix} -DCMAKE_TOOLCHAIN_FILE=${toolchain} -DCREATE_TR=OFF -DMAKE_TESTS=OFF -DMAKE_HW_TESTS=ON -DPROJECTVERSION=$PRODUCT_VERSION_REL -DCMAKE_BUILD_TYPE=${build_mode} ${cmake_arg} ${cmake_add_args} ${@} ${start_dir}

cmake -Wno-dev -G Ninja -DCMAKE_INSTALL_PREFIX=${prefix} -DCMAKE_TOOLCHAIN_FILE=${toolchain} -DCREATE_TR=OFF -DMAKE_TESTS=OFF -DMAKE_HW_TESTS=ON -DPROJECTVERSION=$PRODUCT_VERSION_REL -DCMAKE_BUILD_TYPE=${build_mode} ${cmake_arg} ${cmake_add_args} ${@} ${start_dir}

if [ "x${only_conf}" == "xyes" ]; then
exit 0;
fi

cmake --build . --target all || exit 1
DESTDIR=out cmake --build . --target install || exit 1
cmake --build . --target package || exit 1
if [ "x${gen_opk}" == "xyes" ]; then
cmake --build . --target generate_opkg
fi
exit 0;
