# 🚀 Ivan's Dotfiles

> A modern, cross-platform **ZSH configuration** for developers who want a powerful and beautiful command-line experience.

[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Ubuntu-blue.svg)](https://github.com/ivanoats/dotfiles)
[![Shell](https://img.shields.io/badge/shell-zsh-green.svg)](https://www.zsh.org/)
[![License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE)

This repository contains a carefully crafted **ZSH configuration** that works seamlessly on **macOS** (Intel & Apple Silicon) and **Ubuntu 24.04.3 LTS**. Get a productive terminal setup in minutes with modern tools, beautiful themes, and smart defaults.

> **Note:** This repository also contains legacy configuration files for vim, tmux, and bash that are maintained for historical purposes but are not actively developed.

## ✨ Features

- 🎨 **Beautiful Theme** - [Powerlevel10k](https://github.com/romkatv/powerlevel10k) with instant prompt for blazing-fast startup
- 🔌 **Smart Plugin Management** - Using [Antidote](https://github.com/mattmc3/antidote) for fast, reliable plugin loading
- 🌍 **Cross-Platform** - Automatically detects OS and loads appropriate configurations
- 🛠️ **Modern CLI Tools** - Pre-configured with fzf, zoxide, eza, bat, ripgrep, and more
- 🔄 **Auto Node Switching** - Automatically switches Node.js versions based on `.nvmrc` files
- 🎯 **Smart Aliases** - Productivity-boosting shortcuts and git enhancements
- 🔒 **Private Keys Support** - Secure way to manage sensitive environment variables (gitignored)
- ⚡ **Fast Startup** - Optimized configuration with lazy loading and caching

## 📸 What You Get

A powerful terminal experience with:
- **Syntax highlighting** as you type
- **Auto-suggestions** from your command history
- **Fuzzy search** for files, history, and directories
- **Smart directory navigation** with zoxide
- **Enhanced git workflows** with custom aliases
- **Beautiful, informative prompt** showing git status, Node version, and more

## 🚀 Quick Start

### Prerequisites
- **macOS** or **Ubuntu 24.04.3 LTS**
- zsh shell
- git

### Installation

```bash
# 1. Clone this repository
git clone https://github.com/ivanoats/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Install Antidote plugin manager (required for ZSH plugins)
git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote

# 3. Setup private keys for your secrets (optional)
cp zsh/private_keys.template zsh/private_keys

# 4. Create symlink for ZSH configuration
ln -s ~/dotfiles/zshrc ~/.zshrc
# Or run the legacy makesymlinks.sh for all configs (includes vim, etc.)
# ./makesymlinks.sh

# 5. Restart your terminal or source the configuration
source ~/.zshrc
```

### Optional But Recommended Tools

**macOS:**
```bash
brew install fzf zoxide eza bat fd ripgrep neovim nvm
```

**Ubuntu:**
```bash
sudo apt-get install -y fzf eza bat fd-find ripgrep neovim
# For zoxide, see SETUP.md for installation script
```

## 📚 Documentation

- **[SETUP.md](SETUP.md)** - Comprehensive installation guide with platform-specific instructions
- **[SUGGESTIONS.md](SUGGESTIONS.md)** - Future improvements and optimization ideas
- **[TEST_RESULTS.md](TEST_RESULTS.md)** - Automated test results and verification

## 🎯 Supported Platforms

| Platform | Status | Tested Version |
|----------|--------|----------------|
| macOS (Intel) | ✅ Supported | macOS 13+ |
| macOS (Apple Silicon) | ✅ Supported | macOS 13+ |
| Ubuntu | ✅ Supported | 24.04.3 LTS |
| Other Linux | 🟡 May work | Not tested |

## 🔧 What's Included

### Primary: ZSH Configuration
- **zsh/** - Modern shell configuration, aliases, functions, and environment variables
- **zshrc** - Main ZSH configuration file with cross-platform support
- **bin/** - Custom scripts and utilities for ZSH workflows

### Legacy Files (Maintained for Historical Purposes)
- **vim/** - Vim configuration (legacy)
- **bash/** - Bash configuration (legacy)
- **tmux.conf** - Terminal multiplexer configuration (legacy)
- **gitconfig** - Git configuration (still useful, but not ZSH-specific)

### Key Tools Integration (ZSH-focused)
- **NVM** - Node.js version manager with auto-switching
- **fzf** - Fuzzy finder for files, history, and more
- **zoxide** - Smart `cd` replacement that learns your habits
- **eza** - Modern replacement for `ls` with git integration
- **bat** - Enhanced `cat` with syntax highlighting
- **ripgrep** - Ultra-fast grep alternative

### Plugin Highlights
- Git enhancements (Oh-My-Zsh plugins)
- Syntax highlighting and autosuggestions
- Auto-notify for long-running commands
- Command completion for npm, node, pip, and more
- macOS-specific integrations (when on macOS)

## 🎨 Customization

### Adding Your Own Aliases
Edit `~/dotfiles/zsh/aliases` or create `~/.zsh_custom` for personal overrides.

### Private Environment Variables
Add your API keys and secrets to `~/dotfiles/zsh/private_keys` (this file is gitignored).

### Theme Configuration
Customize your prompt by running:
```bash
p10k configure
```

## 🤝 Contributing

Contributions are welcome! When making changes:
1. Test on both macOS and Ubuntu if possible
2. Use OS detection for platform-specific code
3. Add existence checks for optional tools
4. Update documentation as needed

## 📝 License

See [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Built with these amazing projects:
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - The best ZSH theme
- [Antidote](https://github.com/mattmc3/antidote) - Fast ZSH plugin manager
- [Oh My Zsh](https://ohmyz.sh/) - Framework for managing ZSH configuration
- [fzf](https://github.com/junegunn/fzf) - Command-line fuzzy finder

---

**Made with ❤️ for the command line**
