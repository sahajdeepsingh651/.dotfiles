# Dotfiles

Personal configuration files for development tools.

## What's included

- **Alacritty** - Terminal emulator configuration
- **Neovim** - Text editor with plugins (LSP, Telescope, etc.)
- **Tmux** - Terminal multiplexer configuration

## Installation

1. Clone the repository:

   git clone https://github.com/sahajdeepsingh651/.dotfiles
   cd ~/.dotfiles

2 Initialize submodules:

git submodule update --init --recursive

3 Create symlinks:

# Using stow (recommended)

stow alacritty nvim tmux

# Or manually

ln -sf ~/.dotfiles/alacritty/.config/alacritty ~/.config/alacritty
ln -sf ~/.dotfiles/nvim/.config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/tmux/.config/tmux ~/.config/tmux
