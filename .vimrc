" set shellcmdflag=-ic

call pathogen#infect()

filetype plugin indent on
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4

set guifont=Monaco:h12
colorscheme desert
set guioptions-=T " remove toolbar
set guioptions-=m " remove menu bar
syntax on
set bs=2
set wildmenu
set number

set ignorecase
filetype on

set statusline=%<%F%h%m%r%h%w%y\ [%l,%v]\ %P\ %{SyntasticStatuslineFlag()}
set laststatus=2

set viminfo='1000,f1,<500,@100,:100,/100,%100 

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-k> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-j> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" open file in clipboard
map <silent><F4> :e <C-R>*<CR>

" ctrl+space insert mode
nnoremap <C-space> i
imap <C-space> <Esc>

map <F3> :BufExplorer<CR>
nnoremap <C-s> :w<CR>

noremap <F6> :set hlsearch! hlsearch?<CR>

map ,# :call CommentLineToEnd('#')<CR>+
map ,* :call CommentLinePincer('/* ', ' */')<CR>+
noremap <silent> ,/ :call CommentLineToEnd('// ')<CR>+
noremap <silent> ,< :call CommentLinePincer('<!-- ', ' -->')<CR>+

map <F2> :cd %:p:h<CR>
map <F7> :let @*=expand("%")<CR>

" sticky shifts
vnoremap < <gv
vnoremap > >gv

" notes
" cd %:h cwd to dir of open file
"

map <C-]> g]

let g:CommandTMaxFiles=100000
let g:CommandTMaxCachedDirectories=5

set wildignore=*.o,*.d,docs/**,tags,**/buildtmp-*/**,*.pyc,*.so,*.pot,**/js.min/**

nnoremap <Leader>e :Errors<CR>
let g:syntastic_cpp_compiler_options = '-DXPLAN_STD_HEADER=\<XPLAN_CXX_SERVER_STD.h\> -DCORBA_INCLUDE=\<omniORB4\/CORBA.h\> -std=gnu++0x'
let g:syntastic_cpp_include_dirs = [ '/Users/jsalter/xplan/trunk/include', '/usr/local/include/xercesc', '/usr/local/include', '/usr/local/Cellar/gettext/0.18.1.1/include' ]
let g:syntastic_mode_map = { 'mode': 'passive',
                               \ 'active_filetypes': ['python'],
                               \ 'passive_filetypes': ['c++'] }

let g:syntastic_cpp_compiler = 'clang++'
nnoremap <Leader>s :SyntasticCheck<CR>

au BufRead,BufNewFile *.ejs		set filetype=ejs
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType ejs setlocal shiftwidth=2 tabstop=2

au BufNewFile,BufRead *.ejs set filetype=html
