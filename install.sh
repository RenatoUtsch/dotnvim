#!/usr/bin/env bash

# For license refer to https://github.com/RenatoUtsch/dotnvim/blob/master/LICENSE.txt

errorMsg="I require git, curl and nvim, but one of them is not installed: ";
errorGB=", install and come back. Aborting..."

error(){
    echo >&2 $errorMsg $1 $errorGB; exit 1;
}

existsOrFail(){
    command -v $1 >/dev/null 2>&1 || error $1;
}

getPlugVim(){
    curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
}

getDotNVim(){
    git clone https://github.com/RenatoUtsch/dotnvim $HOME/.config/nvim/dotnvim;
}

config(){
    touch $HOME/.config/nvim/init.vim;
    printf "let g:settings = {}\nlet g:settings.version = 1\nsource ~/.config/nvim/dotnvim/init.vim\n" > $HOME/.config/nvim/init.vim;
    nvim "+PlugInstall +qall"
}

existsOrFail "git"
existsOrFail "curl"
existsOrFail "nvim"
getPlugVim
getDotNVim
config
