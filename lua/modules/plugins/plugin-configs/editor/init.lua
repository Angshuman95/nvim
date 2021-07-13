local config = {}


function config.comment()
    require("nvim_comment").setup()
end


function config.autopairs()
    if not packer_plugins["nvim-treesitter"].loaded then
        vim.cmd [[packadd nvim-treesitter]]
    end
    require("nvim-autopairs").setup()
    local npairs = require("nvim-autopairs")

    _G.MUtils = {}

    vim.g.completion_confirm_key = ""
    MUtils.completion_confirm = function()
        if vim.fn.pumvisible() ~= 0 then
            if vim.fn.complete_info()["selected"] ~= -1 then
                vim.fn["compe#confirm"]()
                return npairs.esc("")
            else
                vim.defer_fn(function()
                    vim.fn["compe#confirm"]("<cr>")
                end, 20)
                return npairs.esc("<c-n>")
            end
        else
            return npairs.check_break_line_char()
        end
    end

    MUtils.completion_confirm = function()
        if vim.fn.pumvisible() ~= 0 then
            if vim.fn.complete_info()["selected"] ~= -1 then
                vim.fn["compe#confirm"]()
                return npairs.esc("")
            else
                vim.api.nvim_select_popupmenu_item(0, false, false, {})
                vim.fn["compe#confirm"]()
                return npairs.esc("<c-n>")
            end
        else
            return npairs.check_break_line_char()
        end
    end

    MUtils.tab = function()
        if vim.fn.pumvisible() ~= 0 then
            return npairs.esc("<C-n>")
        else
            if vim.fn["vsnip#available"](1) ~= 0 then
                vim.fn.feedkeys(string.format("%c%c%c(vsnip-expand-or-jump)",
                                              0x80, 253, 83))
                return npairs.esc("")
            else
                return npairs.esc("<Tab>")
            end
        end
    end

    MUtils.s_tab = function()
        if vim.fn.pumvisible() ~= 0 then
            return npairs.esc("<C-p>")
        else
            if vim.fn["vsnip#jumpable"](-1) ~= 0 then
                vim.fn.feedkeys(string.format("%c%c%c(vsnip-jump-prev)", 0x80,
                                              253, 83))
                return npairs.esc("")
            else
                return npairs.esc("<C-h>")
            end
        end
    end

    vim.api.nvim_set_keymap("i", "<CR>", "v:lua.MUtils.completion_confirm()",
                            {expr = true, noremap = true})
    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.MUtils.tab()", {expr = true, noremap = true})
    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.MUtils.s_tab()", {expr = true, noremap = true})
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
