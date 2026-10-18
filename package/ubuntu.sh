#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Đảm bảo source đúng file log.sh để dùng các hàm in màu
source "$ROOT_DIR/lib/log.sh"

apt_install() {
  sudo apt install -y "$@"
}

## 1. Định nghĩa các nhóm package đã được tối ưu
basic_packages=(
  git
  curl
  wget
  unzip
  zip
  tar
  ca-certificates
  openssh-client
  openssh-server
  zsh      
  stow     
)

cpp_packages=(
  build-essential
  cmake
  gdb
  ninja-build
  valgrind
  cppcheck
  clang
  clangd
  clang-format
  clang-tidy
  pkg-config
  ccache
)

opengl_packages=(
  libxcb-cursor0
  libxcb-cursor-dev
  libgl1-mesa-dev
  mesa-common-dev
  mesa-utils
  libglu1-mesa-dev
  libglew-dev
  libglfw3-dev
  libglm-dev
  libao-dev
  libmpg123-dev
  freeglut3-dev
)

vm_packages=(
  open-vm-tools
  open-vm-tools-desktop
)

utilities_packages=(
  htop
  ibus-unikey
  ripgrep
  fd-find
  fzf
  tree
  qpdfview
  neofetch
  bat
)

unittest_packages=(
  libgtest-dev
  catch2
)

office_packages=(
  libreoffice-calc
)

# 2. Cập nhật apt trước khi cài đặt
info "Updating apt..."
sudo apt update
success "Apt package index updated."

# 3. Tiến hành cài đặt từng nhóm package
info "Installing Basic packages..."
apt_install "${basic_packages[@]}"

info "Installing Virtual Machine tools..."
apt_install "${vm_packages[@]}"

info "Installing C/C++ packages..."
apt_install "${cpp_packages[@]}"

info "Installing QT & OpenGL packages..."
apt_install "${opengl_packages[@]}"

info "Installing Utilities..."
apt_install "${utilities_packages[@]}"
success "Utilities installed."

info "Installing Unit Test packages..."
apt_install "${unittest_packages[@]}"
success "Unit Test packages installed."

info "Installing Office packages..."
apt_install "${office_packages[@]}"
success "Office packages installed."

# 4. Thực thi các lệnh sau khi cài đặt xong
info "Configuring post-installation settings..."

info "Restarting IBus for ibus-unikey..."
if command -v ibus >/dev/null 2>&1; then
  ibus restart || warn "IBus restart failed. You may need to log out and log in again."
else
  warn "IBus is not installed properly."
fi

info "Starting and enabling openssh-server..."
sudo systemctl start ssh
sudo systemctl enable ssh
success "SSH service started and enabled."

info "Setting qpdfview as default PDF viewer..."
if command -v qpdfview >/dev/null 2>&1; then
  xdg-mime default qpdfview.desktop application/pdf
  success "qpdfview is set as the default PDF viewer."
else
  warn "qpdfview not found."
fi

# 5. Cập nhật và nâng cấp toàn bộ hệ thống ở bước cuối cùng
info "Performing final system update and upgrade..."
sudo apt update
sudo apt upgrade -y
success "System fully updated and upgraded."

success "ubuntu.sh execution completed successfully."
