#!/bin/bash

RUN_CLANG_TIDY_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
RUN_CLANG_TIDY_REPO_DIR="$( cd -- "${RUN_CLANG_TIDY_DIR}/.." &> /dev/null && pwd )"
RUN_CLANG_TIDY_REPORTS_DIR="${RUN_CLANG_TIDY_REPO_DIR}/reports"
RUN_CLANG_TIDY_SRC_DIR="${RUN_CLANG_TIDY_REPO_DIR}/src"
RUN_CLANG_TIDY_COMPILE_DB_PATH="${RUN_CLANG_TIDY_REPO_DIR}/compile_commands.json"

set -euo pipefail  # Exit on error, unset variables, and pipeline failures

# Ensure reports directory exists
mkdir -p "${RUN_CLANG_TIDY_REPORTS_DIR}"

# Step 1: Generate compile_commands.json
echo "Generating compile_commands.json..."
"${RUN_CLANG_TIDY_DIR}/generate_compile_db.bash"

# Step 2: Run clang-tidy using find to pass files
echo "Running clang-tidy..."
find "${RUN_CLANG_TIDY_SRC_DIR}" \( -name "*.cpp" -o -name "*.h" -o -name "*.c" -o -name "*.hpp" \) -print0 | \
xargs -0 clang-tidy \
 -p="${RUN_CLANG_TIDY_COMPILE_DB_PATH}" \
 -config-file="${RUN_CLANG_TIDY_REPO_DIR}/.clang-tidy" \
 -header-filter=".*" \
 > "${RUN_CLANG_TIDY_REPORTS_DIR}/clang-tidy-report.txt" 2>&1