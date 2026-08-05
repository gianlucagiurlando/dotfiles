# ============ PATH & EXPORTS ============

# pyenv (only if installed)
if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init --path)"
fi

# Homebrew-based Qt setup (macOS only, only if brew exists)
if command -v brew &>/dev/null; then
  export PATH="$(brew --prefix qt)/bin:$PATH"
  export LDFLAGS="-L$(brew --prefix qt)/lib $LDFLAGS"
  export CPPFLAGS="-I$(brew --prefix qt)/include $CPPFLAGS"
  export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
fi

# opencode (only if the directory exists)
[ -d "$HOME/.opencode/bin" ] && export PATH="$HOME/.opencode/bin:$PATH"

# final PATH cleanup — deduplicates entries
typeset -U path PATH
path=(
  $HOME/.local/bin
  /opt/homebrew/bin
  /usr/local/bin
  /Library/TeX/texbin
  /Applications/Skim.app/Contents/SharedSupport
  $path
)
export PATH="$PATH:/opt/nvim/bin"
export PATH="$HOME/.opencode/bin:$PATH"
