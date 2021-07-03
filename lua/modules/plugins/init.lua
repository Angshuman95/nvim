local modules = {}

-- ======================================================================>
-- UI Modules
-- ======================================================================>

local ui_config = require('modules.plugins.plugin-configs.ui')

-- modules['rafamadriz/neon'] = {
--     config = ui_config.color
-- }

modules['christianchiarulli/nvcode-color-schemes.vim'] = {
    config = ui_config.color
}

-- modules['marko-cerovac/material.nvim'] = {
--     config = ui_config.color
-- }

modules['glepnir/dashboard-nvim'] = {
    config = ui_config.dashboard
}

modules['glepnir/galaxyline.nvim'] = {
    branch = 'main',
    config = ui_config.galaxyline,
    requires = 'kyazdani42/nvim-web-devicons'
}

modules['lukas-reineke/indent-blankline.nvim'] = {
    event = 'BufRead',
    branch = 'lua',
    config = ui_config.indent_blankline
}

modules['kyazdani42/nvim-tree.lua'] = {
    cmd = 'NvimTreeToggle',
    config = ui_config.tree,
    requires = 'kyazdani42/nvim-web-devicons'
}

modules['vifm/vifm.vim'] = { cmd = 'Vifm' }

modules['voldikss/vim-floaterm'] = { config = ui_config.floaterm }


-- ======================================================================>
-- Editor Modules
-- ======================================================================>


local editor_config = require('modules.plugins.plugin-configs.editor')

modules['terrortylor/nvim-comment'] = {
    cmd = 'CommentToggle',
    config = editor_config.comment
}

modules['sbdchd/neoformat'] = { cmd = 'Neoformat' }

modules['windwp/nvim-autopairs'] = {
    after = 'nvim-treesitter',
    config = editor_config.autopairs
}

modules['mbbill/undotree'] = {cmd = 'UndotreeToggle'}

modules['lewis6991/gitsigns.nvim'] = {
    event = 'BufReadPre',
    config = editor_config.gitsigns,
    requires = {'nvim-lua/plenary.nvim', opt = true}
}

modules['tpope/vim-fugitive'] = {
    requires = 'tpope/vim-rhubarb'
}

modules['sindrets/diffview.nvim'] = {
    cmd = {
        'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles',
        'DiffviewFocusFiles', 'DiffviewRefresh'
    },
    config = editor_config.diffview
}

modules['f-person/git-blame.nvim'] = {config = editor_config.blame}


-- ======================================================================>
-- Language Modules
-- ======================================================================>


local languages_config = require('modules.plugins.plugin-configs.' ..
'languages')

modules['neovim/nvim-lspconfig'] = {
    config = languages_config.lsp_configs
}

modules['kabouzeid/nvim-lspinstall'] = {}

modules['glepnir/lspsaga.nvim'] = {
    cmd = 'Lspsaga',
    config = languages_config.lspsaga
}

modules['kevinhwang91/nvim-bqf'] = {
    opt = true
}

modules['nvim-treesitter/nvim-treesitter'] = {
    event = 'BufRead',
    config = languages_config.treesitter,
    requires = {{'nvim-treesitter/playground', opt = true}},
    run = ':TSUpdate'
}

modules['simrat39/symbols-outline.nvim'] = {
    event = 'BufRead',
    config = languages_config.symbols
}


-- ======================================================================>
-- Completion Modules
-- ======================================================================>


local completion_config = require('modules.plugins.plugin-configs.' ..
'completion')

modules['hrsh7th/nvim-compe'] = {
    event = 'InsertEnter',
    config = completion_config.compe
}

modules['hrsh7th/vim-vsnip'] = { after = 'nvim-compe' }

modules['rafamadriz/friendly-snippets'] = { after = 'nvim-compe' }

modules['nvim-telescope/telescope.nvim'] = {
    cmd = 'Telescope',
    config = completion_config.telescope,
    requires = {
        {'nvim-lua/popup.nvim', opt = true},
        {'nvim-lua/plenary.nvim',opt = true},
        {'nvim-telescope/telescope-fzy-native.nvim',opt = true},{'nvim-telescope/telescope-project.nvim', opt = true}
    }
}

modules['onsails/lspkind-nvim'] = {config = completion_config.lspkind}

modules['mattn/emmet-vim'] = {
    event = 'InsertEnter',
    ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact','cshtml'},
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

modules['iamcco/markdown-preview.nvim'] = {
    event = {'VimEnter', 'BufReadPre'},
    run = 'cd app && yarn install'
}

modules['christoomey/vim-tmux-navigator'] = {
    config = tools_config.tmux
}

modules['windwp/nvim-spectre'] = {
    event = 'VimEnter',
    config = tools_config.spectre,
    requires = {
        {'nvim-lua/popup.nvim', opt = true},
        {'nvim-lua/plenary.nvim', opt = true}
    }
}

return modules
