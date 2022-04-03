call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'skywind3000/asyncrun.vim'
Plug 'ycm-core/YouCompleteMe', {'branch':'legacy-vim'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-obsession'
Plug 'milkypostman/vim-togglelist'
" https://github.com/junegunn/fzf.vim/issues/1301
Plug 'junegunn/fzf', {'commit': '3f75a83', 'dir': '~/.fzf', 'do': { -> fzf#install() } }
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

" always show statusline
set laststatus=2
set updatetime=1000
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

" performance tweaks for syntax highlighting
let c_no_curly_error=1

" remap * to search and highlight but not jump (https://stackoverflow.com/a/4257175)
nnoremap * :keepjumps normal! mi*`i<CR>

" jump to last buffer (like ctrl-6)
nmap <Leader>j :b#<cr>

" center cursor on next search result
nmap n nzz
nmap N Nzz

" center cursor on paste result
nmap p pzz
nmap P Pzz

" format pasted text automatically
:nnoremap p ]p

" paste without automatic formatting
:nnoremap <c-p> p

" close all other windows except the current one
nmap <Leader>O :only<cr>

" clear highlights
nmap <Leader>h :noh<cr>

" toggle 'paste' mode
nmap <Leader>p :set paste<cr>
nmap <Leader>P :set nopaste<cr>

" kill buffer
nmap <Leader>K :bd<cr>

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

" map <Esc> to exit terminal-mode
tnoremap <Esc> <C-\><C-n>

"-----------------------------------
" Airline
"-----------------------------------

let g:airline_highlighting_cache = 1
let g:airline_powerline_fonts = 1
let g:airline_inactive_collapse = 1
let g:airline_skip_empty_sections = 1

" don't display character encoding
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" print a glyph in the lower-right gutter to indicate vim-obsession is on
let g:airline#extensions#obsession#indicator_text = '[$]'
let g:airline_section_z = "%{airline#util#wrap(airline#extensions#obsession#get_status(),0)}%#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__#:%v"

" abbreviate display of current vim mode to a single capital letter
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'c'  : 'C',
    \ 'i'  : 'I',
    \ 'ic' : 'I',
    \ 'ix' : 'I',
    \ 'n'  : 'N',
    \ 'ni' : 'N',
    \ 'no' : 'N',
    \ 'R'  : 'R',
    \ 'Rv' : 'R',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ 't'  : 'T',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ }

" add an airline section for AsyncRun status
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

"-----------------------------------
" AsyncRun
"-----------------------------------

let g:asyncrun_open = 5
let g:asyncrun_status = ''

"-----------------------------------
" YouCompleteMe
"-----------------------------------

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_max_num_candidates = 25

nmap <Leader>yRr :YcmCompleter RefactorRename
nmap <Leader>yRf :YcmCompleter FixIt<cr>
nmap <Leader>yr :YcmCompleter GoToReferences<cr>
nmap <Leader>yt :YcmCompleter GetType<cr>
nmap <Leader>yd :YcmCompleter <plug>(YCMHover)
nmap <Leader>yl :YcmCompleter GoToDeclaration<cr>
nmap <Leader>yf :YcmCompleter GoToDefinition<cr>
nmap <Leader>yF :YcmCompleter Format<cr>
nmap <Leader>yu :YcmRestartServer<cr>
nmap <Leader>yU :execute '!./cmake_setup.sh -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DGENERATE_SYMBOLS=ON' <bar> :YcmRestartServer<cr>

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

nmap <Leader>r :Require<cr>
nmap <Leader>R :Require!<cr>
nmap <Leader>E :%Eval<cr>
nmap <Leader>e :Eval<cr>
"nmap <Leader>t :.RunTests<cr>
nmap <Leader>T :RunTests<cr>
nmap <Leader>b :Last<cr>

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
nmap <Leader>gs :Git<cr>
nmap <Leader>gb :GCheckoutBranch<cr>
nmap <Leader>gt :GCheckoutTag<cr>
nmap <Leader>gd :Gdiff<cr>
nmap <Leader>gm :Gdiffsplit!<cr>
nmap <Leader>gM :Git mergetool<cr>
nmap <Leader>ga :Git blame<cr>

" fetch current branch from origin
nmap <Leader>gf :execute 'Git fetch origin ' . FugitiveHead()<cr>

" fetch everything from origin
nmap <Leader>gF :Git fetch<cr>

" pull current branch from originn
nmap <Leader>gl :execute 'Git pull origin ' . FugitiveHead()<cr>

" pull everything from origin
nmap <Leader>gL :Git pull<cr>

nmap <Leader>gp :Git push -u origin HEAD<cr>
nmap <Leader>gc :Git commit<cr>

" commit without running hooks
nmap <Leader>gC :Git commit --no-verify<cr>

nmap <Leader>gg :BCommits<cr>

" git-grep for word under cursor
nmap <leader>gG :Ggrep <c-r>=expand("<cword>")<cr><cr>

" show stash log
nmap <Leader>gSl :Gclog -g stash<cr>

" push to stash
nmap <Leader>gS- :Git stash<cr>:e<cr>

" pop from stash
nmap <Leader>gS+ :Git stash pop<cr>:e<cr>

"-----------------------------------
" FZF
"-----------------------------------

" search for files by name
command! -bang MyFiles call fzf#vim#files('/opt/software', <bang>0)
nmap <Leader>ff :MyFiles<cr>
nmap <Leader>fh :Files $HOME<cr>

" search buffers by file name
nmap <Leader>fb :Buffers<cr>

" search for files by content (ripgrep)
nmap <Leader>fg :Rg<cr>

" find in file
nmap <leader>fl :BLines<cr>

"-----------------------------------
" NOTE: this must be last
"-----------------------------------

if filereadable(".nvimrc")
    source .nvimrc
endif
