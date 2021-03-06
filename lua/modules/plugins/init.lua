local modules = {}

-- ======================================================================>
-- UI Modules
-- ======================================================================>

local ui_config = require('modules.plugins.plugin-configs.ui')

-- Colorschemes -- Begin

-- modules['christianchiarulli/nvcode-color-schemes.vim'] = {
--     config = ui_config.color,
-- }

-- modules['Mofiqul/vscode.nvim'] = {
--     config = ui_config.color,
-- }

-- modules['ellisonleao/gruvbox.nvim'] = {
--     requires = {'rktjmp/lush.nvim', opt = true},
--     config = ui_config.color
-- }

modules['navarasu/onedark.nvim'] = {config = ui_config.color}

-- Colorschemes -- End

modules['glepnir/dashboard-nvim'] = {config = ui_config.dashboard}

modules['nvim-lualine/lualine.nvim'] = {
    config = ui_config.lualine,
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
}

modules['lukas-reineke/indent-blankline.nvim'] = {
    event = 'BufRead',
    config = ui_config.indent_blankline
}

modules['nvim-neo-tree/neo-tree.nvim'] = {
    branch = 'v2.x',
    requires = {
        {"nvim-lua/plenary.nvim"},
        {"kyazdani42/nvim-web-devicons"},
        {"MunifTanjim/nui.nvim"}
    },
    config = ui_config.neotree
}

modules['voldikss/vim-floaterm'] = {config = ui_config.floaterm}

-- ======================================================================>
-- Editor Modules
-- ======================================================================>

local editor_config = require('modules.plugins.plugin-configs.editor')

modules['terrortylor/nvim-comment'] = {
    cmd = 'CommentToggle',
    config = editor_config.comment
}

modules['sbdchd/neoformat'] = {
    cmd = 'Neoformat',
    config = function() vim.g.shfmt_opt = "-ci" end
}

modules['windwp/nvim-autopairs'] = {
    after = 'nvim-treesitter',
    config = editor_config.autopairs
}

modules['mbbill/undotree'] = {cmd = 'UndotreeToggle'}

modules['lewis6991/gitsigns.nvim'] = {
    event = 'BufReadPre',
    config = editor_config.gitsigns,
    requires = {'nvim-lua/plenary.nvim'}
}

modules['tpope/vim-fugitive'] = {}

modules['sindrets/diffview.nvim'] = {
    cmd = {
        'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles',
        'DiffviewFocusFiles', 'DiffviewRefresh'
    },
    config = editor_config.diffview
}

-- ======================================================================>
-- Language Modules
-- ======================================================================>

local languages_config = require('modules.plugins.plugin-configs.' ..
                                     'languages')

modules['neovim/nvim-lspconfig'] = {config = languages_config.lsp_configs}

modules['williamboman/nvim-lsp-installer'] = {}

modules['folke/trouble.nvim'] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
        require('trouble').setup {mode = "document_diagnostics"}
    end
}

modules['mfussenegger/nvim-jdtls'] = {
    ft = {'java'},
    config = languages_config.jdtls
}

modules['nvim-treesitter/nvim-treesitter'] = {
    event = {'BufRead', 'BufNewFile'},
    config = languages_config.treesitter,
    run = ':TSUpdate'
}

modules['simrat39/symbols-outline.nvim'] = {
    event = 'BufRead',
    config = languages_config.symbols
}

modules['rcarriga/nvim-dap-ui'] = {
    requires = 'mfussenegger/nvim-dap',
    config = languages_config.dap_ui
}

-- ======================================================================>
-- Completion Modules
-- ======================================================================>

local completion_config = require('modules.plugins.plugin-configs.' ..
                                      'completion')

modules['hrsh7th/nvim-cmp'] = {
    event = 'InsertEnter',
    config = completion_config.cmp,
    requires = {
        {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'},
        {'hrsh7th/cmp-vsnip', after = 'nvim-cmp'},
        {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
        {'hrsh7th/cmp-path', after = 'nvim-cmp'}
    }
}

modules["hrsh7th/vim-vsnip"] = {
    event = 'InsertEnter',
    requires = {
        {'hrsh7th/vim-vsnip-integ', after = 'vim-vsnip'},
        {'rafamadriz/friendly-snippets', after = 'vim-vsnip'}
    }
}

modules['nvim-telescope/telescope.nvim'] = {
    cmd = 'Telescope',
    config = completion_config.telescope,
    requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzy-native.nvim'},
        {'nvim-telescope/telescope-project.nvim'}
    }
}

modules['onsails/lspkind-nvim'] = {config = completion_config.lspkind}

modules['mattn/emmet-vim'] = {
    event = 'InsertEnter',
    ft = {
        'html', 'css', 'javascript', 'javascriptreact', 'vue', 'typescript',
        'typescriptreact', 'cshtml'
    },
    config = completion_config.emmet
}

modules['tpope/vim-surround'] = {}

-- ======================================================================>
-- Tool Modules
-- ======================================================================>

local tools_config = require('modules.plugins.plugin-configs.tools')

modules['norcalli/nvim-colorizer.lua'] = {
    event = {'VimEnter', 'BufReadPre'},
    config = tools_config.colorize
}

modules['folke/which-key.nvim'] = {
    event = {'VimEnter', 'BufReadPre'},
    config = tools_config.whichkey
}

modules['kristijanhusak/vim-dadbod-ui'] = {
    cmd = {
        'DBUIToggle', 'DBUIAddConnection', 'DBUI', 'DBUIFindBuffer',
        'DBUIRenameBuffer'
    },
    config = tools_config.vim_dadbod_ui,
    requires = {
        {'tpope/vim-dadbod', opt = true},
        {'kristijanhusak/vim-dadbod-completion', opt = true}
    }
}

modules['iamcco/markdown-preview.nvim'] = {
    ft = 'markdown',
    run = 'cd app && yarn install'
}

modules['christoomey/vim-tmux-navigator'] = {config = tools_config.tmux}

modules['windwp/nvim-spectre'] = {
    event = 'VimEnter',
    config = tools_config.spectre,
    requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'}
    }
}

modules['easymotion/vim-easymotion'] = {event = {'VimEnter', 'BufReadPre'}}

modules['szw/vim-maximizer'] = {cmd = 'MaximizerToggle'}

return modules
