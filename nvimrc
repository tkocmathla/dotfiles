call plug#begin('~/.vim/plugged')

Plug 'puremourning/vimspector'
Plug 'chriskempson/base16-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'google/vim-jsonnet'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

Plug 'tpope/vim-obsession'
Plug 'skywind3000/asyncrun.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'smoka7/hop.nvim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
call plug#end()

"-----------------------------------
" basic configuration and mappings
"-----------------------------------

nnoremap <Space> <nop>
let mapleader = " "
let maplocalleader = ","

filetype plugin indent on

" set up color scheme
syntax on
set t_Co=256
colorscheme base16-gruvbox-dark-medium

augroup c
    autocmd FileType c set colorcolumn=80
augroup END
augroup cpp,python
    autocmd FileType cpp,python set colorcolumn=120
augroup END
augroup json
    autocmd BufNewFile,BufRead *.list set syntax=json
augroup END
augroup jsonnet
    autocmd FileType jsonnet set foldmethod=manual
augroup END
augroup mlir
    autocmd FileType mlir set syntax=mlir
augroup END

autocmd BufNewFile,BufRead *.edn,*.clj,*.cljc,*.cljx set filetype=clojure
autocmd FileType clojure,html,yaml set ts=2 sw=2 et
autocmd BufNewFile,BufRead Pipfile set syntax=dosini

" hybrid absolute + relative line numbering
" https://jeffkreeftmeijer.com/vim-number
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" only show tabline if > 1 tab open
set showtabline=1
" always show statusline
set laststatus=2
set mouse=
set updatetime=300
set signcolumn=yes
set noshowmode
set hidden
set confirm
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set foldmethod=indent
set foldlevelstart=10
set cursorline
set listchars=tab:»\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list
set showcmd
set splitright
set splitbelow

" toggle quickfix and location lists
nnoremap <expr> <Leader>q empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'
nnoremap <expr> <Leader>l empty(filter(getwininfo(), 'v:val.loclist')) ? ':lopen<CR>' : ':lclose<CR>'

" quickfix and loclist position and height
autocmd FileType qf call AdjustWindowHeight(1, 10)
function! AdjustWindowHeight(minheight, maxheight)
  " auto adjust to line height
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
  " open full-width at the bottom
  wincmd J
endfunction

" force saving files that require root permission
cnoremap w!! w !sudo tee > /dev/null %

" performance tweaks for syntax highlighting
let c_no_curly_error=1

" remap * to search and highlight but not jump (https://stackoverflow.com/a/4257175)
nnoremap * :keepjumps normal! mi*`i<CR>

" center cursor on next search result
nmap n nzz
nmap N Nzz

" format pasted text automatically
:nnoremap p ]p

" paste without automatic formatting
:nnoremap <c-p> p

" clear highlights
nmap <Leader>H :noh<cr>

" toggle 'paste' mode
nmap <Leader>p :set paste<cr>
nmap <Leader>P :set nopaste<cr>

" jump to last buffer (like ctrl-6)
nmap <Leader>j :b#<cr>

" kill buffer
nmap <Leader>K :bd<cr>

" close window left, down, up, or right (doesn't work with terminals)
nmap <Leader>Ch <C-w>h <C-w>c
nmap <Leader>Cj <C-w>j <C-w>c
nmap <Leader>Ck <C-w>k <C-w>c
nmap <Leader>Cl <C-w>l <C-w>c

" go to tab by number
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

" navigate windows directly
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" FIXME fully expand window horizontally and vertically
"nmap <C-w>* <C-w><C-|><C-w><C-_>

" open a vertical bash terminal
nmap <Leader>t :vsplit <bar> vert term bash<cr>
" map <Esc> to exit terminal-mode
tnoremap <Esc> <C-\><C-n>
" disable normal C-x behavior
nnoremap <C-x> <nop>

" large file handling (> 100M)
" from: https://vim.fandom.com/wiki/Faster_loading_of_large_files
let g:LargeFile = 1024 * 1024 * 100
augroup LargeFile
  au!
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
  " no syntax highlighting
  setlocal eventignore+=FileType
  " save memory when other file is viewed
  setlocal bufhidden=unload
  " is read-only (write with :w new_filename)
  setlocal buftype=nowrite
  " no undo possible
  setlocal undolevels=-1
  " display message
  autocmd VimEnter * echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

"-----------------------------------
" Airline
"-----------------------------------

let g:airline_highlighting_cache = 1
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

" don't display character encoding
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'

let g:airline_section_z = "%#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__#:%v"

" abbreviate display of current vim mode to a single capital letter
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'c'  : 'COM',
    \ 'i'  : 'INS',
    \ 'ic' : 'INS',
    \ 'ix' : 'INS',
    \ 'n'  : 'NOR',
    \ 'ni' : 'NOR',
    \ 'no' : 'NOR',
    \ 'R'  : 'REP',
    \ 'Rv' : 'REP',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ 't'  : 'T',
    \ 'v'  : 'VIS',
    \ 'V'  : 'VIS',
    \ '' : 'VIS',
    \ }

"-----------------------------------
" AsyncRun
"-----------------------------------

let g:asyncrun_open = 5
let g:asyncrun_status = ''

"-----------------------------------
" Coc
"-----------------------------------

" use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<cr>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

"-----------------------------------
" NERDCommenter
"-----------------------------------

" align delimiters flush left
let g:NERDDefaultAlign = 'left'

"-----------------------------------
" NERDTree
"-----------------------------------

nmap <c-n> :NERDTreeToggleVCS<cr>
nmap <Leader>fd :NERDTreeFind<cr>

"-----------------------------------
" Undotree
"-----------------------------------

nmap <F4> :UndotreeToggle<cr>

"-----------------------------------
" Fireplace
"-----------------------------------

nmap <LocalLeader>r :Require<cr>
nmap <LocalLeader>R :Require!<cr>
nmap <LocalLeader>E :%Eval<cr>
nmap <LocalLeader>e :Eval<cr>
nmap <LocalLeader>T :RunTests<cr>
nmap <LocalLeader>b :Last<cr>

" clojure stack trace
nmap <Leader>* :Eval (clojure.repl/pst *e 50)<cr>

" clojure keyword to string
" wb   - move to beginning of word
" x    - delete colon
" ysw" - wrap word in double quotes
nmap <LocalLeader>ks wbxysw"

" clojure string to keyword
" ds" - delete surrounding double quotes
" wb  - move to beginning of word
" i:  - insert a colon
nmap <LocalLeader>sk ds"wbi:<esc>

"-----------------------------------
" Fugitive
"-----------------------------------

function! s:open_branch_or_tag_fzf(line)
  let l:parser = split(a:line)
  let l:branch = l:parser[0]
  if l:branch ==? '*'
    let l:branch = l:parser[1]
  endif
  execute '!git checkout ' . l:branch
endfunction

command! -bang -nargs=0 GCheckoutBranch
  \ call fzf#vim#grep(
  \   'git branch --sort=-creatordate', 0,
  \   {
  \     'sink': function('s:open_branch_or_tag_fzf')
  \   },
  \   <bang>0
  \ )

command! -bang -nargs=0 GCheckoutTag
  \ call fzf#vim#grep(
  \   'git tag --list --sort=-creatordate', 0,
  \   {
  \     'sink': function('s:open_branch_or_tag_fzf')
  \   },
  \   <bang>0
  \ )

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
nmap <Leader>gs :G<cr>
nmap <Leader>gw :Gwrite<cr>
nmap <Leader>gr :Gread<cr>
nmap <Leader>gb :GCheckoutBranch<cr>
nmap <Leader>gt :GCheckoutTag<cr>
nmap <Leader>gd :Gdiff<cr>
nmap <Leader>gm :Gvdiffsplit!<cr>
nmap <Leader>gM :G mergetool<cr>
nmap <Leader>ga :G blame<cr>

" fetch current branch from origin
nmap <Leader>gf :execute 'G! fetch origin ' . FugitiveHead()<cr>

" fetch everything from origin
nmap <Leader>gF :G! fetch<cr>

" pull current branch from originn
nmap <Leader>gl :execute 'G! pull origin ' . FugitiveHead()<cr>

" pull everything from origin
nmap <Leader>gL :G! pull<cr>

nmap <Leader>gp :G! push -u origin HEAD<cr>
nmap <Leader>gc :G commit<cr>

" commit without running hooks
nmap <Leader>gC :G commit --no-verify<cr>

" fetch and merge main
nmap <Leader>gZ :G fetch origin main <bar> :G merge origin/main<cr>

nmap <Leader>gg :BCommits<cr>

" git-grep for word under cursor
"   - ! means do not automatically jump to the first result
"   - --quiet means open results directly in quickfix list
nmap <Leader>gG :Ggrep! --quiet --word-regexp <c-r>=expand("<cword>")<cr><cr>

" git-grep for visual selection
"   - uses g register (qgq clears it first)
"   - getreg(...)[0] means use only first line of visual selection (as a safeguard)
"   - ! means do not automatically jump to the first result
"   - --quiet means open results directly in quickfix list
"   - highlights pattern in results
vmap <Leader>gG qgq
           \ "gy <bar>
           \ :execute ':Ggrep! --quiet ' . escape(getreg('g', 1, 1)[0], ' "')<cr>
           \ /<c-r>=getreg('g', 1, 1)[0]<cr><cr>
           \ ^

" show stash log
nmap <Leader>gSl :Gclog -g stash<cr>

" push to stash
nmap <Leader>gS- :G! stash<cr>:e<cr>

" pop from stash
nmap <Leader>gS+ :G! stash pop<cr>:e<cr>

"-----------------------------------
" FZF
"-----------------------------------

" search for files by name
nmap <Leader>ff :GitFiles<cr>
nmap <Leader>fh :Files $HOME<cr>

" search buffers by file name
nmap <Leader>fb :Buffers<cr>

" search for files by content (ripgrep)
nmap <Leader>fg :Rg<cr>

" find in file
nmap <leader>fl :BLines<cr>

"-----------------------------------
" Hop
"-----------------------------------

nmap <Leader>h :HopWord<cr>
lua << EOF
    require('hop').setup()
EOF

"-----------------------------------
" $WORK-specifics
"-----------------------------------

if filereadable(expand("~/.vimrc-work"))
    source ~/.vimrc-work
endif

"-----------------------------------
" NOTE: this must be last
"-----------------------------------

if filereadable(expand("~/.nvimrc"))
    source ~/.nvimrc
endif
