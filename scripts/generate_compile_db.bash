#!/bin/bash

GENERATE_COMPILE_DB_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
GENERATE_COMPILE_DB_REPO_DIR="${GENERATE_COMPILE_DB_DIR}/.."
GENERATE_COMPILE_DB_SRC_DIR="$(realpath "${GENERATE_COMPILE_DB_REPO_DIR}/src")"
set -euo pipefail  # Exit on error, unset variables, and pipeline failures

# Step 1: cd to the repo root
echo "Changing directory to ${GENERATE_COMPILE_DB_REPO_DIR}"
cd "${GENERATE_COMPILE_DB_REPO_DIR}"

# Step 2: generate compile_commands.json
echo "Generating compile_commands.json..."
mkdir -p build && cd build
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug ..

# Step 3. Find compile_commands.json
echo "Finding compile_commands.json..."
COMPILE_COMMANDS_JSON=$(find . -name "compile_commands.json" -type f)

# Step 4: copy original compile_commands.json to the repo root
echo "Copying original compile_commands.json to the repo root..."
cp "${COMPILE_COMMANDS_JSON}" "${GENERATE_COMPILE_DB_REPO_DIR}/original_compile_commands.json"

# Step 5: Filter compile_commands.json to keep only files from src directory
echo "Filtering compile_commands.json to keep only files from ${GENERATE_COMPILE_DB_SRC_DIR}..."
jq --arg src_dir "${GENERATE_COMPILE_DB_SRC_DIR}" '[.[] | select(.file | startswith($src_dir))]' \
    "${GENERATE_COMPILE_DB_REPO_DIR}/original_compile_commands.json" \
    > "${GENERATE_COMPILE_DB_REPO_DIR}/compile_commands.json"

# Step 6: cleanup
echo "Cleaning up..."
rm "${GENERATE_COMPILE_DB_REPO_DIR}/original_compile_commands.json"
