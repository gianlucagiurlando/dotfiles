ZSHDIR="$HOME/repos/templates/dev-environment-files/zsh"

source "$ZSHDIR/p10k.zsh"
source "$ZSHDIR/plugins.zsh"
source "$ZSHDIR/aliases.zsh"
source "$ZSHDIR/path.zsh"
source "$ZSHDIR/functions.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
eval "$(dirdotenv hook zsh)"
