
# All ALIASES should go here
alias subl='"/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"'
alias pyserv="python2.7 -m SimpleHTTPServer"
alias ven2="virtualenv --no-site-packages venv"
alias ven3="virtualenv --no-site-packages -p python3 venv"
alias venv="ven3"
alias act="source venv/bin/activate"
alias deact="deactivate"
alias pyrm='find . -name "*.pyc" -exec rm -rf {} \;'
alias worktabs="osascript ~/Programming/scripts/openworktabs.scpt"
alias pt="py.test -s -v "
alias vprof="vim ~/.profile"
alias sprof="source ~/.profile"
alias hprof="head -30 ~/.profile"
alias vvim="vim ~/.vimrc"
alias vzsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias c="clear"
alias r3="rebar3"
alias yd="youtube-dl"
# Download MP3 From Youtube
alias ym="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0" 
alias spoof="sudo spoof-mac randomize en0; spoof-mac.py list"
alias scripts="ls ~/Programming/scripts"
alias cdp="cd ~/Programming"
alias p="python3"
alias python="python3"
alias vtmux="vim ~/.tmux.conf"
alias ctagsm="ctags -R --exclude=.git --exclude=log --exclude=node_modules *"
alias mergepdf='"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o ./merged.pdf'
alias asana="/usr/local/bin/asana" # Brew install asana
alias asana-list="/usr/local/bin/asana tasks | peco"
alias asana-add="/Users/alejandro.saucedo/.rvm/gems/ruby-2.4.1/bin/asana letsdothis " # Gem install asana-client

# Geeknote Shortcuts
alias en="vim -c Geeknote"
function ec() {
    vim +"GeeknoteCreateNote $1"
}

# Custom Scripts
alias ydall="download_youtube.sh"
alias gdeploy='push-git-subtree.sh'
alias gcreate='create-git-repo.sh'

# GITHUB ALIASES
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit '
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gga='git add .; git commit -m "added"; git push '
alias gi='cp ~/Programming/lib/git/global_gitignore .gitignore'

# ALL VARIABLES

export GOOGLE_APPLICATION_CREDENTIALS="~/.ssh/ticket_credentials.json"

export PATH="$HOME/Library/Android/sdk/tools:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/9.5/bin:$PATH"
export PATH="$HOME/Programming/scripts/:$PATH"
export PATH="$HOME/bin/:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"

# Adding svim
export PATH=/usr/local/sbin:$PATH

# Adding erlang to path
export PATH=$PATH:~/.cache/rebar3/bin

# Adding LIB
export PATH=$PATH:~/Programming/lib

# Setting RVM

# Setting up nvm
export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# alias node='unalias node ; unalias npm ; nvm use --delete-prefix v7.4.0 ; node $@'
# alias npm='unalias node ; unalias npm ; nvm use --delete-prefix v7.4.0 ; npm $@'

# Exporting SPARK dependencies
export SPARK_HOME=/usr/local/Cellar/apache-spark/2.1.1/libexec
export PYTHONPATH=/usr/local/Cellar/apache-spark/2.1.1/libexec/python/:$PYTHONP$

# SETTING JAVA HOME
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home"

lazy_load() {
    # Act as a stub to another shell function/command. When first run, it will load the actual function/command then execute it.
    # E.g. This made my zsh load 0.8 seconds faster by loading `nvm` when "nvm", "npm" or "node" is used for the first time
    # $1: space separated list of alias to release after the first load
    # $2: file to source
    # $3: name of the command to run after it's loaded
    # $4+: argv to be passed to $3
    echo "Lazy loading $1 ..."

    # $1.split(' ') using the s flag. In bash, this can be simply ($1) #http://unix.stackexchange.com/questions/28854/list-elements-with-spaces-in-zsh
    # Single line won't work: local names=("${(@s: :)${1}}"). Due to http://stackoverflow.com/questions/14917501/local-arrays-in-zsh   (zsh 5.0.8 (x86_64-apple-darwin15.0))
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    . $2
    shift 2
    $*
}

group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}

export NVM_DIR=~/.nvm
group_lazy_load $HOME/.nvm/nvm.sh nvm node npm truffle grunt gulp

#group_lazy_load $HOME/.rvm/scripts/rvm rvm irb rake rails

source ~/.all_secret_keys

# Setting PATH
export PATH="/Applications/Postgres.app/Contents/Versions/9.5/bin:${PATH}"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Set VIM as default PROMPT interface
set -o vi

# Set folder colours for Solarized theme
export LSCOLORS="gxfxbEaEBxxEhEhBaDaCaD"

# Cycle through history based on characters already typed on the line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

echo ".profile ran"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# EIGEN SPECIFIC
export FRONTEND_DEV=True

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export TERM="xterm-256color"

# Enabling ripgrep with FZF
[ -z "$ZSH_NAME" ] && [ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# fkill - kill processes
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
  local inst=$(brew search | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# Search on chrome history
# c - browse chrome history
c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
