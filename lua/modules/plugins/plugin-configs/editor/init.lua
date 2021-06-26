local config = {}


function config.comment()
    require("nvim_comment").setup()
end


function config.autopairs()
    local remap = vim.api.nvim_set_keymap
    local npairs = require('nvim-autopairs')
    local Rule = require('nvim-autopairs.rule')

    -- skip it, if you use another global object
    _G.MUtils= {}

    vim.g.completion_confirm_key = ""
    MUtils.completion_confirm=function()
        if vim.fn.pumvisible() ~= 0  then
            if vim.fn.complete_info()["selected"] ~= -1 then
                return vim.fn["compe#confirm"](npairs.esc("<cr>"))
            else
                return npairs.esc("<cr>")
            end
        else
            return npairs.autopairs_cr()
        end
    end


    remap('i' , '<CR>','v:lua.MUtils.completion_confirm()',
        { expr = true , noremap = true })

    npairs.setup({
        check_ts = true,
        ts_config = {
            lua = {'string'},-- it will not add pair on that treesitter node
            javascript = {'template_string'},
            java = false,-- don't check treesitter on java
        }
    })

    require('nvim-treesitter.configs').setup {
        autopairs = {enable = true}
    }

    local ts_conds = require('nvim-autopairs.ts-conds')

    -- press % => %% is only inside comment or string
    npairs.add_rules({
        Rule("%", "%", "lua")
            :with_pair(ts_conds.is_ts_node({'string','comment'})),
        Rule("$", "$", "lua")
            :with_pair(ts_conds.is_not_ts_node({'function'}))
    })
end


function config.gitsigns()
    if not packer_plugins["plenary.nvim"].loaded then
        vim.cmd [[packadd plenary.nvim]]
    end
    require("gitsigns").setup {
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = " ▎",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn"
            },
            change = {
                hl = "GitSignsChange",
                text = " ▎",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn"
            },
            delete = {
                hl = "GitSignsDelete",
                -- text = '契',
                text = " ▎",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn"
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = " ▎",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn"
            },
            changedelete = {
                hl = "GitSignsChange",
                text = " ▎",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn"
            }
        },
        numhl = false,
        linehl = false,
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true
        },
        watch_index = {interval = 1000},
        sign_priority = 6,
        update_debounce = 200,
        status_formatter = nil, -- Use default
        use_decoration_api = false
    }
end


function config.diffview()
    local cb = require "diffview.config".diffview_callback
    require "diffview".setup {
        diff_binaries = false,
        file_panel = {width = 35, use_icons = true},
        key_bindings = {
            disable_defaults = false,
            view = {
                ["<tab>"] = cb("select_next_entry"),
                ["<s-tab>"] = cb("select_prev_entry"),
                ["<leader>e"] = cb("focus_files"),
                ["<leader>b"] = cb("toggle_files")
            },
            file_panel = {
                ["j"] = cb("next_entry"),
                ["<down>"] = cb("next_entry"),
                ["k"] = cb("prev_entry"),
                ["<up>"] = cb("prev_entry"),
                ["<cr>"] = cb("select_entry"),
                ["o"] = cb("select_entry"),
                ["<2-LeftMouse>"] = cb("select_entry"),
                ["-"] = cb("toggle_stage_entry"),
                ["S"] = cb("stage_all"),
                ["U"] = cb("unstage_all"),
                ["R"] = cb("refresh_files"),
                ["<tab>"] = cb("select_next_entry"),
                ["<s-tab>"] = cb("select_prev_entry"),
                ["<leader>e"] = cb("focus_files"),
                ["<leader>b"] = cb("toggle_files")
            }
        }
    }
end


function config.blame()
    vim.g.gitblame_enabled = 0
end


return config
