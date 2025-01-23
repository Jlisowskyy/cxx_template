#!/bin/bash

BUILD_AND_RUN_UNIT_TESTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

BUILD_AND_RUN_UNIT_TESTS_REPO_DIR="${BUILD_AND_RUN_UNIT_TESTS_DIR}/.."

TEST_TARGET_NAME="UnitTestTarget"

set -euo pipefail  # Exit on error, unset variables, and pipeline failures

# Step 1: cd to the repo root
echo "Changing directory to ${BUILD_AND_RUN_UNIT_TESTS_REPO_DIR}"
cd "${BUILD_AND_RUN_UNIT_TESTS_REPO_DIR}"

# Step 2: configure cmake

echo "Creating build directory and running cmake"
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug ..

# Step 3: build the project (additionally verify if everything builds correctly)
echo "Building the project"
cmake --build . -- -j$(nproc)

# Step 5: find test binary
echo "Finding test binary"
TEST_BINARY=$(find . -name "${TEST_TARGET_NAME}" -type f)

# Step 6: run tests
echo "Running tests"
"${TEST_BINARY}" || exit 1
