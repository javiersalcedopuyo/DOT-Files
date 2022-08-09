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
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlighting and more
	Plug 'neovim/nvim-lspconfig' " Recommended official LSP config
	Plug 'williamboman/nvim-lsp-installer' " Install new LSPs
	" Autocomplete
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
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
let g:fzf_preview_window = 'right:60%'


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

" TODO: Move to a .lua file
lua << EOF
-- LSP
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {}
  server:setup(opts)
end)

-- LSP Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>e', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
	mapping = cmp.mapping.preset.insert({
      	  	['<C-b>'] = cmp.mapping.scroll_docs(-4),
      	  	['<C-f>'] = cmp.mapping.scroll_docs(4),
      	  	['<C-Space>'] = cmp.mapping.complete(),
      	  	['<C-e>'] = cmp.mapping.abort(),
      	  	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      	  	["<Tab>"] = cmp.mapping(function(fallback)
			-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
			if cmp.visible() then
				--local entry = cmp.get_selected_entry()
				--if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				--else
					--cmp.confirm()
				--end
			else
				fallback()
			end
			end, {"i","s","c",}),
    }),
    sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
      	-- { name = 'vsnip' },		-- For vsnip users.
      	-- { name = 'luasnip' },		-- For luasnip users.
      	-- { name = 'ultisnips' },	-- For ultisnips users.
      	-- { name = 'snippy' },		-- For snippy users.
    }, {
		{ name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
    sources = {
		{ name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
		{ name = 'path' }
    }, {
		{ name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['sourcekit'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
	capabilities = capabilities,
}

require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
	capabilities = capabilities,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
EOF

command FilterFlowControl g!/\(\<if\>\|\<else\>|\<for\>|\<while\>|\<do\>|\<switch\>|\<case\>|\<try\>|\<catch\>\)/d
command TrimWhiteSpaces %s/\s\+$//e
command ReloadConfig so $MYVIMRC
