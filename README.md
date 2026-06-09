# Dotfiles

Personal configuration for an **openSUSE + i3** desktop, managed with
[GNU Stow](https://www.gnu.org/software/stow/). Neovim (Lua), i3, Alacritty,
tmux, dunst, and a few shell tools.

## 1. Prerequisites

Install the programs the configs are for, plus `git` and `stow`:

```bash
sudo zypper install git stow neovim alacritty i3 i3status dunst tmux
```

Installed separately (not in the openSUSE repos):
- **[mouseless](https://github.com/jbensmann/mouseless)** — keyboard-driven mouse control
- **[opencode](https://opencode.ai)** — terminal AI coding assistant
- **[Claude Code](https://docs.claude.com/en/docs/claude-code)** — Anthropic's terminal AI assistant (`npm i -g @anthropic-ai/claude-code`)

A [Nerd Font](https://www.nerdfonts.com/) is recommended for icons in Neovim, tmux and i3.

## 2. Install

```bash
# clone into your home directory
git clone https://github.com/sahajdeepsingh651/.dotfiles ~/.dotfiles
cd ~/.dotfiles

# pull in submodules (tmux-resurrect plugin, alacritty themes)
git submodule update --init --recursive

# symlink the configs you want
stow nvim                                                   # just Neovim
stow alacritty bash nvim tmux i3 dunst mouseless opencode systemd   # everything
```

Stow symlinks each package into `$HOME` — e.g. `nvim/.config/nvim/` → `~/.config/nvim/`.
If a target file already exists, move it aside first or stow will refuse.
Undo a package with `stow -D <package>`.

## 3. What's in here

| Package     | Configures                                  | Lands in |
|-------------|---------------------------------------------|----------|
| `alacritty` | Terminal emulator (+ themes submodule)      | `~/.config/alacritty/` |
| `bash`      | Shell — `.bashrc`, aliases                   | `~/.bashrc` |
| `nvim`      | Neovim — LSP, Telescope, Treesitter, …       | `~/.config/nvim/` |
| `tmux`      | tmux (+ tmux-resurrect submodule)            | `~/.tmux.conf` |
| `i3`        | i3 window manager, i3status, helper scripts  | `~/.config/i3/` |
| `dunst`     | Notification daemon                          | `~/.config/dunst/` |
| `mouseless` | Keyboard-driven cursor                       | `~/.config/mouseless/` |
| `opencode`  | OpenCode AI assistant                        | `~/.config/opencode/` |
| `systemd`   | systemd **user** services                    | `~/.config/systemd/user/` |
| `devchron`  | DevChron                                     | `~/.config/devchron/` |

## 4. Post-install notes

- **Neovim:** first launch auto-installs plugins (lazy.nvim) and LSP servers (Mason).
- **systemd user services:** after stowing `systemd`, enable a unit with
  ```bash
  systemctl --user daemon-reload
  systemctl --user enable --now dunst.service
  ```
- **Secrets:** API keys live in `bash/.secrets`, which is **gitignored** and sourced
  by `.bashrc`. Create your own; never commit real tokens.
