# dotfiles

Personal, modular dev environment configs — version-controlled and symlink-based. Every tool finds its config at the path it expects; the source of truth lives here.

Covers terminal setup, Neovim, Git, zsh, tmux, and gh CLI. Designed to grow into a full environment covering SSH and more.

This repo has two separate jobs: **bootstrap** installs the tools, **everything else configures them**. See [Bootstrap](#bootstrap) below.

---

## Structure

```
dotfiles/
├── Makefile                    # shortcuts for editing and switching
├── README.md
├── bootstrap/
│   ├── ubuntu.sh                # installs CLI tools/languages via apt (Ubuntu)
│   └── macos.sh                 # installs CLI tools/languages via brew (macOS)
├── git/
│   ├── .gitconfig              # public git config → ~/.gitconfig
│   └── .gitignore_global       # global ignore → ~/.gitignore_global
├── gh/
│   └── config.yml              # gh CLI preferences & aliases → ~/.config/gh/config.yml
├── nvim/                       # LazyVim config → ~/.config/nvim
├── opencode/
│   └── opencode.json           # opencode config → ~/.config/opencode/opencode.json
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
    │   ├── keybindings.ghostty  # key bindings (minimal for now)
    │   └── cursor.ghostty       # cursor style & color
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

- [oh-my-zsh](https://ohmyz.sh) installed:
  ```bash
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```
  If it asks to overwrite `.zshrc`, answer **n** — this repo's `.zshrc` is a symlink into the repo; don't replace it.
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) cloned into oh-my-zsh's custom themes directory:
  ```bash
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
  ```
- The oh-my-zsh plugins `zsh/plugins.zsh` expects — not bundled with oh-my-zsh by default, so clone them into its custom plugins directory:
  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
  ```
- [WezTerm](https://wezfurlong.org/wezterm/) and/or [Ghostty](https://ghostty.org) installed
- [tmux](https://github.com/tmux/tmux) with [TPM](https://github.com/tmux-plugins/tpm) installed
- [gh](https://cli.github.com) CLI installed
- A [Nerd Font](https://www.nerdfonts.com) configured in your terminal(s) (e.g. a PragmataPro or JetBrainsMono Nerd Font build)

Starship doesn't need a manual prerequisite step — `make bootstrap` installs it (see [Bootstrap](#bootstrap)).

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
~/.p10k.zsh                       → .../terminal/p10k/p10k.zsh
~/.wezterm.lua                    → .../terminal/wezterm/wezterm.lua
~/.config/nvim                    → .../nvim/
~/.gitconfig                      → .../git/.gitconfig
~/.gitignore_global               → .../git/.gitignore_global
~/.zshrc                          → .../zsh/.zshrc
~/.zprofile                       → .../zsh/.zprofile
~/.tmux.conf                      → .../tmux/.tmux.conf
~/.config/gh/config.yml           → .../gh/config.yml
~/.config/starship.toml           → .../terminal/starship/starship.toml
~/.config/ghostty                 → .../terminal/ghostty/
~/.config/opencode/opencode.json  → .../opencode/opencode.json
```

opencode auth (`~/.local/share/opencode/auth.json`) is intentionally left out of this repo — it holds credentials, so it's set up per-machine instead of version-controlled.

Then reload your shell:

```zsh
source ~/.zshrc
```

---

## First-time setup on a new machine

`make install` and `make bootstrap` cover tools and configs, not credentials or machine-specific identity. On a fresh machine, also do the following:

- **Git identity.** `git/.gitconfig` in this repo sets only the public name and includes `~/.gitconfig.local` for the rest — that keeps your email out of a public repo. After cloning, create it:
  ```bash
  echo -e "[user]\n\temail = you@example.com" > ~/.gitconfig.local
  ```
- **GitHub auth.**
  ```bash
  gh auth login
  ```
  Needed before `git push`/`pull` will work over HTTPS on a fresh machine. Also run `gh auth setup-git` — it writes a credential helper line into `git/.gitconfig`, which **is** version-controlled, so watch for it showing up in `git status` on unrelated commits.
- **opencode auth** (if using opencode):
  ```bash
  opencode auth login
  ```
  Set up per machine, same reasoning as the `auth.json` note above.
- **Tailscale.** Not part of `bootstrap`/`install`. Install it per OS:
  ```bash
  # macOS
  brew install --cask tailscale-app

  # Linux
  curl -fsSL https://tailscale.com/install.sh | sh
  ```
  Then run `tailscale up` and follow the browser prompt to join the existing tailnet.

---

## Work and personal machines

This repo is public and runs on more than one machine. Machines differ — screen size, commit email, a search location used by some script — but the repo must not store any of that, and must not say which machine is which.

The rule: never hardcode a value that is private or that should differ per machine. Pick one of these instead, in order of preference:

1. **Derive it at runtime.** If the answer already lives somewhere, read it instead of storing it. The Starship prompt's identity indicator does this — it reads `git config user.email` on each render rather than keeping a per-machine setting.
2. **An untracked `*.local` file, included by a tracked file.** Matches `.gitconfig.local` and `terminal/ghostty/config.local` — the tracked file sets defaults and includes the local file last, so the local file wins. `*.local` is gitignored, so it never leaves the machine it's on.
3. **An environment variable, with a tracked fallback.** Set in `~/.zshenv` (untracked). Used where a script or a config language can read an environment variable directly, e.g. `WEZTERM_FONT_SIZE` in `terminal/wezterm/fonts.lua`.

None of these name a machine as "work" or "personal" in a tracked file. The repo doesn't know or care which machine it's on — only what that machine has chosen to set locally.

---

## Bootstrap

`bootstrap/` and the rest of this repo do different jobs:

| | Job | Where |
|---|---|---|
| **Bootstrap** | Which tools exist — installs CLI tools and languages | `bootstrap/ubuntu.sh`, `bootstrap/macos.sh` |
| **Everything else** | How those tools behave — their config, symlinked via `make install` | `nvim/`, `zsh/`, `terminal/`, etc. |

Run it with:

```bash
make bootstrap
```

This detects the OS via `uname` and runs the matching script. Both scripts install the same tool list — ripgrep, fzf, jq, bat, tree, direnv, cmake, ninja-build, stow, lazygit, pipx (with poetry and ipython), uv, pyenv, starship, and codex — and are safe to re-run: each checks whether a tool is already present before installing it, and prints a summary of what was installed, already present, or skipped.

- **`bootstrap/ubuntu.sh`** — installs most tools via `apt`; lazygit via its official binary release, poetry/ipython via `pipx`, and uv/pyenv/starship/codex via their official install scripts.
- **`bootstrap/macos.sh`** — mirrors the same list via `brew install` (codex via `brew install --cask`). Kept for reproducing a fresh Mac setup; not required on a machine that already has everything installed.

Neither script edits shell rc files for PATH — that stays centralized in `zsh/path.zsh` (see [Prerequisites](#prerequisites) below and that file's `pyenv` block), matching this repo's existing convention of one place for PATH changes instead of installers scattering `export PATH=...` across `.zshrc`/`.zprofile`/`.bashrc`. If `bootstrap/ubuntu.sh` installs pyenv fresh, it prints a reminder to add `$HOME/.pyenv/bin` to `zsh/path.zsh` yourself.

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
