local config = {}

function config.color()
    -- NVCode
    -- vim.g.nvcode_termcolors = 256
    -- vim.cmd('colorscheme nvcode')

    -- VSCode
    -- vim.g.vscode_style = 'dark'
    -- vim.cmd('colorscheme vscode')

    -- GruvBox
    -- vim.o.background = 'dark' -- 'light' or 'dark'
    -- vim.g.gruvbox_contrast_dark = 'hard' -- 'hard' 'medium' or 'low'
    -- vim.g.gruvbox_italic = 1
    -- vim.cmd('colorscheme gruvbox')

    -- OneDark
    require('onedark').setup {style = 'warmer'}
    require('onedark').load()
end

function config.dashboard()
    vim.g.dashboard_custom_header = {
        '                                                       ',
        ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
        ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
        ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
        ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
        ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
        ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
        '                                                       '
    }
    vim.g.dashboard_default_executive = 'telescope'
    vim.g.dashboard_custom_section = {
        a = {
            description = {'  New File           '},
            command = 'DashboardNewFile'
        },
        b = {
            description = {'  Projects           '},
            command = 'Telescope project'
        },
        c = {
            description = {'  Find File          '},
            command = 'Telescope find_files'
        },
        d = {
            description = {'  Recently Used Files'},
            command = 'Telescope oldfiles'
        },
        e = {
            description = {'  Load Last Session  '},
            command = 'SessionLoad'
        },
        f = {
            description = {'  Find Word          '},
            command = 'Telescope live_grep'
        },
        g = {
            description = {'  Settings           '},
            command = 'Telescope vim_options'
        }
    }
end

function config.lualine()
    local colors = {
        bg = '#292D38',
        fg = '#D9DA9E',
        yellow = '#DCDCAA',
        dark_yellow = '#D7BA7D',
        cyan = '#4EC9B0',
        green = '#608B4E',
        light_green = '#B5CEA8',
        string_orange = '#CE9178',
        orange = '#FF8800',
        purple = '#C586C0',
        magenta = '#D16D9E',
        grey = '#858585',
        blue = '#569CD6',
        vivid_blue = '#4FC1FF',
        light_blue = '#9CDCFE',
        red = '#D16969',
        error_red = '#F44747',
        info_yellow = '#FFCC66'
    }

    local conditions = {
        buffer_not_empty = function()
            return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        hide_in_width = function() return vim.fn.winwidth(0) > 120 end,
        check_filetype = function()
            local tbl = {
                ["dashboard"] = true,
                ["packer"] = true,
                ["spectre_panel"] = true,
                ["Outline"] = true,
                ["fugitive"] = true,
                ["gitcommit"] = true,
                ["Trouble"] = true,
                [" "] = true
            }
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        check_git_workspace = function()
            local filepath = vim.fn.expand('%:p:h')
            local gitdir = vim.fn.finddir('.git', filepath .. ';')
            return gitdir and #gitdir > 0 and #gitdir < #filepath
        end
    }

    require('lualine').setup {
        options = {
            icons_enabled = true,
            always_divide_middle = true,
            -- theme = 'gruvbox',
            theme = 'onedark',
            -- theme = 'vscode',
            -- theme = 'codedark',
            section_separators = {left = '', right = ''},
            -- component_separators = { left = '', right = '' },
            component_separators = "",
            disabled_filetypes = {}
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {
                {'filename', cond = conditions.check_filetype}, {
                    -- filesize component
                    'filesize',
                    conditions = conditions.buffer_not_empty
                }, {
                    'diff',
                    colored = true,
                    symbols = {
                        added = '  ',
                        modified = '  ',
                        removed = '  '
                    },
                    diff_color = {
                        added = {fg = colors.green},
                        modified = {fg = colors.blue},
                        removed = {fg = colors.red}
                    }
                }, {
                    -- Put the next section in the middle
                    function() return '%=' end
                }, {
                    -- Lsp server name .
                    function()
                        if not conditions.check_filetype() then
                            return ''
                        end
                        local msg = 'No Active Lsp'
                        local buf_ft = vim.api
                                           .nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~=
                                -1 then
                                return client.name
                            end
                        end
                        return msg
                    end,
                    icon = ' ',
                    color = {fg = colors.grey, gui = 'bold'},
                    cond = conditions.hide_in_width
                }
            },
            lualine_x = {
                {
                    'diagnostics',
                    sources = {"nvim_diagnostic"},
                    colored = true,
                    sections = {'error', 'warn', 'info', 'hint'},
                    symbols = {
                        error = '  ',
                        warn = '  ',
                        info = '  ',
                        hint = '  '
                    },
                    diagnostic_color = {
                        error = {fg = colors.error_red},
                        warn = {fg = colors.orange},
                        hint = {fg = colors.info_yellow},
                        info = {fg = colors.vivid_blue}
                    }
                },
                {
                    'o:encoding',
                    color = {fg = colors.green},
                    cond = conditions.hide_in_width
                }, {'fileformat', cond = conditions.hide_in_width},
                {'filetype', cond = conditions.hide_in_width}
            },
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        }
    }
end

function config.indent_blankline()
    vim.g.indent_blankline_char = "▏"
    vim.g.indent_blankline_show_first_indent_level = true
    vim.g.indent_blankline_filetype_exclude = {
        "startify", "dashboard", "dotooagenda", "log", "fugitive", "gitcommit",
        "packer", "vimwiki", "markdown", "json", "txt", "vista", "help",
        "todoist", "NvimTree", "peekaboo", "git", "TelescopePrompt", "undotree",
        "flutterToolsOutline"
    }
    vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_context_patterns = {
        "class", "function", "method", "block", "list_literal", "selector",
        "^if", "^table", "if_statement", "while", "for"
    }
    vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
end

function config.neotree()
    vim.fn.sign_define("DiagnosticSignError",
                       {text = " ", texthl = "DiagnosticSignError"})
    vim.fn.sign_define("DiagnosticSignWarn",
                       {text = " ", texthl = "DiagnosticSignWarn"})
    vim.fn.sign_define("DiagnosticSignInfo",
                       {text = " ", texthl = "DiagnosticSignInfo"})
    vim.fn.sign_define("DiagnosticSignHint",
                       {text = "", texthl = "DiagnosticSignHint"})

    require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
            indent = {
                indent_size = 2,
                padding = 1, -- extra padding on left hand side
                -- indent guides
                with_markers = true,
                indent_marker = "│",
                last_indent_marker = "└",
                highlight = "NeoTreeIndentMarker",
                -- expander config, needed for nesting files
                with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander"
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "ﰊ",
                default = "*"
            },
            name = {trailing_slash = false, use_git_status_colors = true},
            git_status = {
                symbols = {
                    -- Change type
                    added = "✚",
                    deleted = "✖",
                    modified = "",
                    renamed = "",
                    -- Status type
                    untracked = "",
                    ignored = "",
                    unstaged = "",
                    staged = "",
                    conflict = ""
                }
            }
        },
        window = {
            position = "left",
            width = 30,
            mappings = {
                ["<space>"] = "toggle_node",
                ["<2-LeftMouse>"] = "open",
                ["<cr>"] = "open",
                ["S"] = "open_split",
                ["s"] = "open_vsplit",
                ["C"] = "close_node",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["R"] = "refresh",
                ["/"] = "fuzzy_finder",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["a"] = "add",
                ["A"] = "add_directory",
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["c"] = "copy", -- takes text input for destination
                ["m"] = "move", -- takes text input for destination
                ["q"] = "close_window"
            }
        },
        nesting_rules = {},
        filesystem = {
            filtered_items = {
                visible = false, -- when true, they will just be displayed differently than normal items
                hide_dotfiles = true,
                hide_gitignored = true,
                hide_by_name = {
                    ".DS_Store", "thumbs.db"
                    -- "node_modules"
                },
                never_show = { -- remains hidden even if visible is toggled to true
                    -- ".DS_Store",
                    -- "thumbs.db"
                }
            },
            follow_current_file = true, -- This will find and focus the file in the active buffer every
            -- time the current file is changed while the tree is open.
            hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
            -- in whatever position is specified in window.position
            -- "open_current",  -- netrw disabled, opening a directory opens within the
            -- window like netrw would, regardless of window.position
            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = false -- This will use the OS level file watchers to detect changes
            -- instead of relying on nvim autocmd events.
        },
        buffers = {
            show_unloaded = true,
            window = {mappings = {["bd"] = "buffer_delete"}}
        },
        git_status = {
            window = {
                position = "float",
                mappings = {
                    ["A"] = "git_add_all",
                    ["gu"] = "git_unstage_file",
                    ["ga"] = "git_add_file",
                    ["gr"] = "git_revert_file",
                    ["gc"] = "git_commit",
                    ["gp"] = "git_push",
                    ["gg"] = "git_commit_and_push"
                }
            }
        }
    })
end

function config.floaterm()
    vim.g.floaterm_keymap_toggle = "<F1>"
    vim.g.floaterm_keymap_next = "<F2>"
    vim.g.floaterm_keymap_prev = "<F3>"
    vim.g.floaterm_keymap_new = "<F4>"
    vim.g.floaterm_keymap_kill = "<F12>"
    vim.g.floaterm_title = "Floaterm ($1/$2)"
    vim.g.floaterm_shell = vim.o.shell
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_wintitle = 0
    vim.g.floaterm_autoclose = 1
end

return config
