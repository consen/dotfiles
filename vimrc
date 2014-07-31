"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Consen
" Version: 0.9
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings(much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Setting working dirctory to user's home
"cd ~

" Set how many lines of history VIM has to remember.
set history=2048

" Enable filetype plugins. 
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside.
set autoread

" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

" Enable syntax highlighting.
syntax on

" Show line numbers.
set number
set numberwidth=6

" Automatically wrap left and right.
set whichwrap+=<,>,h,l,[,]

" Make backspace wrok like most other apps.
set backspace=2
" same as:
"set backspace=indent, eol, start

" Enable mouse in all modes
set mouse=a

" Automatically indent when add a curly bracket, etc.
set smartindent
" Disable automatic comment insertion.
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Tabs should be converted to a group of 4 spaces.
set shiftwidth=4    " numbers of spaces of tab (auto)indent.
set tabstop=4       " numbers of spaces of tab character.
set expandtab       " tabs are converted to spaces, use only when required.
set smarttab

" Highlight searches.
set hlsearch
" Do incremental searching, search as you type.
set incsearch
" Ignore case when searching.
set ignorecase
set smartcase
" Press Esc to clear search highlighting and any message already displayed.
"nnoremap <silent> <Esc> :silent nohlsearch<Bar>:echo<CR>

" GUI Settings
if has("gui_running")
	set guioptions-=T			" No Toolbar
	set guioptions-=e			" use non-GUI tab pages line
	set guioptions+=c			" Use console dialogs instead of popup dialogs
	set guioptions-=rL			" no left-hand and right-hand scrollbar
	set guifont=Consolas:h11	" Fontface and fontsize
endif

" Hightlight current line and column.
set cursorline
"set cursorcolumn

" Initial window size
"set lines=34 columns=124

" Use UTF-8
set encoding=utf-8

" Error bells are displayed visually.
"set visualbell

" Show editing mode.
set showmode

" Show line number, cursor position.
set ruler

" Display incomplete commands in the last line of the screen.
set showcmd

" Show autocomplete menus in the status line.
" Use tab completion to scroll through commands that start with what you typed.
set wildmenu
" Ignore compiled files.
set wildignore=*.o,*.obj,*.dll,*.exe,*~,*.pyc

" Show matching brackets when text indicator is over them.
"set showmatch
" ... but 1 tenths of a second to blink when matching brackets.
"set matchtime=1
" Set pairs including '<' and '>'. 
set matchpairs+=<:>

" Lines longer than the width of the window will wrap.
set wrap
" Automatically break a line before it gets too long.
"set textwidth=82

" Keep 10 lines (top/bottom) for scope.
set scrolloff=10

" Splitting a window will put the new window below the current one.
set splitbelow

" Maximum number of items to show in the popup menu for Insert mode completion.
set pumheight=15

" Always show the status line.
set laststatus=2
" Format the status line.
set statusline=
set statusline+=[CWD:\ %{getcwd()}]				" current working directory
set statusline+=\ \ \ \ [%n/%{bufnr('$')}]		" buffer number / buffer count
set statusline+=%r								" read only flag
set statusline+=[%F]							" full path
set statusline+=\ [%{strlen(&ft)?&ft:'none'}]	" filetype
set statusline+=\ \ %m							" modified flag
set statusline+=%{(&key==\"\"?\"\":'[encr]')}	" encrypted ?
set statusline+=\ \ %w							" preview window flag
set statusline+=%=								" right align remainder
set statusline+=[%l/%L,%c]						" line number/lines, column number
set statusline+=[0x%02B]						" character value under the cursor
set statusline+=\ \ [%{&fileformat}]			" file format
set statusline+=\ [%{&fenc==\"\"?&enc:&fenc}]	" encoding

" Turn backup off, since most stuff is in SVN,GIT,etc.anyway...
set nobackup
set nowritebackup
set noswapfile

" To insert timestamp, press F3.
" %w is replaced by the weekday as a decimal number [0, 6],
" with 0 representing Sunday.
"nmap <F3> a<C-R>=strftime("%Y-%m-%d %H:%M:%S [%w]")<CR><Esc>
"imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M:%S [%w]")<CR>

" To save, press ctrl-s.
"nmap <c-s> :w<CR>
"imap <c-s> <Esc>:w<CR>a

" Toggle auto-indenting for code paste.
"set pastetoggle=<F2>

" space / shift-space scroll in normal mode.
"noremap <S-space> <C-b>
"noremap <space> <C-f>

" In normal mode, press Enter to toggle the current fold open/closed. However,
" if the cursor is not in a fold, move to next line(the default behavior).
" CTRL-M is equivalent to Enter, this is because carriage return is ASCII
" character no.13 and M is the 14th letter of the alphabet. see :h key-notation
"nnoremap <silent> <CR> @=(foldlevel('.')?'za':'ctrl-m')<CR>


" Save session whenever vim closes.
"autocmd VimLeave * call SaveSession()
" Load session when vim is opened.
" If you omit 'options' from 'sessionoptions', you might want to use nested flag
" from VimEnter autocmd, Syntax highlighting and mappings might not be restored
" otherwise.
"autocmd VimEnter * nested call OpenSession()

"let g:session_file = $HOME."/.session.vim"

"function! SaveSession()
"	execute "mksession! ".g:session_file
"endfunction

" Open a saved session if there were no file-names passed as arguments.
"function! OpenSession()
"	if argc() == 0
"		" if session file exists, ask user if he wants to load it
"		if filereadable(g:session_file)
"			"if(confirm("Load last session?\n\n".g:session_file, "&Yes\n&No", 1) == 1)
"				execute "source ".g:session_file
"			"endif
"		endif
"	endif
"endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
Plugin 'terryma/vim-multiple-cursors'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'sickill/vim-monokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'junegunn/goyo.vim'
Plugin 'yonchu/accelerated-smooth-scroll'
"Plugin 'tpope/vim-fugitive'
"Bundle 'scrooloose/nerdtree'
"Bundle 'msanders/snipmate.vim'
"Bundle 'uguu-org/vim-matrix-screensaver'
"Bundle 'bling/vim-airline'

" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9"
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""
" Goyo
"""""""""""""""""""""""""""""
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2 

"""""""""""""""""""""""""""""
" CtrlP
"""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_root_markers = ['SConstruct']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"""""""""""""""""""""""""""""
" Solarized
"""""""""""""""""""""""""""""
"set background=dark
"colorscheme solarized
"let g:solarized_menu=1		" menu 'Solarized'
"call togglebg#map("<F5>")	" press F5 to Toggle Background

"""""""""""""""""""""""""""""
" Molokai
"""""""""""""""""""""""""""""
set t_Co=256
let g:molokai_original = 1
"let g:rehash256 = 1
colorscheme molokai
" In molokai.vim reset values:
" 150 hi String ctermfg=186
" 139 hi Normal ctermfg=253     ctermbg=235
" 215 hi Todo   ctermfg=231     ctermbg=NONE    cterm=inverse,bold
" 223 hi Visual                 ctermbg=237

"""""""""""""""""""""""""""""
" Monokai
"""""""""""""""""""""""""""""
"colorscheme monokai

"""""""""""""""""""""""""""""
" SnipMate
"""""""""""""""""""""""""""""
"let g:snips_author = 'Consen'

"""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""
"let NERDTreeIgnore=['\~$[[file]]', '\.o$[[filie]]', '\.exe$[[file]]', '\.pyc$[[file]]',
"			\		'\.obj$[[file]]', '\.dll$[[file]]', '\.lib$[[file]]', '\.a$[[file]]']
