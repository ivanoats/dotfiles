# Ivan's Dotfiles

Cross-platform ZSH and Neovim configuration for macOS, Ubuntu 24.04 LTS, and GitHub Codespaces.

[![CI](https://github.com/ivanoats/dotfiles/workflows/CI%20-%20Test%20Shell%20Configuration/badge.svg)](https://github.com/ivanoats/dotfiles/actions/workflows/ci.yml)
[![Shell](https://img.shields.io/badge/shell-zsh-green.svg)](https://www.zsh.org/)
[![Editor](https://img.shields.io/badge/editor-neovim-green.svg)](https://neovim.io/)
[![License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE)

## What's included

**ZSH:**

- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme with instant prompt
- [Antidote](https://github.com/mattmc3/antidote) plugin manager (no Oh-My-Zsh required)
- Syntax highlighting, autosuggestions, fuzzy history
- Auto-switching Node versions via `.nvmrc` (NVM)
- Cross-platform: macOS and Ubuntu paths handled automatically
- Aliases, custom functions, and private keys support (gitignored)

**Neovim** (`nvim/`):

- Lua-based config with LSP via Mason, Treesitter, Telescope, OneDark theme

**Legacy** (maintained but not actively developed): vim, tmux, bash, gitconfig

## Quick start

### GitHub Codespaces

1. Go to [Codespaces Settings](https://github.com/settings/codespaces)
2. Under "Dotfiles", enable automatic install and select `ivanoats/dotfiles`
3. Any new Codespace will have your environment ready automatically

### Local install

```bash
git clone https://github.com/ivanoats/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
source ~/.zshrc
```

`install.sh` will: clone Antidote, create symlinks, and scaffold `zsh/private_keys` from the template.

### Install recommended CLI tools

```bash
./install-tools.sh
```

Installs `fzf`, `zoxide`, `eza`, `bat`, `fd`, `ripgrep`, and `neovim` via Homebrew (macOS) or apt/cargo (Ubuntu).

## Configuration

### Private environment variables

Add API keys and secrets to `~/dotfiles/zsh/private_keys` — this file is gitignored:

```bash
cp zsh/private_keys.template zsh/private_keys
```

Then, edit zsh/private_keys and add your exports

### Local overrides

Anything you don't want to commit can go in `~/.zshrc.local` (sourced automatically if it exists).

### Customize your prompt

```bash
p10k configure
```

## Platform notes

| Platform              | Status          |
| --------------------- | --------------- |
| macOS (Apple Silicon) | Fully supported |
| macOS (Intel)         | Fully supported |
| Ubuntu 24.04 LTS      | Fully supported |
| GitHub Codespaces     | Fully supported |

- macOS-only tools (iTerm2, pbcopy, Homebrew paths) are guarded with OS detection
- Linux uses `xclip`, `batcat`, `fdfind` with appropriate aliases
- NVM uses Homebrew path on macOS, `$NVM_DIR` on Linux

## Testing

```bash
# Validate zsh config syntax
zsh -n zshrc

# Run the full test suite
./test-zsh-config.sh
```

## Contributing

1. Fork and clone the repo
2. Create a branch: `git checkout -b feat/your-change`
3. Keep platform compatibility in mind:
   - Guard macOS-only code with `[[ $OSTYPE_REAL == 'darwin' ]]`
   - Guard Linux-only code with `[[ $OSTYPE_REAL == 'linux-gnu' ]]`
   - Check tool existence before sourcing: `[[ -f ... ]]` or `command -v ...`
4. Run `./test-zsh-config.sh` before opening a PR
5. Open a PR — CI will test on both Ubuntu and macOS

## License

See [LICENSE](LICENSE.md).
