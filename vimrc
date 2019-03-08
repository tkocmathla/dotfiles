call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'jnurmine/Zenburn'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-obsession'
Plug 'milkypostman/vim-togglelist'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'jgdavey/tslime.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
Plug 'tpope/vim-db'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_solarized_bg = 'dark'

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

set noshowmode
set hidden
set confirm
set number
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set foldmethod=syntax
set cursorline
set listchars=tab:»\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list
set mouse=a

" Adjust behavior based on filetype
autocmd BufNewFile,BufRead *.edn,*.clj,*.cljc,*.cljx set filetype=clojure
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
" Kill buffer
nmap <Leader>K :bd<cr>
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

" Navigate windows directly
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Copy and paste using system clipboard
nmap <Leader>y "+y
vmap <Leader>y "+y

nmap <c-n> :NERDTreeToggle<cr>
nmap <F4> :UndotreeToggle<cr>

" Fireplace mappings
nmap <Leader>r :Require<cr>
nmap <Leader>R :Require!<cr>
nmap <Leader>E :%Eval<cr>
nmap <Leader>e :Eval<cr>
nmap <Leader>t :.RunTests<cr>
nmap <Leader>T :RunTests<cr>
nmap <Leader>b :Last<cr>

" Clojure stack trace
nmap <Leader>* :Eval (clojure.repl/pst *e 50)<cr>
" Clojure keyword to string
" wb   - move to beginning of word
" x    - delete colon
" ysw" - wrap word in double quotes
nmap <Leader>ks wbxysw"
" Clojure string to keyword
" ds" - delete surrounding double quotes
" wb  - move to beginning of word
" i:  - insert a colon
nmap <Leader>sk ds"wbi:<esc>

" fugitive mappings
nmap <Leader>gd :Gdiff<cr>
nmap <Leader>gb :Gblame<cr>
nmap <Leader>gl :Glog<cr>
nmap <Leader>gs :Gstatus<cr>
nmap <Leader>gc :Gcommit<cr>

" fzf mappings
command! -nargs=* Ag call fzf#vim#ag(<q-args>, '-G "((\.clj[cs]?)|\.py|\.edn)$"', {})
nmap <Leader>ff :Files<cr>
nmap <Leader>fh :Files $HOME<cr>
nmap <Leader>fb :Buffers<cr>
nmap <Leader>fg :Ag<cr>
