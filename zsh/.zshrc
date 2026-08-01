ZSHDIR="$HOME/repos/dotfiles/zsh"

source "$ZSHDIR/prompt-early.zsh"
source "$ZSHDIR/plugins.zsh"
source "$ZSHDIR/aliases.zsh"
source "$ZSHDIR/path.zsh"
source "$ZSHDIR/functions.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
eval "$(dirdotenv hook zsh)"

source "$ZSHDIR/prompt-late.zsh"

