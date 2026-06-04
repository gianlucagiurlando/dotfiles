# ============ SYMBOLS & ICONS ============
# Nerd Font glyphs, prompt separators, and visual layout characters.
# Requires: nerdfont-v3 font (e.g. MesloLGS NF, JetBrainsMono Nerd Font).

# ---- SEPARATORS ----

# Character set — nerdfont-v3 enables all Nerd Font v3 glyphs.
typeset -g POWERLEVEL9K_MODE=nerdfont-v3
# Extra space after icons: 'moderate' adds space, 'none' does not.
typeset -g POWERLEVEL9K_ICON_PADDING=none
# Icons appear before segment content on both sides.
typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=true

# No whitespace surrounding segment content.
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
# Single space between adjacent segments.
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
# No end-of-line symbol between left and right prompts.
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=

# No symbol at the very start of left prompt or end of right prompt.
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=

# Ruler character (used when POWERLEVEL9K_SHOW_RULER=true).
typeset -g POWERLEVEL9K_RULER_CHAR='─'        # reasonable alternative: '·'

# ---- MULTILINE PREFIX / SUFFIX ----
# Connectors drawn between multi-line prompt rows (all empty = lean style).

typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX=
typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX=
typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX=

# ---- SEGMENT ICONS ----

# -- Prompt char (❯ / ❮ / V / ▶) --
# typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
# typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
# typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
# typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'

typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='●'
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'

# No symbol appended/prepended around prompt_char itself.
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=

# -- VCS / git --
# VCS type icon for github.com remotes.
# Default is U+F113 (octocat); override with U+F1D3 (git wordmark glyph).
typeset -g POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$''
# Branch icon (U+F126 = git-branch glyph).
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' '
# Untracked files marker.
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

# -- Status --
typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✔'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✔'
typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'

# ---- DECORATORS ----

# Battery pictograms from empty → full (Nerd Font battery icons U+F008E … U+F0079).
typeset -g POWERLEVEL9K_BATTERY_STAGES='\UF008E\UF007A\UF007B\UF007C\UF007D\UF007E\UF007F\UF0080\UF0081\UF0082\UF0079'
