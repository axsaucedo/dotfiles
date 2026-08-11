# dotfiles

Personal shell, vim and tmux configuration for macOS.

Everything under `home/` is **symlinked** into `$HOME`. The repo file *is* the live file — edit `~/.zshrc` and you are editing `home/.zshrc`. There is no sync step, and so nothing can drift.

> This replaces the old `update_from_local.sh` copy-sync, under which the repo silently fell 8 months behind the live config.

## Layout

```
home/                     mirrors $HOME — symlinked by install.sh
  .zprofile               login shell: PATH, exported env
  .zshrc                  interactive shell: prompt, plugins, aliases, history
  .vimrc  .tmux.conf  .vim/  .config/nvim/
bin/                      helper scripts (auto-commit, notifications)
install.sh                idempotent: symlinks home/, seeds local files
```

## Setup on a new machine

```sh
git clone git@github.com:axsaucedo/dotfiles.git ~/Programming/dotfiles
cd ~/Programming/dotfiles && ./install.sh
```

`install.sh` is idempotent. Any existing real file it would replace is moved aside to `<name>.bak.<timestamp>` rather than deleted.

## Untracked files

This repo is **public**, so machine-local and work configuration lives only in `$HOME` and is gitignored:

| File | Purpose |
|---|---|
| `~/.zshrc.zalando` | work-specific config and endpoints |
| `~/.zshrc.local` | per-machine overrides |
| `~/.all_secret_keys` | credentials (mode `600`, never in git) |

The first two are sourced from `home/.zshrc` if present, so their absence is harmless — a machine without them simply lacks the work-specific commands.

A `gitleaks` pre-commit hook blocks commits containing secret-shaped strings.

## Adding a new dotfile

Move it under `home/` (mirroring its path relative to `$HOME`) and re-run `./install.sh`.
