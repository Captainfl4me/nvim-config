:set number

:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set guifont="Monoki Nerd Font"

call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " ChadTree
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw):w
Plug 'https://github.com/ap/vim-css-color' " CSS Color 
Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation

Plug 'https://github.com/tpope/vim-fugitive' "Git plugin
Plug 'https://github.com/airblade/vim-gitgutter' " Git diff highlighting

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' } " Markdown preview
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' } " File search popup
Plug 'mhinz/vim-startify' " Dashboard
Plug 'https://github.com/github/copilot.vim' " Github Copilot

:set encoding=UTF-8

call plug#end()

let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]
let g:startify_custom_header = 'startify#pad(startify#fortune#boxed() + g:dashboard_custom_header)'

nnoremap <C-t> :CHADopen <CR>

nmap <F7> :TagbarToggle<CR>

syntax on
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

let g:Lf_WindowPosition = 'popup'

