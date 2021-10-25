local config = {}

function config.color()
    -- NVCode
    -- vim.g.nvcode_termcolors = 256
    -- vim.cmd('colorscheme nvcode')

    -- VSCode
    -- vim.g.vscode_style = 'dark'
    -- vim.cmd('colorscheme vscode')

    -- GruvBox
    vim.o.background = 'dark' -- 'light' or 'dark'
    vim.g.gruvbox_contrast_dark = 'hard' -- 'hard' 'medium' or 'low'
    vim.g.gruvbox_italic = 1
    vim.cmd('colorscheme gruvbox')
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
                ["NvimTree"] = true,
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
            theme = 'gruvbox',
            -- theme = 'onedark',
            -- theme = 'vscode',
            -- theme = 'codedark',
            section_separators = { left = '', right = '' },
            -- component_separators = { left = '', right = '' },
            component_separators = "",
            disabled_filetypes = {}
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {
                {
                    'filename',
                    cond = conditions.check_filetype
                },
                {
                    -- filesize component
                    function()
                        local function format_file_size(file)
                            local size = vim.fn.getfsize(file)
                            if size <= 0 then
                                return ''
                            end
                            local sufixes = {'b', 'k', 'm', 'g'}
                            local i = 1
                            while size > 1024 do
                                size = size / 1024
                                i = i + 1
                            end
                            return string.format('%.1f%s', size, sufixes[i])
                        end
                        local file = vim.fn.expand('%:p')
                        if string.len(file) == 0 then
                            return ''
                        end
                        return format_file_size(file)
                    end,
                    color = {fg = colors.grey},
                    cond = conditions.hide_in_width
                },
                {
                    'diff',
                    colored = true,
                    symbols = {
                        added = '  ',
                        modified = '  ',
                        removed = '  '
                    },
                    color_added = colors.green,
                    color_modified = colors.blue,
                    color_removed = colors.red
                },
                {
                    -- Put the next section in the middle
                    function() return '%=' end
                },
                {
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
                    sources = {"nvim_lsp"},
                    symbols = {
                        error = '  ',
                        warn = '  ',
                        info = '  ',
                        hint = '  '
                    },
                    color_error = colors.error_red,
                    color_warn = colors.orange,
                    color_hint = colors.info_yellow,
                    color_info = colors.vivid_blue
                },
                {
                    'encoding',
                    color = {fg = colors.green},
                    cond = conditions.hide_in_width
                },
                {
                    'fileformat',
                    cond = conditions.hide_in_width
                },
                {
                    'filetype',
                    cond = conditions.hide_in_width
                }
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

function config.tree()
    vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
    vim.g.nvim_tree_hide_dotfiles = 1
    vim.g.nvim_tree_git_hl = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_highlight_opened_files = 1
    vim.g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 0
    }
    vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
        git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "➜",
            untracked = "",
            ignored = "◌"
        },
        folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = ""
        }
    }
    require('nvim-tree').setup {
        disable_netrw = false,
        auto_close = true,
        ignore_ft_on_setup = { 'startify', 'dashboard' },
        diagnostics = {
            enable = true,
            icons = { hint = "", info = "", warning = "", error = "" }
        },
        update_focused_file = { enable = true, update_cwd = true }
    }
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
