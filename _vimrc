set shell=C:\\cygwin\bin\zsh.exe
" set shellcmdflag=-ic
filetype plugin indent on
set columns=85

colorscheme desert
:set guifont=Consolas:h10:cANSI
:set guioptions-=T " remove toolbar
:set guioptions-=m " remove menu bar
syntax on
set bs=2
set wildmenu
set number

set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set textwidth=79
set ignorecase
filetype on

set cdpath=,c:\xplanbase\version\1.35.999\data\wwwroot

set tags=c:\xplanbase\version\1.35.999\src\py\tags,c:\xplanbase\version\1.35.999\src\cxx\tags,c:\xplanbase\build\vc90\omniORB-4.1.4\tags,c:\xplanbase\version\1.35.999\test\py\tags,c:\xplanbase\version\1.35.999\include\tags,c:\xplanbase\version\1.35.999\data\wwwroot\js\tags
set statusline=%<%F%h%m%r%h%w%y\ [%l,%v]\ %P
set laststatus=2

set viminfo='1000,f1,<500,@100,:100,/100,%100 
let @d='iimport rpdb2; rpdb2.start_embedded_debugger("rdb")'

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-k> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-j> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" ctrl+space insert mode
nnoremap <C-space> i
imap <C-space> <Esc>

" f4 switch to header
map <F4> :e %:p:s,.h$,.X123X,:s,.cxx$,.h,:s,.X123X$,.cxx,<CR>
nnoremap <Home> ^

map <F3> :BufExplorer<CR>
nnoremap <C-s> :w<CR>

map <F5> :!zsh -ic rtr<CR>
noremap <F6> :set hlsearch! hlsearch?<CR>

" tort log
map <F10> :!ts log '%:p'<CR>

map ,# :call CommentLineToEnd('#')<CR>+
map ,* :call CommentLinePincer('/* ', ' */')<CR>+
noremap <silent> ,/ :call CommentLineToEnd('// ')<CR>+
noremap <silent> ,< :call CommentLinePincer('<!-- ', ' -->')<CR>+

map <F2> :cd %:p:h<CR>

" sticky shifts
vnoremap < <gv
vnoremap > >gv

map <F2> :NERDTreeToggle<CR>

" notes
" cd %:h cwd to dir of open file
