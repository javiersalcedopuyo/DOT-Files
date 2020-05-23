call plug#begin('~/.local/share/nvim/plugged')
" Base editor plugins
Plug 'vim-airline/vim-airline'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'dominikduda/vim_current_word'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
" Language plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'
Plug 'CaffeineViking/vim-glsl'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/ShaderHighLight'
" Themes
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'morhetz/gruvbox', {'as': 'gruvbox'}
Plug 'rakr/vim-one', {'as': 'one'}
call plug#end()

"General
set number  "Show line numbers
set relativenumber
set linebreak "Break lines at word (requires Wrap lines)
set colorcolumn=100
set textwidth=100 "Line wrap (number of cols)
set showmatch "Highlight matching brace

"Back to normal mode from terminal mode
tnoremap <Esc> <C-\><C-n>

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Visual cursor movement
nnoremap j gj
nnoremap k gk
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" Tabs
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>

" Speedup stuff
nnoremap <C-s> :w<CR>
nnoremap <C-f> /
nnoremap <Space> /

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
set shiftwidth=2  " Number of auto-indent spaces
set smartindent "Enable smart-indent
set smarttab  "Enable smart-tabs
set softtabstop=2 "Number of spaces per Tab

let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'

set ruler  " Show row and column ruler information

" Multicursors
let g:multi_cursor_use_default_mapping = 0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<A-d>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<A-d>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


" Omnisharp
let g:OmniSharp_server_stdio = 1
"let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_timeout = 5 " Timeout in seconds to wait for a response from the server
set completeopt=longest,menuone,preview
set previewheight=5

"Jump to definition
nmap <F12> <C-]>

set t_Co=256
syntax enable
let c_space_errors=1

" THEMES
set termguicolors background=light
"colorscheme dracula
colorscheme one
" Background stays the same as the terminals
hi Normal  guibg=NONE ctermbg=NONE
" Parts of buffers without content are transparent
hi NonText guibg=NONE ctermbg=NONE
" air-line
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

highlight TrailWhitespace ctermbg=red guibg=red
match TrailWhitespace /\s\+$/
