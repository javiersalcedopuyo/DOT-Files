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


-- AUTOCOMMANDS ------------------------------------------------------------------------------------
    -- Don't display the line numbers in terminal mode
    vim.api.nvim_create_autocmd(
        'TermOpen',
        {
            desc = 'Hide the line numbers in terminal mode.',
            group = vim.api.nvim_create_augroup( 'custom_term_open', { clear = true } ),
            callback = function ()
                vim.opt.number         = false
                vim.opt.relativenumber = false
            end
        } )

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

    -- Stop LSP
    local stop_lsp = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })  -- 0 = current buffer
        vim.lsp.stop_client( clients )
    end
    vim.api.nvim_create_user_command( "LSPStop", stop_lsp, {} )

        --
    -- Restart LSP
    vim.api.nvim_create_user_command(
        "LSPRestart",
        function ()
            stop_lsp()
            vim.cmd.edit()
        end,
        {})

    -- Print the currently attached LSPs
    vim.api.nvim_create_user_command(
        "LSPInfo",
        function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })  -- 0 = current buffer
            if #clients == 0 then
                print("No LSP attached")
            else
                for _, client in ipairs(clients) do
                    print("Attached LSPs:", client.name)
                end
            end
        end,
        {} )


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

    -- vim.keymap.set( 'n', 'fo', 'zo', { desc = '[O]pen the [F]old under cursor' })
    -- vim.keymap.set( 'n', 'fO', 'zR', { desc = '[O]pen all [F]olds' })
    -- vim.keymap.set( 'n', 'fc', 'zc', { desc = '[C]lose the [F]old under cursor' })
    -- vim.keymap.set( 'n', 'fC', 'zM', { desc = '[C]lose all [F]olds' })
    -- vim.keymap.set( 'n', 'ft', 'za', { desc = '[T]oggle the [F]old under cursor' })

    -- Go to definition
    vim.keymap.set( 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { desc = '[G]o to [D]efinition' })

    -- Rename symbol under the cursor
    vim.keymap.set( 'n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', { desc = '[R]e[n]ame' })

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
    vim.diagnostic.config(
    {
        virtual_lines =
        {
            severity = { min = vim.diagnostic.severity.ERROR } -- TODO: Make this toggleable
        }
        -- Use the default config for everything else
    })
    vim.lsp.config[ 'lua_ls' ] = 
    {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git', '.svn' },
        settings =
        {
            Lua =
            {
                runtime     = { version = 'LuaJIT' },
                diagnostics = { globals = 'vim'    }, -- FIXME: It still doesn't recognise the `vim` global
            },
        }
    }
    vim.lsp.config[ 'clangd' ] =
    {
        cmd = { 'clangd' },
        filetypes = { 'c', 'h', 'cpp', 'hpp', 'cc', 'cxx' },
        root_markers = { '.clangd', 'compile_commands.json', '.git', '.svn', 'build.cpp' },
        settings = {}
    }
    vim.lsp.config[ 'slangd' ] =
    {
        cmd = { 'slangd' },
        filetypes = { 'vert', 'frag', 'comp', 'shader', 'slang' },
        root_markers = { '.git', '.svn', 'build.cpp' },
        settings = {}
    }

    vim.lsp.enable( 'lua_ls' )
    vim.lsp.enable( 'clangd' )
    vim.lsp.enable( 'slangd' )


-- PLUGINS -----------------------------------------------------------------------------------------
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath( "data" ) .. "/lazy/lazy.nvim"
    if not ( vim.uv or vim.loop ).fs_stat( lazypath ) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend( lazypath )
    require( "lazy" ).setup(
    {
        spec = -- Plugins go here
        {
            'dominikduda/vim_current_word', -- Highlights instances of the word under cursor
            'mg979/vim-visual-multi',       -- Multiple cursors using <C-n>
            -- Version control stuff
            {
                'mhinz/vim-signify',
                config = function()
                    vim.g.signify_sign_change = '~'
                    vim.keymap.set('n', '<Leader>vd', ':SignifyHunkDiff<CR>', {desc = '[V]ersion Control [D]iff'})
                    vim.keymap.set('n', '<Leader>vu', ':SignifyHunkUndo<CR>', {desc = '[V]ersion Control [U]ndo'})
                end
            },
            -- Easymotion
            {
                'asvetliakov/vim-easymotion',
                config = function()
                    vim.g.EasyMotion_smartcase = true
                    vim.keymap.set('n', '<Leader>j', '<Plug>(easymotion-overwin-f)', {desc = '[J]ump to character'})
                end,
            },
            -- Collection of various small independent plugins/modules
            {
                'echasnovski/mini.nvim',
                config = function()
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

                    -- Simple statusline.
                    require( 'mini.statusline' ).setup(
                    {
                        use_icons = vim.g.have_nerd_font
                        -- Set the section for cursor location to l:LINE c:COLUMN
                        --section_location = function()
                            --return 'l:%4l c:%3v'
                        --end
                    })
                end,
            },
            { -- Useful plugin to show you pending keybinds.
                'folke/which-key.nvim',
                event = 'VimEnter', -- Sets the loading event to 'VimEnter'
                opts =
                {
                    -- delay between pressing a key and opening which-key (milliseconds)
                    -- this setting is independent of vim.o.timeoutlen
                    delay = 0,
                    icons =
                    {
                        -- set icon mappings to true if you have a Nerd Font
                        mappings = vim.g.have_nerd_font,
                        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                        keys = vim.g.have_nerd_font and {} or
                        {
                            Up = '<Up> ',
                            Down = '<Down> ',
                            Left = '<Left> ',
                            Right = '<Right> ',
                            C = '<C-…> ',
                            M = '<M-…> ',
                            D = '<D-…> ',
                            S = '<S-…> ',
                            CR = '<CR> ',
                            Esc = '<Esc> ',
                            ScrollWheelDown = '<ScrollWheelDown> ',
                            ScrollWheelUp = '<ScrollWheelUp> ',
                            NL = '<NL> ',
                            BS = '<BS> ',
                            Space = '<Space> ',
                            Tab = '<Tab> ',
                            F1 = '<F1>',
                            F2 = '<F2>',
                            F3 = '<F3>',
                            F4 = '<F4>',
                            F5 = '<F5>',
                            F6 = '<F6>',
                            F7 = '<F7>',
                            F8 = '<F8>',
                            F9 = '<F9>',
                            F10 = '<F10>',
                            F11 = '<F11>',
                            F12 = '<F12>',
                        },
                    },
                    spec = {}, -- Name groups
                },
            },
            { -- Fuzzy Finder (files, lsp, etc)
                'nvim-telescope/telescope.nvim',
                event = 'VimEnter',
                dependencies =
                {
                    'nvim-lua/plenary.nvim',
                    {
                        'nvim-telescope/telescope-fzf-native.nvim',
                        build = 'make',
                        cond = function()
                          return vim.fn.executable 'make' == 1
                        end,
                    },
                    { 'nvim-telescope/telescope-ui-select.nvim' },
                    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
                },
                config = function()
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

                    local builtin = require 'telescope.builtin'
                    vim.keymap.set( 'n', '<leader>sh', builtin.help_tags,                     { desc = '[S]earch [H]elp' })
                    vim.keymap.set( 'n', '<leader>sk', builtin.keymaps,                       { desc = '[S]earch [K]eymaps' })
                    vim.keymap.set( 'n', '<leader>f',  builtin.find_files,                    { desc = 'Search [F]iles' })
                    vim.keymap.set( 'n', '<leader>ss', builtin.builtin,                       { desc = '[S]earch [S]elect Telescope' })
                    vim.keymap.set( 'n', '<leader>sw', builtin.grep_string,                   { desc = '[S]earch current [W]ord' })
                    vim.keymap.set( 'n', '<leader>sg', builtin.live_grep,                     { desc = '[S]earch by [G]rep' })
                    vim.keymap.set( 'n', '<leader>sd', builtin.diagnostics,                   { desc = '[S]earch [D]iagnostics' })
                    vim.keymap.set( 'n', 'gr',         builtin.lsp_references,                { desc = '[G]o to [R]eferences' })
                    vim.keymap.set( 'n', 'gsd',        builtin.lsp_document_symbols,          { desc = '[G]o to [S]ymbols in [D]ocument ' })
                    vim.keymap.set( 'n', 'gsw',        builtin.lsp_dynamic_workspace_symbols, { desc = '[G]o to [S]ymbols in [W]orkspace ' })

                    -- Shortcut for searching your Neovim configuration files
                    vim.keymap.set('n', '<leader>sn', function()
                        builtin.find_files { cwd = vim.fn.stdpath 'config' }
                    end,{ desc = '[S]earch [N]eovim files' })
                end,
              },
            -- FIXME: Very slow?
            -- Highlight, edit, and navigate code
            --{
            --    'nvim-treesitter/nvim-treesitter',
            --    build   = ':TSUpdate',
            --    main    = 'nvim-treesitter.configs', -- Sets main module to use for opts
            --    opts    =
            --    {
            --        auto_install = true,
            --        highlight    = { enable = true },
            --    },
            --},
            --'nvim-treesitter/nvim-treesitter-context', -- Sticky scrolling
        },
        checker = { enabled = false } -- Automatic update checker
    });
