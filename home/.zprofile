
#           888 88e  888 88e    e88 88e   888'Y88 888 888     888'Y88 
#    8P d8P 888 888D 888 888D  d888 888b  888 ,'Y 888 888     888 ,'Y 
#    P d8P  888 88"  888 88"  C8888 8888D 888C8   888 888     888C8   
#     d8P d 888      888 b,    Y888 888P  888 "   888 888  ,d 888 ",d 
#    d8P d8 888      888 88b,   "88 88"   888     888 888,d88 888,d88 


typeset -U path PATH


# AI Agents

# claude code
export PATH=$PATH:~/.claude/bin

# Copilot telemetry usage
export COPILOT_OTEL_ENABLED=true
export COPILOT_OTEL_EXPORTER_TYPE=file
export COPILOT_OTEL_FILE_EXPORTER_PATH="$HOME/.copilot/otel/copilot-otel-$(date +%Y%m%d-%H%M%S).jsonl"

# BEADS task management
export BEADS_DIR=~/.beads-planning/.beads


### Joplin export
export PATH=$PATH:~/Programming/lib/joplin-export

# LANGUAGES

### RUBY
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export HOMEBREW_AUTO_UPDATE_SECS=604800




### PERL

PATH="/Users/asaucedo/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/asaucedo/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/asaucedo/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/asaucedo/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/asaucedo/perl5"; export PERL_MM_OPT;


# Ensure password prompt can work
# -----------------
export GPG_TTY=$(tty)


# Load cargo envs
. "$HOME/.cargo/env"

source ~/.all_secret_keys

# Setting PATH
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/Programming/bin
export PATH=$PATH:~/.joplin-bin/bin

# Roborev
export PATH=$PATH:/Users/asaucedo/Programming/external/roborev/bin


# GOLang
export GOPATH=$HOME/go

# JAVA
# Mac brew installed
_zi=~/.cache/zsh-init
mkdir -p "$_zi"
[[ -s $_zi/java_home ]] || /usr/libexec/java_home >| "$_zi/java_home"
export JAVA_HOME=$(<"$_zi/java_home")

# Ensure opt+backspace and opt+keys behave for moving around text
bindkey -M viins '^[[1;3D' backward-word        # Option+Left
bindkey -M viins '^[[1;3C' forward-word         # Option+Right
bindkey -M viins '^[^?'    backward-kill-word    # Option+Backspace


# Set folder colours for Solarized theme
export LSCOLORS="gxfxbEaEBxxEhEhBaDaCaD"

# Enabling ripgrep with FZF
[ -z "$ZSH_NAME" ] && [ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"



# Ensure editor is vim
export VISUAL=nvim
export EDITOR="$VISUAL"

# Vulkan
export VULKAN_SDK_VERSION=1.3.275.0
export VULKAN_SDK="$HOME/VulkanSDK/${VULKAN_SDK_VERSION}/macOS"
export PATH="${VULKAN_SDK}/bin:${PATH}"
export LD_LIBRARY_PATH="${VULKAN_SDK}/lib"
export VK_LAYER_PATH="${VULKAN_SDK}/share/vulkan/explicit_layer.d"
export VK_ICD_FILENAMES="${VULKAN_SDK}/share/vulkan/icd.d/MoltenVK_icd.json"

# Custom Zalando Machine 

# Set PATH, MANPATH, etc., for Homebrew.
[[ $_zi/brew.zsh -nt /opt/homebrew/bin/brew ]] || /opt/homebrew/bin/brew shellenv >| "$_zi/brew.zsh"
source "$_zi/brew.zsh"
command -v bat >/dev/null && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Adding asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# SBT Config
export SBT_CREDENTIALS="$HOME/.ivy2/.credentials"

# Adding main dirs
export PYENV_ROOT="$HOME/.pyenv"
[[ $_zi/pyenv.zsh -nt ${commands[pyenv]} ]] || pyenv init - --no-rehash >| "$_zi/pyenv.zsh"
source "$_zi/pyenv.zsh"
unset _zi

# Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
