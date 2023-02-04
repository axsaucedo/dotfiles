# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/alejandro/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Build our prompt
prompt_kube_context_fast () {
  local reset_color="%f"
  local blue="%F{blue}"
  local red="%F{red}"
  local cyan="%F{cyan}"

  KUBE_PS1+="${blue}$KUBE_PS1_CONTEXT${reset_color}"
  KUBE_PS1+="${black} ~ ns:$KUBE_PS1_NAMESPACE ☯ ${reset_color}"

  echo -n "${KUBE_PS1}"
}

prompt_fast_pyenv () {
    echo -n "${reset_color}${yellow} `which python |  rev | cut -d"/" -f3 | rev ` 💖 ${reset_color}"
}

# Theme specific options
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vcs vi_mode dir )
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( virtualenv anaconda background_jobs time vi_mode)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv anaconda kube_context_fast background_jobs)
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
POWERLEVEL9K_PYTHON_ICON="💖 "
POWERLEVEL9K_ANACONDA_BACKGROUND="cyan"
POWERLEVEL9K_ANACONDA_FOREGROUND="black"
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode # This provides the same functionality without the issues of zsh-vi-mode
  # zsh-vi-mode not needed as above is the same but without issues
  #zsh-vi-mode # git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
  you-should-use # git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
  zsh-autosuggestions # git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  zsh-syntax-highlighting # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  kube-ps1
  asdf # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/asdf
  kubectl # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl
  gcloud # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gcloud
  docker
  golang
  helm
  ubuntu
  $plugins
)

# This function is required for the copy to clipboard and back
function xclip {
    # If the output is "in" then copy, otherwise paste
    if [[ "${@:$#}" == "-in" ]]; then
        cat "/dev/stdin" | clip.exe
    else
        echo -n "$(/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard)" | sed 's/\r//'
    fi
}

# https://github.com/kutsan/zsh-system-clipboard
source "$HOME/.zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh"


# Ensuring the you-should-use message is at the end
export YSU_MESSAGE_POSITION="after"

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/alejandro/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

# Avoid escaping parenthesis
zstyle ':urlglobber' url-other-schema

DISABLE_AUTO_UPDATE="true"
echo "ZSH auto-updates disabled. Please check updates manually."

# Highlights for vim mode
zle_highlight=( region:bg=236 )

export PATH="$HOME/.poetry/bin:$PATH"

# Git aliases (for clashes with git plugin)
alias gs='git status '
alias ga='git add '
alias gaf='git add $(git ls-files -m -o --exclude-standard | fzf -m)'
alias gb='git branch '
alias gc='git commit -v -s '
alias gd='git diff'
alias gk='gitk --all&'
alias gx='gitx --all'
alias gga='git add .; git commit -m "added"; git push '
alias gi='git init'
alias gicp='cp ~/Programming/lib/global_gitignore .gitignore'
# REmoves git folder completely from history and adds it to git ignore
function gremove() {
    git filter-branch --tree-filter "rm -rf $1" --prune-empty HEAD
    git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
    echo "$1" >> .gitignore
    git add .gitignore
    git commit -m "Removing $1 from git history"
    git gc
}
# CUSTOM git aliases
alias gssh="~/Programming/lib/custom_scripts/git_https_to_ssh.sh"
alias ghttps="~/Programming/lib/custom_scripts/git_ssh_to_https.sh"

echo ".zshrc ran"

tmux ls || tmux new # Create and attach tmux session if none exist and send I as normally it starts in vi mode
tmux send-keys Enter # Change to insert mode as initial tmux session starts in visual

