# Dotfiles Cross-Platform Setup Guide

This repository contains dotfiles that work on both **macOS** and **Ubuntu 24.04.3 LTS**.

## Prerequisites

### Common (Both OS)
- zsh shell
- git

### macOS
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install zsh git
```

### Ubuntu 24.04.3 LTS
```bash
# Update package list
sudo apt-get update

# Install required tools
sudo apt-get install -y zsh git curl

# Make zsh the default shell
chsh -s $(which zsh)
```

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ivanoats/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Setup private keys**
   ```bash
   cp zsh/private_keys.template zsh/private_keys
   # Edit zsh/private_keys and add your secrets
   ```

3. **Install Antidote plugin manager**
   ```bash
   # Clone antidote
   git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
   ```

4. **Create symlinks**
   ```bash
   # Run the setup script
   ./makesymlinks.sh
   ```

5. **Install optional tools (recommended)**
   
   **macOS:**
   ```bash
   brew install fzf zoxide eza bat fd ripgrep neovim
   brew install nvm  # Node version manager
   ```
   
   **Ubuntu:**
   ```bash
   # fzf
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   
   # zoxide
   curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
   
   # eza (modern ls replacement)
   sudo apt-get install -y eza
   
   # bat (better cat)
   sudo apt-get install -y bat
   ln -s /usr/bin/batcat ~/.local/bin/bat
   
   # fd (better find)
   sudo apt-get install -y fd-find
   
   # ripgrep (better grep)
   sudo apt-get install -y ripgrep
   
   # neovim
   sudo apt-get install -y neovim
   
   # NVM (Node Version Manager)
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
   ```

## Features

### Cross-Platform Compatibility
- Automatically detects OS type (macOS vs Linux)
- Conditionally loads OS-specific plugins
- OS-specific paths and configurations
- Graceful fallbacks for missing tools

### Plugin Management
- Uses [Antidote](https://github.com/mattmc3/antidote) for plugin management
- Powerlevel10k theme
- Oh-My-Zsh plugins
- Syntax highlighting and autosuggestions

### Tools Integration
- **NVM**: Node.js version manager
- **fzf**: Fuzzy file finder
- **zoxide**: Smart directory jumper
- **eza**: Modern ls replacement
- **Git**: Enhanced git aliases and completions

### Custom Features
- Auto-switches Node version based on `.nvmrc` files
- Custom aliases for common tasks
- Private keys management (not committed to git)

## Platform-Specific Notes

### macOS
- Supports both Intel and Apple Silicon (via Homebrew paths)
- iTerm2 shell integration
- macOS-specific aliases (pbcopy, pbpaste, etc.)
- Homebrew-based package paths

### Ubuntu 24.04.3 LTS
- Standard Linux paths
- Alternative clipboard commands (xclip)
- fd-find/bat compatibility aliases
- chruby for Ruby management (if installed)

## Troubleshooting

### Missing Tools
The configuration gracefully handles missing tools. If you see warnings about missing commands:
- Install the tool following the instructions above
- Or ignore if you don't need that specific functionality

### Permission Issues
If you see "insecure directories" warnings from zsh:
```bash
# Fix permissions
compaudit | xargs chmod g-w
# Or ignore by adding to zshrc:
# ZSH_DISABLE_COMPFIX=true (already set)
```

### Antidote Not Found
If antidote is not found:
```bash
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
```

### Private Keys File
If you get errors about missing private_keys:
```bash
cp ~/dotfiles/zsh/private_keys.template ~/dotfiles/zsh/private_keys
```

## Customization

### Adding Private Keys
Edit `~/dotfiles/zsh/private_keys` (this file is gitignored):
```bash
export MY_API_KEY="your-key-here"
export MY_SECRET="your-secret-here"
```

### Custom Aliases
Add to `~/dotfiles/zsh/aliases` or create your own in `~/.zsh_custom`

### Environment Variables
Edit `~/dotfiles/zsh/env`

## Testing

To test the configuration without fully switching:
```bash
zsh -c 'source ~/dotfiles/zshrc'
```

To validate syntax:
```bash
zsh -n ~/dotfiles/zshrc
```

## Contributing

When making changes:
1. Test on both macOS and Ubuntu if possible
2. Use OS detection for platform-specific code
3. Add existence checks for optional tools
4. Update this README with any new requirements

## License

See LICENSE file for details.
