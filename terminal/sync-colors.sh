#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
YAML="$SCRIPT_DIR/colors.yaml"
WEZTERM_LUA="$SCRIPT_DIR/wezterm/colors.lua"
P10K_ZSH="$SCRIPT_DIR/p10k/colors.zsh"

echo "sync-colors: reading $YAML"
echo ""

python3 - "$YAML" "$WEZTERM_LUA" "$P10K_ZSH" <<'PYEOF'
import sys, re

yaml_file, lua_file, zsh_file = sys.argv[1], sys.argv[2], sys.argv[3]

with open(yaml_file) as f:
    src = f.read()

# ── Parse palette ──────────────────────────────────────────────────────────
palette = {}
for m in re.finditer(
    r'^\s{2}(\w+):\s*\{\s*hex:\s*"(#[0-9a-fA-F]{6})"'
    r'(?:,\s*ansi:\s*(\d+))?(?:,\s*xterm256:\s*(\d+))?\s*\}',
    src, re.MULTILINE
):
    e = {'hex': m.group(2)}
    if m.group(3): e['ansi'] = int(m.group(3))
    if m.group(4): e['xterm256'] = int(m.group(4))
    palette[m.group(1)] = e

# ── Parse prompt roles ─────────────────────────────────────────────────────
prompt_roles = {
    m.group(1): m.group(2)
    for m in re.finditer(r'^\s{2}(\w+):\s*\{\s*role:\s*(\w+)\s*\}', src, re.MULTILINE)
}

# ── Regenerate wezterm/colors.lua ──────────────────────────────────────────
ANSI   = ['black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white']
BRIGHT = ['bright_' + c for c in ANSI]

def lua_list(names):
    return '\n'.join(
        f'\t\t\t"{palette[n]["hex"]}", -- {n.replace("_", " ")}'
        for n in names
    )

p = palette
lua = f"""\
-- ============ COLOR PALETTE ============
-- Single source of truth for terminal colors, shared with p10k later.

local M = {{}}

M.config = {{
\tcolors = {{
\t\tforeground    = "{p['foreground']['hex']}",
\t\tbackground    = "{p['background']['hex']}",
\t\tcursor_bg     = "{p['cursor']['hex']}",
\t\tcursor_border = "{p['cursor']['hex']}",
\t\tcursor_fg     = "{p['cursor_fg']['hex']}",
\t\tselection_bg  = "{p['selection_bg']['hex']}",
\t\tselection_fg  = "{p['selection_fg']['hex']}",
\t\tansi = {{
{lua_list(ANSI)}
\t\t}},
\t\tbrights = {{
{lua_list(BRIGHT)}
\t\t}},
\t}},
}}

return M
"""

with open(lua_file, 'w') as f:
    f.write(lua)
print("[wezterm/colors.lua]  regenerated")

# ── Update p10k/colors.zsh ─────────────────────────────────────────────────
# Maps YAML prompt role names to the p10k variables they govern.
ROLE_MAP = {
    'directory':    ['POWERLEVEL9K_DIR_FOREGROUND'],
    'dir_anchor':   ['POWERLEVEL9K_DIR_ANCHOR_FOREGROUND'],
    'git_clean':    ['POWERLEVEL9K_VCS_CLEAN_FOREGROUND',
                     'POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND',
                     'POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR'],
    'git_modified': ['POWERLEVEL9K_VCS_MODIFIED_FOREGROUND'],
    'prompt_ok':    ['POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND',
                     'POWERLEVEL9K_STATUS_OK_FOREGROUND',
                     'POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND'],
    'prompt_error': ['POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND',
                     'POWERLEVEL9K_STATUS_ERROR_FOREGROUND',
                     'POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND',
                     'POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND'],
    'time':         ['POWERLEVEL9K_TIME_FOREGROUND'],
    'exec_time':    ['POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND'],
    'aws':          ['POWERLEVEL9K_AWS_DEFAULT_FOREGROUND'],
}

with open(zsh_file) as f:
    zsh = f.read()

changed, unchanged, warnings = [], [], []

for role, color_name in prompt_roles.items():
    color = palette.get(color_name, {})
    if 'xterm256' not in color:
        warnings.append(f"  SKIP  {role}: color '{color_name}' has no xterm256 entry")
        continue
    xterm = color['xterm256']
    for var in ROLE_MAP.get(role, []):
        pat = rf'(typeset -g {re.escape(var)}=)(\d+)'
        m = re.search(pat, zsh)
        if not m:
            warnings.append(f"  WARN  variable not found in file: {var}")
            continue
        old = int(m.group(2))
        zsh = re.sub(pat, rf'\g<1>{xterm}', zsh)
        if old != xterm:
            changed.append((var, old, xterm))
        else:
            unchanged.append((var, xterm))

with open(zsh_file, 'w') as f:
    f.write(zsh)

print(f"[p10k/colors.zsh]     {len(changed)} changed, {len(unchanged)} already correct")
for var, old, new in changed:
    print(f"    {var}: {old} → {new}")
for w in warnings:
    print(w)

print()
print("─" * 60)
print("Palette:")
for name, e in palette.items():
    xpart = f"  xterm256={e['xterm256']}" if 'xterm256' in e else ''
    print(f"  {name:16s}  {e['hex']}{xpart}")
print()
print("Prompt roles:")
for role, color in prompt_roles.items():
    xterm = palette.get(color, {}).get('xterm256', '—')
    print(f"  {role:14s} → {color:12s}  xterm256={xterm}")
PYEOF
