PACKAGE_MGR_UPDATE="sudo apt-get update"
PACKAGE_MGR_GET="sudo apt-get install -y"

PACKAGES=(
  "clang-format"
  "gcc"
  "g++"
  "cmake"
  "make"
  "build-essential"
  "cppcheck"
  "clang-tidy"
  "jq"

  # for glfw wayland
  "libxkbcommon-dev"
  "libwayland-dev"

  # for glfw x11
  "xorg-dev"
)
