# C++ Project Template

## Overview

This repository provides a comprehensive C++ project template with modern development tools, automated workflows, and best practices for C++ software development.

## Features

### Development Environment Setup

#### `./scripts/setup_dev_env.bash`

- Automates development environment setup for different platforms
- Installs all required packages based on platform-specific configuration
- Configures git hooks for code quality

#### Package Management

- Platform-specific package installation scripts located in `./packages/`
- Package files must define the following variables:
  ```bash
  PACKAGE_MGR_UPDATE="sudo apt-get update" # must define command to update package manager
  PACKAGE_MGR_GET="sudo apt-get install -y" # must define command to install packages
  PACKAGES=(  # list of packages to install
    "clang-format"
    "gcc"
    "g++"
    "cmake"
    "make"
    "build-essential"
    "cppcheck"
    "clang-tidy"
    "jq"
  )
  ```

### Code Quality Tools

#### Git Hooks
- Clang-format git hook automatically applied before each commit
- Ensures consistent code formatting across the project

### Testing

#### Google Test (GTest) Integration
- Pre-configured GTest target for unit testing
- Separation of application logic into library and runner
- Simplifies test attachment and management

### Build System

#### CMake Enhancements
- Automatic source directory management
- Flexible project structure

### Dependency Management

#### External Dependencies
- `deps/` directory for simplified dependency management
- Uses CMake FetchContent for easy dependency integration
- Add new dependencies by creating a folder in `deps/` with a `CMakeLists.txt`

### Continuous Integration

#### GitHub Actions Workflows
1. **Automated Testing**
    - Runs GTest target on every commit
    - Ensures code correctness and regression prevention

2. **Code Formatting Check**
    - Validates clang-format compliance
    - Maintains consistent code style

3. **Static Analysis**
    - CppCheck Analysis
        - Performs static code analysis on `src/` directory
        - Generates and uploads analysis report as GitHub Actions artifact

4. **Code Linting**
    - Clang-Tidy Analysis
        - Performs code linting on `src/` directory
        - Generates and uploads linting report as GitHub Actions artifact
