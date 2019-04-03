#
# This ZPROFILE file will execute before loading oh-my-zsh and before
# loading ZSHRC. If you would like to add commands that load after 
# loading oh-my-zsh please add them at the end off the ZSHRC.
# Examples of this are commands like `bindkey -v`.


# All ALIASES should go here
alias pyserv="python2.7 -m SimpleHTTPServer"
alias pyrm='find . -name "*.pyc" -exec rm -rf {} \;'
alias vprof="vim ~/.zprofile"
alias sprof="source ~/.zprofile"
alias hprof="cat ~/.zprofile | peco"
alias vvim="vim ~/.vimrc"
alias vzsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias yd="youtube-dl --add-metadata --write-all-thumbnails --embed-thumbnail --write-info-json --embed-subs --all-subs --external-downloader aria2c --external-downloader-args '-c -j 3 -x 3 -s 3 -k 1M'"
alias ydm="youtube-dl --extract-audio --audio-format mp3 --prefer-ffmpeg "
alias lss="l | peco"
# Download MP3 From Youtube
alias ym="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg" 
alias cdp="cd ~/Programming"
alias cde="cd ~/Programming/ethical"
alias cdee="cd ~/Programming/ethical/ethical"
alias cdd="cd ~/Programming/devnull"
alias p="python"
alias vtmux="vim ~/.tmux.conf"
alias ctagsm="ctags -R --exclude=.git --exclude=log --exclude=node_modules *"
# Using asana from: https://github.com/thash/asana
alias asana="~/go/bin/asana" # Brew install asana
alias asana-list="asana tasks | peco"
# Gem install asana-client
alias asana-client="/var/lib/gems/2.5.0/gems/asana-client-1.0.0/bin/asana" 
alias asana-add="asana-client letsdothis " 
# OPEN FILE
# Open file in Linux:
# alias open="xdg-open"
# Open file in widnows
alias open="explorer.exe"
# Music
alias sconsify='sconsify -username=1156282187 -playlists="Deep House Relax"'
alias mt='mpc toggle' # Toggle play/pause
alias mn='mpc next'
alias mp="mpc prev"
alias m='ncmpcpp'
alias mconf='vim ~/.config/ncmpcpp/config'
# Get size of directory sorted
alias duh="du -hs .* * | sort -h"
# Enable Flux
alias fu='xflux11 -l 51.5074, -g -0.1278 -r 0'
alias fd='killall xflux11'
alias fl='pidof xflux11'
function ft () { # Toggle flux
    local flux_pid=$(pidof xflux11)
    if [ "x$flux_pid" != "x" ]; then
        
        killall xflux11
    else
        xflux11 -l 51.5074, -g -0.1278 -r 0
    fi
}
# Change jupyer notebook theme 
alias jtm="jt -t monokai -altp -nfs 115 -cellw 98% -T -N -kl -ofs 11 -altmd"

# To use when audio not working and dummy output displayed
alias audioreset="pulseaudio -k && sudo alsa force-reload"


# Mac Specific
alias mergepdf='"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o ./merged.pdf'
alias spoof="sudo spoof-mac randomize en0; spoof-mac.py list"

# Geeknote Shortcuts
alias en="vim -c Geeknote"
function ec() {
    vim +"GeeknoteCreateNote $1"
}

# Express VPN
alias x="expressvpn"
alias xl="x list | peco"
alias xc="x connect"
alias xcs="x connect ch2"
alias xs="x status"
alias xh="x --help | peco"
alias xd="x disconnect"

# Brightness
alias b="xrandr --output DP-0 --brightness"
alias bu="xrandr --output DP-0 --brightness 1"
alias bd="xrandr --output DP-0 --brightness 0.25"

# Windows Subsystem for Linux (wsl)
alias cdw="cd /mnt/c/"
alias cdwa="cd /mnt/c/Users/alejandro/Music"
alias cdwm="cd /mnt/c/Users/alejandro/Music"

# Tor
alias torb="(cd ~/Programming/lib/tor-browser_en-US/ && ./start-tor-browser.desktop)"

# Wifi from terminal
alias ws="nmcli general && nmcli device wifi | head"
alias wl="nmcli device wifi"
alias wd="nmcli radio wifi off"
alias wu="nmcli radio wifi on"
declare -f fzf
wcc() {
    local ssid
    local tmpfile
    nmcltmp="/tmp/nmcltmp.tmp"
    nmclout="/tmp/nmclout.tmp"

    while [ "x$ssid" = "x" ]; do
        rm $nmcltmp $rmclout
        # Scan for networks and wait 1 sec
        echo "Scanning for networks "
        nmcli device wifi rescan
        # Save all the current connections into tmp file 
        nmcli dev wifi | sed 1d > $nmcltmp
        # Run the fzf command with the connections found 
        # and store output in tmp file
        timeout 10 fzf < $nmcltmp > $nmclout
        # Get the SSID name from the file found
        ssid=$(awk -F'  +' '{print $2}' < $nmclout)
        sleep 0.3
    done

    if [ "x$ssid" != "x" ]
    then
        echo "Connecting to $ssid"
        echo $ssid | nmcli device wifi connect "$ssid"
    fi

    # Clean
    rm $nmclout $nmcltmp
}
wcn() { 
    echo "Re-scanning wifi (If none appear, rerun...)"
    device wifi rescan
    sleep 1
    echo "Connecting to $DEFAULT_WIFI_SSID"
    nmcli device wifi connect "$DEFAULT_WIFI_SSID" password "$DEFAULT_WIFI_PASSWORD" 
    nmcli general status
}


# Compress pdf
cpdf() {
    /usr/bin/gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=SMALL-$1 $1
}


# Custom Scripts
alias gdeploy='push-git-subtree.sh'
alias gcreate='create-git-repo.sh'

# GITHUB ALIASES
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit '
alias gd='git diff'
alias gk='gitk --all&'
alias gx='gitx --all'
alias gga='git add .; git commit -m "added"; git push '
alias gi='cp ~/Programming/lib/git/global_gitignore .gitignore'

# TODO, need to make sure helper keys are automatically loaded
alias xx="sudo bash /etc/init.d/keyremap && xmodmap ~/.Xmodmap"


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
export PATH=$PATH:~/anaconda3/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/Programming/bin


# Show prompt type vim mode (insert/visual)
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


# Set folder colours for Solarized theme
export LSCOLORS="gxfxbEaEBxxEhEhBaDaCaD"

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

# # Search on chrome history
# # c - browse chrome history
# c() {
#   local cols sep google_history open
#   cols=$(( COLUMNS / 3 ))
#   sep='{::}'
# 
#   if [ "$(uname)" = "Darwin" ]; then
#     google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
#     open=open
#   else
#     google_history="$HOME/.config/google-chrome/Default/History"
#     open=xdg-open
#   fi
#   cp -f "$google_history" /tmp/h
#   sqlite3 -separator $sep /tmp/h \
#     "select substr(title, 1, $cols), url
#      from urls order by last_visit_time desc" |
#   awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
#   fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
# }


# Quickfixes for WSL
umask 002

echo ".zprofile ran"
