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

ln -sf "$REPO_ROOT/git/.gitconfig" ~/.gitconfig
echo "✓ ~/.gitconfig → $REPO_ROOT/git/.gitconfig"

ln -sf "$REPO_ROOT/git/.gitignore_global" ~/.gitignore_global
echo "✓ ~/.gitignore_global → $REPO_ROOT/git/.gitignore_global"

ln -sf "$REPO_ROOT/zsh/.zshrc" ~/.zshrc
echo "✓ ~/.zshrc → $REPO_ROOT/zsh/.zshrc"

ln -sf "$REPO_ROOT/tmux/.tmux.conf" ~/.tmux.conf
echo "✓ ~/.tmux.conf → $REPO_ROOT/tmux/.tmux.conf"

ln -sf "$REPO_ROOT/zsh/.zprofile" ~/.zprofile
echo "✓ ~/.zprofile → $REPO_ROOT/zsh/.zprofile"

mkdir -p ~/.config/gh
ln -sf "$REPO_ROOT/gh/config.yml" ~/.config/gh/config.yml
echo "✓ ~/.config/gh/config.yml → $REPO_ROOT/gh/config.yml"
