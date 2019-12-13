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
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'
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

" Operator Highlight
let g:ophigh_color = 256
let g:ophigh_color_gui = "#F6FF00" "Yellow

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
nnoremap <C-c> :q<CR>
nnoremap <C-f> /
nnoremap <Space> /

" Highlights
set hlsearch  "Highlight all search results
set smartcase  "Enable smart-case search
set ignorecase "Always case-insensitive
set incsearch   "Searches for strings incrementally
set cursorline "Highlight current line
highlight ColorColumn ctermbg=darkgray

" Indent and tabs
set autoindent  "Auto-indent new lines
set cindent "Use 'C' style program indenting
set expandtab  "Use spaces instead of tabs
set shiftwidth=2  " Number of auto-indent spaces
set smartindent "Enable smart-indent
set smarttab  "Enable smart-tabs
set softtabstop=2 "Number of spaces per Tab
"let g:indent_guides_enable_on_vim_startup = 1

let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'

" Advanced
set ruler  " Show row and column ruler information

" Multicursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<A-d>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<A-d>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cs_checkers = ['code_checker']

" Omnisharp
"let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_timeout = 5 " Timeout in seconds to wait for a response from the server
set completeopt=longest,menuone,preview
set previewheight=5

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

"Jump to definition
nmap <F12> <C-]>

"set tabstop=2
set t_Co=256
syntax enable
let c_space_errors=1

" THEMES
"colorscheme dracula
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

highlight TrailWhitespace ctermbg=red guibg=red
match TrailWhitespace /\s\+$/
