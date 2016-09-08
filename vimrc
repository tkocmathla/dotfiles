" Enable powerline-status
set runtimepath+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

" Enable pathogen
execute pathogen#infect()
filetype plugin indent on

" Set up color scheme
syntax on
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Always show statusline
set laststatus=2

set number
set tabstop=4
set shiftwidth=4
set expandtab

map <C-n> :NERDTreeToggle<CR>
