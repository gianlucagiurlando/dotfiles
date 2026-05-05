#!/usr/bin/env bash
set -e
DOTFILES="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ln -sf "$DOTFILES/p10k/p10k.zsh" ~/.p10k.zsh
echo "✓ ~/.p10k.zsh → $DOTFILES/p10k/p10k.zsh"

ln -sf "$DOTFILES/wezterm/wezterm.lua" ~/.wezterm.lua
echo "✓ ~/.wezterm.lua → $DOTFILES/wezterm/wezterm.lua"

ln -sf "$REPO_ROOT/nvim" ~/.config/nvim
echo "✓ ~/.config/nvim → $REPO_ROOT/nvim"
