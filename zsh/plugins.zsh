# ============ PLUGINS ============
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME is set conditionally by prompt-early.zsh (sourced before this
# file), based on zsh/.prompt-engine.

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  history-substring-search
  z
  git virtualenv
)

source $ZSH/oh-my-zsh.sh
