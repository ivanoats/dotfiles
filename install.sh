#!/usr/bin/env bash
################################################################################
# install.sh
# This script is automatically run by GitHub Codespaces when setting up dotfiles
# It can also be run manually on any system to set up the dotfiles
################################################################################

set -e  # Exit on error

echo "🚀 Installing dotfiles..."

# Directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "📁 Dotfiles directory: $DOTFILES_DIR"

# Install Antidote plugin manager (required for ZSH)
echo "📦 Installing Antidote plugin manager..."
if [ ! -d "${HOME}/.antidote" ]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git "${HOME}/.antidote"
    echo "✅ Antidote installed"
else
    echo "✅ Antidote already installed"
fi

# Create private_keys file from template if it doesn't exist
echo "🔑 Setting up private_keys file..."
if [ ! -f "${DOTFILES_DIR}/zsh/private_keys" ]; then
    cp "${DOTFILES_DIR}/zsh/private_keys.template" "${DOTFILES_DIR}/zsh/private_keys"
    echo "✅ Created private_keys file from template"
else
    echo "✅ private_keys file already exists"
fi

# Create symlinks for dotfiles
echo "🔗 Creating symlinks..."

# Primary dotfiles to symlink
declare -A dotfiles=(
    ["zshrc"]=".zshrc"
    ["gitconfig"]=".gitconfig"
    ["gitignore_global"]=".gitignore_global"
    ["tmux.conf"]=".tmux.conf"
    ["zsh/zsh_plugins.txt"]=".zsh_plugins.txt"
)

# Create symlinks
for source in "${!dotfiles[@]}"; do
    target="${dotfiles[$source]}"
    source_path="${DOTFILES_DIR}/${source}"
    target_path="${HOME}/${target}"
    
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        # If it's already a symlink to our dotfile, skip
        if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
            echo "  ✅ $target (already linked)"
            continue
        fi
        # Otherwise, back it up
        echo "  📦 Backing up existing $target to ${target}.backup"
        mv "$target_path" "${target_path}.backup"
    fi
    
    ln -s "$source_path" "$target_path"
    echo "  ✅ Linked $target"
done

# Create .config/nvim symlink for Neovim
echo "🔗 Creating Neovim config symlink..."
mkdir -p "${HOME}/.config"
nvim_target="${HOME}/.config/nvim"
nvim_source="${DOTFILES_DIR}/nvim"

if [ -e "$nvim_target" ] || [ -L "$nvim_target" ]; then
    if [ -L "$nvim_target" ] && [ "$(readlink "$nvim_target")" = "$nvim_source" ]; then
        echo "  ✅ nvim config (already linked)"
    else
        echo "  📦 Backing up existing nvim config to ${nvim_target}.backup"
        mv "$nvim_target" "${nvim_target}.backup"
        ln -s "$nvim_source" "$nvim_target"
        echo "  ✅ Linked nvim config"
    fi
else
    ln -s "$nvim_source" "$nvim_target"
    echo "  ✅ Linked nvim config"
fi

echo ""
echo "✨ Dotfiles installation complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your shell or run: source ~/.zshrc"
echo "  2. If you see Antidote errors, ZSH will set up plugins on first run"
echo "  3. Edit ${DOTFILES_DIR}/zsh/private_keys to add your API keys and secrets"
echo ""
