" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" Copyright 2017 Renato Utsch 
"
" This project is released under the Apache 2 license.
" Licensed under the Apache License, Version 2.0 (the "License"); 
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
" }

" vim-neovim {
    Plug 'noahfrederick/vim-neovim-defaults'
" }

" General {
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-surround'
    Plug 'rhysd/conflict-marker.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'benjifisher/matchit.zip' " {
        let b:match_ignorecase = 1
    " }
    Plug 'vim-airline/vim-airline' " {
        let g:airline_powerline_fonts = 1
    " }
    Plug 'powerline/fonts', { 'do': './install.sh' }
    Plug 'vim-airline/vim-airline-themes' " {
        let g:airline_theme = g:settings.airline_colorscheme
    " }
    Plug 'bling/vim-bufferline'
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
    if executable('ag') " {
        Plug 'rking/ag.vim'
    endif
" }

" Programming {
    Plug 'tpope/vim-commentary'
    Plug 'godlygeek/tabular'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'cespare/vim-toml'
    Plug 'dcharbon/vim-flatbuffers'
" }
