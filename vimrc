call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'milkypostman/vim-togglelist'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/vcscommand.vim'
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-surround', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
call plug#end()

set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim

nnoremap <Space> <nop>
let mapleader = " "
let maplocalleader = ","

filetype plugin indent on

" Set up color scheme
syntax on
set t_Co=256
set background=dark
colorscheme solarized

" Always show statusline
set laststatus=2
     
set hidden
set confirm
set number
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set foldmethod=syntax

" Adjust behavior based on filetype
autocmd BufNewFile,BufRead *.clj,*.cljc,*.cljx set filetype=clojure
autocmd FileType clojure,html set ts=2 sw=2 et

" Align NERDCommenter delimiters flush left
let g:NERDDefaultAlign = 'left'

" Key mappings
nmap n nzz
nmap p pzz
nmap N Nzz
nmap P Pzz
nmap <Leader>h :noh<cr>
nmap <Leader>p :set paste<cr>
nmap <Leader>P :set nopaste<cr>
nmap <Leader>* :Eval (clojure.repl/pst)<cr>
" Copy mode: opens a copy of the buffer in the current window in a new tab and disables line numbers
nmap <Leader>C :split<cr><C-W>T:se nonu<cr>
" Go to tab by number
nmap <Leader>1 1gt
nmap <Leader>2 2gt
nmap <Leader>3 3gt
nmap <Leader>4 4gt
nmap <Leader>5 5gt
nmap <Leader>6 6gt
nmap <Leader>7 7gt
nmap <Leader>8 8gt
nmap <Leader>9 9gt
nmap <Leader>0 :tablast<cr> 

nmap <c-n> :NERDTreeToggle<cr>

" Fireplace mappings
nmap <Leader>r :Require<cr>
nmap <Leader>R :Require!<cr>
nmap <Leader>E :%Eval<cr>
nmap <Leader>e :Eval<cr>
nmap <Leader>t :.RunTests<cr>
nmap <Leader>T :RunTests<cr>

" VCSCommand mappings
nmap <Leader>sa :VCSAdd<cr>
nmap <Leader>sb :VCSBlame<cr>
nmap <Leader>sc :VCSCommit<cr>
nmap <Leader>sD :VCSDelete<cr>
nmap <Leader>sd :VCSDiff<cr>
nmap <Leader>sv :VCSVimDiff<cr>
nmap <Leader>si :VCSInfo<cr>
nmap <Leader>sl :VCSLog<cr>
nmap <Leader>ss :VCSStatus<cr>
nmap <Leader>su :VCSUpdate<cr>
nmap <Leader>sRR :VCSRevert<cr>

" fzf mappings
command! -nargs=* AgClj call fzf#vim#ag(<q-args>, '-G "\.clj[cs]?$"', {})
nmap <Leader>ff :Files $HOME<cr>
nmap <Leader>fb :Buffers<cr>
nmap <Leader>fg :AgClj<cr>
