# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Cross-platform dotfiles for macOS and Ubuntu 24.04 LTS. Managed via symlinks created by `install.sh`.

## Key Commands

**Install / setup:**

```bash
./install.sh          # Create symlinks, install antidote, scaffold private_keys
```

**Validate zsh config syntax:**

```bash
zsh -n zshrc
```

**Run the test suite:**

```bash
./test-zsh-config.sh
```

**Test config loading (dry run):**

```bash
zsh -c 'source ~/dotfiles/zshrc'
```

## Architecture

### Symlink Map (`install.sh`)

`install.sh` links these repo files into `$HOME`:

| Repo file | Symlink target |
|-----------|---------------|
| `zshrc` | `~/.zshrc` |
| `zsh/zshenv` | `~/.zshenv` |
| `zsh/zsh_plugins.txt` | `~/.zsh_plugins.txt` |
| `gitconfig` | `~/.gitconfig` |
| `gitignore_global` | `~/.gitignore_global` |
| `tmux.conf` | `~/.tmux.conf` |
| `nvim/` | `~/.config/nvim` |

### zshrc Load Order

1. Powerlevel10k instant prompt (top, before any output)
2. Antidote plugin manager (`~/.antidote/`) loads `zsh/zsh_plugins.txt`
3. Shell options & completions
4. PATH configuration (base, then OS-specific)
5. Language runtimes: Go, OCaml, Haskell, Elixir, Node (NVM/Bun/pnpm)
6. Cloud tools: AWS, GCloud, Terraform, Serverless
7. Tool integrations: fzf, zoxide, iTerm2
8. Custom functions from `zsh/functions/`
9. Sources `zsh/env`, `zsh/aliases`, `zsh/private_keys`

### OS Detection

`OSTYPE_REAL=${OSTYPE//[0-9.]/}` strips version numbers, yielding `darwin` or `linux-gnu`. All platform-specific code must guard on this variable.

### Plugin Management

Antidote reads `zsh/zsh_plugins.txt`. Plugins include Powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting, and selected oh-my-zsh plugins (git, npm, node, pip, macos).

### Private / Secret Files

- `zsh/private_keys` — gitignored; holds exported env vars for API keys/tokens
- `zsh/private_keys.template` — committed template to bootstrap from

### Custom Functions

`zsh/functions/` is in `fpath`. Currently contains `auto-switch-node-version`, which fires on `chpwd` to switch Node via NVM when a `.nvmrc` is detected.

## Cross-Platform Rules

- Always guard macOS-only commands with `[[ $OSTYPE_REAL == 'darwin' ]]`
- Always guard Linux-only commands with `[[ $OSTYPE_REAL == 'linux-gnu' ]]`
- Always check file/command existence before sourcing or calling optional tools (`[[ -f ... ]]`, `command -v ...`)
- NVM: use Homebrew path on macOS (`/opt/homebrew/opt/nvm/nvm.sh`), `$NVM_DIR/nvm.sh` on Linux
- pnpm home: `~/Library/pnpm` on macOS, `~/.local/share/pnpm` on Linux
- Linux clipboard: `xclip` instead of `pbcopy`/`pbpaste`; `fd` is `fdfind`; `bat` is `batcat`
