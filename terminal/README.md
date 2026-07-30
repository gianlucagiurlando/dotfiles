# Terminal Configuration

Modular terminal config split across focused files, covering two prompt engines (p10k, Starship) and two terminal emulators (WezTerm, Ghostty). Each tool owns its own color config directly — see the top-level README's "Colors are decentralized by design" for why.

---

## Usage

> **Important:** always run `make` from the repo root — not from inside `terminal/`.

```bash
cd ~/repos/dev-environment-files
make install
```

---

## Structure

```
terminal/
├── install.sh              # symlinks configs to home directory
├── p10k/
│   ├── p10k.zsh            # entry point — sourced by p10k, sources the modules, sets colors inline
│   ├── symbols.zsh         # icons, glyphs, separators
│   └── segments.zsh        # prompt element lists and per-segment behavior
├── starship/
│   └── starship.toml       # entry point — Catppuccin Mocha preset (starship preset catppuccin-powerline)
├── ghostty/
│   ├── config              # entry point — config-file includes only, no settings directly
│   ├── colors.ghostty       # theme = "Catppuccin Mocha"
│   ├── fonts.ghostty        # font family & size
│   └── keybindings.ghostty  # key bindings (minimal for now)
└── wezterm/
    ├── wezterm.lua         # entry point — required by WezTerm, requires the modules
    ├── fonts.lua           # font family & size
    ├── keybindings.lua     # key mappings
    └── appearance.lua      # window, tabs, padding, cursor, opacity, color_scheme
```

---

## p10k modules

| File | Role |
|------|------|
| `p10k.zsh` | Entry point. Sets all `POWERLEVEL9K_*_FOREGROUND` / `_BACKGROUND` color variables inline (Catppuccin Mocha), then sources `symbols.zsh` and `segments.zsh`. Also sets global options (instant prompt, transient prompt, mode). |
| `symbols.zsh` | Every Nerd Font glyph used in the prompt: segment separators, git icons, status icons. Safe to edit freely. |
| `segments.zsh` | `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS`, `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS`, and all per-segment config (thresholds, git formatter, show-on-command). The git formatter's inline branch/status colors are hand-set to match the palette in `p10k.zsh`. |

After any edit to p10k files, apply with:

```zsh
source ~/.p10k.zsh
```

This repo also supports Starship as an alternative prompt engine — see the top-level README's "Switching prompts" section.

---

## WezTerm modules

| File | Role |
|------|------|
| `wezterm.lua` | Entry point. Requires all modules and merges their tables into a single config returned to WezTerm. |
| `fonts.lua` | `font`, `font_size`, and related settings. |
| `keybindings.lua` | `keys` table — modifier + key combinations and their actions. |
| `appearance.lua` | Window decorations, tab bar, padding, background opacity, cursor style, and `color_scheme` (hand-set, e.g. `'Catppuccin Mocha'`). |

WezTerm hot-reloads on file save — no restart needed.

---

## Ghostty modules

| File | Role |
|------|------|
| `config` | Entry point. Contains **only** `config-file = "..."` lines pointing at the three files below. Per Ghostty's docs, `config-file` includes load *after* the file that references them and win on conflicting keys — keeping the entry point include-only avoids ever hitting that ordering surprise. |
| `colors.ghostty` | `theme = "Catppuccin Mocha"` (exact name confirmed via `ghostty +list-themes`). |
| `fonts.ghostty` | `font-family`, `font-size` — matched to `wezterm/fonts.lua` for visual consistency across emulators. |
| `keybindings.ghostty` | `keybind = ...` lines. Currently minimal — Ghostty's defaults apply until this is filled in. |

Ghostty hot-reloads config on save (or `super+shift+,` by default).

---

## Starship module

| File | Role |
|------|------|
| `starship.toml` | Full prompt config, generated via `starship preset catppuccin-powerline` (palette defaults to `catppuccin_mocha`). Hand-editable after generation. |

Starship is an alternative to p10k, not a dependency of it — only needed on machines where you've switched via `make prompt-starship`.

---

## How symlinks work

`install.sh` creates symlinks so each tool finds its config at the standard path:

```
~/.p10k.zsh              → <repo>/terminal/p10k/p10k.zsh
~/.wezterm.lua           → <repo>/terminal/wezterm/wezterm.lua
~/.config/starship.toml  → <repo>/terminal/starship/starship.toml
~/.config/ghostty/config → <repo>/terminal/ghostty/config
```

The symlink target is resolved as an absolute path at install time, so it survives `cd` or shell restarts.

Once symlinked, editing any file inside these directories takes effect immediately — you're editing the live config, which is under version control.

---

## Path resolution

Both the p10k and WezTerm entry points resolve their own absolute path so `require` / `source` calls work correctly regardless of where the symlink lives or how the shell was started. (Ghostty doesn't need this — its `config-file` paths are resolved by Ghostty itself, relative to the file containing the directive.)

### p10k.zsh — zsh path resolution

```zsh
local _cfg="${${(%):-%x}:A:h}"
```

- `%x` — expands to the path of the currently sourced file (follows symlinks)
- `:A` — resolves to the absolute real path (equivalent to `realpath`)
- `:h` — strips the filename, leaving the directory

This gives the real directory of `p10k.zsh` even when sourced via `~/.p10k.zsh → .../p10k/p10k.zsh`.

### wezterm.lua — Lua path resolution

```lua
local handle = io.popen("readlink -f " .. wezterm.config_file)
local real_path = handle:read("*l")
handle:close()
local config_dir = real_path:match("^(.-)[^/]+$")
```

- `wezterm.config_file` — the path WezTerm loaded (the `~/.wezterm.lua` symlink)
- `readlink -f` — resolves the symlink to an absolute real path
- `match("^(.-)[^/]+$")` — strips the filename, returning the directory

This lets `wezterm.lua` `require`/`dofile` its sibling modules using paths relative to its real location, regardless of where WezTerm looks for `~/.wezterm.lua`.
