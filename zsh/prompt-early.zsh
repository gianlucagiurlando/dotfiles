# ============ PROMPT ENGINE — EARLY STAGE ============
# Runs before plugins.zsh sources oh-my-zsh, because ZSH_THEME must already be
# set (or explicitly emptied) by the time oh-my-zsh.sh loads a theme.
# Reads zsh/.prompt-engine. Switch with:  make prompt-p10k  |  make prompt-starship

_engine_file="$ZSHDIR/.prompt-engine"
_engine=""
[[ -f "$_engine_file" ]] && _engine="$(<"$_engine_file")"
_engine="${_engine//[[:space:]]/}"

case "$_engine" in
  p10k)
    export ZSH_THEME="powerlevel10k/powerlevel10k"
    # Instant-prompt cache + ~/.p10k.zsh sourcing live in zsh/p10k.zsh (single
    # source of truth for that logic — do not copy-paste it here).
    source "$ZSHDIR/p10k.zsh"
    ;;
  starship)
    # Empty (not unset) tells oh-my-zsh to load no theme at all, so nothing
    # sets a PROMPT before Starship's own precmd hook takes over in
    # prompt-late.zsh.
    ZSH_THEME=""
    ;;
  *)
    echo "prompt-early.zsh: unknown or missing prompt engine in $_engine_file (got: '${_engine:-<empty>}') — defaulting to p10k" >&2
    export ZSH_THEME="powerlevel10k/powerlevel10k"
    source "$ZSHDIR/p10k.zsh"
    ;;
esac

unset _engine_file _engine
