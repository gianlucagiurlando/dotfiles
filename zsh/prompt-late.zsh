# ============ PROMPT ENGINE — LATE STAGE ============
# Runs after everything else in .zshrc. Reads zsh/.prompt-engine again.
# p10k needs nothing here — ZSH_THEME + oh-my-zsh already fully initialized it
# back in prompt-early.zsh. Missing/unrecognized values were already warned
# about there too, so this stays silent instead of warning twice.

_engine_file="$ZSHDIR/.prompt-engine"
_engine=""
[[ -f "$_engine_file" ]] && _engine="$(<"$_engine_file")"
_engine="${_engine//[[:space:]]/}"

case "$_engine" in
  starship)
    eval "$(starship init zsh)"
    ;;
  *)
    # p10k, missing, or unrecognized — nothing to do at this stage.
    ;;
esac

unset _engine_file _engine
