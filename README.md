# RenatoUtsch's dotnvim
This is a distribution built specifically for neovim, with extensibility and performance in mind. It is largely based on [spf13-vim](https://github.com/spf13/spf13-vim) and [bling.vim](https://github.com/bling/dotvim).

## Installation
Before installation, ensure that you have either vim8 or neovim installed and updated to the latest version.

1. Clone this repository to `~/.config/dotnvim` folder by running:
```
git clone https://github.com/RenatoUtsch/dotnvim ~/.config/dotnvim
```
2. Make the following symlinks to make both Vim and Neovim use dotnvim:
```
ln -s ~/.config/dotnvim/vim-plug ~/.local/share/nvim/site/autoload
ln -s ~/.config/dotnvim/init.vim ~/.config/nvim/init.vim
ln -s ~/.config/dotnvim/vim-plug ~/.vim/autoload
ln -s ~/.config/dotnvim/init.vim ~/.vimrc
```
4. Startup neovim, run `:PlugUpgrade` and then `:PlugInstall`
5. Install the patched font ("The status line is showing weird symbols" section below)
6. Done!

## Troubleshooting
### The colors are messed up
Your terminal needs to support TrueColor and have it enabled for the themes used to work. Unfortunately the instructions are terminal-specific, so you'll have to search on your own.

For tmux though, you can do this (assuming your terminal emulator already has TrueColor support enabled):

1. Have tmux 2.3+ installed.
2. Add the following code to `~/.tmux.conf`:
```
set-option -ga terminal-overrides ",xterm-256color:Tc"
```
3. Add the following alias to your `~/.bashrc` or `~/.zshrc`:
```
alias tmux="env TERM=xterm-256color tmux" # TrueColor on tmux
```

### The status line is showing weird symbols
This is because [vim-airline](https://github.com/vim-airline/vim-airline) needs special patched fonts "for Powerline" to display properly. These fonts were installed in your system with the distribution, and you need to change the terminal's font to one of them. The available fonts are listed [here](https://github.com/powerline/fonts). I, particularly, use DejaVu Sans Mono Book for Powerline 11 pt.

## Updating
1. Enter `~/.cache/dotnvim` and run `git pull`
2. Open vim/neovim and run `:PlugUpgrade`,then `:PlugUpdate` and then `:PlugClean!`

## Customization
You can store your settings to the `~/.config/dotnvim/init.before.vim` and `~/.config/dotnvim/init.after.vim` files, so you don't need to alter the distribution's vimrc file.

## Adding other plugs
To add other plugs to your configuration, create a `~/.config/dotnvim/plugs.before.vim` and `~/.config/dotnvim/plugs.after.vim` files. This file will be automatically called before and after the dotnvim's plugs are loaded, respectively.
