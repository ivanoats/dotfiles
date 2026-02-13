# 🚀 Ivan's Dotfiles

> A modern, cross-platform **ZSH and Neovim configuration** for developers who want a powerful and beautiful command-line experience.

[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Ubuntu%20%7C%20Codespaces-blue.svg)](https://github.com/ivanoats/dotfiles)
[![Codespaces](https://img.shields.io/badge/Codespaces-compatible-brightgreen.svg)](https://github.com/features/codespaces)
[![Shell](https://img.shields.io/badge/shell-zsh-green.svg)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/editor-neovim-green.svg)](https://neovim.io/)
[![License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE)
[![CI](https://github.com/ivanoats/dotfiles/workflows/CI%20-%20Test%20Shell%20Configuration/badge.svg)](https://github.com/ivanoats/dotfiles/actions/workflows/ci.yml)
[![Markdown Lint](https://github.com/ivanoats/dotfiles/workflows/Markdown%20Linting/badge.svg)](https://github.com/ivanoats/dotfiles/actions/workflows/markdown-lint.yml)

This repository contains carefully crafted **ZSH and Neovim configurations** that work seamlessly on **macOS** (Intel & Apple Silicon), **Ubuntu 24.04.3 LTS**, and **GitHub Codespaces**. Get a productive terminal and editor setup in minutes with modern tools, beautiful themes, and smart defaults.

> **Note:** This repository also contains legacy configuration files for vim (old Vimscript), tmux, and bash that are maintained for historical purposes but are not actively developed.

## ✨ Features

### ZSH Shell
- 🎨 **Beautiful Theme** - [Powerlevel10k](https://github.com/romkatv/powerlevel10k) with instant prompt for blazing-fast startup
- 🔌 **Smart Plugin Management** - Using [Antidote](https://github.com/mattmc3/antidote) for fast, reliable plugin loading
- 🌍 **Cross-Platform** - Automatically detects OS and loads appropriate configurations
- 🛠️ **Modern CLI Tools** - Pre-configured with fzf, zoxide, eza, bat, ripgrep, and more
- 🔄 **Auto Node Switching** - Automatically switches Node.js versions based on `.nvmrc` files
- 🎯 **Smart Aliases** - Productivity-boosting shortcuts and git enhancements
- 🔒 **Private Keys Support** - Secure way to manage sensitive environment variables (gitignored)
- ⚡ **Fast Startup** - Optimized configuration with lazy loading and caching

### Neovim Editor
- 📝 **Modern Lua Config** - Full Lua-based Neovim configuration (not legacy Vimscript)
- 🔧 **LSP Support** - Language servers with Mason for intelligent code completion and diagnostics
- 🌳 **Treesitter** - Advanced syntax highlighting and code understanding
- 🔍 **Telescope** - Powerful fuzzy finder for files, buffers, and more
- 🎨 **OneDark Theme** - Beautiful, modern color scheme
- 📦 **Packer** - Fast plugin management

## 📸 What You Get

### Terminal (ZSH)
- **Syntax highlighting** as you type
- **Auto-suggestions** from your command history
- **Fuzzy search** for files, history, and directories
- **Smart directory navigation** with zoxide
- **Enhanced git workflows** with custom aliases
- **Beautiful, informative prompt** showing git status, Node version, and more

### Editor (Neovim)
- **LSP-powered completion** with intelligent code suggestions
- **Go-to-definition** and symbol search across your codebase
- **Inline diagnostics** showing errors and warnings as you type
- **Git integration** in the editor with gitsigns
- **Treesitter highlighting** for accurate syntax coloring

## 🚀 Quick Start

### For GitHub Codespaces (Easiest!)

This repository is fully compatible with **GitHub Codespaces**! Simply enable it in your [Codespaces settings](https://github.com/settings/codespaces):

1. Go to [GitHub Codespaces Settings](https://github.com/settings/codespaces)
2. Under "Dotfiles", check **"Automatically install dotfiles"**
3. Select **`ivanoats/dotfiles`** from the repository dropdown
4. Create any new Codespace - your dotfiles will be automatically installed! 🎉

The `install.sh` script will automatically:
- Install Antidote plugin manager
- Create necessary symlinks
- Set up your ZSH and Neovim configuration

### Manual Installation

#### Prerequisites
- **macOS** or **Ubuntu 24.04.3 LTS** (or GitHub Codespaces)
- zsh shell
- git
- neovim 0.8+ (for the nvim configuration)

#### Option 1: Using the Install Script (Recommended)

```bash
# 1. Clone this repository
git clone https://github.com/ivanoats/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Run the install script
./install.sh

# 3. Restart your terminal or source the configuration
source ~/.zshrc

# 4. Open Neovim to automatically install plugins (first time only)
nvim
# Packer will automatically install all plugins on first launch
```

#### Option 2: Manual Setup

```bash
# 1. Clone this repository
git clone https://github.com/ivanoats/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Install Antidote plugin manager (required for ZSH plugins)
git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote

# 3. Setup private keys for your secrets (optional)
cp zsh/private_keys.template zsh/private_keys

# 4. Create symlinks
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/zsh_plugins.txt ~/.zsh_plugins.txt
ln -s ~/dotfiles/nvim ~/.config/nvim
# Or run the legacy makesymlinks.sh for all configs (includes old vim, etc.)
# ./makesymlinks.sh

# 5. Restart your terminal or source the configuration
source ~/.zshrc

# 6. Open Neovim to automatically install plugins (first time only)
nvim
# Packer will automatically install all plugins on first launch
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
- **[.github/README.md](.github/README.md)** - GitHub Actions and CI/CD documentation

## 🎯 Supported Platforms

| Platform | Status | Tested Version |
|----------|--------|----------------|
| **GitHub Codespaces** | ✅ **Fully Compatible** | Latest |
| macOS (Intel) | ✅ Supported | macOS 13+ |
| macOS (Apple Silicon) | ✅ Supported | macOS 13+ |
| Ubuntu | ✅ Supported | 24.04.3 LTS |
| Other Linux | 🟡 May work | Not tested |

## 🔧 What's Included

### Primary: ZSH & Neovim Configuration
- **zsh/** - Modern shell configuration, aliases, functions, and environment variables
- **zshrc** - Main ZSH configuration file with cross-platform support
- **nvim/** - Modern Neovim configuration with LSP, Treesitter, and Packer plugin manager
  - LSP support with Mason for language servers
  - Treesitter for advanced syntax highlighting
  - Telescope for fuzzy finding
  - Git integration with Fugitive and Gitsigns
  - Modern Lua-based configuration (422 lines)
- **bin/** - Custom scripts and utilities

### Legacy Files (Maintained for Historical Purposes)
- **vim/** - Old Vimscript configuration (legacy - use nvim/ instead)
- **bash/** - Bash configuration (legacy)
- **tmux.conf** - Terminal multiplexer configuration (legacy)
- **gitconfig** - Git configuration (still useful, but not ZSH/Neovim-specific)

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

## 🔄 Continuous Integration

This repository uses GitHub Actions for automated quality assurance:

- **✅ Cross-Platform Testing** - Validates configurations on Ubuntu and macOS
- **📝 Documentation Quality** - Markdown linting, link checking, and spell checking
- **🔒 Security Scanning** - Automated secret detection and vulnerability scanning
- **🏷️ Auto-Labeling** - PRs are automatically labeled based on changed files
- **🔄 Dependency Updates** - Dependabot keeps GitHub Actions up-to-date
- **🌐 Netlify Integration** - Deployment status updates on PRs

See [.github/README.md](.github/README.md) for detailed documentation on all workflows.

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
