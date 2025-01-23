#!/bin/bash

SETUP_DEV_ENV_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SETUP_DEV_ENV_PACKAGES_DIR="${SETUP_DEV_ENV_DIR}/../packages"

usage() {
  cat << EOF
Usage: ${0##*/} <platform>

Description:
  Things done by this script:
    - Installs needed development packages
    - Setups git hooks

Where:
    <platform> is one of the following:
EOF
  for platform_file in "${SETUP_DEV_ENV_PACKAGES_DIR}"/*.bash; do
    platform_name=$(basename "${platform_file}" .bash)
    echo "    - ${platform_name}"
  done
  echo
}

install_packages() {
    local package_file="${SETUP_DEV_ENV_PACKAGES_DIR}/$1.bash"

    if [ ! -f "${package_file}" ]; then
        echo "Platform not found: $1"
        exit 1
    fi

    source "${package_file}"

    # Update package list
    echo "Updating package list with command: ${PACKAGE_MGR_UPDATE}"
    ${PACKAGE_MGR_UPDATE}

    # Install packages
    for package in "${PACKAGES[@]}"; do
        echo "Installing package: ${package}"
        ${PACKAGE_MGR_GET} "${package}"
    done
}

main() {
  # ------------------------------
  # Install C++ dev packages
  # ------------------------------

  if [ -z "$1" ]; then
      usage && exit 1
  fi

  install_packages "$1"

  # ------------------------------
  # Setup git hooks
  # ------------------------------

  SETUP_DEV_ENV_GIT_HOOKS_SCRIP="${SETUP_DEV_ENV_DIR}/git-hooks/setup-hooks.bash"
  ${SETUP_DEV_ENV_GIT_HOOKS_SCRIP}

  # ------------------------------
  # Load custom scripts
  # ------------------------------

  # TODD: Add custom scripts here
}

main "$@"
