#!/bin/bash


ZSH_CONF_PATH="$HOME/.config/zsh"
EMACS_CONF_PATH="$HOME/.emacs.d"
DIR=$(cd `dirname $0` && pwd)
######################################## Functions
symbolic_if_possible()
{
    TARGET=$1
    LINK_NAME=$2

    if [ ! -f $LINK_NAME ]
    then
	ln -sv $TARGET $LINK_NAME
    else
	printf "$LINK_NAME already exists\n"
    fi
}

######################################## Emacs
printf "Installing emacs files..\n"
symbolic_if_possible $DIR/emacs/init.el $EMACS_CONF_PATH/init.el
printf "Done\n\n"


######################################## zsh
printf "Installing zsh files..\n"
symbolic_if_possible $DIR/zsh/.zshrc $HOME/.zshrc

if [ ! -d $ZSH_CONF_PATH ]
then
    printf "Creating folder $ZSH_CONF_PATH\n"
    mkdir -p $ZSH_CONF_PATH
fi

ZSH_FILES="zplug.zsh
aliases.zsh"

for zf in $ZSH_FILES
do
    symbolic_if_possible $DIR/zsh/$zf $ZSH_CONF_PATH/$zf
done
printf "Done\n"


