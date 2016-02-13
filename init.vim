" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" This is the personal neovim configuration file of Renato Utsch.
" It is largely based on Steve Francia's spf13 vim distribution.
"
" The objective with this dotnvim is to make a light but useful distribution
" specifically for neovim. The settings and plugins I use in this
" configuration are the ones I find most useful, and I avoided adding a lot of
" plugins to keep everything fast and preferred neovim plugins when available.
"
" This file configures the core vanilla neovim and loads the plugs.vim file
" with the plugins and their configuration.
"
" This project is released under the Apache 2 license.
"
" Find me at https://github.com/RenatoUtsch
" }

" dotnvim settings {
    if !exists('g:settings') || !exists('g:settings.version')
    echom 'The g:settings and g:settings.version variables must be defined. Please consult the README.md.'
        finish
    endif 
    if g:settings.version != 1
        echom 'The version number in your shim does not match the distribution version.  Please consult the README.md changelog section.'
        finish
    endif

    " Default Settings {
        let s:default_settings = {}
        let s:default_settings.default_indent = 4
        let s:default_settings.max_column = 80
        let s:default_settings.colorscheme = 'base16-default'
        let s:default_settings.airline_colorscheme = 'base16_default'
        let s:default_settings.cache_dir = '~/.config/nvim/.cache'
    " }

    " Override defaults with the ones specified in g:settings
    for key in keys(s:default_settings)
        if !has_key(g:settings, key)
            let g:settings[key] = s:default_settings[key]
        endif
    endfor
" }

" Functions {
    function! s:get_cache_dir(suffix)
        return resolve(expand(g:settings.cache_dir . '/' . a:suffix))
    endfunction

    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction

    function! EnsureExists(path)
        if !isdirectory(expand(a:path))
            call mkdir(expand(a:path))
        endif
    endfunction
" }

" General {
    set background=dark         " Assume dark background
    filetype plugin indent on   " Automatically detect file types.

    " Clipboard {
        if has('clipboard')
            if has('unnamedplus')  " When possible use the + register
                set clipboard=unnamed,unnamedplus
            else         " On mac and Windows, use the * register
                set clipboard=unnamed
            endif
        endif
    " }

    " Automatically switch to the current file directory when a new buffer is
    " opened.
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Directory configuration {
        " Backups
        set backup
        let &backupdir = s:get_cache_dir('backup')

        " Persistent undo
        if has('persistent_undo')
            set undofile
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
            let &undodir = s:get_cache_dir('undo')
        endif

        " Swap files
        let &directory = s:get_cache_dir('swap')

        call EnsureExists(g:settings.cache_dir)
        call EnsureExists(&undodir)
        call EnsureExists(&backupdir)
        call EnsureExists(&directory)
    " }
" }

" nvim UI {
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    " Whitespace
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

    " Formatting
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    let &shiftwidth=g:settings.default_indent   " Number of spaces when indenting
    let &tabstop=g:settings.default_indent      " Number of spaces per tab for display
    let &softtabstop=g:settings.default_indent  " Number of spaces per tab in insert mode
    set expandtab                   " Tabs are spaces, not tabs
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
" }

" Key (re)mappings {
    " Set leader to ','
    let mapleader = ','

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " For changing between splits
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Toggle search highlight with /
    nmap <silent> <leader>/ :set invhlsearch<CR>

    " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip
" }

" Plugs {
    call plug#begin('~/.vim/plugged')

    source ~/.config/nvim/dotnvim/plugs.vim

    " Add plugins to &runtimepath
    call plug#end()
" }

" Finishing touches {
    " Don't change the colorscheme until the plugins are installed to avoid
    " error messages.
    if isdirectory(expand("~/.vim/plugged"))
        exec 'colorscheme '.g:settings.colorscheme
    endif

" }
