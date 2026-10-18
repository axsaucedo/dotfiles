# p10k instant prompt deliberately NOT enabled: it paints a cached prompt
# immediately and finishes loading behind it, which reads as a glitchy
# two-stage startup. Startup is fast enough to load in one pass instead.


#     8P d8P  dP"8 888 888
#     P d8P  C8b Y 888 888 888,8,  e88'888 
#      d8P d  Y8b  8888888 888 "  d888  '8 
#     d8P d8 b Y8D 888 888 888    Y888   , 
#    d8P d88 8edP  888 888 888     "88,e8' 



#######################################################################
#                           THEME & PS1
#######################################################################

ZSH_THEME="powerlevel10k/powerlevel10k"

# Collapse past prompts to a minimal line so scrollback stays clean
POWERLEVEL9K_TRANSIENT_PROMPT=always

# Theme specific options
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( vcs vi_mode dir )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs virtualenv kubecontext )
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=1
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="black"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="white"
POWERLEVEL9K_DIR_ETC_BACKGROUND="white"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='black'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='white'
POWERLEVEL9K_VI_INSERT_MODE_STRING="○"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="∅"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_ANACONDA_LEFT_DELIMITER=""
POWERLEVEL9K_ANACONDA_RIGHT_DELIMITER=""
POWERLEVEL9K_PYTHON_ICON="🔥 "
POWERLEVEL9K_ANACONDA_BACKGROUND="cyan"
POWERLEVEL9K_ANACONDA_FOREGROUND="black"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="cyan"
POWERLEVEL9K_VIRTUALENV_FOREGROUND="black"
POWERLEVEL9K_VIRTUALENV_CONTENT_EXPANSION='${VIRTUAL_ENV_PROMPT}'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL9K_KUBECONTEXT_BACKGROUND="white"
POWERLEVEL9K_KUBECONTEXT_FOREGROUND="black"
POWERLEVEL9K_KUBECONTEXT_CONTENT_EXPANSION='${P9K_KUBECONTEXT_CLUSTER[1,5]}../${${P9K_KUBECONTEXT_NAMESPACE:-default}[1,5]}..'
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|ku|kub|kube|kubec|kubect|helm|he|hel|kgp|kg|kgpw|kep|ke|kgpl|kl|kd|kdp|ka|kaf|kgns|ksns|kgcm|kgd'

autoload -U colors && colors

#######################################################################
#                           Plugins
#######################################################################

plugins=(
  # git removed git plugin as it only adds aliases that clash with mine
  vi-mode
  fzf-tab # MUST load before widget-wrapping plugins (autosuggestions, syntax-highlighting). git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab
  zsh-autosuggestions # git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  docker
  golang
  helm
  fzf
  you-should-use # git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
  zsh-syntax-highlighting # MUST BE LAST PLUGIN! git clone https://github.com/zsh-users/zsh-syntax-highlighting
)

#######################################################################
#                           Run oh-my-zsh
#######################################################################

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# fzf-tab previews and group navigation
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath 2>/dev/null || ls -1G $realpath'
zstyle ':fzf-tab:complete:(vim|nvim|cat|bat):*' fzf-preview 'bat --style plain --color=always $realpath 2>/dev/null || ls $realpath'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'git log --oneline -20 --color=always $word'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' prefix ''   # no leading · on entries

#######################################################################
#                           Utility Load & Config
#######################################################################


# Avoid escaping parenthesis
zstyle ':urlglobber' url-other-schema

## Loading direnv
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

## atuin: searchable shell history database on ctrl-r (brew install atuin).
## Arrow-up is left on zsh's default history so only ctrl-r changes behavior.
command -v atuin >/dev/null && eval "$(atuin init zsh --disable-up-arrow)"

# Avoid changing folder without cd (ie typing folder name directly)
setopt noautocd

[ -r ~/.aliases.zsh ] && source ~/.aliases.zsh


#######################################################################
#                           Autocompletion
#######################################################################

# compinit already ran inside oh-my-zsh; do NOT run it again here -- a rerun
# rebuilds the completion table and wipes compdefs registered below.

# kubectl + uv + 1password completions, cached: the eval forks the tool on
# every shell start, so dump once and re-source; regenerate when the binary
# is newer.
_zc=~/.cache/zsh-completions
mkdir -p "$_zc"
if command -v kubectl >/dev/null; then
  [[ $_zc/kubectl.zsh -nt ${commands[kubectl]} ]] || kubectl completion zsh > "$_zc/kubectl.zsh"
  source "$_zc/kubectl.zsh"
  command -v kubecolor >/dev/null && compdef kubecolor=kubectl
fi
if command -v uv >/dev/null; then
  [[ $_zc/uv.zsh -nt ${commands[uv]} ]] || uv generate-shell-completion zsh > "$_zc/uv.zsh"
  source "$_zc/uv.zsh"
fi
if command -v op >/dev/null; then
  [[ $_zc/op.zsh -nt ${commands[op]} ]] || op completion zsh > "$_zc/op.zsh"
  source "$_zc/op.zsh"
  compdef _op op
fi
unset _zc

# Ensuring the you-should-use message is at the end
export YSU_MESSAGE_POSITION="after"


#######################################################################
#                           Histsize
#######################################################################

# Set history file size. HISTSIZE is held in memory at startup, so keep it
# bounded rather than effectively infinite.
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

#######################################################################
#                     Machine-local & work config
#######################################################################
# Untracked (this repo is public): work config and per-machine overrides.
for f in ~/.zshrc.zalando ~/.zshrc.local; do
  [ -r "$f" ] && source "$f"
done

#######################################################################
#                           Dotfiles helpers
#######################################################################

# Operate on the dotfiles repo from anywhere: `dots`, `dots diff`, `dots push`
dots() { git -C ~/Programming/dotfiles "${@:-status}"; }

# Mention uncommitted/unpushed dotfiles changes. Auto-commit handles saving; this
# is about the push, which is deliberately manual on a public repo.
#
# At most weekly, and then only on ~20% of eligible shells (oh-my-zsh's
# auto-update approach) so it reads as an occasional prompt rather than a fixture
# you stop seeing. The stamp is only touched when the message actually prints --
# a lost dice roll leaves the shell eligible, so it still surfaces within a few
# shells rather than going quiet for another week.
_dots_nudge() {
  local stamp=~/.cache/dots-nudge
  [[ -n $(find "$stamp" -maxdepth 0 -mtime -7 2>/dev/null) ]] && return
  (( RANDOM % 5 )) && return
  mkdir -p ~/.cache && touch "$stamp"
  local n
  n=$(git -C ~/Programming/dotfiles status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  (( n > 0 )) && print -P "%F{yellow}dotfiles: $n uncommitted change(s) — run 'dots'%f"
  n=$(git -C ~/Programming/dotfiles log --oneline @{u}.. 2>/dev/null | wc -l | tr -d ' ')
  (( n > 0 )) && print -P "%F{yellow}dotfiles: $n unpushed commit(s) — run 'dots push'%f"
}
_dots_nudge

#######################################################################
#                           Dotfile navigators
#######################################################################

# Pick a known dotfile and open it. Only the basename is shown -- the names are
# distinct and a narrow pane has no room for twelve copies of $HOME. The full
# path rides along in a trailing tab-delimited field that fzf never displays.
z() {
  # NOT `path`: that name is tied to $PATH in zsh, and a local scalar of that
  # name empties PATH inside the function -- fzf itself stops resolving.
  local selected entry target desc name colour
  local -a files rows
  files=(
    "$HOME/.zshenv"$'\t'"every zsh, including non-interactive agent shells"
    "$HOME/.zprofile"$'\t'"login shells only"
    "$HOME/.zshrc"$'\t'"interactive shells only"
    "$HOME/.aliases.zsh"$'\t'"interactive aliases, read by .zshrc"
    "$HOME/.zshrc.zalando"$'\t'"untracked work config, read by .zshrc"
    "$HOME/.zshrc.local"$'\t'"untracked machine overrides, read by .zshrc"
    "$HOME/.all_secret_keys"$'\t'"untracked credentials, read by every zsh"
    "$HOME/.config/dotfiles/internal-patterns"$'\t'"untracked pre-commit patterns, read on commit"
    "$HOME/.gitconfig"$'\t'"Git configuration, read by Git"
    "$HOME/.tmux.conf"$'\t'"tmux configuration, read when tmux starts"
    "$HOME/.config/nvim/init.lua"$'\t'"Neovim configuration, read when Neovim starts"
    "$HOME/Programming/dotfiles/AGENTS.md"$'\t'"repository guidance, read before dotfile edits"
  )

  for entry in "${files[@]}"; do
    target=${entry%%$'\t'*}
    desc=${entry#*$'\t'}
    name=${target:t}
    # Cyan when the file is there, red when it is not: the machine-local ones
    # are listed either way, and their absence is the useful signal.
    if [ -e "$target" ]; then colour=$'\e[36m'; else colour=$'\e[31m'; desc="$desc -- absent"; fi
    rows+=( "${colour}${(r:24:)name}"$'\e[0m'$'\t'$'\e[90m'"${desc}"$'\e[0m'$'\t'"${target}" )
  done

  selected=$(printf '%s\n' "${rows[@]}" | fzf --ansi --delimiter=$'\t' --with-nth=1,2 --no-preview) || return
  "$EDITOR" "${selected##*$'\t'}"
}

# Search tracked and machine-local dotfiles, re-running rg on every keystroke.
#
# Both binds use the reload(...) parenthesised form and separate --bind flags.
# The colon form (`--bind=start:reload:CMD,change:reload:CMD`) silently breaks:
# reload: consumes the rest of the string, so the change binding is swallowed
# into the start command and typing never re-runs the search.
#
# awk rewrites rg's `path:line:text` into `basename:line:text<TAB>path`, so a
# narrow pane shows the filename rather than 40 columns of $HOME, while the
# preview and the editor still get the real path from the trailing field. The
# delimiter regex splits on both, making {2} the line number and {-1} the path.
zz() {
  local selected file line rg_cmd
  local -a roots=("$HOME/Programming/dotfiles/home")
  local candidate
  for candidate in \
    "$HOME/.zshrc.zalando" \
    "$HOME/.zshrc.local" \
    "$HOME/.all_secret_keys" \
    "$HOME/.config/dotfiles/internal-patterns"; do
    [ -f "$candidate" ] && roots+=("$candidate")
  done

  rg_cmd="rg --line-number --no-heading --color=always --colors=path:none --colors=line:none --smart-case --hidden -- {q} ${(j: :)${(@q)roots}} 2>/dev/null"

  # awk does three things: rewrites rg's `path:line:text` into
  # `basename:line:text<TAB>path`, colours the basename magenta as rg would, and
  # floats definitions of the searched name to the top -- `foo() {`, `function
  # foo`, `alias foo=`, `export foo=`, `local/typeset foo` -- so searching a name
  # lands on where it is defined rather than the first place it happens to be
  # used. fzf's own sorting is off (--disabled), so input order is final order.
  #
  # q is only trusted as a regex when it is plain identifier characters;
  # anything else disables the reordering rather than risking an awk regex error
  # that would empty the whole result list.
  rg_cmd+=" | awk -F: -v OFS=: -v q={q} '"
  rg_cmd+='BEGIN { if (q !~ /^[A-Za-z0-9_.-]+$/) q = "" }'
  rg_cmd+='{ p = $1; n = p; sub(/.*\//, "", n);'
  rg_cmd+='  t = $0; sub(/^[^:]*:[0-9]*:/, "", t); gsub(/\033\[[0-9;]*m/, "", t);'
  rg_cmd+='  $1 = "\033[35m" n "\033[0m"; gsub(/\t/, " ");'
  rg_cmd+='  if (q != "" && (t ~ "(alias|function|local|typeset|export)[ \t]+[^ \t=]*" q || t ~ q "[ \t]*(\\(\\)|=)"))'
  rg_cmd+='    defs[++d] = $0 "\t" p; else rest[++r] = $0 "\t" p }'
  rg_cmd+='END { for (i = 1; i <= d; i++) print defs[i]; for (i = 1; i <= r; i++) print rest[i] }'
  rg_cmd+="' || true"

  # bat resolves a syntax from the filename, and four of the files searched here
  # -- the machine-local ones and .tmux.conf -- match nothing it knows, so their
  # previews came out as flat white text. Since every one of them is shell, map
  # them explicitly; searching for a credential lands in exactly these files.
  local bat_cmd="bat --color=always --style=numbers --highlight-line {2}"
  bat_cmd+=" --map-syntax '.all_secret_keys:Bourne Again Shell (bash)'"
  bat_cmd+=" --map-syntax '.zshrc.*:Bourne Again Shell (bash)'"
  bat_cmd+=" --map-syntax 'internal-patterns:Bourne Again Shell (bash)'"
  bat_cmd+=" --map-syntax '.tmux.conf:Bourne Again Shell (bash)'"
  bat_cmd+=" -- {-1}"

  # --with-nth drops the trailing path field from the display only; {-1} still
  # resolves to it for the preview and the editor.
  selected=$(fzf --ansi --disabled --delimiter='[:\t]' --with-nth='1..-2' --query="${1:-}" \
    --bind "start:reload($rg_cmd)" \
    --bind "change:reload($rg_cmd)" \
    --preview "$bat_cmd" \
    --preview-window '+{2}/2') || return

  file=${selected##*$'\t'}
  line=${${selected#*:}%%:*}
  [ -n "$file" ] && "$EDITOR" "+$line" "$file"
}

#######################################################################
#                           Tips
#######################################################################

# The less-used goodies are easy to forget: `tips` lists them all, every
# new terminal opens with one at random in a box, and another surfaces
# every ~15 commands.
_TIPS=(
  "ctrl+a Tab -- extrakto: fzf-pick any path/URL/hash from the visible pane"
  "ctrl+a g -- popup scratchpad shell in the current path"
  "ctrl+a h/j/k/l (or arrows) -- resize panes, repeatable"
  "ctrl+r -- atuin history: shows exit status + duration of every past command"
  "cd <tab> -- fzf picker with directory preview; , and . switch groups"
  "lt / tree -- eza tree view (-L 4 for deeper); la/l show a git column"
  "duh -- dust disk usage, dotfiles included; duhh for full depth"
  "git-stash-apply / gb / gl -- fzf pickers for stashes, branches, commits"
  "z -- fzf list of every key dotfile, what it is and when zsh reads it"
  "zz -- live rg across all dotfiles (incl. untracked ones); enter opens at the line"
)
tips() { printf '%s\n' "${_TIPS[@]}" }

_tip_show() {
  local t="${_TIPS[$((RANDOM % ${#_TIPS[@]} + 1))]}"
  local line="${(l:${#t}+2::─:)}"
  print -P "%F{cyan}╭${line}╮%f"
  print -P "%F{cyan}│%f %F{yellow}${t}%f %F{cyan}│%f"
  print -P "%F{cyan}╰${line}╯%f"
}
_tip_show

# ...and again every ~15 commands (precmd runs once per prompt)
_tip_count=0
_tip_precmd() { (( ++_tip_count % 15 )) || _tip_show }
autoload -U add-zsh-hook
add-zsh-hook precmd _tip_precmd
# Record each pane's last command for the tmux navigator (~/.tmux/agent-nav.sh).
_tmux_last_cmd() { [[ -n $TMUX ]] && tmux set -p @last_cmd "${1[1,60]}" 2>/dev/null }
add-zsh-hook preexec _tmux_last_cmd

#######################################################################
#                           Wrap Up
#######################################################################

# Attach to an existing tmux session (or start one) -- last, so everything
# above is loaded even in the outer shell. No-op inside tmux.
[[ -z $TMUX ]] && { tmux attach 2>/dev/null || tmux new -c ~; }
