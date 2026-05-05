# ============ PLUGINS ============
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

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
