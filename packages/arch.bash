PACKAGE_MGR_UPDATE="sudo pacman -Syu"
PACKAGE_MGR_GET="sudo pacman -S --noconfirm"

PACKAGES=(
  "clang"
  "cmake"
  "base-devel"
  "cppcheck"
  "jq"

  # for glfw wayland
  "wayland"

  # for glfw x11
  "xorg"
)
