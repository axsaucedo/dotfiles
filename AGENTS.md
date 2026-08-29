# AGENTS.md

Context for agents working in this repo. Read this before editing anything.

## What this repo is

Personal macOS dotfiles. Everything under `home/` is **symlinked into `$HOME`** by `install.sh`. The repo file *is* the live file: editing `home/.zshrc` edits the running shell's config, and editing `~/.zshrc` edits this repo. There is no sync step.

This replaced a copy-based sync (`update_from_local.sh`) under which the repo silently fell 8 months behind.

## Rules that matter most

### 1. This repo is PUBLIC

Never commit:

- Credentials of any kind.
- Internal hostnames, internal tool names, internal marketplace/plugin identifiers, or work email addresses.
- A denylist of the above. **A list of what to hide names exactly what is being hidden.** The pre-commit pattern list deliberately lives outside this repo at `~/.config/dotfiles/internal-patterns`.

Work-specific config belongs in `~/.zshrc.zalando` (untracked, mode 600), which `home/.zshrc` sources when present. If a change would put an internal reference in a tracked file, put it there instead.

Do not add an `.example` template documenting those values. It was tried and removed: a machine with the real file does not need it, and a machine without it gains only placeholders.

### 2. Do not break the running shell

The user's live shell loads these files. A syntax error in `home/.zshrc` or `home/.zprofile` breaks every new terminal and tmux session.

Always validate before committing:

```sh
zsh -n home/.zshrc && zsh -n home/.zprofile
```

**Never** spawn interactive shells (`zsh -i`, `zsh -l`) for validation, and never run several in parallel. `home/.zprofile` runs `pyenv init -`, which rehashes on every shell start; a killed rehash leaves a stale lock at `~/.pyenv/shims/.pyenv-shim` that makes *every new shell hang for 60 seconds*. This has already happened once.

Recovery, if it does: `rm -f ~/.pyenv/shims/.pyenv-shim`

Use `zsh -n` (parse only). If you genuinely need an interactive shell, run exactly one, sequentially, with a timeout.

### 3. A launchd agent is watching

`com.asaucedo.dotfiles.autocommit` watches `home/` and auto-commits ~30s after any change (`bin/autocommit.sh`, 30s debounce, `ThrottleInterval` 60). Consequences:

- Edits to `home/` get committed **without you asking**. Stray `auto:` commits will appear mid-branch if you work slowly.
- Pause it while doing multi-step git work, and reload after:

```sh
launchctl unload ~/Library/LaunchAgents/com.asaucedo.dotfiles.autocommit.plist
# ... work ...
launchctl load ~/Library/LaunchAgents/com.asaucedo.dotfiles.autocommit.plist
```

- It commits `-- home/` only, so staged changes elsewhere are not swept in. Keep it that way.
- It does **not** push. That is deliberate: on a public repo an auto-push publishes a mistake within seconds. `DOTFILES_AUTOPUSH=1` opts in.
- Never add `WatchPaths` for the repo root — the commit's own `.git` writes would retrigger it into an infinite loop.

### 4. The pre-commit hook will block you

`hooks/pre-commit` (wired via `core.hooksPath`) runs three checks: gitleaks on staged content, site-specific patterns from `~/.config/dotfiles/internal-patterns`, and a filename guard for machine-local files.

- A blocked commit is a real finding, not an obstacle. Move the content to a machine-local file.
- `--no-verify` exists for genuine false positives. Justify it.
- gitleaks **allowlists the well-known AWS documentation example key**, so that string is useless as a test. Use a realistically-shaped credential.

## Layout

```
home/                 mirrors $HOME — symlinked by install.sh
  .zprofile           login shell: PATH, exported env
  .zshrc              interactive: prompt, plugins, aliases, history, helpers
  .vimrc  .tmux.conf  .vim/  .config/nvim/
bin/autocommit.sh     launchd-triggered commit
bin/notify-fail.sh    Mail.app failure alerts (no address hardcoded)
hooks/pre-commit      secret + internal-reference guard
launchd/              agent plist
install.sh            idempotent: symlinks, hooks, launchd, permissions
```

## Machine-local files (never tracked)

| File | Purpose |
|---|---|
| `~/.zshrc.zalando` | work config, sourced by `home/.zshrc` |
| `~/.zshrc.local` | per-machine overrides |
| `~/.all_secret_keys` | credentials, mode 600 |
| `~/.config/dotfiles/internal-patterns` | pre-commit denylist |
| `~/.config/dotfiles/notify.env` | notification sender/recipient |

Their absence must always be harmless — guard with `[ -r "$f" ]`, never assume they exist.

## Keybindings that macOS does not deliver to tmux

The terminal is **iTerm2**. Cmd-based shortcuts never reach tmux: macOS keeps Cmd for the app, so no escape sequence is sent. A binding like "Cmd+Left moves the current tab left" is therefore two halves, and only one of them lives in this repo.

Repo half — `home/.tmux.conf` listens for a private escape sequence via `user-keys`:

```
set -s user-keys[0] "\e[9000~"
set -s user-keys[1] "\e[9001~"
bind -n User0 swap-window -t -1
bind -n User1 swap-window -t +1
```

Machine half — iTerm2 → Settings → Keys → Key Bindings → **+**, shortcut `⌘←`, action **Send Hex Code**, value `0x1b 0x5b 0x39 0x30 0x30 0x30 0x7e` (and `...0x31 0x7e` for `⌘→`). That is `\e[9000~` / `\e[9001~` byte by byte.

Current iTerm2 has no **Send Escape Sequence** action; older docs and forum answers still name it. The equivalents are **Send Hex Code** or **Send Text with "vim" Special Chars** (which does accept `\e`). **Send tmux Command** is unrelated — it only applies to tmux integration mode (`tmux -CC`).

Do this in the GUI. iTerm2 holds its preferences in memory and rewrites `~/Library/Preferences/com.googlecode.iterm2.plist` on quit, so a plist edited under a running app is silently discarded. That file is machine-local and untracked, which means **the repo alone cannot reproduce these bindings on a new machine** — document each one here when adding it.

Pick sequences in a range nothing else uses (`\e[90NN~`). Reusing a real terminfo sequence (`\e[1;6D` and friends) collides with the existing pane-resize bindings.

## Conventions

- **Radical simplicity.** Prefer the smallest change that works. Do not introduce frameworks, abstraction layers, or config systems for one-off needs.
- **Comprehensive commit messages.** Explain *why*, not just what — including constraints discovered and approaches rejected. No `Claude-Session:` trailer.
- **Match surrounding style.** `.zprofile` and `.zshrc` use banner comment blocks; follow them.
- Scratch files go in `./tmp/` (gitignored), not `/tmp`.
- `install.sh` must stay idempotent and must never delete a user file — move it aside to `<name>.bak.<epoch>`.

## Known issues, not yet fixed

`home/.zprofile` and `home/.zshrc` are still largely unreviewed legacy. A prior audit found, and these remain open:

- `compinit` runs 3× (`.zprofile`, oh-my-zsh, `.zshrc`) — ~667ms of ~720ms startup.
- `export TERM="xterm"` forces 8-colour and fights tmux.
- `. $HOME/.asdf/asdf.sh` is a dead shim; asdf v0.16+ needs the shims dir on `PATH`.
- ~300 lines of Linux/WSL/Windows config for binaries that do not exist on this machine.
- Duplicate `PATH` entries and 15 nonexistent directories; no `typeset -U path`.
- `pyenv init -` should be `pyenv init - --no-rehash` to stop the lock recurrence above.
- Aliases defined twice: `p`, `gpge`. `alias cdg=cd $GOPATH` is broken (unquoted).

Do not fix these opportunistically as part of unrelated work — they are a separate, deliberate cleanup with its own verification (alias parity diff, startup timing).

## Verifying a change

```sh
zsh -n home/.zshrc && zsh -n home/.zprofile   # must pass before committing
./install.sh --dry                            # confirm no unexpected relinking
git status --short                            # expect clean; stray auto: commits mean the agent fired
```

For anything touching startup, capture `alias | sort` and `functions | grep '^[a-z]'` before and after and diff them — silent alias loss is the main regression risk.
