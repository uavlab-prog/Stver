#!/bin/sh

#export

cd `dirname $0`

rm -rf  build
mkdir build
cd build
cmake ../ -G Ninja -DCMAKE_INSTALL_PREFIX=/usr -DCREATE_TR=ON -DMAKE_TESTS=ON -DLAND=ON -DLANDSERVER_ONLY=ON -DLANDCLIENT_ONLY=OFF -DCMAKE_BUILD_TYPE=Coverage -DUSE_COVERAGE=ON -DPROJECTVERSION=$PRODUCT_VERSION_REL -DUSE_MAP=OFF
ninja all -k 5000
echo "2,2," > todo2
cat todo | while read line; do
ctest -N | sed -r 's .{8}  ' | sed 's/#//g' | grep $line | cut -d ":" -f1 | sed 's/^/,/' >> todo2
done;
echo -n $(cat todo2) > todo3

ctest -V -I $(sed 's/\s//g' todo3) || exit 1

lcov --directory . --capture --output-file coverage.info
lcov --remove coverage.info 'src/*Test/*' 'src/*/Mocks/*' 'build/*' 'tools/*' 'tests/*' '/usr/*' --output-file coverage.info.cleaned
genhtml -o coverage coverage.info.cleaned --demangle-cpp --function-coverage --branch-coverage --show-details --ignore-errors source
exit 0;
