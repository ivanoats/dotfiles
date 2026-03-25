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
  sudo apt-get update -y
  # bat is 'batcat' and fd is 'fdfind' on Debian/Ubuntu
  sudo apt-get install -y fzf bat fd-find ripgrep neovim zoxide

  # eza is not in default apt repos on Ubuntu 24.04 — install via cargo or deb
  if ! command -v eza &>/dev/null; then
    if command -v cargo &>/dev/null; then
      cargo install eza
    else
      echo "eza: install cargo (rustup) then re-run, or download from https://github.com/eza-community/eza/releases"
    fi
  fi
}

case "$(uname)" in
  Darwin)   install_macos ;;
  Linux)    install_linux ;;
  *)        echo "Unsupported OS: $(uname)"; exit 1 ;;
esac

echo "Done. Restart your shell or run: source ~/.zshrc"
