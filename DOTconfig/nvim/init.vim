call plug#begin('~/.local/share/nvim/plugged')
" Base editor plugins
Plug 'vim-airline/vim-airline'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'dominikduda/vim_current_word'
Plug 'Valloric/vim-operator-highlight'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
" Language plugins
Plug 'neomake/neomake'
Plug 'ycm-core/YouCompleteMe'
Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'
Plug 'CaffeineViking/vim-glsl'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-scripts/ShaderHighLight'
" Themes
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'morhetz/gruvbox', {'as': 'gruvbox'}
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
nnoremap <C-w> :q<CR>
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
" Operator Highlight
let g:ophigh_color = 226
let g:ophigh_color_gui = "#F6FF00" "Yellow

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

" Neomake
" Full config: when writing or reading a buffer, and on changes in insert and normal mode
"              (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)

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
colorscheme gruvbox
" air-line
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

highlight TrailWhitespace ctermbg=red guibg=red
match TrailWhitespace /\s\+$/
