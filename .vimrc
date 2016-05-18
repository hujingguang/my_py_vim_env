set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Bundle 'gmarik/vundle'
Bundle 'SuperTab'
Bundle 'bash-support.vim'
Bundle 'Vim-airline'
Bundle 'Molokai'
Bundle 'ctrlp.vim'
Plugin 'https://github.com/thinca/vim-quickrun.git'
"Plugin 'https://github.com/Shougo/neocomplete.vim.git'
Plugin 'https://github.com/scrooloose/nerdcommenter.git'
Plugin 'https://github.com/vim-scripts/taglist.vim.git'
Plugin 'https://github.com/klen/python-mode.git'
Bundle 'WinManager'
Plugin 'https://github.com/vim-scripts/Pydiction.git'
Plugin 'vim-airline/vim-airline-themes'
Bundle 'https://github.com/scrooloose/syntastic.git'
Bundle 'https://github.com/maksimr/vim-jsbeautify.git'

 let python_highlight_all = 1
call vundle#end()
filetype plugin indent on 
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set number
" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
let g:pydiction_location = '/root/.vim/bundle/Pydiction/complete-dict'
let g:pydiction_menu_height = 3 
set shiftwidth=4
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme="luna" 
let g:airline#extensions#tabline#buffer_nr_show = 1
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
let g:solarized_termcolors=16
set laststatus=2
let g:airline_detect_paste=1
let g:winManagerWindowLayout = "TagList|FileExplorer"
let g:winManagerWidth = 30
nmap <silent> <F1> :WMToggle<cr>
let g:AutoOpenWinManager = 1
syntax enable
syntax on
set t_Co=256
set background=dark
colorscheme molokai
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1 
 let Tlist_Exit_OnlyWindow = 1
  let Tlist_Use_Right_Window = 1
  set mouse=a 
  let Tlist_Use_SingleClick=1  

  syn keyword pythonBuiltin     reversed sorted sum self
  syn match pythonOper    "=/|+/|-/|*/|{/|}/|[/|]/|(/|)/|/./|,"

syn keyword pythonStatement False, None, True 
syn keyword pythonStatement as assert break continue del exec global 
syn keyword pythonStatement lambda nonlocal pass print return with yield 
syn keyword pythonStatement class def nextgroup=pythonFunction skipwhite 
syn keyword pythonConditional elif else if 
syn keyword pythonRepeat for while
syn keyword pythonOperator and in is not or
syn keyword pythonException except finally raise try 
syn keyword pythonInclude from import
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>
nnoremap <F4> :call g:Jsbeautify()<CR>  

filetype plugin indent on
syntax on
autocmd FileType python nnoremap <buffer> <F5> :w<CR>:!python % <CR>
