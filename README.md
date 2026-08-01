# dotfiles

Personal, modular dev environment configs — version-controlled and symlink-based. Every tool finds its config at the path it expects; the source of truth lives here.

Covers terminal setup, Neovim, Git, zsh, tmux, and gh CLI. Designed to grow into a full environment covering SSH and more.

---

## Structure

```
dotfiles/
├── Makefile                    # shortcuts for editing and switching
├── README.md
├── git/
│   ├── .gitconfig              # public git config → ~/.gitconfig
│   └── .gitignore_global       # global ignore → ~/.gitignore_global
├── gh/
│   └── config.yml              # gh CLI preferences & aliases → ~/.config/gh/config.yml
├── nvim/                       # LazyVim config → ~/.config/nvim
├── tmux/
│   └── .tmux.conf              # tmux config → ~/.tmux.conf
├── zsh/                        # modular zsh config → ~/.zshrc
│   ├── .zshrc                  # entry point
│   ├── .zprofile               # env setup (Homebrew, PATH) → ~/.zprofile
│   ├── .prompt-engine          # active prompt engine: "p10k" or "starship"
│   ├── prompt-early.zsh        # sets/empties ZSH_THEME, sourced before plugins.zsh
│   ├── prompt-late.zsh         # inits Starship (if selected), sourced last
│   ├── p10k.zsh                # p10k instant-prompt shim, sources ~/.p10k.zsh
│   ├── plugins.zsh             # oh-my-zsh + plugins
│   ├── aliases.zsh             # shell aliases
│   ├── path.zsh                # PATH & exports
│   └── functions.zsh           # shell functions
└── terminal/
    ├── install.sh              # symlinks configs to home directory
    ├── README.md
    ├── p10k/
    │   ├── p10k.zsh            # entry point → ~/.p10k.zsh (colors set inline)
    │   ├── symbols.zsh         # icons, glyphs, separators
    │   └── segments.zsh        # prompt elements & git formatter
    ├── starship/
    │   └── starship.toml       # entry point → ~/.config/starship.toml
    ├── ghostty/
    │   ├── config              # entry point → ~/.config/ghostty/config (config-file includes only)
    │   ├── colors.ghostty       # theme = "Catppuccin Mocha"
    │   ├── fonts.ghostty        # font family & size
    │   └── keybindings.ghostty  # key bindings (minimal for now)
    └── wezterm/
        ├── wezterm.lua         # entry point → ~/.wezterm.lua
        ├── fonts.lua           # font family & size
        ├── keybindings.lua     # key mappings
        └── appearance.lua      # window, tabs, padding, opacity, color_scheme
```

---

## Philosophy

Most dotfile repos are single-file monoliths. A 1700-line `~/.p10k.zsh` works, but every edit is a grep hunt and diffs are unreadable.

This repo separates each concern into its own file — colors, symbols, segments, fonts, keybindings each get their own home, per tool.

| Principle | How it's applied |
|-----------|-----------------|
| **Modular** | Each file has one job — colors, symbols, segments, fonts, keybindings |
| **Version controlled** | All configs live here, not scattered in `~` |
| **Symlink-based** | `install.sh` links config files here — tools find configs where they expect them |
| **Swappable** | The prompt engine (p10k vs Starship) is a one-line switch, not a rewrite |

### Colors are decentralized by design

Earlier versions of this repo tried to make `colors.yaml` a single shared source of truth, generating `p10k/colors.zsh` and `wezterm/colors.lua` via a sync script. In practice the tools drifted from it anyway — WezTerm's `color_scheme` got hand-edited directly, the generated files went stale, and the "single source of truth" was a source of truth for nothing.

So: **each tool now owns its own color config directly, hand-edited, no shared file.**

- WezTerm → `terminal/wezterm/appearance.lua` (`color_scheme = 'Catppuccin Mocha'`)
- Ghostty → `terminal/ghostty/colors.ghostty` (`theme = "Catppuccin Mocha"`)
- p10k → `terminal/p10k/p10k.zsh` (Catppuccin Mocha hex values set inline)
- Starship → `terminal/starship/starship.toml` (Catppuccin Mocha palette, from the official preset)

They currently agree on Catppuccin Mocha because that's the theme in use everywhere right now — not because a script enforces it. Changing the theme means editing each file directly. This is a deliberate tradeoff: one less layer of indirection to debug, at the cost of updating N files instead of one when the palette changes. Given how rarely the palette actually changes, that's the right side of the tradeoff.

---

## Stack

| Tool | Role |
|------|------|
| **zsh** | Shell |
| **Powerlevel10k** | Prompt engine (default) — fast, highly configurable, git-aware |
| **Starship** | Prompt engine (alternative) — cross-shell, Catppuccin Mocha preset, swap in with `make prompt-starship` |
| **WezTerm** | GPU-accelerated terminal emulator — Lua-configurable, multiplexer built in |
| **Ghostty** | GPU-accelerated terminal emulator (alternative) — native, fast startup, config-file includes |
| **tmux** | Terminal multiplexer — sessions, panes, vim-keybindings, TPM plugins |
| **gh** | GitHub CLI — configured with `co` alias and https protocol |
| **Nerd Fonts** | Icon glyphs used by the prompt (nerdfont-v3) |

---

## Getting started

### Prerequisites

- zsh with [Powerlevel10k](https://github.com/romkatv/powerlevel10k) installed
- [Starship](https://starship.rs) installed (optional — only needed if you switch to it)
- [WezTerm](https://wezfurlong.org/wezterm/) and/or [Ghostty](https://ghostty.org) installed
- [tmux](https://github.com/tmux/tmux) with [TPM](https://github.com/tmux-plugins/tpm) installed
- [gh](https://cli.github.com) CLI installed
- A [Nerd Font](https://www.nerdfonts.com) configured in your terminal(s) (e.g. a PragmataPro or JetBrainsMono Nerd Font build)

### Install

> **Important:** always run `make` from the repo root.
> ```bash
> cd ~/repos/dotfiles
> make install
> ```

```bash
git clone https://github.com/gianlucagiurlando/dotfiles.git
cd dotfiles
make install
```

`install.sh` creates the symlinks:

```
~/.p10k.zsh              → .../terminal/p10k/p10k.zsh
~/.wezterm.lua           → .../terminal/wezterm/wezterm.lua
~/.config/nvim           → .../nvim/
~/.gitconfig             → .../git/.gitconfig
~/.gitignore_global      → .../git/.gitignore_global
~/.zshrc                 → .../zsh/.zshrc
~/.zprofile              → .../zsh/.zprofile
~/.tmux.conf             → .../tmux/.tmux.conf
~/.config/gh/config.yml  → .../gh/config.yml
~/.config/starship.toml  → .../terminal/starship/starship.toml
~/.config/ghostty        → .../terminal/ghostty/
```

Then reload your shell:

```zsh
source ~/.zshrc
```

---

## How to customize

All common edits have Makefile shortcuts. Run `make help` to see the full list.

### Prompt symbols and icons

```bash
make edit-symbols   # opens terminal/p10k/symbols.zsh
```

### Prompt segments

```bash
make edit-segments  # opens terminal/p10k/segments.zsh
```

Edit `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS` / `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS` and per-segment config grouped below.

### Colors

There's no single color file anymore — see [Colors are decentralized by design](#colors-are-decentralized-by-design). Edit the tool directly:

```bash
nvim terminal/wezterm/appearance.lua    # WezTerm color_scheme
nvim terminal/ghostty/colors.ghostty    # Ghostty theme
nvim terminal/p10k/p10k.zsh             # p10k color block, near the top
nvim terminal/starship/starship.toml    # Starship palette
```

### Starship

```bash
make edit-starship   # opens terminal/starship/starship.toml
```

### Ghostty

```bash
make edit-ghostty   # opens colors.ghostty, fonts.ghostty, keybindings.ghostty as tabs
```

### WezTerm appearance

```bash
make edit-wezterm      # window, tabs, padding, opacity
make edit-fonts        # font family & size
make edit-keybindings  # key mappings
```

### tmux

```bash
make edit-tmux   # opens tmux/.tmux.conf
```

After saving, reload inside a running tmux session with `prefix + r` (bound to source-file).

### gh CLI

```bash
make edit-gh   # opens gh/config.yml
```

### Push changes

```bash
make push   # git add . && commit && push
```

---

## Switching prompts

The active prompt engine is a single word in `zsh/.prompt-engine` (`p10k` or `starship`), read at two points during shell startup: `zsh/prompt-early.zsh` (first line of `.zshrc`) and `zsh/prompt-late.zsh` (last line). Switch with:

```bash
make prompt-p10k       # writes "p10k" to zsh/.prompt-engine
make prompt-starship   # writes "starship" to zsh/.prompt-engine
```

Then reload your shell (`source ~/.zshrc` or open a new terminal). If `.prompt-engine` is missing or contains anything unrecognized, `prompt-early.zsh` prints a warning and falls back to p10k, so a broken switch never leaves you with no prompt at all — `prompt-late.zsh` stays silent in that case rather than warning twice.

The split exists because oh-my-zsh's `ZSH_THEME` has to be set (or explicitly emptied) *before* `plugins.zsh` sources oh-my-zsh, while Starship's own init has to run *after* everything else — otherwise both would register competing precmd hooks and fight over the prompt:

- **`prompt-early.zsh`** (before `plugins.zsh`): for `p10k`, exports `ZSH_THEME="powerlevel10k/powerlevel10k"` and sources `zsh/p10k.zsh` (unchanged — instant-prompt cache, then `~/.p10k.zsh`). For `starship`, sets `ZSH_THEME=""` (empty, not unset) so oh-my-zsh loads no theme at all.
- **`prompt-late.zsh`** (last line of `.zshrc`): for `starship`, runs `eval "$(starship init zsh)"`. For `p10k`, does nothing — the prompt is already fully initialized by that point.

Powerlevel10k's instant-prompt feature still works exactly as before: the cache-loading logic lives in exactly one place, `zsh/p10k.zsh`, and `prompt-early.zsh` sources that file rather than duplicating its contents.

---

## Roadmap

- [x] `nvim/` — LazyVim config
- [x] `git/` — `.gitconfig`, global ignore
- [x] `zsh/` — modular `.zshrc` + `.zprofile` + prompt-engine switch
- [x] `tmux/` — `.tmux.conf` with TPM plugins
- [x] `gh/` — gh CLI config and aliases
- [x] `terminal/starship/` — Starship as an alternative prompt engine
- [x] `terminal/ghostty/` — Ghostty as an alternative terminal emulator
- [ ] `ssh/` — future, add when needed; will follow the same public/private split as `git/` (public host config in repo, private identities/keys outside)

---

## License

MIT
