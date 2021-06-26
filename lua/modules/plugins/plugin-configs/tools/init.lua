local config = {}


function config.colorize()
    require "colorizer".setup(
        {"*"},
        {
            RGB = true,
            RRGGBB = true,
            RRGGBBAA = true,
            names = true,
            rgb_fn = true,
            hsl_fn = true,
            css = true,
            css_fn = true
        }
    )
end


function config.whichkey()
    require("which-key").setup {
        plugins = {
            marks = true,
            registers = true,

            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = true,
                nav = true,
                z = true,
                g = true
            }
        },
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+"
        },
        window = {
            border = "single",
            position = "bottom",
            margin = {1, 0, 1, 0},
            padding = {2, 2, 2, 2}
        },
        layout = {
            height = {min = 4, max = 25},
            width = {min = 20, max = 50},
            spacing = 3
        },
        hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "},
        show_help = true
    }

    local opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false
    }

    vim.g.mapleader = ' '
    vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
    vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
    vim.api.nvim_set_keymap("v", "<leader>;", ":Dashboard<CR>", {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>p', ":lua require'telescope'.extensions.project.project{}<CR>",
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-f>', ":lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", {silent = true})
    vim.api.nvim_set_keymap('n', '<C-b>', ":lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", {silent = true})

    local mappings = {
        [';'] = "Dashboard",
        ["/"] = "Comment",
        ["b"] = "Buffers",
        ["e"] = "Explorer",
        ["f"] = "Find File",
        ["h"] = "No Highlight",
        ["p"] = "Projects",
        d = {
            name = "+Debug",
            b = {"<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint"},
            c = {"<cmd>DebugContinue<cr>", "Continue"},
            i = {"<cmd>DebugStepInto<cr>", "Step Into"},
            o = {"<cmd>DebugStepOver<cr>", "Step Over"},
            r = {"<cmd>DebugToggleRepl<cr>", "Toggle Repl"},
            s = {"<cmd>DebugStart<cr>", "Start"}
        },
        g = {
            name = "+Git",
            j = {"<cmd>NextHunk<cr>", "Next Hunk"},
            k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
            p = {"<cmd>PreviewHunk<cr>", "Preview Hunk"},
            r = {"<cmd>ResetHunk<cr>", "Reset Hunk"},
            R = {"<cmd>ResetBuffer<cr>", "Reset Buffer"},
            s = {"<cmd>StageHunk<cr>", "Stage Hunk"},
            u = {"<cmd>UndoStageHunk<cr>", "Undo Stage Hunk"},
            o = {"<cmd>Telescope git_status<cr>", "Open changed file"},
            b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
            c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
            C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"},
        },
        l = {
            name = "+LSP",
            f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"},
            i = {"<cmd>LspInfo<cr>", "Info"},
            a = {
                name = "+Code Action",
                l = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Line Code Action"},
                r = {"<cmd>lua vim.lsp.buf.range_code_action()<cr>", "Range Code Action"}
            },
            g = {
                name = "+Go To",
                d = {"<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition"},
                D = {"<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration"},
                i = {"<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation"},
                r = {"<cmd>lua vim.lsp.buf.references()<CR>", "References"}
            },
            d = {
                name = "+Diagnostics",
                l = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
                    "Line Diagnostics"},
                f = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "File Diagnostics"},
                ["["] = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Next Diagnostic"},
                ["]"] = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Previous Diagnostic"},
            },
            p = {
                name = "+Preview",
                d = {"<cmd>Lspsaga preview_definition<CR>", "Definition"}
            },
            q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
            r = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
            t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
            x = {"<cmd>cclose<cr>", "Close Quickfix"},
            s = {"<cmd>SymbolsOutline<CR>", "Show Symbols"}
        },
        r = {
            name = "+Rename",
            f = {"<cmd>lua require('spectre').open_file_search()<cr>", "Current File"},
            p = {"<cmd>lua require('spectre').open()<cr>", "Project"}
        },
        s = {
            name = "+Search",
            b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
            c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
            d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
            D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
            f = {"<cmd>Telescope find_files<cr>", "Find File"},
            m = {"<cmd>Telescope marks<cr>", "Marks"},
            M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
            r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
            R = {"<cmd>Telescope registers<cr>", "Registers"},
            t = {"<cmd>Telescope live_grep<cr>", "Text"},
            s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
            S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"}
        },
        S = {name = "+Session", s = {"<cmd>SessionSave<cr>", "Save Session"}, l = {"<cmd>SessionLoad<cr>", "Load Session"}},

    }

    local wk = require("which-key")
    wk.register(mappings, opts)
end


function config.tmux()
    vim.g.tmux_navigator_save_on_switch = 2
end


function config.spectre()
    if not packer_plugins['plenary.nvim'].loaded or
        not packer_plugins['popup.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
        vim.cmd [[packadd popup.nvim]]
    end
    require('spectre').setup({
        color_devicons = true,
        line_sep_start = '-----------------------------------------',
        result_padding = '|  ',
        line_sep = '-----------------------------------------',
        highlight = {
            ui = "String",
            search = "DiffChange",
            replace = "DiffDelete"
        },
        mapping = {
            ['toggle_line'] = {
                map = "dd",
                cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
                desc = "toggle current item"
            },
            ['enter_file'] = {
                map = "<cr>",
                cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
                desc = "goto current file"
            },
            ['send_to_qf'] = {
                map = "<Blash>q",
                cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                desc = "send all item to quickfix"
            },
            ['replace_cmd'] = {
                map = "<Bslash>c",
                cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
                desc = "input replace vim command"
            },
            ['show_option_menu'] = {
                map = "<Bslash>o",
                cmd = "<cmd>lua require('spectre').show_options()<CR>",
                desc = "show option"
            },
            ['run_replace'] = {
                map = "<Bslash>R",
                cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                desc = "replace all"
            },
            ['change_view_mode'] = {
                map = "<Bslash>v",
                cmd = "<cmd>lua require('spectre').change_view()<CR>",
                desc = "change result view mode"
            },
            ['toggle_ignore_case'] = {
                map = "ti",
                cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
                desc = "toggle ignore case"
            },
            ['toggle_ignore_hidden'] = {
                map = "th",
                cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
                desc = "toggle search hidden"
            },
        },
        find_engine = {
            -- rg is map with finder_cmd
            ['rg'] = {
                cmd = "rg",
                -- default args
                args = {
                    '--color=never', '--no-heading', '--with-filename',
                    '--line-number', '--column'
                },
                options = {
                    ['ignore-case'] = {
                        value = "--ignore-case",
                        icon = "[I]",
                        desc = "ignore case"
                    },
                    ['hidden'] = {
                        value = "--hidden",
                        desc = "hidden file",
                        icon = "[H]"
                    }
                    -- you can put any option you want here it can toggle with
                    -- show_option function
                }
            },
            ['ag'] = {
                cmd = "ag",
                args = {'--vimgrep', '-s'},
                options = {
                    ['ignore-case'] = {
                        value = "-i",
                        icon = "[I]",
                        desc = "ignore case"
                    },
                    ['hidden'] = {
                        value = "--hidden",
                        desc = "hidden file",
                        icon = "[H]"
                    }
                }
            }
        },
        replace_engine = {
            ['sed'] = {cmd = "sed", args = nil},
            options = {
                ['ignore-case'] = {
                    value = "--ignore-case",
                    icon = "[I]",
                    desc = "ignore case"
                }
            }
        },
        default = {
            find = {
                -- pick one of item in find_engine
                cmd = "rg",
                options = {"ignore-case"}
            },
            replace = {
                -- pick one of item in replace_engine
                cmd = "sed"
            }
        },
        replace_vim_cmd = "cfdo",
        is_open_target_win = true, -- open file on opener window
        is_insert_mode = false -- start open panel on is_insert_mode
    })
end


return config
