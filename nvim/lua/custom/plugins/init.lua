-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.keymap.set('n', '<Leader>w', ':w<CR>')
vim.keymap.set('n', '<Leader>q', ':q<CR>')

-- Copy to system's clipboard
vim.keymap.set('v', '<Leader>y', '*y')

-- Tabs
vim.keymap.set('n', 'tn', ':tabnew<Space><CR>')
vim.keymap.set('n', 'tk', 'gt')
vim.keymap.set('n', 'tj', 'gT')

-- Scroll
vim.keymap.set('n', '<C-j>', '<C-e>')
vim.keymap.set('n', '<C-k>', '<C-y>')

vim.o.colorcolumn = "80,100"
-- Highlight matching brace
vim.o.showmatch = true
-- Highlight the current line
vim.o.cursorline = true

-- Indentation
vim.o.autoindent = true		-- Auto-indent new lines
vim.o.shiftwidth = 4		-- Number of auto-indent spaces
vim.o.noexpandtab = true	-- Indent using tabs
vim.o.softtabstop = 4		-- Number of spaces per Tab
vim.o.ts = 4				-- Tabs show as 4 spaces
vim.o.copyindent = true
vim.o.preserveindent = true

-- Back to normal mode from terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- MORE PLUGINS
return{
	{-- Bracket color matching
		'luochen1990/rainbow',
		config = function()
			vim.g.rainbow_active = 1
		end
	},
	-- Highlight instances of the word under cursor
	'dominikduda/vim_current_word',

	'tpope/vim-surround',

	{
		'asvetliakov/vim-easymotion',
		config = function()
			vim.g.EasyMotion_smartcase = true
			vim.keymap.set('n', '<Leader>j', '<Plug>(easymotion-overwin-f)')
		end,
	},

	-- Version control stuff
	{
		'mhinz/vim-signify',
		config = function()
			vim.g.signify_sign_change = '~'
			vim.keymap.set('n', '<Leader>d', ':SignifyHunkDiff<CR>')
			vim.keymap.set('n', '<Leader>u', ':SignifyHunkUndo<CR>')
		end
	},

	-- Zig syntax support
	{
		'ziglang/zig.vim',
		config = function()
			vim.g.zig_fmt_autosave = false
		end
	},

	'mg979/vim-visual-multi',

	-- Show the current context on the top
	'nvim-treesitter/nvim-treesitter-context',

	-- Smooth scrolling
	'karb94/neoscroll.nvim'
}
