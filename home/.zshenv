# .zshenv - read by ALL zsh invocations, including non-interactive/non-login shells.
# Agents (Copilot CLI, Claude Code, MCP servers) spawn non-interactive shells, which
# do NOT read .zshrc or .zprofile. Toolchain PATH entries needed by agents live here.

typeset -U path PATH

# Homebrew (provides asdf, databricks, copilot, ...)
[ -d /opt/homebrew/bin ] && path=(/opt/homebrew/bin /opt/homebrew/sbin $path)

# asdf shims. Guard on the shims dir being non-empty, not on `command -v asdf`:
# in a bare non-interactive env the asdf binary (~/.asdf/bin) is not yet on PATH,
# so the binary check silently dropped the shims for exactly the agent shells this
# file exists to serve. An empty shims dir means a dead asdf install; skip that.
_asdf_dir="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
_asdf_shims=($_asdf_dir/*(N))
(( $#_asdf_shims )) && path=("$_asdf_dir" $path)
unset _asdf_dir _asdf_shims

# uv / pipx tools (zllm)
path=("$HOME/.local/bin" $path)

# pixi global tools
[ -d "$HOME/.pixi/bin" ] && path=("$HOME/.pixi/bin" $path)

# Tools needed by non-interactive shells
export VISUAL=nvim
export EDITOR="$VISUAL"
export GOPATH="$HOME/go"
export BEADS_DIR="$HOME/.beads-planning/.beads"
export PYENV_ROOT="$HOME/.pyenv"
export HOMEBREW_AUTO_UPDATE_SECS=604800

[ -d "$HOME/go/bin" ] && path+=("$HOME/go/bin")
[ -d "$HOME/Programming/bin" ] && path+=("$HOME/Programming/bin")
[ -d "$HOME/Programming/lib/joplin-export" ] && path+=("$HOME/Programming/lib/joplin-export")
[ -d "$HOME/Programming/external/roborev/bin" ] && path+=("$HOME/Programming/external/roborev/bin")
[ -d "$HOME/.claude/bin" ] && path+=("$HOME/.claude/bin")
[ -d "$PYENV_ROOT/shims" ] && path=("$PYENV_ROOT/shims" $path)
[ -d "$HOME/.cargo/bin" ] && path=("$HOME/.cargo/bin" $path)
[ -d /opt/homebrew/opt/ruby/bin ] && path=(/opt/homebrew/opt/ruby/bin $path)

[ -r "$HOME/.all_secret_keys" ] && source "$HOME/.all_secret_keys"

export PATH
