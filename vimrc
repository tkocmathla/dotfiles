" Enable powerline-status
set runtimepath+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

" Enable pathogen
execute pathogen#infect()
filetype plugin indent on

" Set up color scheme
syntax on
set t_Co=256
set background=dark
colorscheme solarized

" Always show statusline
set laststatus=2

set autochdir
set number
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch

" Adjust behavior based on filetype
autocmd BufNewFile,BufRead *.cljc,*.cljx set filetype=clojure
autocmd FileType clojure,html set ts=2 sw=2 et

" Align NERDCommenter delimiters flush left
let g:NERDDefaultAlign = 'left'

" NERDTree mappings
nmap <c-n> :NERDTreeToggle<cr>

" Fireplace mappings
nmap <Leader>r :Require<cr>
nmap <Leader>R :Require!<cr>
nmap <Leader>E :%Eval<cr>
nmap <Leader>e :Eval<cr>
nmap <Leader>t :w<cr>:Require!<cr>:RunTests<cr>

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

" ack/ag mappings
nmap <Leader>a :Ack<Space>

" Toggle quickfix window 
nnoremap <leader>q :call QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

