#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

source "$ROOT_DIR/lib/log.sh"

info "Installing Oh My Zsh..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  warn "Oh My Zsh already installed. Skipping."
fi

info "Installing Zsh plugins..."

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

ZSH_SYNTAX_HIGHLIGHTING_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"
ZSH_AUTOSUGGESTIONS_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
# Khai báo thêm đường dẫn cho 2 plugin mới
ZSH_YOU_SHOULD_USE_DIR="$ZSH_CUSTOM_DIR/plugins/you-should-use"
ZSH_BAT_DIR="$ZSH_CUSTOM_DIR/plugins/zsh-bat"

if [ ! -d "$ZSH_SYNTAX_HIGHLIGHTING_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_SYNTAX_HIGHLIGHTING_DIR"
else
  warn "zsh-syntax-highlighting already installed. Skipping."
fi

if [ ! -d "$ZSH_AUTOSUGGESTIONS_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_AUTOSUGGESTIONS_DIR"
else
  warn "zsh-autosuggestions already installed. Skipping."
fi

# Tải You-should-use
if [ ! -d "$ZSH_YOU_SHOULD_USE_DIR" ]; then
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_YOU_SHOULD_USE_DIR"
else
  warn "you-should-use already installed. Skipping."
fi

info "Changing default shell to zsh..."

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
else
  warn "Default shell is already zsh. Skipping."
fi

success "Done setting up Zsh."