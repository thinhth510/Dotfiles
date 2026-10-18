#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/log.sh"

run_script() {
  local script_path="$1"

  if [[ -x "$script_path" ]]; then
    "$script_path"
  elif [[ -f "$script_path" ]]; then
    bash "$script_path"
  else
    error "Script not found: $script_path"
    exit 1
  fi
}

info "Starting minimal dotfiles installation..."

info "1. Installing Ubuntu packages and applying system configurations..."
run_script "$SCRIPT_DIR/package/ubuntu.sh"

info "2. Installing Zsh, Oh My Zsh, and plugins..."
run_script "$SCRIPT_DIR/package/zsh.sh"

info "3. Linking config files with stow..."
if command -v stow >/dev/null 2>&1; then
  # Tự động kiểm tra và sao lưu file .zshrc cũ nếu có để tránh lỗi xung đột với stow
  if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
    info "Found existing non-symlink .zshrc. Backing it up to .zshrc.bak..."
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi

  stow --dir "$SCRIPT_DIR" --target "$HOME" zsh
  success "Zsh config linked successfully."
else
  error "Stow is not installed. Cannot link .zshrc."
fi

success "Installation complete! Please restart your terminal or log out and log back in."
