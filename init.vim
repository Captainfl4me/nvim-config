:set number

:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set guifont="Monoki Nerd Font"
:set updatetime=300
:set clipboard+=unnamedplus

call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " ChadTree
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw):w
Plug 'https://github.com/ap/vim-css-color' " CSS Color 
Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'numToStr/Comment.nvim'

Plug 'https://github.com/tpope/vim-fugitive' "Git plugin
Plug 'https://github.com/airblade/vim-gitgutter' " Git diff highlighting

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' } " Markdown preview
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' } " File search popup
Plug 'mhinz/vim-startify' " Dashboard
Plug 'https://github.com/github/copilot.vim' " Github Copilot

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'

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
let g:startify_list_order = ['bookmarks', 'files']
let g:startify_bookmarks = [
\ { 'c': '~/Appdata/Local/nvim/init.vim' },
\ ]

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

"" COC CONFIGURATION
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-rust-analyzer']

" Init comment plugin
lua require('Comment').setup()
