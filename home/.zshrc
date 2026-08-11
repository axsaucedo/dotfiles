# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


#     8P d8P  dP"8 888 888
#     P d8P  C8b Y 888 888 888,8,  e88'888 
#      d8P d  Y8b  8888888 888 "  d888  '8 
#     d8P d8 b Y8D 888 888 888    Y888   , 
#    d8P d88 8edP  888 888 888     "88,e8' 



#######################################################################
#                           THEME & PS1
#######################################################################

ZSH_THEME="powerlevel10k/powerlevel10k"

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

# Required to load pyenv fast
prompt_fast_pyenv () {
    echo -n "${reset_color}${yellow} `which python |  rev | cut -d"/" -f3 | rev ` 🔥 ${reset_color}"
}

autoload -U colors && colors

#######################################################################
#                           Plugins
#######################################################################

### Load plugins
source "$HOMEBREW_PREFIX/opt/kube-ps1/share/kube-ps1.sh"


plugins=(
  # git removed git plugin as it only adds aliases that clash with mine
  vi-mode
  zsh-autosuggestions # git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  kube-ps1 # brew install kube-ps1
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
eval "$(direnv hook zsh)"

# Avoid changing folder without cd (ie typing folder name directly)
setopt noautocd


#######################################################################
#                           Autocompletion
#######################################################################

## uv
eval "$(uv generate-shell-completion zsh)"


## 1pass cli
eval "$(op completion zsh)"; compdef _op op

# Ensuring the you-should-use message is at the end
export YSU_MESSAGE_POSITION="after"

## Enable autocomplete
autoload -Uz compinit && compinit


#######################################################################
#                           Histsize
#######################################################################

# Set history file size
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTFILESIZE=2000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

#######################################################################
#                           Wrap Up
#######################################################################

tmux ls > /dev/null 2>&1 || tmux new # Create and attach tmux session if none exist



export PATH="/Users/asaucedo/.pixi/bin:$PATH"

#######################################################################
#                     Machine-local & work config
#######################################################################
# Untracked (this repo is public). See templates/.zshrc.zalando.example
for f in ~/.zshrc.zalando ~/.zshrc.local; do
  [ -r "$f" ] && source "$f"
done

#######################################################################
#                           Dotfiles helpers
#######################################################################

# Operate on the dotfiles repo from anywhere: `dots`, `dots diff`, `dots push`
dots() { git -C ~/Programming/dotfiles "${@:-status}"; }

# Once a day, mention uncommitted dotfiles changes. Auto-commit handles saving;
# this is about the push, which is deliberately manual on a public repo.
_dots_nudge() {
  local stamp=~/.cache/dots-nudge
  [[ -n $(find "$stamp" -maxdepth 0 -mtime -1 2>/dev/null) ]] && return
  mkdir -p ~/.cache && touch "$stamp"
  local n
  n=$(git -C ~/Programming/dotfiles status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  (( n > 0 )) && print -P "%F{yellow}dotfiles: $n uncommitted change(s) — run 'dots'%f"
  n=$(git -C ~/Programming/dotfiles log --oneline @{u}.. 2>/dev/null | wc -l | tr -d ' ')
  (( n > 0 )) && print -P "%F{yellow}dotfiles: $n unpushed commit(s) — run 'dots push'%f"
}
_dots_nudge
