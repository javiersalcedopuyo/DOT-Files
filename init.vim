call plug#begin('~/.local/share/nvim/plugged')
" Base editor plugins
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ervandew/supertab'
Plug 'mhinz/vim-signify'
Plug 'kshenoy/vim-signature'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dominikduda/vim_current_word'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
" Language plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'CaffeineViking/vim-glsl'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/ShaderHighLight'
" Theming
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'
Plug 'sainnhe/gruvbox-material'
Plug 'tomasiser/vim-code-dark'
call plug#end()

let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>/ :Ag<Space>
nnoremap <Leader>g g<C-]>

" Copy to system's clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"General
set number          "Show line numbers
set relativenumber
set colorcolumn=80,100
set showmatch       "Highlight matching brace
set autoread        "Automatically open changes in disk

"Back to normal mode from terminal mode
tnoremap <Esc> <C-\><C-n>

" Toggle NERD Tree
nnoremap <C-E> :NERDTreeToggle<CR>

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Visual cursor movement
nnoremap j gj
nnoremap k gk
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" Tabs
nnoremap tn :tabnew<Space><CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>

" EasyMotion
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" FZF
nnoremap <C-p> :SK<CR>

" Highlights
set hlsearch  "Highlight all search results
set smartcase  "Enable smart-case search
set ignorecase "Always case-insensitive
set incsearch   "Searches for strings incrementally
set cursorline "Highlight current line
highlight ColorColumn ctermbg=darkgray
" Highlight occurrences of the current word
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 0

" Indent and tabs
set autoindent  "Auto-indent new lines
set cindent "Use 'C' style program indenting
set expandtab  "Use spaces instead of tabs
set shiftwidth=4  " Number of auto-indent spaces
set smartindent "Enable smart-indent
set smarttab  "Enable smart-tabs
set softtabstop=4 "Number of spaces per Tab

set ruler  " Show row and column ruler information

" CoC: Remap keys for gotos
nmap <silent> g<C-]> <Plug>(coc-definition)
nmap <silent> gy    <Plug>(coc-type-definition)
nmap <silent> gi    <Plug>(coc-implementation)
nmap <silent> gr    <Plug>(coc-references)

"Jump to definition
nmap <F12> g<C-]>
nmap gd g<C-]>
nmap <C-]> g<C-]>

let g:signify_sign_change = "~"

set t_Co=256
syntax enable
let c_space_errors=1

" THEMES
colorscheme codedark
let g:rainbow_active = 1
au VimEnter,BufReadPost * :RainbowToggleOn
" Background stays the same as the terminals
hi Normal  guibg=NONE ctermbg=NONE
" Parts of buffers without content are transparent
hi NonText guibg=NONE ctermbg=NONE
" air-line
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" powerline symbols
"let g:airline_left_sep = "\uE0BC"
"let g:airline_left_alt_sep = "\uE0BD"
"let g:airline_right_sep = "\uE0BE"
"let g:airline_right_alt_sep = "\uE0BF"

highlight TrailWhitespace ctermbg=red guibg=red
match TrailWhitespace /\s\+$/
