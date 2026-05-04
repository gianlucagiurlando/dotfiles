# dev-environment-files

Personal, modular dev environment configs — version-controlled and symlink-based so every tool finds its file in the expected place while the source of truth lives here.

Currently focused on terminal setup. Designed to grow into a full environment config covering Neovim, Git, SSH, and more.

---

## Structure

```
dev-environment-files/
├── README.md
└── terminal/
    ├── README.md
    ├── install.sh          # creates ~/.p10k.zsh → terminal/p10k/p10k.zsh
    └── p10k/
        ├── p10k.zsh        # entry point — sources the three modules below
        ├── colors.zsh      # all FOREGROUND / BACKGROUND color values
        ├── symbols.zsh     # Nerd Font icons, separators, glyphs
        └── segments.zsh    # prompt elements, git formatter, per-segment config
```

---

## Philosophy

Most dotfile repos are single-file monoliths. A 1700-line `~/.p10k.zsh` works, but it makes every edit a grep hunt and diffs are unreadable.

This repo splits each concern into its own file:

| File | Single responsibility |
|------|-----------------------|
| `colors.zsh` | Every color number in one place — change your palette without touching logic |
| `symbols.zsh` | Every icon and separator — swap Nerd Font glyphs without touching colors |
| `segments.zsh` | Which segments appear and how they behave — no color noise |
| `p10k.zsh` | Entry point only — sources the modules, sets global options |

**Symlink-based**: `install.sh` creates `~/.p10k.zsh → .../terminal/p10k/p10k.zsh`. Tools find the config at the path they expect; the actual file lives here under version control.

**Live reload**: after any edit, `source ~/.p10k.zsh` picks up all module changes instantly — no shell restart needed.

---

## Stack

| Tool | Role |
|------|------|
| **zsh** | Shell |
| **Oh My Zsh** | Plugin and theme management |
| **Powerlevel10k** | Prompt engine — fast, highly configurable, git-aware |
| **WezTerm** | GPU-accelerated terminal emulator — Lua-configurable, multiplexer built in |
| **Nerd Fonts** | Icon glyphs used by the prompt (nerdfont-v3) |

---

## Getting started

### Prerequisites

- zsh with [Oh My Zsh](https://ohmyz.sh)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) installed
- A [Nerd Font](https://www.nerdfonts.com) configured in your terminal (e.g. MesloLGS NF, JetBrainsMono Nerd Font)

### Install

```bash
git clone https://github.com/gianlucagiurlando/dev-environment-files.git ~/repos/dev-environment-files
cd ~/repos/dev-environment-files
bash terminal/install.sh
```

`install.sh` creates the symlink:

```
~/.p10k.zsh → .../terminal/p10k/p10k.zsh
```

Then apply:

```zsh
source ~/.p10k.zsh
```

### Verify

```zsh
ls -la ~/.p10k.zsh        # should show symlink → terminal/p10k/p10k.zsh
source ~/.p10k.zsh && echo "✓ loaded"
```

---

## Customising

### Change colors

Open `terminal/p10k/colors.zsh`. Colors are xterm-256 indices. A WezTerm alignment table at the bottom shows which prompt colors to update when switching terminal themes.

```bash
# Preview the 256-color palette in your terminal
for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
```

### Change icons or separators

Open `terminal/p10k/symbols.zsh`. Each glyph is a Unicode code point from the Nerd Fonts v3 set.

### Change which segments appear

Open `terminal/p10k/segments.zsh` and edit `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS` or `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS`. Per-segment config (thresholds, sources, show-on-command) is grouped by segment directly below the element lists.

### Apply any change

```zsh
source ~/.p10k.zsh
```

---

## Roadmap

- [ ] `terminal/wezterm/` — WezTerm Lua config (colors, keybindings, multiplexer)
- [ ] `nvim/` — Neovim config
- [ ] `git/` — `.gitconfig`, global ignore
- [ ] `ssh/` — `~/.ssh/config` template

---

## Author

**Gianluca Giurlando** — ML/AI Engineer  
[github.com/gianlucagiurlando](https://github.com/gianlucagiurlando)
