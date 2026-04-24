vim.loader.enable() -- EXPERIMENTAL

-- APPEARANCE -------------------------------------------------------------------------------------
    -- TODO: Move this to its own lua file and make it its own theme
    vim.cmd( "colorscheme unokai" )
    local tweak_theme = function()
        -- Make sure the comments stand out more
        vim.cmd( "hi Comment ctermfg=NONE guifg=Cyan gui=italic" )

        -- Make operators stand out less
        vim.cmd( "hi Operator ctermfg=NONE guifg=LightMagenta gui=NONE" )

        -- Purple types
        vim.cmd( "hi Type ctermfg=NONE guifg=#AE81FF gui=NONE" )
        vim.cmd( "hi Type ctermfg=NONE guifg=#AE81FF gui=NONE" )
        vim.cmd( "hi! link Structure Type" )
        vim.cmd( "hi! link Typedef   Type" )

        vim.cmd( "hi PreProc gui=italic" )

        -- Treat `struct` and `typedef` as keywords

        -- Remove colors from variables
        vim.cmd( "hi Identifier ctermfg=NONE guifg=White gui=NONE" )
        -- FIXME: This doesn't work?
        --vim.cmd( "hi Normal ctermfg=NONE guifg=White gui=NONE" )
        --vim.cmd( "hi! link Identifier Normal" )

        -- Make all literals look the same
        vim.cmd( "hi! link Character String" )
        vim.cmd( "hi! link Number    String" )
        vim.cmd( "hi! link Float     Number" )
        vim.cmd( "hi! link Boolean   Number" )
        vim.cmd( "hi! link Constant  Number" )
    end
    tweak_theme()

    -- Always display the gutter so there's no horizontal shifting when symbols are added
    vim.o.signcolumn = 'yes'

    -- Display certain whitespace characters
    vim.o.list = true
    vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

    -- Relative line numbers but displaying the current line number
    vim.o.number = true
    vim.o.relativenumber = true

    -- Enable mouse input
    vim.o.mouse = 'a'

    vim.o.colorcolumn = '100'
    vim.o.cursorline  = true
    vim.o.winborder   = "rounded" -- For floating windows

    vim.diagnostic.config(
    {
        virtual_lines =
        {
            severity = { min = vim.diagnostic.severity.ERROR } -- TODO: Make this toggleable
        }
        -- Use the default config for everything else
    })


-- AUTOCOMMANDS ------------------------------------------------------------------------------------
    -- Don't display the line numbers in terminal mode
    vim.api.nvim_create_autocmd(
        'TermOpen',
        {
            desc = 'Hide the line numbers in terminal mode.',
            group = vim.api.nvim_create_augroup( 'custom_term_open', { clear = true } ),
            callback = function ()
                vim.opt_local.number         = false
                vim.opt_local.relativenumber = false
            end
        } )

    -- Apply my custom theme tweaks after loading a different colorscheme
    -- TODO: Take into account light/dark backgrounds
    vim.api.nvim_create_autocmd(
        'ColorScheme',
        {
            desc = 'Apply my custom theme tweaks after loading a different colorscheme',
            group = vim.api.nvim_create_augroup( 'auto_tweak_colorscheme', { clear = true } ),
            callback = tweak_theme
        } )


-- CUSTOM COMMANDS ---------------------------------------------------------------------------------
    -- ToggleTransparencyON
    vim.api.nvim_create_user_command(
        "ToggleTransparencyON",
        function ()
            vim.api.nvim_set_hl( 0, "Normal",      { guibg = NONE } )
            vim.api.nvim_set_hl( 0, "NormalFloat", { guibg = NONE } )
            vim.api.nvim_set_hl( 0, "FloatBorder", { guibg = NONE } )
            vim.api.nvim_set_hl( 0, "SignColumn",  { guibg = NONE } )
            vim.api.nvim_set_hl( 0, "Pmenu",       { guibg = NONE } ) -- The autocomplete popup
        end,
        {})
    vim.cmd( "ToggleTransparencyON" ) -- Make the background transparent by default

    -- ToggleTransparencyOFF
    vim.api.nvim_create_user_command(
        "ToggleTransparencyOFF",
        function ()
            vim.cmd( "colorscheme " .. vim.g.colors_name )
        end,
        {})

    -- CopyFilePath
    vim.api.nvim_create_user_command(
        "CopyFilePath",
        function ()
            local path = vim.fn.expand( "%:p" )
            vim.fn.setreg( "+", path )
        end,
        {})


-- GENERAL FUNCTIONALITY --------------------------------------------------------------------------
    vim.o.autoread = true -- Auto reload a file when it's changed outside nvim

    vim.opt.foldmethod = 'indent'
    vim.opt.foldlevelstart = 99 -- Start with *no* folds closed

    -- Case-insensitive searching UNLESS one or more capital letters in the search term
    vim.o.ignorecase = true
    vim.o.smartcase  = true

    -- Stay consistent with the file indentation
    vim.o.autoindent        = true
    vim.o.copyindent        = true
    vim.o.preserveindent    = true

    -- 1 Tab == 4 spaces
    vim.o.expandtab     = true  -- Replace Tab *input* with spaces
    vim.o.shiftwidth    = 4     -- Number of autoindent spaces
    vim.o.softtabstop   = 4     -- Number of spaces replacing a Tab
    vim.o.ts            = 4     -- Number of spaces a Tab is *displayed* as

    -- Sync clipboard between OS and Neovim.
    --  Schedule the setting after `UiEnter` because it can increase startup-time.
    vim.schedule(
        function()
            vim.o.clipboard = 'unnamedplus'
        end )

    -- Use git-bash on Windows and fish elsewhere (if available)
    if vim.loop.os_uname().version:match("Windows") then
        vim.o.shell = '"C:/Program Files/Git/bin/bash.exe"'
    elseif vim.fn.executable( "fish" ) then
        vim.o.shell = "fish"
    end

    vim.g.markdown_folding = true


-- KEY MAPPINGS ------------------------------------------------------------------------------------
    -- Make Space the leader key
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    -- Exit terminal mode by tapping Esc twice
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

    -- Moving focus without having to go CtrlW first
    vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
    vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
    vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

    -- Quick save and close
    vim.keymap.set('n', '<Leader>w', ':w<CR>', { desc = '[W]rite' })
    vim.keymap.set('n', '<Leader>q', ':q<CR>', { desc = '[Q]uit'  })

    -- Buffers as tabs
    vim.keymap.set( 'n', 'tn', ':tabnew<Space><CR>' )
    vim.keymap.set( 'n', 'tk', 'gt' )
    vim.keymap.set( 'n', 'tj', 'gT' )

    -- Shortcut to config
    vim.keymap.set( 'n', '<Leader>oc', ':e $MYVIMRC<CR>', { desc = '[O]pen the [C]onfig file' })

    -- Open a terminal in a bottom split
    vim.keymap.set(
        'n',
        '<Leader>ot',
        function()
            vim.cmd.new()
            vim.cmd.term()
            vim.cmd.wincmd("J") -- Move the new split to the bottom
            vim.api.nvim_win_set_height(0, 15)
        end,
        {desc = '[O]pen [T]erminal'})

    -- Open a terminal in a new tab
    vim.keymap.set(
        'n',
        'tt',
        function()
            vim.cmd.tabnew()
            vim.cmd.term()
        end,
        {desc = "[T]erminal in new [T]ab"})


-- LSP ---------------------------------------------------------------------------------------------
    vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })
    vim.lsp.enable(
    {
        'lua_ls',
        'clangd',
        'slangd'
    })

    -- Set up the LSP when opening a file associated with it
    vim.api.nvim_create_autocmd(
        'LspAttach',
        {
            callback = function( event )
                local client = vim.lsp.get_client_by_id( event.data.client_id )

                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
                    vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
                    vim.lsp.completion.enable( true, client.id, event.buf, { autotrigger = true } )
                end
            end,
        })

    -- Restart LSP
    vim.api.nvim_create_user_command(
        "LspRestart",
        function ()
            vim.cmd( 'lsp stop' )
            vim.cmd.edit()
        end,
        {})

    -- Print the currently attached LSPs
    vim.api.nvim_create_user_command( "LspInfo", function() vim.cmd( 'checkhealth vim.lsp' ) end, {} )
    -- Go to definition
    vim.keymap.set( 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { desc = '[G]o to [D]efinition' })
    -- Rename symbol under the cursor
    vim.keymap.set( 'n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', { desc = '[R]e[n]ame' })


-- PLUGINS -----------------------------------------------------------------------------------------
    vim.api.nvim_create_user_command( "PackInfo",   function() vim.pack.update( nil, {  offline = true }) end, {} )
    vim.api.nvim_create_user_command( "PackUpdate", function() vim.pack.update() end, {} )
    vim.api.nvim_create_user_command( "PackClean",
        function()
            vim.pack.del(
                vim.iter(vim.pack.get())
                    :filter(function(x) return not x.active end)
                    :map(function(x) return x.spec.name end)
                    :totable() )
        end,
        {})

    vim.pack.add({
        'https://github.com/dominikduda/vim_current_word',  -- Highlights instances of the word under cursor
        'https://github.com/mg979/vim-visual-multi',        -- Multiple cursors using <C-n>
        'https://github.com/echasnovski/mini.nvim',         -- Collection of various small independent plugins/modules
        'https://github.com/folke/which-key.nvim',          -- Useful plugin to show you pending keybinds
        'https://github.com/wellle/context.vim'             -- Sticky scrolling
    })

    -- Easymotion
    vim.pack.add({ 'https://github.com/asvetliakov/vim-easymotion' })
    vim.g.EasyMotion_smartcase = true
    vim.keymap.set('n', '<Leader>j', '<Plug>(easymotion-overwin-f)', {desc = '[J]ump to character'})

    -- Version control stuff
    vim.pack.add({ 'https://github.com/mhinz/vim-signify' })
    vim.g.signify_sign_change = '~'
    vim.keymap.set('n', '<Leader>vd', ':SignifyHunkDiff<CR>', {desc = '[V]ersion Control [D]iff'})
    vim.keymap.set('n', '<Leader>vu', ':SignifyHunkUndo<CR>', {desc = '[V]ersion Control [U]ndo'})

    -- Simple statusline.
    require( 'mini.statusline' ).setup({ use_icons = vim.g.have_nerd_font })

    -- Better autocomplete than the native one
    require( 'mini.completion' ).setup({})
    -- Use Tab to navigate the suggestions
    vim.keymap.set( 'i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { expr = true } )
    vim.keymap.set( 'i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true } )

    -- Better Around/Inside textobjects
    require( 'mini.ai' ).setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require( 'mini.surround' ).setup(
    {
        mappings =
        {
            add         = '<C-s>a', -- Add surrounding in Normal and Visual modes
            delete      = '<C-s>d', -- Delete surrounding
            replace     = '<C-s>r', -- Replace surrounding
            find        = '',       -- Find surrounding (to the right)
            find_left   = '',       -- Find surrounding (to the left)
            highlight   = '',       -- Highlight surrounding

            suffix_last = 'l',      -- Suffix to search with "prev" method
            suffix_next = 'n',      -- Suffix to search with "next" method
        }
    })

    -- Fuzzy Finder (files, lsp, etc)
    vim.pack.add({
        'https://github.com/nvim-telescope/telescope.nvim',
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
        'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    })
    if vim.g.have_nerd_font == true then
        vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons' })
    end
        require('telescope').setup
        {
            extensions =
            {
                ['ui-select'] = { require( 'telescope.themes' ).get_dropdown(), },
            },
        }
        -- Enable Telescope extensions if they are installed
        pcall( require( 'telescope' ).load_extension, 'fzf' )
        pcall( require( 'telescope' ).load_extension, 'ui-select' )

        local telescope_builtin = require 'telescope.builtin'
        vim.keymap.set( 'n', '<leader>sh', telescope_builtin.help_tags,                     { desc = '[S]earch [H]elp' })
        vim.keymap.set( 'n', '<leader>sk', telescope_builtin.keymaps,                       { desc = '[S]earch [K]eymaps' })
        vim.keymap.set( 'n', '<leader>f',  telescope_builtin.find_files,                    { desc = 'Search [F]iles' })
        vim.keymap.set( 'n', '<leader>ss', telescope_builtin.builtin,                       { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set( 'n', '<leader>sw', telescope_builtin.grep_string,                   { desc = '[S]earch current [W]ord' })
        vim.keymap.set( 'n', '<leader>sg', telescope_builtin.live_grep,                     { desc = '[S]earch by [G]rep' })
        vim.keymap.set( 'n', '<leader>sd', telescope_builtin.diagnostics,                   { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set( 'n', 'gr',         telescope_builtin.lsp_references,                { desc = '[G]o to [R]eferences' })
        vim.keymap.set( 'n', 'gsd',        telescope_builtin.lsp_document_symbols,          { desc = '[G]o to [S]ymbols in [D]ocument ' })
        vim.keymap.set( 'n', 'gsw',        telescope_builtin.lsp_dynamic_workspace_symbols, { desc = '[G]o to [S]ymbols in [W]orkspace ' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn',
            function()
                telescope_builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end,
            { desc = '[S]earch [N]eovim files' })
