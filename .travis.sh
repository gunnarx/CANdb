#!/bin/bash

cmake_command="cmake .. -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE"

if [ "$WITH_COVERAGE" == "ON" ]; then
    cmake_command="$cmake_command -DWITH_COVERAGE=ON"
fi

echo "ci_env: $ci_env"

set -e
rm -rf build
mkdir -p build
cd build
$cmake_command
make -j5
make test
if [ '$WITH_COVERAGE' == 'ON' ]; then 
  bash <(curl -s https://codecov.io/bash) -x gcov-6 || echo 'Codecov did not collect coverage reports'
fi
