# Terminal Configuration

Modular Powerlevel10k configuration split into focused files for easy editing.

## Structure

```
terminal/
├── install.sh          # Symlinks p10k/p10k.zsh → ~/.p10k.zsh
├── p10k/
│   ├── p10k.zsh        # Entry point — sources the three modules below
│   ├── colors.zsh      # All FOREGROUND / BACKGROUND color values
│   ├── symbols.zsh     # Nerd Font icons, separators, and glyphs
│   └── segments.zsh    # Prompt element lists and per-segment behavior
└── wezterm/            # WezTerm terminal configuration (future)
```

## Installation

```bash
bash terminal/install.sh
source ~/.p10k.zsh
```

## Editing

| I want to change…         | Edit this file       |
|---------------------------|----------------------|
| Prompt colors             | `p10k/colors.zsh`    |
| Icons / separators        | `p10k/symbols.zsh`   |
| Which segments are shown  | `p10k/segments.zsh`  |
| Transient / instant prompt| `p10k/p10k.zsh`      |

After any edit, apply changes with:

```zsh
source ~/.p10k.zsh
```

## WezTerm color alignment

When switching WezTerm color schemes, see the **WezTerm colors** section at the
bottom of `p10k/colors.zsh` for a table of the key prompt colors to update.

## Regenerating from scratch

```zsh
p10k configure
```

> **Note:** This will overwrite `~/.p10k.zsh` (i.e. `p10k/p10k.zsh` via the symlink).
> Commit your changes before reconfiguring.
