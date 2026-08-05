#!/usr/bin/env bash
# Installs the CLI tools and languages this dev environment expects, on macOS.
# Mirrors bootstrap/ubuntu.sh's tool list via Homebrew. Kept for documenting
# and reproducing a fresh Mac setup — not needed on machines already set up.
set -euo pipefail

if ! command -v brew &>/dev/null; then
  echo "Homebrew is required: https://brew.sh" >&2
  exit 1
fi

INSTALLED=()
PRESENT=()

note_installed() { INSTALLED+=("$1"); }
note_present()   { PRESENT+=("$1"); }

echo "==> brew formulae"
formulae=(ripgrep fzf jq bat tree direnv cmake ninja stow lazygit pipx uv pyenv poetry ipython)
to_install=()
for pkg in "${formulae[@]}"; do
  if brew list --formula "$pkg" &>/dev/null; then
    note_present "$pkg (brew)"
  else
    to_install+=("$pkg")
  fi
done

if [ "${#to_install[@]}" -gt 0 ]; then
  brew install "${to_install[@]}"
  for pkg in "${to_install[@]}"; do note_installed "$pkg (brew)"; done
fi

echo "==> codex"
if brew list --cask codex &>/dev/null; then
  note_present "codex (brew cask)"
else
  brew install --cask codex
  note_installed "codex (brew cask)"
fi

echo
echo "==================== bootstrap summary ===================="
if [ "${#INSTALLED[@]}" -gt 0 ]; then
  echo "Installed:"
  printf '  + %s\n' "${INSTALLED[@]}"
fi
if [ "${#PRESENT[@]}" -gt 0 ]; then
  echo "Already present:"
  printf '  = %s\n' "${PRESENT[@]}"
fi
echo "=============================================================="

echo
echo "pyenv installed via brew already puts \$(brew --prefix pyenv)/bin on PATH"
echo "through /opt/homebrew/bin — zsh/path.zsh's guarded pyenv init block"
echo "will pick it up with no further changes needed."
