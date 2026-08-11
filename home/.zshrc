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
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs virtualenv kubecontext )
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
  kubectl
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
#                           Wrap Up
#######################################################################

# Attach to an existing tmux session (or start one) -- last, so everything
# above is loaded even in the outer shell. No-op inside tmux.
[[ -z $TMUX ]] && { tmux attach 2>/dev/null || tmux new; }
