scripte utf-8
" vim: set fenc=utf-8 tw=0:

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Revert all command settings before proceeding with other settings below
"set all&

" Work in Vim compatible not Vi compatible
set nocompatible

" Keep 50 commands and 50 search patterns in the history.
" 50 is undo limit.
set history=100

" No need to understand this. Leave this when using Vim.
set magic

" No swap file. It's messy.
set noswapfile

" Wait for a key code forever.
" Wait for a mapped key sequence to complete within ttimeoutlen.
set notimeout ttimeout

" In Milliseconds
set timeoutlen=3000 ttimeoutlen=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load plugins when starting up

set loadplugins
filetype off                  " required
call plug#begin()
	Plug 'itchyny/lightline.vim'
	Plug 'mgee/lightline-bufferline' " For tabs on top
	Plug 'tpope/vim-fugitive'
	Plug 'wolf-dog/lightline-nighted.vim'
	Plug 'ryanoasis/vim-devicons'
	Plug 'dikiaap/minimalist'
	Plug 'vim-syntastic/syntastic'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-unimpaired'
	Plug 'scrooloose/nerdtree'
	Plug 'majutsushi/tagbar'
	Plug 'altercation/vim-colors-solarized'
	"Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	Plug 'inkarkat/vim-ingo-library'
	Plug 'inkarkat/vim-mark'
	Plug 'ervandew/supertab'
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'guru245/gutentags_plus'
	Plug 'wakatime/vim-wakatime'
	Plug 'vim-scripts/gccsingle.vim'
call plug#end()

set visualbell
set number
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"

" Set tagbar
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_sort = 0
" Set NERDTree position
let g:NERDTreeWinPos='right'
" Set airline
"let g:airline_theme='dark'
"let g:airline_solarized_bg='dark'
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline#extensions#tagbar#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_symbols.branch = ''
"let g:airline_symbols.linenr = ''
"let g:airline_symbols.maxlinenr = ''
"let g:airline_section_error  = ''
"let g:airline_section_warning = ''
"let g:airline_symbols.notexists = ''
"autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()

" Set Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Set vim-gutentags and gutentags_plus
let g:gutentags_project_root = ['.root']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_modules = ['ctags', 'gtags_cscope']

let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline = { 'colorscheme': 'nighted' }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

syntax on
if (has("termguicolors"))
	set termguicolors
endif
colorscheme minimalist

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tell Vim to delete the white space at the start of the line, a line break
"  and the character before where Insert mode started.
set backspace=indent,eol,start

" Display the current cursor position in the lower right corner of the
" Vim window. But for now this is no londer used thanks to airline plugin.
"set ruler

" Display an incomplete vim command in the lower right corner of the Vim window
" This is no longer used thanks to AutoComplPop plugin
"set showcmd

" Display line numbers
set nu

" Set line number width
set numberwidth=5

" Do not wrap lines
set nowrap

" Move the cursor to the first non-blank of the line when Vim
" move commands are used.
set startofline

" Turn on syntax highlighting
syntax on

" Whatever floats in your boat
set background=dark
"set background=light

" Delete trailing spaces at eol when a file is saved.
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

" Locate the cursor in the last position when Vim is closed
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "norm g`\"" |
\ endif

" Set 100 column guideline
"set colorcolumn=100
highlight ColorColumn ctermbg=red


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab & Indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set tab size
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Use spaces instead of tabs
"set expandtab

" Work for C-like programs, but can also be used for other languages
set smartindent

" Copy indent from current line when starting a new line. This should be
" on when smartindent is used.
set autoindent

" Set indent for switch statement in C. Just my cup of tea.
set cinoptions=:0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding and Format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Determine the 'fileencoding' of a file being opened.
set fileencodings=utf-8,cp949,cp932,euc-kr,shift-jis,big5,ucs-2le,latin1

" Represent data in memory
set encoding=utf-8

" Use only unix fileformat. "dos" can be added like "unix, dos"
" if you are a coward.
set fileformats=unix


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight all matches
set hlsearch

" Not search wrap around the end of a file
set nowrapscan

" Ignore case in search patterns
set ignorecase

" Override ignorecase option if the search pattern contains an uppercase
" character.
set smartcase

" Show where the pattern matches as it was typed so far.
set incsearch

" Jump to one to the other using %. Various character can be added.
set matchpairs+=<:>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show the man page when you press F1
func! Man()
    let sm = expand("<cword>")
    exe "!man -S 2:3:4:5:6:7:8:9:tcl:n:1:p:o ".sm
endfunc
map <F1> :call Man()<cr><cr>

" Save
map <F2> :w!<cr>

" Show a sidebar listing defines, variables, and functions
map <F3> :TagbarToggle<cr>

" Show a sidebar listing file system in tree view
map <F4> :NERDTreeToggle<cr>

" Fold/unfold a function body from brace to brace.
map <F5> v]}zf
map <F6> zo

" Clear all markers
map <F8> :MarkClear<cr> :noh<cr>
"map <F8> [i
"Map <F9> gd

" Step into the function.
func! Tj()
    let st = expand("<cword>")
    exe "tj ".st
endfunc
map <F11> :call Tj()<cr>

" Step out of the function.
map <F12> <c-T>

" Move around buffers by pressing ctrl+h or ctrl+l
map <C-Left> :bprevious<cr>
map <C-Right> :bnext<cr>

" Move between split windows
map <S-h> :wincmd h<cr>
map <S-l> :wincmd l<cr>
map <S-k> :wincmd k<cr>
map <S-j> :wincmd j<cr>

" Save and close the buffer
map ,w :bp <BAR> bd #<CR>

" Format source codes by clang-format. To use this clang-format must be
" installed.

" Move source codes by tab size. Tab is right move and Shift+tab is left.
vmap <Tab> >gv
vmap <S-Tab> <gv

" Toggle line number display
fu! ToggleNu()
    let &nu = 1 - &nu
endf
map <leader>d :call ToggleNu()<CR>

" Toggle paste option. This is useful if you want to cut or copy some text
" from one window and paste it in Vim. Don't forget to toggle paste again once
" you're done with pasting.
fu! TogglePaste()
    let &paste = 1 - &paste
endf
map <leader>p :call TogglePaste()<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
