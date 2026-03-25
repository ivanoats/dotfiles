#!/usr/bin/env bash
# install-tools.sh — Install recommended CLI tools based on OS

set -e

install_macos() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Install it first: https://brew.sh"
    exit 1
  fi
  brew install fzf zoxide eza bat fd ripgrep neovim
}

install_linux() {
  if command -v apt-get &>/dev/null; then
    sudo apt-get update -y
    # bat is 'batcat' and fd is 'fdfind' on Debian/Ubuntu
    sudo apt-get install -y fzf bat fd-find ripgrep neovim zoxide

    # Ensure bat/fd commands exist for consistency with macOS and docs
    mkdir -p "$HOME/.local/bin"
    if command -v batcat &>/dev/null; then
      # Remove broken bat symlink if it exists, so ln -s won't fail under set -e
      if [ -L "$HOME/.local/bin/bat" ] && [ ! -e "$HOME/.local/bin/bat" ]; then
        rm "$HOME/.local/bin/bat"
      fi
      if [ ! -e "$HOME/.local/bin/bat" ]; then
        ln -s "$(command -v batcat)" "$HOME/.local/bin/bat"
        echo "Created symlink: $HOME/.local/bin/bat -> $(command -v batcat)"
      fi
    fi
    if command -v fdfind &>/dev/null; then
      # Remove broken fd symlink if it exists, so ln -s won't fail under set -e
      if [ -L "$HOME/.local/bin/fd" ] && [ ! -e "$HOME/.local/bin/fd" ]; then
        rm "$HOME/.local/bin/fd"
      fi
      if [ ! -e "$HOME/.local/bin/fd" ]; then
        ln -s "$(command -v fdfind)" "$HOME/.local/bin/fd"
        echo "Created symlink: $HOME/.local/bin/fd -> $(command -v fdfind)"
      fi
    fi
    if ! printf '%s\n' "$PATH" | grep -q "$HOME/.local/bin"; then
      echo "Note: $HOME/.local/bin is not in your PATH. Add it to use 'bat' and 'fd' directly."
    fi
    # Try apt first (available in some Ubuntu versions/added repos), then fall back to cargo
    if ! command -v eza &>/dev/null; then
      if sudo apt-get install -y eza; then
        echo "eza installed via apt"
      elif command -v cargo &>/dev/null; then
        echo "eza not available via apt, installing via cargo..."
        cargo install eza
      else
        echo "eza: not available via apt. Install cargo (rustup) then re-run, or download from https://github.com/eza-community/eza/releases"
      fi
    fi
  else
    echo "Unsupported Linux distribution for this installer."
    echo "This script currently supports Debian/Ubuntu systems with apt-get."
    echo "Please install the following tools using your distribution's package manager:"
    echo "  - fzf"
    echo "  - zoxide"
    echo "  - eza"
    echo "  - bat"
    echo "  - fd"
    echo "  - ripgrep"
    echo "  - neovim"
    exit 1
  fi
}

case "$(uname)" in
  Darwin)   install_macos ;;
  Linux)    install_linux ;;
  *)        echo "Unsupported OS: $(uname)"; exit 1 ;;
esac

echo "Done. Restart your shell or run: source ~/.zshrc"
