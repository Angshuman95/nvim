local config = {}

function config.colorize()
    require"colorizer".setup({"*"}, {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        names = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true
    })
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
        icons = {breadcrumb = "»", separator = "➜", group = "+"},
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
        hidden = {
            "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "
        },
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
    vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>",
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap("v", "<leader>lf", ":Neoformat<CR>",
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-f>',
                            '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>',
                            {noremap = true})
    vim.api.nvim_set_keymap('n', '<C-b>',
                            '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>',
                            {noremap = true})

    vim.api.nvim_buf_set_keymap(0, 'v', '<leader>ljav',
                                '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>',
                                {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'v', '<leader>ljam',
                                '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>',
                                {noremap = true, silent = true})

    local mappings = {
        [';'] = {"<cmd>Dashboard<CR>", "Dashboard"},
        ["/"] = {"<cmd>CommentToggle<CR>", "Comment"},
        ["b"] = {"<cmd>Telescope buffers<CR>", "Buffers"},
        ["e"] = {"<cmd>NvimTreeToggle<CR>", "Explorer"},
        ["f"] = {"<cmd>Telescope find_files<CR>", "Find Files"},
        ["h"] = {"<cmd>set hlsearch!<CR>", "No Highlight"},
        ["m"] = {"<cmd>MaximizerToggle<CR>", "Maximize"},
        ["p"] = {"<cmd>Telescope project<CR>", "Projects"},
        ["."] = {
            name = "+Virtual Text",
            s = {
                "<cmd>lua require('modules.lsp.virtualtext').show()<CR>", "Show"
            },
            h = {
                "<cmd>lua require('modules.lsp.virtualtext').hide()<CR>", "Hide"
            }
        },
        d = {
            name = "+Debug",
            b = {
                "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
                "Toggle Breakpoint <A-b>"
            },
            c = {
                "<cmd>lua require'dap'.continue()<CR>",
                "Continue or Start <A-h>"
            },
            i = {"<cmd>lua require'dap'.step_into()<CR>", "Step Into <A-j>"},
            o = {"<cmd>lua require'dap'.step_over()<CR>", "Step over <A-l>"},
            O = {"<cmd>lua require'dap'.step_out()<CR>", "Step Out <A-k>"}
        },
        D = {
            name = "+Database",
            u = {"<cmd>DBUIToggle<CR>", "UI Toggle"},
            f = {"<cmd>DBUIFindBuffer<CR>", "Find Buffer"},
            r = {"<cmd>DBUIRenameBuffer<CR>", "Rename Buffer"},
            l = {"<cmd>DBUILastQueryInfo<CR>", "Last Query"}
        },
        g = {
            name = "+Git",
            g = {"<Esc><cmd>:Git<cr>", "Git Status"},
            j = {"<cmd>Gitsigns next_hunk<cr>", "Next Hunk"},
            k = {"<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk"},
            p = {"<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk"},
            r = {"<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk"},
            R = {"<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer"},
            s = {"<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk"},
            u = {"<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk"},
            B = {"<cmd>Gitsigns toggle_current_line_blame<cr>", "Blame"},
            d = {"<cmd>Gdiffsplit<cr>", "Split Diff"},
            f = {"<cmd>Telescope git_status<cr>", "Search changed files"},
            b = {"<cmd>Telescope git_branches<cr>", "Search branchs"},
            c = {"<cmd>Telescope git_commits<cr>", "Search commits"},
            C = {
                "<cmd>Telescope git_bcommits<cr>",
                "Search commits(for current file)"
            }
        },
        l = {
            name = "+LSP",
            f = {"<cmd>Neoformat<cr>", "Format File"},
            i = {"<cmd>LspInfo<cr>", "Info"},
            a = {
                name = "+Code Action",
                l = {
                    "<cmd>lua vim.lsp.buf.code_action()<cr>", "Line Code Action"
                },
                r = {
                    "<cmd>lua vim.lsp.buf.range_code_action()<cr>",
                    "Range Code Action"
                }
            },
            g = {
                name = "+Go To",
                d = {
                    "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition <A-d>"
                },
                D = {
                    "<Cmd>lua vim.lsp.buf.declaration()<CR>",
                    "Declaration <A-D>"
                },
                i = {
                    "<cmd>lua vim.lsp.buf.implementation()<CR>",
                    "Implementation <A-i>"
                },
                r = {
                    "<cmd>lua vim.lsp.buf.references()<CR>", "References <A-r>"
                },
                s = {
                    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                    "Signature Help"
                }
            },
            d = {
                name = "+Diagnostics",
                l = {
                    "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
                    "Line Diagnostics"
                },
                f = {
                    "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
                    "File Diagnostics"
                },
                ["["] = {
                    "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
                    "Next Diagnostic"
                },
                ["]"] = {
                    "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
                    "Previous Diagnostic"
                }
            },
            j = {
                name = "+Java - jdtls",
                a = {
                    name = "Extract - visual mode",
                    v = 'Variable',
                    m = 'method'
                },
                i = {
                    "<Cmd>lua require'jdtls'.organize_imports()<CR>",
                    "Organize Imports"
                },
                v = {
                    "<Cmd>lua require('jdtls').extract_variable()<CR>",
                    "Extract Variable"
                },
                R = {
                    "<Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>",
                    "Refactor"
                }
            },
            p = {
                name = "+Preview",
                d = {"<cmd>Lspsaga preview_definition<CR>", "Definition <A-p>"}
            },
            q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
            r = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
            t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
            x = {"<cmd>cclose<cr>", "Close Quickfix"},
            s = {"<cmd>SymbolsOutline<CR>", "Show Symbols"}
        },
        r = {
            name = "+Rename",
            f = {
                "<cmd>lua require('spectre').open_file_search()<cr>",
                "Current File"
            },
            p = {"<cmd>lua require('spectre').open()<cr>", "Project"}
        },
        s = {
            name = "+Search",
            c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
            d = {
                "<cmd>Telescope lsp_document_diagnostics<cr>",
                "Document Diagnostics"
            },
            D = {
                "<cmd>Telescope lsp_workspace_diagnostics<cr>",
                "Workspace Diagnostics"
            },
            f = {
                "<cmd>Telescope current_buffer_fuzzy_find<cr>",
                "Fuzzy Find (Current File)"
            },
            m = {"<cmd>Telescope marks<cr>", "Marks"},
            M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
            r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
            R = {"<cmd>Telescope registers<cr>", "Registers"},
            t = {"<cmd>Telescope live_grep<cr>", "Text"},
            s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
            S = {
                "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                "Workspace Symbols"
            }
        },
        S = {
            name = "+Session",
            s = {"<cmd>SessionSave<cr>", "Save Session"},
            l = {"<cmd>SessionLoad<cr>", "Load Session"}
        },
        t = {
            name = "+Terminal",
            g = {"<Cmd>FloatermNew lazygit<CR>", "Git"},
            n = {"<Cmd>FloatermNew lazynode<CR>", "Node"}
        }
    }

    local wk = require("which-key")
    wk.register(mappings, opts)
end

local function load_env_file()
    local env_file = os.getenv("HOME") .. '/.env'
    local env_contents = {}
    if vim.fn.filereadable(env_file) ~= 1 then
        print('.env file does not exist')
        return
    end
    local contents = vim.fn.readfile(env_file)
    for _, item in pairs(contents) do
        local line_content = vim.fn.split(item, "=")
        env_contents[line_content[1]] = line_content[2]
    end
    return env_contents
end

local function load_dbs()
    local env_contents = load_env_file()
    local dbs = {}
    for key, value in pairs(env_contents) do
        if vim.fn.stridx(key, "DB_CONNECTION_") >= 0 then
            local db_name = vim.fn.split(key, "_")[3]:lower()
            dbs[db_name] = value
        end
    end
    return dbs
end

function config.vim_dadbod_ui()
    if packer_plugins["vim-dadbod"] and not packer_plugins["vim-dadbod"].loaded then
        vim.cmd [[packadd vim-dadbod]]
    end
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_winwidth = 35
    vim.g.db_ui_auto_execute_table_helpers = true
    vim.g.db_ui_save_location = os.getenv("HOME") .. "/.cache/vim/db_ui_queries"
    vim.g.dbs = load_dbs()
end

function config.tmux() vim.g.tmux_navigator_save_on_switch = 2 end

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
            }
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
