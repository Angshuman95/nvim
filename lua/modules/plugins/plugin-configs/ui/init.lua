local config = {}


function config.color()
    vim.g.nvcode_termcolors=256
    vim.cmd('colorscheme nvcode')
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
        a = { description = { '  Projects           ' },
                command = 'Telescope project' },
        b = { description = { '  Find File          ' },
                command = 'Telescope find_files' },
        c = { description = { '  Recently Used Files' },
                command = 'Telescope oldfiles' },
        d = { description = { '  Load Last Session  ' },
                command = 'SessionLoad' },
        e = { description = { '  Find Word          ' },
                command = 'Telescope live_grep' },
        f = { description = { '  Settings           ' },
                command = ':vs ' .. '$HOME/.config/nvim/lua/config/options.lua' }
    }
end


function config.galaxyline()
    local gl = require("galaxyline")
    local colors = {
        bg = '#292D38',
        fg = "#D9DA9E",
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
    local condition = require("galaxyline.condition")
    local gls = gl.section
    gl.short_line_list = {
        "NvimTree", "vista", "dbui", "packer"
    }
    gls.left[1] = {
        ViMode = {
            provider = function()
                -- auto change color according the vim mode
                local alias = {
                    n = "NORMAL",
                    v = "VISUAL",
                    V = "V-LINE",
                    [""] = "V-BLOCK",
                    s = "SELECT",
                    S = "S-LINE",
                    [""] = "S-BLOCK",
                    i = "INSERT",
                    R = "REPLACE",
                    c = "COMMAND",
                    r = "PROMPT",
                    ["!"] = "EXTERNAL",
                    t = "TERMINAL"
                }
                local mode_color = {
                    n = colors.blue,
                    v = colors.purple,
                    V = colors.purple,
                    [""] = colors.purple,
                    s = colors.orange,
                    S = colors.orange,
                    [""] = colors.orange,
                    i = colors.green,
                    R = colors.red,
                    c = colors.blue,
                    r = colors.cyan,
                    ["!"] = colors.blue,
                    t = colors.blue
                }
                local vim_mode = vim.fn.mode()
                vim.api.nvim_command("hi GalaxyViMode guifg=" ..
                                         mode_color[vim_mode])
                return alias[vim_mode] .. "    "
            end,
            highlight = {colors.red, colors.bg, "bold"}
        }
    }
    gls.left[2] = {
        FileIcon = {
            provider = "FileIcon",
            condition = condition.buffer_not_empty,
            highlight = {colors.fg, colors.bg}
        }
    }
    gls.left[3] = {
        FileName = {
            provider = {"FileName"},
            condition = condition.buffer_not_empty,
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.fg, colors.bg}
        }
    }
    gls.left[4] = {
        GitIcon = {
            provider = function() return "  " end,
            condition = condition.check_git_workspace,
            -- separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.orange, colors.bg}
        }
    }
    gls.left[5] = {
        GitBranch = {
            provider = "GitBranch",
            condition = condition.check_git_workspace,
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.grey, colors.bg}
        }
    }
    gls.left[6] = {
        DiffAdd = {
            provider = "DiffAdd",
            condition = condition.hide_in_width,
            icon = "   ",
            highlight = {colors.green, colors.bg}
        }
    }
    gls.left[7] = {
        DiffModified = {
            provider = "DiffModified",
            condition = condition.hide_in_width,
            icon = "   ",
            highlight = {colors.blue, colors.bg}
        }
    }
    gls.left[8] = {
        DiffRemove = {
            provider = "DiffRemove",
            condition = condition.hide_in_width,
            icon = "   ",
            highlight = {colors.red, colors.bg}
        }
    }
    gls.right[1] = {
        DiagnosticError = {
            provider = "DiagnosticError",
            icon = "  ",
            highlight = {colors.error_red, colors.bg}
        }
    }
    gls.right[2] = {
        DiagnosticWarn = {
            provider = "DiagnosticWarn",
            icon = "  ",
            highlight = {colors.orange, colors.bg}
        }
    }
    gls.right[3] = {
        DiagnosticHint = {
            provider = "DiagnosticHint",
            icon = "  ",
            highlight = {colors.vivid_blue, colors.bg}
        }
    }
    gls.right[4] = {
        DiagnosticInfo = {
            provider = "DiagnosticInfo",
            icon = "  ",
            highlight = {colors.info_yellow, colors.bg}
        }
    }

    gls.right[5] = {
        TreesitterIcon = {
            provider = function()
                if next(vim.treesitter.highlighter.active) ~= nil then return ' ' end
                return ''
            end,
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            highlight = {colors.green, colors.bg}
        }
    }

    gls.right[6] = {
        ShowLspClient = {
            provider = "GetLspClient",
            condition = function()
                local tbl = {["dashboard"] = true, [" "] = true}
                if tbl[vim.bo.filetype] then return false end
                return true
            end,
            icon = "   ",
            highlight = {colors.grey, colors.bg}
        }
    }

    gls.right[7] = {
        LineInfo = {
            provider = "LineColumn",
            separator = "  ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.grey, colors.bg}
        }
    }

    gls.right[8] = {
        PerCent = {
            provider = "LinePercent",
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.grey, colors.bg}
        }
    }

    gls.right[9] = {
        Tabstop = {
            provider = function()
                return
                    "Spaces: " .. vim.api.nvim_buf_get_option(0, "tabstop") ..
                        " "
            end,
            condition = condition.hide_in_width,
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.grey, colors.bg}
        }
    }

    gls.right[10] = {
        BufferType = {
            provider = "FileTypeName",
            condition = condition.hide_in_width,
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.grey, colors.bg}
        }
    }

    gls.right[11] = {
        FileEncode = {
            provider = "FileEncode",
            condition = condition.hide_in_width,
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.grey, colors.bg}
        }
    }

    gls.right[12] = {
        Space = {
            provider = function() return " " end,
            separator = " ",
            separator_highlight = {"NONE", colors.bg},
            highlight = {colors.grey, colors.bg}
        }
    }

    gls.short_line_left[1] = {
        SFileName = {
            provider = "SFileName",
            condition = condition.buffer_not_empty,
            highlight = {colors.fg, colors.bg}
        }
    }

    gls.short_line_right[1] = {
        BufferIcon = {
            provider = "BufferIcon",
            highlight = {colors.fg, colors.bg}
        }
    }

    gls.short_line_right[2] = {
        BufferType = {
            provider = 'FileTypeName',
            separator = ' ',
            separator_highlight = {'NONE', colors.bg},
            highlight = {colors.grey, colors.bg}
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
    vim.g.nvim_tree_disable_netrw = 0
    vim.g.nvim_tree_hide_dotfiles = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_lsp_diagnostics = 1
    vim.g.nvim_tree_auto_close = true
    vim.g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}
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
