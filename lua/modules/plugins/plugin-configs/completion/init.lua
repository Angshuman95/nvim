local config = {}

function config.compe()
    vim.o.completeopt = "menuone,noselect"
    require"compe".setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = "enable",
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,
        source = {
            path = {kind = "  "},
            buffer = {kind = "  "},
            calc = {kind = "  "},
            vsnip = {kind = "  "},
            nvim_lsp = {kind = "  "},
            -- nvim_lua = {kind = "  "},
            nvim_lua = false,
            spell = {kind = "  "},
            tags = false,
            vim_dadbod_completion = true,
            -- snippets_nvim = {kind = "  "},
            -- ultisnips = {kind = "  "},
            treesitter = {kind = " 侮 "},
            emoji = {kind = " ﲃ ", filetypes = {"markdown"}}
            -- for emoji press : (idk if that in compe tho)
        }
    }
    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end
    local check_back_space = function()
        local col = vim.fn.col(".") - 1
        if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
            return true
        else
            return false
        end
    end
    _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-n>"
        elseif vim.fn.call("vsnip#available", {1}) == 1 then
            return t "<Plug>(vsnip-expand-or-jump)"
        elseif check_back_space() then
            return t "<Tab>"
        else
            return vim.fn["compe#complete"]()
        end
    end
    _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-p>"
        elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
            return t "<Plug>(vsnip-jump-prev)"
        else
            return t "<S-Tab>"
        end
    end
    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()",
                            {expr = true})
    vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()",
                            {expr = true})
end

function config.telescope()
    if not packer_plugins['plenary.nvim'].loaded or
        not packer_plugins['popup.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
        vim.cmd [[packadd popup.nvim]]
        vim.cmd [[packadd telescope-fzy-native.nvim]]
        vim.cmd [[packadd telescope-project.nvim]]
    end
    require('telescope').setup {
        defaults = {
            prompt_prefix = '🔭 ',
            layout_config = {prompt_position = 'top'},
            selection_caret = " ",
            sorting_strategy = 'ascending',
            file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep
                .new,
            qflist_previewer = require'telescope.previewers'.vim_buffer_qflist
                .new
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true
            }
        }
    }

    require('telescope').load_extension('project')
    require('telescope').load_extension('fzy_native')

end

function config.lspkind()
    require("lspkind").init({
        with_text = true,
        symbol_map = {
            Text = "",
            Method = "ƒ",
            Function = "",
            Constructor = "",
            Variable = "",
            Class = "",
            Interface = "ﰮ",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "了",
            Keyword = "",
            Snippet = "﬌",
            Color = "",
            File = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = ""
        }
    })
end

function config.emmet() vim.g.user_emmet_mode = "inv" end

return config
