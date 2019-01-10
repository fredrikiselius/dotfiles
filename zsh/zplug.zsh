# Check if zplug is installed, otherwise install it
if [[ ! -d ~/.zplug ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/copydir", from:oh-my-zsh
zplug "plugins/copyfile", from:oh-my-zsh
zplug "plugins/systemd", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/pyenv", from:oh-my-zsh

# Pure prompt
# https://github.com/sindresorhus/pure
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# Load syntax highlighting last
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug load

if ! zplug check --verbose; then
    printf "Install now? [y/N]: "
    if read -q; then
	echo; zplug install
    fi
fi
