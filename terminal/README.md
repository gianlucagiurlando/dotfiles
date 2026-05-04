# Terminal Configuration

Modular terminal config split across focused files for p10k and WezTerm. A single `colors.yaml` drives colors in both.

---

## Structure

```
terminal/
├── colors.yaml             # single source of truth for all colors
├── sync-colors.sh          # generates p10k/colors.zsh and wezterm/colors.lua
├── install.sh              # symlinks configs to home directory
├── p10k/
│   ├── p10k.zsh            # entry point — sourced by p10k, sources the modules
│   ├── colors.zsh          # auto-generated — do not edit directly
│   ├── symbols.zsh         # icons, glyphs, separators
│   └── segments.zsh        # prompt element lists and per-segment behavior
└── wezterm/
    ├── wezterm.lua         # entry point — required by WezTerm, requires the modules
    ├── colors.lua          # auto-generated — do not edit directly
    ├── fonts.lua           # font family & size
    ├── keybindings.lua     # key mappings
    └── appearance.lua      # window, tabs, padding, cursor, opacity
```

---

## p10k modules

| File | Role |
|------|------|
| `p10k.zsh` | Entry point. Sources `colors.zsh`, `symbols.zsh`, `segments.zsh` in order. Sets global options (instant prompt, transient prompt, mode). |
| `colors.zsh` | Defines all `POWERLEVEL9K_*_FOREGROUND` / `_BACKGROUND` variables. Auto-generated from `colors.yaml` — do not edit by hand. |
| `symbols.zsh` | Every Nerd Font glyph used in the prompt: segment separators, git icons, status icons. Safe to edit freely. |
| `segments.zsh` | `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS`, `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS`, and all per-segment config (thresholds, git formatter, show-on-command). |

After any edit to p10k files, apply with:

```zsh
source ~/.p10k.zsh
```

---

## WezTerm modules

| File | Role |
|------|------|
| `wezterm.lua` | Entry point. Requires all modules and merges their tables into a single config returned to WezTerm. |
| `colors.lua` | Color palette table. Auto-generated from `colors.yaml` — do not edit by hand. |
| `fonts.lua` | `font`, `font_size`, and related settings. |
| `keybindings.lua` | `keys` table — modifier + key combinations and their actions. |
| `appearance.lua` | Window decorations, tab bar, padding, background opacity, cursor style. |

WezTerm hot-reloads on file save — no restart needed.

---

## How symlinks work

`install.sh` creates two symlinks so each tool finds its config at the standard path:

```
~/.p10k.zsh    → <repo>/terminal/p10k/p10k.zsh
~/.wezterm.lua → <repo>/terminal/wezterm/wezterm.lua
```

The symlink target is resolved as an absolute path at install time, so it survives `cd` or shell restarts.

Once symlinked, editing any file inside `terminal/p10k/` or `terminal/wezterm/` takes effect immediately — you're editing the live config, which is under version control.

---

## How color sync works

`colors.yaml` is the single source of truth. It contains one named color per line:

```yaml
base: "#1e1e2e"
text: "#cdd6f4"
accent: "#89b4fa"
# ...
```

Running `sync-colors.sh` (or `make sync`) reads this file and:

1. Rewrites `p10k/colors.zsh` — sets xterm-256 indices or hex values as `POWERLEVEL9K_*` variables
2. Rewrites `wezterm/colors.lua` — builds a Lua color table for the WezTerm palette

Both generated files include a header comment warning against direct edits. To change any color, edit `colors.yaml` and re-run `make sync`.

---

## Path resolution

Both entry points resolve their own absolute path so `require` / `source` calls work correctly regardless of where the symlink lives or how the shell was started.

### p10k.zsh — zsh path resolution

```zsh
local _p10k_dir="${${(%):-%x}:A:h}"
```

- `%x` — expands to the path of the currently sourced file (follows symlinks)
- `:A` — resolves to the absolute real path (equivalent to `realpath`)
- `:h` — strips the filename, leaving the directory

This gives the real directory of `p10k.zsh` even when sourced via `~/.p10k.zsh → .../p10k/p10k.zsh`.

### wezterm.lua — Lua path resolution

```lua
local function script_dir()
  local path = io.popen("readlink -f " .. debug.getinfo(2, "S").source:sub(2)):read("*l")
  return path:match("(.*/)") or "./"
end
```

- `debug.getinfo(2, "S").source:sub(2)` — gets the source file path of the calling function, stripping the leading `@`
- `readlink -f` — resolves the symlink to an absolute real path
- `:match("(.*/)") ` — strips the filename, returning the directory

This lets `wezterm.lua` `require` its sibling modules using paths relative to its real location, regardless of where WezTerm looks for `~/.wezterm.lua`.
