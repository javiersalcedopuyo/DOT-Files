call plug#begin('~/.local/share/nvim/plugged')
	" Base editor plugins
	Plug 'asvetliakov/vim-easymotion'
	Plug 'mg979/vim-visual-multi', {'branch': 'master'}
	Plug 'vim-airline/vim-airline'
	Plug 'preservim/nerdtree'
	Plug 'mhinz/vim-signify'
	Plug 'tpope/vim-fugitive'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Keep FzF for Ag command
	Plug 'junegunn/fzf.vim'
	Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
	Plug 'dominikduda/vim_current_word'
	Plug 'tpope/vim-surround'
	Plug 'kshenoy/vim-signature'
	Plug 'yggdroot/indentline'
	" Language plugins
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlighting and more
	" Customization
	Plug 'luochen1990/rainbow'
	Plug 'ryanoasis/vim-devicons'
	Plug 'tomasiser/vim-code-dark', {'as': 'vs_dark'}
	Plug 'altercation/vim-colors-solarized'
call plug#end()

let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>g g<C-]>

" Copy to system's clipboard
vmap <Leader>y "*y

" NERDTREE:
nnoremap <C-e> :NERDTreeToggle<CR>

" EASY MOTION:
let g:EasyMotion_smartcase = 1
" Move to char
map  <Leader><Leader> <Plug>(easymotion-bd-f)
nmap <Leader><Leader> <Plug>(easymotion-overwin-f)

" SKIM:
nnoremap <Leader>f :Files<CR>
let g:fzf_preview_window = 'right:50%'

" CURRENT WORD: Highlight occurrences of the current word
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 0

" SIGNIFY:
let g:signify_sign_change = '~'
nnoremap <Leader>d :SignifyHunkDiff<CR>
nnoremap <Leader>u :SignifyHunkUndo<CR>

"AIRLINE:
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" Rounded separators MODE)...(%
"let g:airline_left_sep = "\uE0B4"
"let g:airline_right_sep = "\uE0B6"
"let g:airline_left_alt_sep = "\uE0B5"
"let g:airline_right_alt_sep = "\uE0B7"
" Tilted separators MODE/...\%
"let g:airline_left_sep = "\uE0BC"
"let g:airline_right_sep = "\uE0BE"
"let g:airline_left_alt_sep = "\uE0BD"
"let g:airline_right_alt_sep = "\uE0BF"

let g:airline_section_y = {}
let g:airline_section_warning = ''

" RAINBOW:
let g:rainbow_active = 1
au VimEnter,BufReadPost * :RainbowToggleOn

" CTRLP:
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <Leader>/ :Ag<Space>

" Tabs
nnoremap tn :tabnew<Space><CR>
noremap tk gt
noremap tj gT

" Scrolling
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

"Back to normal mode from terminal mode
tnoremap <Esc> <C-\><C-n>

" THEMING
set t_Co=256   " This is may or may not needed.
syntax enable
set background=dark
colorscheme codedark
highlight ColorColumn ctermbg=lightgray
highlight TrailWhitespace ctermbg=red guibg=red
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight SignColumn ctermbg=none
match TrailWhitespace /\s\+$/

"General
set mouse=a			" Enable the mouse
set autoread		" Reload file automatically upon change on disk
set number			" Show line numbers
set relativenumber
set colorcolumn=80,100
set showmatch		" Highlight matching brace
set undolevels=999 " Not having it set caused it to always be at the oldest change

" Highlights
set hlsearch   " Highlight all search results
set smartcase  " Enable smart-case search
set ignorecase " Always case-insensitive
set incsearch  " Searches for strings incrementally
set cursorline " Highlight current line

" Indent and tabs
set autoindent		" Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set copyindent
set preserveindent
set noexpandtab     " Indent using tabs
set softtabstop=4	" Number of spaces per Tab
set ts=4			" Tabs show as 4 spaces

set ruler  " Show row and column ruler information

"set completeopt=longest,menuone,preview
set completeopt=menu,menuone,noselect
"set previewheight=5

let c_space_errors=1

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" CoC suggestions
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

command FilterFlowControl g!/\(\<if\>\|\<else\>|\<for\>|\<while\>|\<do\>|\<switch\>|\<case\>|\<try\>|\<catch\>\)/d
command TrimWhiteSpaces %s/\s\+$//e
command ReloadConfig so $MYVIMRC
