# RenatoUtsch's dotnvim
This is a distribution built specifically for neovim, with extensibility and performance in mind. It is largely based on [spf13-vim](https://github.com/spf13/spf13-vim) and [bling.vim](https://github.com/bling/dotvim).

## Quick installation

Easy way through bash and curl:

*Requires bash or zsh, git, nvim and curl.*

    curl https://raw.githubusercontent.com/RenatoUtsch/dotnvim/master/install.sh -L -o - | sh

Copy to your terminal, and press enter. Done.

Please note that this install script is quite invasive and will make changes to your `.zshrc` and `.bashrc` and also change the colors on your terminal, because the terminal colors affect neovim's colors. If you do not want to run such an install script, please see the manual installation instructions below.

It may also be a good idea to take a look at the troubleshooting section after installation, mainly "the status line is showing weird symbols".

## Manual Installation
Before installation, ensure that you have neovim and neovim's python3 module (installed through pip3) installed and updated to the latest version.

1. Download [vim-plug's](https://github.com/junegunn/vim-plug) `plug.vim` file and put it in the `~/.config/nvim/autoload` directory (see the project's page for more instructions)
2. Clone this repository into your `~/.config/nvim` folder by running:
```
git clone https://github.com/RenatoUtsch/dotnvim ~/.config/nvim/dotnvim
```
3. Create the following shim and save it as `~/.config/nvim/init.vim`
```
let g:settings = {}
let g:settings.version = 1
source ~/.config/nvim/dotnvim/init.vim
```
4. Startup neovim and run `:PlugInstall`
5. Install the terminal colors ("The colors are messed up" section below) and the patched font ("The status line is showing weird symbols" section below)
6. Done!

## Troubleshooting
### The colors are messed up
This distribution uses the `base16-default` theme with 256 colors. For the colors to display properly you have to use base16-default's theme on your terminal. [base16-shell](https://github.com/chriskempson/base16-shell) is a helper for that and I suggest reading it. Instructions for bash and zsh are provided below:

1. `git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell`
2. In `./zshrc` or `./bashrc` place the following lines:
```
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
```
3. Reopen your shell

### The colors are still messed up
If the colors are still messed up after setting up base16-shell, first ensure that your terminal's terminfo is declared as `xterm-256color`. If it is, then your terminal probably isn't fully capable of displaying 256 colors properly. This happens, for example, with Apple's Terminal.app. To solve this problem, you should either use another terminal (for example, on OS X, use iTerm2) or change the colorscheme to one of your preference.

### The status line is showing weird symbols
This is because [vim-airline](https://github.com/vim-airline/vim-airline) needs special patched fonts "for Powerline" to display properly. These fonts were installed in your system with the distribution, and you need to change the terminal's font to one of them. The available fonts are listed [here](https://github.com/powerline/fonts). I, particularly, use DejaVu Sans Mono Book for Powerline 11 pt.

## Updating
1. Enter `~/.cache/nvim/dotnvim` and run `git pull`
2. Open neovim and run `:PlugUpgrade` and then `:PlugUpdate`

## Customization
You can modify the settings in your `init.vim` file, so you don't need to alter the distribution's vimrc file.

## Adding other plugs
To add other plugs to your configuration, create a `~/.cache/nvim/plugs.vim` file. This file will be automatically called after the dotnvim's plugs are loaded.
