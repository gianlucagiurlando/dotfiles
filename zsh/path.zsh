# ============ PATH & EXPORTS ============
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"

export PATH="$(brew --prefix qt)/bin:$PATH"
export LDFLAGS="-L$(brew --prefix qt)/lib $LDFLAGS"
export CPPFLAGS="-I$(brew --prefix qt)/include $CPPFLAGS"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export PATH=$HOME/.opencode/bin:$PATH

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
