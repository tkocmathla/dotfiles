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
autocmd BufNewFile,BufRead *.cljc set filetype=clojure
autocmd FileType clojure,html set ts=2 sw=2 et

" Align NERDCommenter delimiters flush left
let g:NERDDefaultAlign = 'left'

nmap <c-n> :NERDTreeToggle<cr>
nmap <Leader>r :Require<cr>
nmap <Leader>R :Require!<cr>
nmap <Leader>E :%Eval<cr>
nmap <Leader>e :Eval<cr>
nmap <Leader>t :w<cr>:Require!<cr>:RunTests<cr>

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

