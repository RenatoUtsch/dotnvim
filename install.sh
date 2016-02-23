#!/usr/bin/env sh

# For license refer to https://github.com/RenatoUtsch/dotnvim/blob/master/LICENSE.txt

errorMsg="I require git, curl and nvim, but one of them is not installed: ";
errorGB=", install and come back. Aborting..."
finished="Done. Reopen your shell and nvim."

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

printColorConf(){
    printf "\n\n# Base16 Shell\nBASE16_SHELL=\"\$HOME/.config/base16-shell/base16-default.dark.sh\"\n[[ -s \$BASE16_SHELL ]] && source \$BASE16_SHELL" >> $HOME/$1;
}

getColors(){
    git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell;
    command -v zsh >/dev/null 2>&1 && printColorConf ".zshrc";
    command -v bash >/dev/null 2>&1 && printColorConf ".bashrc";
}

config(){
    touch $HOME/.config/nvim/init.vim;
    printf "let g:settings = {}\nlet g:settings.version = 1\nsource ~/.config/nvim/dotnvim/init.vim\n" > $HOME/.config/nvim/init.vim;
    nvim "+PlugInstall" "+qall"
}

existsOrFail "git"
existsOrFail "curl"
existsOrFail "nvim"
getPlugVim
getDotNVim
getColors
config
echo $finished
