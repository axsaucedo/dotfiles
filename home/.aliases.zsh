#######################################################################
#                      Aliases & Functions
#######################################################################

# All ALIASES should go here
alias colorsprint="msgcat --color=test" # print all colors
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
alias yd="yt-dlp --add-metadata --write-all-thumbnails --embed-thumbnail --write-info-json --embed-subs --all-subs --external-downloader aria2c --external-downloader-args '-c -j 3 -x 3 -s 3 -k 1M'"
alias ydm='yt-dlp --extract-audio --audio-format mp3 --prefer-ffmpeg -o "%(title)s.%(ext)s" --ignore-errors ' 
command -v eza >/dev/null && alias l='eza -lah --git'
command -v eza >/dev/null && alias lt='eza -T -L 2'
alias lss="l | peco"
# Download MP3 From Youtube
alias ym="yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg" 
alias vtmux="vim ~/.tmux.conf"
alias ctagsm="ctags -R --exclude=.git --exclude=log --exclude=node_modules *"
alias ctagsall='ctags -R --fields=+l --languages=python,java,go --python-kinds=-iv --exclude="*zip" -f ./.tags ./ $JAVA_HOME $CONDA_PREFIX/lib/python3.7/site-packages/ $GOPATH'
alias ctagspy='ctags -R --fields=+l --languages=python --python-kinds=-iv --exclude="*zip" -f ./.tags ./'
# Ascicast 2 gif (to convert .cast to .gif)
alias asciicast2gif='docker run --rm -v $PWD:/data asciinema/asciicast2gif'
alias xdg-open="open"
# Get size of directory sorted
alias duh="du -hs ./* | sort -h"
alias duhh="du -hs ./.* * | sort -h"
# Speed test
alias speedtest=librespeed-cli
alias p='python3'
# Run time start for zsh
alias timez="time zsh -i -c echo"

# Tar / Compress
tarz() {
    local name="$1"
    shift
    tar -zcvf "${name}.tar.gz" "$@" "$name"
}
untarz() { tar -zxvf $1; }

# Change folders
alias cdp="cd ~/Programming"
alias cdz="cd ~/Programming/zalando"
alias cdk="cd ~/.keys"
alias cde="cd ~/Programming/ethical"
alias cdee="cd ~/Programming/ethical/ethical"
alias cdd="cd ~/Programming/devnull"
alias cds="cd ~/Programming/kubernetes/seldon"
alias cdss="cd ~/Programming/kubernetes/seldon/seldon-core"
cdtmp() { mkdir /tmp/$(date +'%Y-%m-%dT%H-%M-%S') && cd $_ }
alias cleantmp="rm -rf ~/Programming/tmp/*"
alias cdvk="cd ~/Programming/vk/kompute"
alias cdak="cd ~/Programming/agentic/kaos"
alias cdaa=cdak
alias cdau="cd ~/Programming/agentic/kaos-ui"
alias cda="cd ~/Programming/agentic/"


# Mac Specific
alias mergepdf='"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o ./merged.pdf'

# Brightness
alias b="xrandr --output DP-0 --brightness"
alias bu="xrandr --output DP-0 --brightness 1"
alias bd="xrandr --output DP-0 --brightness 0.25"

# Compress pdf
cpdf() {
    /usr/bin/gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=SMALL-$1 $1
}


# Custom Scripts
alias gdeploy='push-git-subtree.sh'
alias gcreate='create-git-repo.sh'

####### GITHUB ALIASES

# Delete all untracked files and ask first for confirmation
git-clean() {
  git clean -xfd -n
  local ans
  # Works in zsh
  read "ans?Proceed with git clean -xfd? [y/N] "
  [[ $ans == [yY] ]] && git clean -xfd
}
# GIt aliases have been moved to zshrc to avoid clash with plugin
git-branches() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
git-commits() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % bash -c 'git show -p --color=always %') << 'FZF-EOF'
                {}
FZF-EOF"
}
# Git stash commands
alias git-stash-apply="git stash list | fzf --preview-window=right:70%:wrap --preview 's=\$(echo {} | cut -d: -f1); git stash show -p --color=always \"\$s\"' | cut -d: -f1 | xargs -r git stash apply"
alias git-stash-pop="git stash list | fzf --preview-window=right:70%:wrap --preview 's=\$(echo {} | cut -d: -f1); git stash show -p --color=always \"\$s\"' | cut -d: -f1 | xargs -r git stash pop"
alias git-stash-drop="git stash list | fzf --preview-window=right:70%:wrap --preview 's=\$(echo {} | cut -d: -f1); git stash show -p --color=always \"\$s\"' | cut -d: -f1 | xargs -r git stash drop"
# Git aliases (for clashes with git plugin)
alias gco="git checkout"
alias gp='git push'
alias gl='git-commits'
alias gs='git status '
alias ga='git add '
alias gaf='git add $(git ls-files -m -o --exclude-standard | fzf -m)'
alias gb='git-branches'
alias gc='git commit -v -s '
alias gd='git diff -u'
alias gk='gitk --all&'
alias gx='gitx --all'
alias gi='git init'
alias gitignore="curl -O https://gist.githubusercontent.com/axsaucedo/a3331f79d30ce3acef95f187d8e72b87/raw/9520430de244b9ddcf004dc2ae832456e35a00ea/.gitignore"
# REmoves git folder completely from history and adds it to git ignore
function gremove() {
    git filter-branch --tree-filter "rm -rf $1" --prune-empty HEAD
    git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
    echo "$1" >> .gitignore
    git add .gitignore
    git commit -m "Removing $1 from git history"
    git gc
}
# Git exploration commands
## What Changes the Most
alias git-blame-files='git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20'

## Who built this
alias git-blame-authors='git shortlog -sn --no-merges'

## Where do bugs cluster
alias git-blame-bugs="git log -i -E --grep=\"fix|bug|broken\" --name-only --format='' | sort | uniq -c | sort -nr | head -20"

## Is project accelerating or dying
alias git-blame-project="git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c"

## How often is the team firefighting
alias git-blame-fire="git log --oneline --since=\"1 year ago\" | grep -iE 'revert|hotfix|emergency|rollback'"

# Script to laod all sessions on copilot and run the selected session
copilot-sessions() {
  local sdir="${HOME}/.copilot/session-state"
  local id
  id=$(ls -td "$sdir"/*/ 2>/dev/null | while read -r d; do
    local uuid=$(basename "$d")
    local git_root=$(grep '^git_root:' "$d/workspace.yaml" 2>/dev/null | sed 's/^git_root: //')
    local cwd=$(grep '^cwd:' "$d/workspace.yaml" 2>/dev/null | sed 's/^cwd: //')
    local project=$(basename "${git_root:-${cwd:--}}")
    local modified=$(stat -f "%Sm" -t "%b %d %H:%M" "$d/workspace.yaml" 2>/dev/null)
    local plan_line=""
    [ -f "$d/plan.md" ] && plan_line=$(head -1 "$d/plan.md" | sed 's/^#* *//')
    printf "\033[2m%s\033[0m | \033[33m%s\033[0m | \033[36m%s\033[0m | \033[35m%s\033[0m\n" \
      "$uuid" "${modified:--}" "${project:--}" "${plan_line:--}"
  done | fzf --ansi --header "Enter: resume | Esc: cancel | CWD: -C \"$PWD\"" \
    --delimiter ' \| ' --with-nth=2.. --preview-window=right:55%:wrap \
    --preview 'd='"$sdir"'/{1}
      printf "\033[1;34m📅 Last Modified\033[0m\n"
      printf "   \033[33m%s\033[0m\n" "$(stat -f "%Sm" -t "%Y-%m-%d %H:%M" "$d/workspace.yaml" 2>/dev/null)"
      echo ""
      printf "\033[1;34m📋 Workspace\033[0m\n"
      printf "   \033[2mID:\033[0m  %s\n" "$(grep "^id:" "$d/workspace.yaml" 2>/dev/null | sed "s/^id: //")"
      printf "   \033[2mCWD:\033[0m %s\n" "$(grep "^cwd:" "$d/workspace.yaml" 2>/dev/null | sed "s/^cwd: //")"
      summary=$(grep "^summary:" "$d/workspace.yaml" 2>/dev/null | head -1 | sed "s/^summary: //")
      [ -n "$summary" ] && printf "   \033[1;33mSummary:\033[0m %s\n" "$summary"
      if [ -f "$d/plan.md" ]; then
        echo ""
        printf "\033[1;34m📝 Plan\033[0m\n"
        bat --style=plain --color=always -l md "$d/plan.md" 2>/dev/null | sed "s/^/   /" || sed "s/^/   /" "$d/plan.md" 2>/dev/null
      fi') || return 0
  copilot --resume="${id%% |*}" "$@"
}

# Github pages
alias gh-pages="bundle exec jekyll serve"
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
command -v kubecolor >/dev/null && alias kubectl=kubecolor
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
alias ke='kubectl edit'
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
    kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl delete --all --force -n $1
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
kind-stop()   { docker stop $(kind get nodes --name "${1:-kind}") ; }
kind-start()  { docker start $(kind get nodes --name "${1:-kind}") ; }
kind-status() { docker ps -a --filter label=io.x-k8s.kind.cluster --format '{{.Label "io.x-k8s.kind.cluster"}}: {{.State}}' | sort -u ; }

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
# Upgrade Joplin in Mac
alias joplinupgrade="SHARP_IGNORE_GLOBAL_LIBVIPS=1 NPM_CONFIG_PREFIX=~/Programming/ npm install -g joplin"
### PYTHON

# This function creates the venv in the same directory
function uv-init-local() {
    uv init;
    uv venv --seed;
    echo ". .venv/bin/activate" >.envrc;
    direnv allow;
}

# This default function creates it in a central directory
function uv-init() {
    local UV_DIR=~/.venvs/${PWD//\//-}
    uv init;
    UV_PROJECT_ENVIRONMENT=$UV_DIR uv venv --seed;
    ln -sfn $UV_DIR .venv
    uv sync;
    echo "source ./.venv/bin/activate" > .envrc;
    direnv allow;
}

alias pip="python -m pip"
# Utilities

alias cat="bat --style plain"
alias ccat="bat --style full"

#######################################################################
#               GPG Keys & Passwords
#######################################################################

# List GPG keys:
# ----------
alias gpglk="gpg --list-secret-keys"
alias gpgl="gpg --list-keys"

# Generate GPG keys:
# -------------
alias gpggf="gpg --full-generate-key"
#OR
alias gpgg="gpg --gen-key"

# Export/Import GPG keys:
# -------------------
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
# Joplin
alias joplin-reload="/Users/asaucedo/Programming/lib/joplin-export/joplin-export-job.sh"
alias cdg='cd $GOPATH'
# Function to convert mp4 to gif - params:
vid-to-gif() {
  local input="input.mov"
  local output="output.gif"
  local start=""
  local end=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -i|--input)  input="$2"; shift 2;;
      -o|--output) output="$2"; shift 2;;
      -s|--start)  start="$2"; shift 2;;
      -e|--end)    end="$2"; shift 2;;
      -h|--help)   echo "Usage: gifify [-i input] [-o output] [-s start] [-e end]"; return 0;;
      *) echo "Unknown arg: $1" >&2; return 1;;
    esac
  done

  local args=()
  [[ -n "$start" ]] && args+=(-ss "$start")
  [[ -n "$end" ]]   && args+=(-to "$end")

  ffmpeg -i "$input" -vf "setpts=0.5*PTS,fps=15,scale=1080:-1:flags=lanczos" \
    "${args[@]}" -loop 0 "$output"
}


# Compress / reduce size of video 
# Arg1 - Name of input file
# Arg2 - Name of output file
ffmpegrerduce() {
    ffmpeg -i $1 -c:v libx264 -b:v 2000k -minrate 1000k -maxrate 2500k -r:v 25/1 -speed 4 -c:a aac -b:a 128k -ar 48000  -y $2
}
ffmpeg-remove-audio() {
    ffmpeg -i $1 -c copy -an $2
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
