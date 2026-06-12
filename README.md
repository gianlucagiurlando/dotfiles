# dev-environment-files

Personal, modular dev environment configs — version-controlled and symlink-based. Every tool finds its config at the path it expects; the source of truth lives here.

Covers terminal setup, Neovim, Git, zsh, tmux, and gh CLI. Designed to grow into a full environment covering SSH and more.

---

## Structure

```
dev-environment-files/
├── Makefile                    # shortcuts for editing and syncing
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
│   ├── p10k.zsh                # instant prompt
│   ├── plugins.zsh             # oh-my-zsh + plugins
│   ├── aliases.zsh             # shell aliases
│   ├── path.zsh                # PATH & exports
│   └── functions.zsh           # shell functions
└── terminal/
    ├── colors.yaml             # single source of truth for all colors
    ├── sync-colors.sh          # generates p10k + wezterm color files from colors.yaml
    ├── install.sh              # symlinks configs to home directory
    ├── README.md
    ├── p10k/
    │   ├── p10k.zsh            # entry point → ~/.p10k.zsh
    │   ├── colors.zsh          # auto-synced from colors.yaml (do not edit directly)
    │   ├── symbols.zsh         # icons, glyphs, separators
    │   └── segments.zsh        # prompt elements & git formatter
    └── wezterm/
        ├── wezterm.lua         # entry point → ~/.wezterm.lua
        ├── colors.lua          # auto-synced from colors.yaml (do not edit directly)
        ├── fonts.lua           # font family & size
        ├── keybindings.lua     # key mappings
        └── appearance.lua      # window, tabs, padding, opacity
```

---

## Philosophy

Most dotfile repos are single-file monoliths. A 1700-line `~/.p10k.zsh` works, but every edit is a grep hunt and diffs are unreadable.

This repo separates each concern into its own file, and treats `colors.yaml` as the single source of truth shared across both the terminal prompt and the terminal emulator.

| Principle | How it's applied |
|-----------|-----------------|
| **Modular** | Each file has one job — colors, symbols, segments, fonts, keybindings |
| **Single color source** | `colors.yaml` feeds both p10k and WezTerm via `sync-colors.sh` |
| **Version controlled** | All configs live here, not scattered in `~` |
| **Symlink-based** | `install.sh` links `~/.p10k.zsh` and `~/.wezterm.lua` here — tools find configs where they expect them |

---

## Stack

| Tool | Role |
|------|------|
| **zsh** | Shell |
| **Powerlevel10k** | Prompt engine — fast, highly configurable, git-aware |
| **WezTerm** | GPU-accelerated terminal emulator — Lua-configurable, multiplexer built in |
| **tmux** | Terminal multiplexer — sessions, panes, vim-keybindings, TPM plugins |
| **gh** | GitHub CLI — configured with `co` alias and https protocol |
| **Nerd Fonts** | Icon glyphs used by the prompt (nerdfont-v3) |

---

## Getting started

### Prerequisites

- zsh with [Powerlevel10k](https://github.com/romkatv/powerlevel10k) installed
- [WezTerm](https://wezfurlong.org/wezterm/) installed
- [tmux](https://github.com/tmux/tmux) with [TPM](https://github.com/tmux-plugins/tpm) installed
- [gh](https://cli.github.com) CLI installed
- A [Nerd Font](https://www.nerdfonts.com) configured in WezTerm (e.g. JetBrainsMono Nerd Font)

### Install

> **Important:** always run `make` from the repo root.
> ```bash
> cd ~/repos/dev-environment-files
> make install
> make sync
> ```

```bash
git clone https://github.com/gianlucagiurlando/dev-environment-files.git
cd dev-environment-files
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
```

Then reload your shell:

```zsh
source ~/.zshrc
```

---

## How to customize

All common edits have Makefile shortcuts. Run `make help` to see the full list.

### Colors (both prompt and terminal)

Edit `terminal/colors.yaml` — this is the single source of truth for every color in both p10k and WezTerm. After editing, sync both configs:

```bash
make sync
```

This runs `sync-colors.sh`, which rewrites `p10k/colors.zsh` and `wezterm/colors.lua` from `colors.yaml`. Do not edit those generated files directly.

### Prompt symbols and icons

```bash
make edit-symbols   # opens terminal/p10k/symbols.zsh
```

### Prompt segments

```bash
make edit-segments  # opens terminal/p10k/segments.zsh
```

Edit `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS` / `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS` and per-segment config grouped below.

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

## Roadmap

- [x] `nvim/` — LazyVim config
- [x] `git/` — `.gitconfig`, global ignore
- [x] `zsh/` — modular `.zshrc` + `.zprofile`
- [x] `tmux/` — `.tmux.conf` with TPM plugins
- [x] `gh/` — gh CLI config and aliases
- [ ] `ssh/` — future, add when needed; will follow the same public/private split as `git/` (public host config in repo, private identities/keys outside)

---

## License

MIT
