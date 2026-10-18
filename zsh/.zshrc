# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

# Theme
ZSH_THEME="robbyrussell"

# Plugins đã được bổ sung
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  you-should-use
)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# Aliases - Hệ thống & Điều hướng
alias home="cd ~"
alias work="cd ~/Workspace"
alias ll="ls -lah"
alias cls="clear"
alias ..="cd .."
alias ...="cd ../.."

# Aliases - Khắc phục lệnh bat trên Ubuntu
alias bat="batcat"

# Aliases - Rút gọn lệnh Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate --all"

# Aliases - Hỗ trợ thao tác build C++ / CMake nhanh
alias cb="cmake -B build -S . && cmake --build build" # Cấu hình và Build nhanh
alias cr="rm -rf build/"                               # Clean thư mục build

# Editor mặc định (Ubuntu có sẵn nano, bạn có thể chuyển thành vim nếu quen)
if command -v nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
  export VISUAL="nvim"
elif command -v vim >/dev/null 2>&1; then
  export EDITOR="vim"
  export VISUAL="vim"
else
  export EDITOR="nano"
  export VISUAL="nano"
fi