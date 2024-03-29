#
# This ZPROFILE file will execute before loading oh-my-zsh and before
# loading ZSHRC. If you would like to add commands that load after 
# loading oh-my-zsh please add them at the end off the ZSHRC.
# Examples of this are commands like `bindkey -v`.


# All ALIASES should go here
alias pyserv="python -m http.server"
alias pyrm='find . -name "*.pyc" -exec rm -rf {} \;'
alias vim="nvim"
function gvim() {
    rm /tmp/godotnvimsocket || true
    NVIM_LISTEN_ADDRESS=/tmp/godotnvimsocket nvim
}
alias vprof="vim ~/.zprofile"
alias sprof="source ~/.zprofile"
alias hprof="cat ~/.zprofile | peco"
alias vvim="vim ~/.vimrc"
alias vzsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias yd="youtube-dl --add-metadata --write-all-thumbnails --embed-thumbnail --write-info-json --embed-subs --all-subs --external-downloader aria2c --external-downloader-args '-c -j 3 -x 3 -s 3 -k 1M'"
alias ydm='youtube-dl --extract-audio --audio-format mp3 --prefer-ffmpeg -o "%(title)s.%(ext)s" --ignore-errors ' 
function ydmw() { (cd /c/Users/axsau/Music/other/ && ydm $1) }
alias lss="l | peco"
# Download MP3 From Youtube
alias ym="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg" 
alias p="python"
alias vtmux="vim ~/.tmux.conf"
alias ctagsm="ctags -R --exclude=.git --exclude=log --exclude=node_modules *"
alias ctagsall='ctags -R --fields=+l --languages=python,java,go --python-kinds=-iv --exclude="*zip" -f ./.tags ./ $JAVA_HOME $CONDA_PREFIX/lib/python3.7/site-packages/' $GOPATH
alias ctagspy='ctags -R --fields=+l --languages=python --python-kinds=-iv --exclude="*zip" -f ./.tags ./'
# Ascicast 2 gif (to convert .cast to .gif)
alias asciicast2gif='docker run --rm -v $PWD:/data asciinema/asciicast2gif'
# OPEN FILE
# Open file in Linux:
# alias open="xdg-open"
# Open file in widnows
alias open="explorer.exe"
alias xdg-open="open"
# Music
alias sconsify='sconsify -username=1156282187 -playlists="Deep House Relax"'
alias mt='mpc toggle' # Toggle play/pause
alias mn='mpc next'
alias mp="mpc prev"
alias m='ncmpcpp'
alias mconf='vim ~/.config/ncmpcpp/config'
# Get size of directory sorted
alias duh="du -hs * | sort -h"
alias duhh="du -hs .* * | sort -h"
# Speed test
alias speedtest=librespeed-cli
# Enable Flux
alias fu='xflux11 -l 51.5074, -g -0.1278 -r 0'
alias fd='killall xflux11'
alias fl='pidof xflux11'
alias p='python3'
alias gl='git log'
function ft () { # Toggle flux
    local flux_pid=$(pidof xflux11)
    if [ "x$flux_pid" != "x" ]; then
        
        killall xflux11
    else
        xflux11 -l 51.5074, -g -0.1278 -r 0
    fi
}
# Change jupyer notebook theme 
alias jtm="jt -t monokai -T -nfs 115 -cellw 98% -N -kl -ofs 11 -altmd"
# Run time start for zsh
alias timez="time zsh -i -c echo"

# Tar / Compress
tarz() { tar -zcvf $1.tar.gz $1; }
untarz() { tar -zxvf $1; }

# To use when audio not working and dummy output displayed
alias audioreset="pulseaudio -k && sudo alsa force-reload"

# Change folders
alias cdp="cd ~/Programming"
alias cdk="cd ~/.keys"
alias cde="cd ~/Programming/ethical"
alias cdee="cd ~/Programming/ethical/ethical"
alias cdd="cd ~/Programming/devnull"
alias cds="cd ~/Programming/kubernetes/seldon"
alias cdss="cd ~/Programming/kubernetes/seldon/seldon-core"
cdtmp() { mkdir ~/Programming/tmp/$(date +'%Y-%m-%dT%H:%M:%S%z') && cd $_ }
alias cleantmp="rm -rf ~/Programming/tmp/*"
# Windows Subsystem for Linux (wsl)
alias cdw="cd /c/Users/axsau/"
alias cdwa="cd /c/Users/axsau/Music"
alias cdwp="cd /c/Users/axsau/Programming"
alias cdv="cd /c/Users/axsau/Programming/vulkan/"
alias cdvk="cd /home/alejandro/Programming/kubernetes/seldon/vulkan-kompute"


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
# GIt aliases have been moved to zshrc to avoid clash with plugin

# View file
alias view='vim -c '
alias viewl="vim -c 'set syntax=log' -c 'set nowrap' - "

# DOCKER ALIASES
alias dk='docker'
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
dkl() {  docker logs -t $1 | less }
alias dcl='docker-compose logs -f -t --tail=10'
alias dcll='docker-compose logs -t | less'
alias dki='docker images'
alias dkr='docker rm'
alias dkm='docker-machine'
alias dkp='docker ps'
alias dkpa='docker ps -a'
alias dkpl="docker ps --format '{{.ID}}\t~ {{.Names}}\t~ {{.Status}}\t~ {{.Image}}'"
alias dkip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'  # Get IP of last container
alias dkra='docker rm $(docker ps -a -q)' # Delete all Docker containers
alias dksa='docker stop $(docker ps -a -q)' # Delete all Docker containers
dke() { docker exec -it $1 /bin/bash -s }
alias dks='docker ps -q | xargs  docker stats --no-stream'
alias dkss='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t"'
alias dkv='docker volume'
alias dkvl='docker volume ls'
alias dkvra='docker volume prune '
# List all tags for image
dtags() {
    image=$1
    page_size=100
    page_index=0
    while true; do 
      page_index=$((page_index+1))
      results=$(curl -L -s "https://registry.hub.docker.com/v2/repositories/$image/tags?page=$page_index&page_size=$page_size" | jq -r 'select(.results != null) | .results[]["name"]')
      echo "$results"
      [[ -z "$results" ]] && break
      echo "$results"
    done
}


#### KUBERNETES ALIAS

alias kdash='kubectl -n kube-system describe secret default && echo "Website at http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default" && kubectl proxy'
# This command is used a LOT both below and in daily life
alias k=kubectl
# Execute a kubectl command against all namespaces
alias kca='f(){ kubectl "$@" --all-namespaces;  unset -f f; }; f'
# Apply a YML file
alias kaf='kubectl apply -f'
alias ka='kubectl apply'
# Drop into an interactive terminal on a container
alias keti='kubectl exec -ti'
# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='kubectl config use-context'
alias kcsc='kubectl config set-context'
alias kcdc='kubectl config delete-context'
alias kccc='kubectl config current-context'
# General aliases
alias kd='kubectl describe'
alias krf='kubectl delete -f'
# Pod management.
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgpw='kgp --watch'
alias kgpwide='kgp -o wide'
alias kep='kubectl edit pods'
alias kdp='kubectl describe pods'
alias krp='kubectl delete pods'
# get pod by label: kgpl "app=myapp" -n myns
alias kgpl='kgp -l'
# Service management.
alias kgs='kubectl get svc'
alias kgsw='kgs --watch'
alias kgswide='kgs -o wide'
alias kes='kubectl edit svc'
alias kds='kubectl describe svc'
alias krs='kubectl delete svc'
# Ingress management
alias kgi='kubectl get ingress'
alias kei='kubectl edit ingress'
alias kdi='kubectl describe ingress'
alias kdeli='kubectl delete ingress'
# Namespace management
alias kgns='kubectl get namespaces'
alias kens='kubectl edit namespace'
alias kdns='kubectl describe namespace'
alias krns='kubectl delete namespace'
alias ksns='kubectl config set-context $(kubectl config current-context) --namespace'
# ConfigMap management
alias kgcm='kubectl get configmaps'
alias kecm='kubectl edit configmap'
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'
# Secret management
alias kgsec='kubectl get secret'
alias kdsec='kubectl describe secret'
alias kdelsec='kubectl delete secret'
# Deployment management.
alias kgd='kubectl get deployment'
alias kgdw='kgd --watch'
alias kgdwide='kgd -o wide'
alias ked='kubectl edit deployment'
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ksd='kubectl scale deployment'
alias krsd='kubectl rollout status deployment'
# Grant admin privileges to the default service account
alias kadmin='kubectl create rolebinding default-admin --clusterrole=admin --serviceaccount=default:default'
kres(){
    kubectl set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S)
}
kevicted() {
    # Remove evicted pods in a namespace with first parameter being the namespace
    kubectl get pods -n $1 | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n $1
}
# Rollout management.
alias kgrs='kubectl get rs'
alias krh='kubectl rollout history'
alias kru='kubectl rollout undo'
# Port forwarding
alias kpf="kubectl port-forward"
# Tools for accessing all information
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'
# Logs
alias kl='kubectl logs'
alias klf='kubectl logs -f'
# File copy
alias kcp='kubectl cp'
# Node Management
alias kgno='kubectl get nodes'
alias keno='kubectl edit node'
alias kdno='kubectl describe node'
alias kdelno='kubectl delete node'
# Top
alias ktn='kubectl top node'
alias ktp='kubectl top pod'
### FULLY CLEAN NAMESPACE
function kcleanns() {
    kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl delete --all -n $1
}
### DELETE STUCK TERMINATING NAMESPACE
function kdelns() {
    kubectl proxy &
    kubectl get namespace $1 -o json |jq '.spec = {"finalizers":[]}' >temp.json
    curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$1/finalize 
}
### DELETE STUCK TERMINATING Resource
function kdelr() {
    kubectl proxy port --port 8123 &
    kubectl get $1 $2 -o json |jq '.spec = {"finalizers":[]}' >temp.json
    curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8123/api/v1/$1/$2/finalize 
}
# Kubernetes KIND
alias kindconfig='kubectl cluster-info --context kind-kind'

# Godot 
alias godot="\"/c/Program Files (x86)/Steam/steamapps/common/Godot Engine/godot.windows.opt.tools.64.exe\""


# CONDA ALIASES
# This function allows for the following commands:
# cenv <COMMAND> <OPTIONAL_YML_FILE>
#       Commands are:
#           activate, delete and update
function cenv() {

    # Usage and help message
    read -r -d '' CENV_HELP <<-'EOF'
Usage: cenv [COMMAND] [FILE]

Detect, activate, delete, and update conda environments.
FILE should be a conda .yml environment file.
If FILE is not given, assumes it is environment.yml.
Automatically finds the environment name from FILE.

Commands:

  None     Activates the environment
  rm       Delete the environment
  up       Update the environment
  list     List all environments
  register Register environment as jupyter kernel

EOF

        envfile="env.yml"

        # Parse the command line arguments
        if [[ $# -gt 2 ]]; then
            echo "Invalid argument(s): $@";
            return 1;
        elif [[ $# == 0 ]]; then
            cmd="activate"
        elif [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
            echo "$CENV_HELP";
            return 0;
        elif [[ "$1" == "rm" ]]; then
            cmd="delete"
            if [[ $# == 2 ]]; then
                envfile="$2"
            fi
        elif [[ "$1" == "up" ]]; then
            cmd="update"
            if [[ $# == 2 ]]; then
                envfile="$2"
            fi
        elif [[ "$1" == "create" ]]; then
            cmd="create"
            if [[ $# == 2 ]]; then
                envfile="$2"
            fi
        elif [[ "$1" == "down" ]]; then
            cmd="deactivate"
        elif [[ "$1" == "list" ]]; then
            cmd="list"
        elif [[ $# == 1 ]]; then
            envfile="$1"
            cmd="activate"
        elif [[ "$1" == "register" ]]; then
            cmd="register"
        else
            echo "Invalid argument(s): $@";
            return 1;
        fi

        # Check if the file exists
        if [[ ! -e "$envfile" ]]; then
            echo "Environment file not found:" $envfile;
            return 1;
        fi

        # Get the environment name from the yaml file
        envname=$(grep "name: *" $envfile | sed -n -e 's/name: //p')

        # Execute one of these actions: activate, update, delete
        if [[ $cmd == "activate" ]]; then
            source activate "$envname";
        elif [[ $cmd == "update" ]]; then
            echo "Updating environment:" $envname;
            source activate "$envname";
            conda env update -f "$envfile"
        elif [[ $cmd == "create" ]]; then
            echo "Creating environment from env file";
            conda env create --file "$envfile"
            source activate "$envname";
        elif [[ $cmd == "delete" ]]; then
            echo "Removing environment:" $envname;
            source deactivate;
            conda env remove --name "$envname";
        elif [[ $cmd == "list" ]]; then
            conda env list;
        elif [[ $cmd == "down" ]]; then
            source deactivate;
        elif [[ $cmd == "register" ]]; then
            python -m ipykernel install --user --name $CONDA_DEFAULT_ENV --display-name "Python ($CONDA_DEFAULT_ENV)"
        fi
}

### ZIG
export PATH=$PATH:~/Programming/lib/zig


### CPP
export PATH=$PATH:~/Programming/lib/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/
alias wcmake="/c/Program\ Files/CMake/bin/cmake.exe"
alias wscons='cmd.exe /c "C:\Users\axsau\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.8_qbz5n2kfra8p0\LocalCache\local-packages\Python38\Scripts\scons.bat"'
alias msbuild="/c/Program\ Files\ (x86)/Microsoft\ Visual\ Studio/2019/Community/MSBuild/Current/Bin/MSBuild.exe"

alias clang-format=/home/alejandro/Programming/lib/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang-format
alias clang-tidy=/home/alejandro/Programming/lib/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang-tidy

# Unreal Compile WSL compile_commands.json
function unreal_cpp_setup () {
    PROJECT_PATH="$(pwd)/$1.uproject"
    echo "$PROJECT_PATH"
    # Getting windows path and escaping backslashes
    WIN_PROJECT_PATH=$(wslpath -w "$PROJECT_PATH" | sed 's/\\/\\\\/g')
    echo "$WIN_PROJECT_PATH"
	"/c/Program Files/Epic Games/UE_4.25/Engine/Binaries/DotNET/UnrealBuildTool.exe" -mode=GenerateClangDatabase -project="$WIN_PROJECT_PATH" -Engine -ThirdParty -rocket -progress $1 Development Win64
	python /home/alejandro/Programming/lib/wsl-to-ccls-compile-commands/convert.py --path "/c/Program Files/Epic Games/UE_4.25/compile_commands.json"
	python ~/Programming/lib/wsl-compile-commands-converter/convert.py "/c/Program Files/Epic Games/UE_4.25/compile_commands.json"
}

#######################################################################
#               GPG Keys                                            #
#######################################################################

# List keys:
# ----------
alias gpglk="gpg --list-secret-keys"
alias gpgl="gpg --list-keys"

# Generate keys:
# -------------
alias gpggf="gpg --full-generate-key"
#OR
alias gpgg="gpg --gen-key"

# Export/Import keys:
# -------------------
alias gpge="gpg --export -a Alejandro"
alias gpgi="gpg --import " # Input file
alias gpges="gpg --export-secret-keys Alejandro"

# Encrypt 
# -----------------
alias gpge="gpg -e -r Alejandro " # Input File
alias gpget="gpg --always-trust -e -r Alejandro " # Input file

# Decrypt
# -----------------
gpgd () {
    gpg -d $1 | vim -
}

# Ensure password prompt can work
# -----------------
export GPG_TTY=$(tty)

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

# Load nvm
# export NVM_DIR=~/.nvm
# group_lazy_load $HOME/.nvm/nvm.sh nvm node npm truffle grunt gulp yarn joplin vim nvim gvim

# Load cargo rust 
group_lazy_load $HOME/.cargo/env cargo rust

# group_lazy_load $HOME/.rvm/scripts/rvm rvm irb rake rails

source ~/.all_secret_keys

# Setting PATH
#export PATH=$PATH:~/anaconda3/bin
export PATH=$PATH:~/miniconda3/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/Programming/bin
export PATH=$PATH:~/.local/bin/
export PATH=$PATH:~/Programming/bin/kafka/bin/
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/kubebuilder/bin
export PATH=$PATH:~/.joplin-bin/bin
export PATH=$PATH:/c/Users/axsau/Programming/lib/vcpkg/

# GOLang
export GOPATH=$HOME/go
alias cdg=cd $GOPATH

# JAVA
export JAVA_HOME="/usr/lib/jvm/default-java"

# SPARK
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
export PYSPARK_PYTHON=/home/alejandro/miniconda3/bin/python
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'

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

# Adding mamba to the path
export PATH=$PATH:$HOME/mambaforge/bin/


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

export TERM="screen-256color-bce"

# Enabling ripgrep with FZF
[ -z "$ZSH_NAME" ] && [ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Function to convert mp4 to gif - params:
# Arg1 - Name of input/output file
# Arg2 - Pixels for width to base on (900 recommended)
vid2gif() {
    ffmpeg -i $1.mp4 frame%04d.png
    gifski -o $1.gif frame*.png --width $2
    rm frame*.png
}

# Compress / reduce size of video 
# Arg1 - Name of input file
# Arg2 - Name of output file
ffmpegrerduce() {
    ffmpeg -i $1 -c:v libx264 -b:v 2000k -minrate 1000k -maxrate 2500k -r:v 25/1 -speed 4 -c:a aac -b:a 128k -ar 48000  -y $2
}

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

# Ensure editor is vim
export VISUAL=vim
export EDITOR="$VISUAL"

# Set interaction on command line to vim forma
# set -o vi

########### WSL

# DISPLAY
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
# We need to disable "native opengl" to open VxSRV
export LIBGL_ALWAYS_INDIRECT=0
export XDG_RUNTIME_DIR=/home/alejandro/tmp-xdg-runtime-dir
export RUNLEVEL=3
# File permissions and write level
umask 002 # ENsure all files are being written with the right permissions

# WSL Allow fast reclaim of memory https://devblogs.microsoft.com/commandline/memory-reclaim-in-the-windows-subsystem-for-linux-2/
# This is useful when running docker and containers are stopped to make sure memory is given back to windows
alias wmem="sudo bash -c 'echo 1 > /proc/sys/vm/drop_caches'"

alias wpython="/c/Users/axsau/scoop/apps/python/current/python.exe"

# Allow running windows espasno locally
alias espanso="cmd.exe /c/Users/axsau/AppData/Local/Programs/Espanso/espanso.cmd"

# Neeed for backspace working on ec2 ssh machines
#export TERM=vt100

# Envs
export PATH="$HOME/.poetry/bin:$PATH"

# Vulkan
export VULKAN_SDK_VERSION=1.3.231.2
export VULKAN_SDK="$HOME/Programming/bin/VulkanSDK/${VULKAN_SDK_VERSION}/x86_64"
export PATH="${VULKAN_SDK}/bin:${PATH}"
export LD_LIBRARY_PATH="${VULKAN_SDK}/lib"
export VK_LAYER_PATH="${VULKAN_SDK}/etc/explicit_layer.d"
# Swiftshader for vulkan linux
export VK_ICD_FILENAMES=$HOME/Programming/bin/swiftshader/vk_swiftshader_icd.json

echo ".zprofile ran"

