#!/usr/bin/env bash
# Installs the CLI tools and languages this dev environment expects, on Ubuntu.
# Safe to re-run: every step checks for an existing install first.
set -euo pipefail

INSTALLED=()
PRESENT=()
SKIPPED=()

note_installed() { INSTALLED+=("$1"); }
note_present()   { PRESENT+=("$1"); }
note_skipped()   { SKIPPED+=("$1 ($2)"); }

echo "==> apt packages"
sudo apt-get update -y

apt_packages=(ripgrep fzf jq bat tree direnv cmake ninja-build stow pipx)
to_install=()
for pkg in "${apt_packages[@]}"; do
  if dpkg -s "$pkg" &>/dev/null; then
    note_present "$pkg (apt)"
  else
    to_install+=("$pkg")
  fi
done

if [ "${#to_install[@]}" -gt 0 ]; then
  sudo apt-get install -y "${to_install[@]}"
  for pkg in "${to_install[@]}"; do note_installed "$pkg (apt)"; done
fi

echo "==> lazygit"
if command -v lazygit &>/dev/null; then
  note_present "lazygit ($(lazygit --version | grep -oP 'version=\K[^,]+' || echo installed))"
else
  case "$(uname -m)" in
    x86_64) lg_arch="x86_64" ;;
    aarch64|arm64) lg_arch="arm64" ;;
    *)
      echo "  ! unsupported architecture $(uname -m), skipping lazygit" >&2
      note_skipped "lazygit" "unsupported architecture $(uname -m)"
      lg_arch=""
      ;;
  esac

  if [ -n "$lg_arch" ]; then
    lg_version="$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": *"v\K[^"]+')"
    tmp_dir="$(mktemp -d)"
    curl -fsSL -o "$tmp_dir/lazygit.tar.gz" \
      "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${lg_version}_linux_${lg_arch}.tar.gz"
    tar -xf "$tmp_dir/lazygit.tar.gz" -C "$tmp_dir" lazygit
    sudo install "$tmp_dir/lazygit" /usr/local/bin/lazygit
    rm -rf "$tmp_dir"
    note_installed "lazygit $lg_version"
  fi
fi

echo "==> pipx-managed tools"
pipx_tools=(poetry ipython)
for tool in "${pipx_tools[@]}"; do
  if pipx list --short 2>/dev/null | grep -q "^${tool} "; then
    note_present "$tool (pipx)"
  else
    pipx install "$tool"
    note_installed "$tool (pipx)"
  fi
done

echo "==> uv"
if command -v uv &>/dev/null; then
  note_present "uv"
else
  # UV_NO_MODIFY_PATH: this repo centralizes PATH changes in zsh/path.zsh,
  # not in installer-edited rc files.
  curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
  note_installed "uv"
fi

echo "==> pyenv"
if command -v pyenv &>/dev/null || [ -d "$HOME/.pyenv" ]; then
  note_present "pyenv"
else
  curl -fsSL https://pyenv.run | bash
  note_installed "pyenv"
  PYENV_REMINDER=1
fi

echo "==> starship"
if command -v starship &>/dev/null; then
  note_present "starship"
else
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y
  note_installed "starship"
fi

echo "==> codex"
if command -v codex &>/dev/null; then
  note_present "codex"
else
  # Ensure ~/.local/bin (codex's install dir) is already on PATH so the
  # installer sees no work to do and leaves rc files untouched — PATH
  # changes for this repo live in zsh/path.zsh only.
  curl -fsSL https://chatgpt.com/codex/install.sh | env PATH="$HOME/.local/bin:$PATH" sh
  note_installed "codex"
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
if [ "${#SKIPPED[@]}" -gt 0 ]; then
  echo "Skipped:"
  printf '  ! %s\n' "${SKIPPED[@]}"
fi
echo "=============================================================="

if [ "${PYENV_REMINDER:-0}" = "1" ]; then
  echo
  echo "pyenv was installed but not wired into your shell."
  echo "zsh/path.zsh already has a guarded pyenv init block, so add"
  echo "\$HOME/.pyenv/bin to the path=(...) list in zsh/path.zsh, then"
  echo "reload your shell (source ~/.zshrc)."
fi
