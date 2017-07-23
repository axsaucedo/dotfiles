
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
alias ym="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0" # Download MP3 From Youtube
alias spoof="sudo spoof-mac randomize en0; spoof-mac.py list"
alias scripts="ls ~/Programming/scripts"
alias cdp="cd ~/Programming"
alias p="python3"

# Azure
alias azure='az'

# Custom Scripts
alias ydall="download_youtube.sh"
alias gdeploy='push-git-subtree.sh'
alias gcreate='create-git-repo.sh'

# AWS Aliases
alias aws-get-p2='export instanceId=`aws ec2 describe-instances --filters "Name=instance-state-name,Values=stopped,Name=instance-type,Values=p2.xlarge" --query "Reservations[0].Instances[0].InstanceId"` && echo $instanceId'
alias aws-get-t2='export instanceId=`aws ec2 describe-instances --filters "Name=instance-state-name,Values=stopped,Name=instance-type,Values=t2.xlarge" --query "Reservations[0].Instances[0].InstanceId"` && echo $instanceId'
alias aws-start='aws ec2 start-instances --instance-ids $instanceId && aws ec2 wait instance-running --instance-ids $instanceId && export instanceIp=`aws ec2 describe-instances --filters "Name=instance-id,Values=$instanceId" --query "Reservations[0].Instances[0].PublicIpAddress"` && echo $instanceIp'
alias aws-ip='export instanceIp=`aws ec2 describe-instances --filters "Name=instance-id,Values=$instanceId" --query "Reservations[0].Instances[0].PublicIpAddress"` && echo $instanceIp'
alias aws-ssh='ssh -i ~/.ssh/aws-key-fast-ai.pem ubuntu@$instanceIp'
alias aws-stop='aws ec2 stop-instances --instance-ids $instanceId'
alias aws-nb='open http://$instanceIp:8888'
alias aws-cmds='cat ~/Programming/scripts/fast-ai-commands.txt'

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



# ALL VARIABLES

export GOOGLE_APPLICATION_CREDENTIALS="~/.ssh/ticket_credentials.json"

export PATH="~/Library/Android/sdk/tools:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/9.5/bin:$PATH"
export PATH="~/Programming/scripts/:$PATH"
export PATH="~/bin/:$PATH"
export PATH="/usr/local/anaconda3/bin/:$PATH"

# Adding erlang to path
export PATH=$PATH:~/.cache/rebar3/bin

# Setting up nvm
export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Exporting SPARK dependencies
export SPARK_HOME=/usr/local/Cellar/apache-spark/2.1.1/libexec
export PYTHONPATH=/usr/local/Cellar/apache-spark/2.1.1/libexec/python/:$PYTHONP$

# SETTING JAVA HOME
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home"

# alias node='unalias node ; unalias npm ; nvm use --delete-prefix v7.4.0 ; node $@'
# alias npm='unalias node ; unalias npm ; nvm use --delete-prefix v7.4.0 ; npm $@'

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

# Setup Azure Scripts
autoload bashcompinit && bashcompinit
source '~/lib/azure-cli/az.completion'

echo ".profile ran"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
