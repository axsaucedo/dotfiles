# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/alejandro/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

function prompt_git_quick() {
  if [ -e ".git" ]; then
    branch_name=$(git symbolic-ref -q HEAD)
    branch_name=${branch_name##refs/heads/}
    branch_name=${branch_name:-HEAD}

    echo -n "%{$bg[green]%}% %{$fg[black]%}%   "

    if [[ $(git status 2> /dev/null | tail -n1) = *"nothing to commit"* ]]; then
      echo -n "$branch_name"
    elif [[ $(git status 2> /dev/null | head -n5) = *"Changes to be committed"* ]]; then
      echo -n "$branch_name"
    else
      echo -n "$branch_name ●"
    fi

    echo -n " "
  fi
}

# Build our prompt
prompt_kustom_kube_ps1 () {
  local reset_color="%f"
  local blue="%F{blue}"
  local red="%F{red}"
  local cyan="%F{cyan}"

  #KUBE_PS1="${reset_color}$KUBE_PS1_PREFIX"
  #KUBE_PS1+="${blue}$(_kube_ps1_symbol)"
  #KUBE_PS1+="${reset_color}$KUBE_PS1_SEPERATOR"
  KUBE_PS1+="${blue}$KUBE_PS1_CONTEXT${reset_color}"
  #KUBE_PS1+="$KUBE_PS1_DIVIDER"
  KUBE_PS1+="${black} ~ ns:$KUBE_PS1_NAMESPACE ☯ ${reset_color}"
  #KUBE_PS1+="$KUBE_PS1_SUFFIX"

  echo -n "${KUBE_PS1}"
}

prompt_fast_pyenv () {
    echo -n "${reset_color}${yellow} `which python |  rev | cut -d"/" -f3 | rev ` ❤ ${reset_color}"
}

# Theme specific options
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(git_quick dir )
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( virtualenv anaconda background_jobs time vi_mode)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv anaconda kustom_kube_ps1)
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="white"
POWERLEVEL9K_DIR_ETC_BACKGROUND="white"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
#POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND="black"
#POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND="white"
#POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND="black"
#POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND="yellow"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_ANACONDA_LEFT_DELIMITER=""
POWERLEVEL9K_ANACONDA_RIGHT_DELIMITER=""
POWERLEVEL9K_PYTHON_ICON="❤ "
POWERLEVEL9K_ANACONDA_BACKGROUND="cyan"
POWERLEVEL9K_ANACONDA_FOREGROUND="black"
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'

# This is for battery saver as it's slower
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=() 
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir) 

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  #vi-mode
  you-should-use # git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
  zsh-autosuggestions # git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  zsh-syntax-highlighting # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  kube-ps1
  $plugins
)

# Ensuring the you-should-use message is at the end
export YSU_MESSAGE_POSITION="after"

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


# Set VIM as default PROMPT interface
# bindkey -v
# set -o vi

# Ensure up down arrow completion is enabled 
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

# Create and attach tmux session if none exist
tmux ls || tmux new

echo ".zshrc ran"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/alejandro/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/alejandro/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/alejandro/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/alejandro/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Kubectl autocomplete
source <(kubectl completion zsh)
# Jenkins X autocompletion
source <(jx completion zsh)

# source ~/.zshrc_kubectl


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/alejandro/google-cloud-sdk/path.zsh.inc' ]; then . '/home/alejandro/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/alejandro/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/alejandro/google-cloud-sdk/completion.zsh.inc'; fi
