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

Plug 'noahfrederick/vim-neovim-defaults'
Plug 'morhetz/gruvbox'

Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'

Plug 'bling/vim-bufferline'
Plug 'powerline/fonts', { 'do': './install.sh' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

Plug 'google/vim-codefmt'
Plug 'mhinz/vim-signify'
Plug 'neomake/neomake' | Plug 'dojoteef/neomake-autolint'

Plug 'benjifisher/matchit.zip'
Plug 'gcmt/wildfire.vim'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'myusuf3/numbers.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/restore_view.vim'

Plug 'dcharbon/vim-flatbuffers'
Plug 'kbenzie/vim-spirv'
Plug 'sheerun/vim-polyglot'

if executable('ag')
    Plug 'rking/ag.vim'
endif
