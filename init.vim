call plug#begin('~/.local/share/nvim/plugged')
	" Base editor plugins
	Plug 'asvetliakov/vim-easymotion'
	Plug 'mg979/vim-visual-multi', {'branch': 'master'}
	Plug 'vim-airline/vim-airline'
	Plug 'preservim/nerdtree'
	Plug 'ervandew/supertab'
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
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'preservim/tagbar'
	Plug 'beyondmarc/hlsl.vim'
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
vmap <Leader>d "*d
nmap <Leader>p "*p
nmap <Leader>P "*P
vmap <Leader>p "*p
vmap <Leader>P "*P

" Use C++ syntax with metal shaders
au BufReadPost *.metal set syntax=hlsl
au BufReadPost *.dxbc set syntax=hlsl

" GUTENTAGS:
let g:gutentags_ctags_extra_args = ['--fields=+ainKz', '--languages=C,C++']
let g:gutentags_project_root = ['*.xcodeproj']

" NERDTREE:
nnoremap <C-e> :NERDTreeToggle<CR>

" TAGBAR:
nmap <F8> :TagbarToggle<CR>

" EASY MOTION:
let g:EasyMotion_smartcase = 1
" Move to char
map  <Leader><Leader> <Plug>(easymotion-bd-f)
nmap <Leader><Leader> <Plug>(easymotion-overwin-f)

" SKIM:
nnoremap <Leader>f :SK<CR>

" CoC:
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
  execute 'h '.expand('<cword>')
else
  call CocActionAsync('doHover')
endif
endfunction
"nmap <silent> gd <Plug>(coc-definition)

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
let g:rainbow_active = 0
"au VimEnter,BufReadPost * :RainbowToggleOn

" CTRLP:
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <Leader>/ :Ag<Space>

" Tabs
noremap tk gt
noremap tj gT

nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

set foldmethod=manual
"Back to normal mode from terminal mode
tnoremap <Esc> <C-\><C-n>

nnoremap tn :tabnew<Space><CR>

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
set autoread		" Reload file automatically upon change on disk
set number			" Show line numbers
set relativenumber
set colorcolumn=80,100
set showmatch		" Highlight matching brace
set undolevels=999 " Not having it set caused it to always be at the oldest change

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Tags
nnoremap <C-]> g<C-]>
"nmap gd <C-]> " Jump to definition
set tagcase=match

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
"set expandtab       " Indent using spaces
"set smarttab		 " Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
set ts=4			" Tabs show as 4 spaces

set ruler  " Show row and column ruler information

set completeopt=longest,menuone,preview
set previewheight=5

set mouse=a

let c_space_errors=1

command FilterFlowControl g!/\(\<if\>\|\<else\>|\<for\>|\<while\>|\<do\>|\<switch\>|\<case\>|\<try\>|\<catch\>\)/d
command TrimWhiteSpaces %s/\s\+$//e
command ReloadConfig so $MYVIMRC
