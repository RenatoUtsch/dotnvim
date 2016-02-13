" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" This is the personal neovim configuration file of Renato Utsch.
" It is largely based on Steve Francia's spf13 vim distribution.
"
" The objective with this dotnvim is to make a light but useful distribution
" specifically for neovim. The settings and plugins I use in this
" configuration are the ones I find most useful, and I avoided adding a lot of
" plugins to keep everything fast.
"
" This file specifies the plugins and their configuration.
"
" This project is released under the Apache 2 license.
"
" Find me at https://github.com/RenatoUtsch
" }

" General {
    Plug 'chriskempson/base16-vim' " {
        let base16colorspace = 256
    " }
    Plug 'tpope/vim-surround'
    Plug 'rhysd/conflict-marker.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'vim-scripts/sessionman.vim'
    Plug 'benjifisher/matchit.zip' " {
        let b:match_ignorecase = 1
    " }
    Plug 'vim-airline/vim-airline'
    Plug 'powerline/fonts', { 'do': './install.sh' } " {
        let g:airline_powerline_fonts = 1
    " }
    Plug 'vim-airline/vim-airline-themes' " {
        let g:airline_theme = g:settings.airline_colorscheme
    " }
    Plug 'bling/vim-bufferline'
    Plug 'easymotion/vim-easymotion' " {
        nmap s <leader><leader>s
    " }
    Plug 'mbbill/undotree' " {
        nnoremap <Leader>u :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it
        let g:undotree_SetFocusWhenToggle = 1
    " }
    Plug 'nathanaelkane/vim-indent-guides' " {
        let g:indent_guides_start_level = 2
        let g:indent_guides_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }
    Plug 'vim-scripts/restore_view.vim'
    Plug 'mhinz/vim-signify'
    Plug 'gcmt/wildfire.vim' " {{
        let g:wildfire_objects = {
            \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
            \ "html,xml" : ["at"],
            \ }
    " }}
    Plug 'myusuf3/numbers.vim'
    if executable('ag') " rking/ag.vim {
        Plug 'rking/ag.vim'
    endif
    " }
" }

" Programming {
    Plug 'tpope/vim-fugitive'
    Plug 'mattn/gist-vim'
    Plug 'tpope/vim-commentary'
    Plug 'godlygeek/tabular'
    Plug 'benekastah/neomake' " {
        if isdirectory(expand("~/.vim/plugged/neomake"))
            autocmd! BufEnter,BufWritePost * Neomake
        endif
    " }
    if has('python3') " Shougo/deoplete.nvim {
        Plug 'Shougo/deoplete.nvim'
        let g:deoplete#enable_at_startup = 1
    endif
    " }
" }

" HTML {
    Plug 'amirh/HTML-AutoCloseTag'
    Plug 'hail2u/vim-css3-syntax'
" }

" Misc {
    Plug 'rust-lang/rust.vim'
    Plug 'spf13/vim-preview'
    Plug 'cespare/vim-toml'
" }

" User plugins {
    if filereadable(expand("~/.config/nvim/plugs.vim"))
        source ~/.config/nvim/plugs.vim
    endif
" }
