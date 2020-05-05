call plug#begin()
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'skywind3000/asyncrun.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-obsession'
Plug 'milkypostman/vim-togglelist'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
call plug#end()

let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'
let g:airline_powerline_fonts = 1
let g:airline_inactive_collapse = 1
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#obsession#indicator_text = '[$]'
let g:airline_section_z = "%{airline#util#wrap(airline#extensions#obsession#get_status(),0)}%#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__#:%v"
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

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_max_num_candidates = 25

" Add an airline section for AsyncRun
let g:asyncrun_status = ''
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

nnoremap <Space> <nop>
let mapleader = " "
let maplocalleader = ","

filetype plugin indent on

" Set up color scheme
syntax on
set t_Co=256
set background=dark
colorscheme solarized
augroup c,python
    autocmd FileType c,python set colorcolumn=80
augroup END
augroup cpp
    autocmd FileType cpp set colorcolumn=120
augroup END

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
set foldlevelstart=10
set cursorline
set listchars=tab:»\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list
set mouse=a

" Performance tweaks for syntax highlighting
set synmaxcol=120
let c_no_curly_error=1

" Adjust behavior based on filetype
autocmd BufNewFile,BufRead *.edn,*.clj,*.cljc,*.cljx set filetype=clojure
autocmd FileType clojure,html,yaml set ts=2 sw=2 et
autocmd BufNewFile,BufRead Pipfile set syntax=dosini

" Align NERDCommenter delimiters flush left
let g:NERDDefaultAlign = 'left'

" Key mappings
nmap <Leader>j :b#<cr>
nmap n nzz
nmap p pzz
nmap N Nzz
nmap P Pzz
nmap <Leader>O :only<cr>
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
"nmap <Leader>t :.RunTests<cr>
nmap <Leader>T :RunTests<cr>
nmap <Leader>b :Last<cr>

" Clojure stack trace
nmap <Leader>* :Eval (clojure.repl/pst *e 50)<cr>
" Clojure keyword to string
" wb   - move to beginning of word
" x    - delete colon
" ysw" - wrap word in double quotes
nmap <LocalLeader>ks wbxysw"
" Clojure string to keyword
" ds" - delete surrounding double quotes
" wb  - move to beginning of word
" i:  - insert a colon
nmap <LocalLeader>sk ds"wbi:<esc>

" git/fugitive mappings
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
nmap <Leader>gf :Git fetch<cr>
nmap <Leader>gl :Git pull<cr>
nmap <Leader>gp :Git push<cr>
nmap <Leader>gc :Git commit<cr>
nmap <Leader>gC :Git commit --no-verify<cr>
nmap <Leader>gL :Commits<cr>
nmap <Leader>gSl :Git stash list<cr>
nmap <Leader>gS- :Git stash<cr>:e<cr>
nmap <Leader>gS+ :Git stash pop<cr>:e<cr>
nmap <Leader>gV :!gitk %<cr>

" fzf mappings
command! -bang -nargs=* Find
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --smart-case --glob "!.git/*" --glob "!build/*" --color "always" '.shellescape(<q-args>),
    \   1,
    \   fzf#vim#with_preview(),
    \   <bang>0)
nmap <Leader>ff :Files<cr>
nmap <Leader>fh :Files $HOME<cr>
nmap <Leader>fb :Buffers<cr>
nmap <Leader>fg :Find<cr>
nmap <leader>fl :BLines<cr>

" Navigate windows directly
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Map <Esc> to exit terminal-mode
tnoremap <Esc> <C-\><C-n>

" ycm mappings
nmap <Leader>yRr :YcmCompleter RefactorRename 
nmap <Leader>yRf :YcmCompleter FixIt<cr>
nmap <Leader>yr :YcmCompleter GoToReferences<cr>
nmap <Leader>yt :YcmCompleter GetType<cr>
nmap <Leader>yd :YcmCompleter GetDocImprecise<cr>
nmap <Leader>yl :YcmCompleter GoToDeclaration<cr>
nmap <Leader>yf :YcmCompleter GoToDefinition<cr>

" gtest mappings
nmap <Leader>tc :exec ':GTestCmd ' . trim(system('find ' . b:build_dir . ' -name ' . expand('%:t:r')))<cr>
nmap <Leader>tt :GTestRun<cr>
nmap <Leader>tu :GTestRunUnderCursor<cr>

if filereadable(".nvimrc")
    source .nvimrc
endif
