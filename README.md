# Minimal Ubuntu C++ Dotfiles

Personal dotfiles for setting up a minimal, high-performance Ubuntu environment. Optimized for C++ software development, with tooling perfectly suited for building custom data parsing libraries (such as `CSVLoader` or `BinLoader`). 

This repository focuses on terminal tooling, Zsh configuration with auto-suggestions, and essential development packages.

## Repository Structure

```text
.
├── install.sh
├── lib
│   └── log.sh
├── package
│   ├── ubuntu.sh
│   └── zsh.sh
└── zsh
    └── .zshrc
```

## Support

- Target: Ubuntu Desktop/Server environments (tested on VMware).
- Requires internet access and `sudo` privileges.

## Quick Start on a New Machine

```bash
# 1. Clone the repository
git clone https://github.com/thinhth510/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Grant execution permissions to scripts
chmod +x install.sh package/*.sh

# 3. Run the installer
./install.sh
```

After the script finishes, open a new terminal or log out and back in so the Zsh default shell is applied.

## What the Installer Does

`install.sh` runs these steps automatically:

1. **Ubuntu Setup (`package/ubuntu.sh`)**:
   - Updates the system package index.
   - Installs core utilities (Git, curl, stow, etc.).
   - Installs C++ compilation, testing, and debugging tools (CMake, Ninja, Clang, GDB, Catch2, GTest).
   - Installs Qt/OpenGL runtime dependencies.
   - Configures system services (starts and enables SSH).
   - Restarts IBus for Unikey support.
   - Sets `qpdfview` as the default PDF viewer.
   - Upgrades the entire system.
2. **Zsh Setup (`package/zsh.sh`)**:
   - Installs Oh My Zsh.
   - Downloads `zsh-syntax-highlighting`, `zsh-autosuggestions` and `you-should-use` plugins.
   - Changes the default shell to Zsh.
3. **Symlinking**:
   - Uses GNU Stow to link the configuration in `zsh/.zshrc` directly to your `$HOME` directory.

## Notes for Virtual Machines
If you are running this on a Virtual Machine (like VMware), the installer automatically pulls `open-vm-tools` and `open-vm-tools-desktop` to enable clipboard sharing, screen resizing, and drag-and-drop features. Ensure your VM is fully rebooted after the first install.
