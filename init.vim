" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" This is the personal vim/neovim configuration file of Renato Utsch.
" It is largely based on Steve Francia's spf13 vim distribution and bling's
" dotvim distribution.
"
" The objective with this dotnvim is to make a light but useful distribution
" for both vim and neovim. I always used to install loads of plugins and use
" none of them, so now I'm keeping just the plugins I'm actually using and
" expanding slowly. 
"
" The defaults are all defining in the beginning of the file and can be
" overriden by you. The defaults were based after the Google style guides.
"
" This dotnvim was implemented to work seamlessly with both vim and neovim 
" on Windows, Linux and MacOS, without the need to change anything between
" them and being able to be shared between both. It was also implemented 
" with the intention to work well with closed source plugins from inside
" your company. You just include these plugins before or after this file 
" executes.
"
" This project is released under the Apache 2 license.
" }

" nocompatible {
    set nocompatible
    set termguicolors
" }

" Custom user code {
    " TODO(renatoutsch): Unfortunately, no way to use s:relative_path here.
    if filereadable(expand("~/.config/dotnvim/init.before.vim"))
        source ~/.config/dotnvim/init.before.vim
    endif
" }

" dotnvim settings {
    " Default Settings {
        let s:default_settings = {}
        let s:default_settings.default_indent = 2
        let s:default_settings.max_column = 80
        let s:default_settings.colorscheme = 'gruvbox'
        let s:default_settings.airline_colorscheme = 'gruvbox'
        let s:default_settings.gvim_font = 'Hack:h10'
        let s:default_settings.cache_dir = 'cache'
        let s:default_settings.config_dir = "~/.config/dotnvim"
        let s:default_settings.google_java_executable = "google-java-format"
    " }

    if !exists('g:settings')
       let g:settings = {} 
    endif

    " Override defaults with the ones specified in g:settings
    for key in keys(s:default_settings)
        if !has_key(g:settings, key)
            let g:settings[key] = s:default_settings[key]
        endif
    endfor
" }

" Windows portability {
    if has("win32") || has("win64")
        source $VIMRUNTIME/mswin.vim
        behave mswin

        " set Vim-specific sequences for RGB colors
        set term=xterm
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        inoremap <Char-0x07F> <BS>
        nnoremap <Char-0x07F> <BS>
    endif
" }

" GVim settings {
    if has("gui_running")
        set guioptions-=m
        set guioptions-=T
        set guioptions-=r
        set guioptions-=L
        let &guifont = g:settings.gvim_font
    endif
" }

" Functions {
    function! s:relative_path(dir)
        return resolve(expand(g:settings.config_dir . "/" . a:dir))
    endfunction

    function! s:get_cache_dir(suffix)
        return s:relative_path(g:settings.cache_dir . "/" . a:suffix)
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

" Plugs {
    call plug#begin(s:relative_path('plugged'))

    if filereadable(s:relative_path("plugs.before.vim"))
        execute 'source ' . s:relative_path('plugs.before.vim')
    endif

    execute 'source ' . s:relative_path('plugs.vim')

    if filereadable(s:relative_path("plugs.after.vim"))
        execute 'source ' . s:relative_path('plugs.after.vim')
    endif

    call plug#end()

    if filereadable(s:relative_path("plugs.config.before.vim"))
        execute 'source ' . s:relative_path('plugs.config.before.vim')
    endif

    execute 'source ' . s:relative_path('plugs.config.vim')

    if filereadable(s:relative_path("plugs.config.after.vim"))
        execute 'source ' . s:relative_path('plugs.config.after.vim')
    endif
" }

" General {
    set background=dark         " Assume dark background

    if has("unnamedplus") " Use + register when possible for copy-paste.
        set clipboard=unnamed,unnamedplus
    else " On Windows, use * for copy-paste.
        set clipboard=unnamed
    endif

    " Automatically switch to the current file directory when a new buffer is
    " opened.
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
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

        call EnsureExists(s:get_cache_dir(''))
        call EnsureExists(&undodir)
        call EnsureExists(&backupdir)
        call EnsureExists(&directory)
    " }
" }

" vim UI {
    " Don't change the colorscheme until the plugins are installed to avoid
    " error messages.
    if isdirectory(s:relative_path('plugged'))
         exec 'colorscheme ' . g:settings.colorscheme
    endif

    set showmode                            " Display the current mode
    set cursorline                          " Highlight current line
    let &colorcolumn=g:settings.max_column  " Highlight max_column

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    " Whitespace
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list

    " Formatting
    set nowrap                      " Do not wrap long lines
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
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    if has('nvim')
        tnoremap <Esc> <C-\><C-n>
        tnoremap <C-h> <C-\><C-n><C-w>h
        tnoremap <C-j> <C-\><C-n><C-w>j
        tnoremap <C-k> <C-\><C-n><C-w>k
        tnoremap <C-l> <C-\><C-n><C-w>l
    endif

    " Toggle search highlight with /
    nmap <silent> <leader>/ :set invhlsearch<CR>
" }

" Custom user code {
    if filereadable(s:relative_path("init.after.vim"))
        execute 'source ' . s:relative_path('init.after.vim')
    endif
" }
