local config = {}


function config.lsp_configs()
    require("modules.lsp")
    require("modules.lsp.languages")

    if not packer_plugins["nvim-bqf"].loaded then
        vim.cmd [[packadd nvim-bqf]]
    end
end


function config.lspsaga()
    if not packer_plugins['lspsaga.nvim'].loaded then
        vim.cmd [[packadd lspsaga.nvim]]
    end

    require("lspsaga").init_lsp_saga({
        code_action_icon = '💡'
    })
end


function config.treesitter()
    if not packer_plugins["playground"].loaded then
        vim.cmd [[packadd playground]]
    end
    require "nvim-treesitter.configs".setup {
        ensure_installed = "all",
        ignore_install = {"haskell"},
        highlight = {enable = true},
        indent = {enable = {"javascriptreact"}},
        playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = false,
            keybindings = {
                toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<cr>",
                show_help = "?"
            }
        },
        autotag = {enable = true},
        rainbow = {enable = true},
        context_commentstring = {
            enable = true,
            config = {javascriptreact = {style_element = "{/*%s*/}"}}
        }
    }
end


function config.symbols()
    require("symbols-outline").setup {
        highlight_hovered_item = true,
        show_guides = true
    }
end


return config
