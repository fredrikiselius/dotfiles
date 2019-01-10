zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle :compinstall filename '/home/fidde/.zshrc'

autoload -Uz compinit
autoload -U edit-command-line
compinit

zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

ZSH_CONFIG_DIR="/home/fidde/.config/zsh"
source "$ZSH_CONFIG_DIR/zplug.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Make sure emacs keybinding are used in shell
bindkey -e

# set tabs to width TABWIDTH
TABWIDTH=4
tabs ${TABWIDTH}
unset TABWIDTH

# Set editor to emacs
export VISUAL=emacs
export EDITOR=$VISUAL


# Uncomment to allow X11 forwarding over ssh
#export DISPLAY=localhost:0.0

# Add users bin dirs to PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Force english language
#export LC_ALL=C

 # Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    touch $SSH_ENV
    chmod 600 "${SSH_ENV}"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' >> "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    kill -0 $SSH_AGENT_PID 2>/dev/null || {
	start_agent
    }
else
    start_agent
fi
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
