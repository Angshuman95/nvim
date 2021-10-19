local config = {}

function config.cmp()
    local cmp = require('cmp')

    local lsp_symbols = {
        Text = '   (Text) ',
        Method = '   (Method)',
        Function = '   (Function)',
        Constructor = '   (Constructor)',
        Field = ' ﴲ  (Field)',
        Variable = '[] (Variable)',
        Class = '   (Class)',
        Interface = ' ﰮ  (Interface)',
        Module = '   (Module)',
        Property = ' 襁 (Property)',
        Unit = '   (Unit)',
        Value = '   (Value)',
        Enum = ' 練 (Enum)',
        Keyword = '   (Keyword)',
        Snippet = '   (Snippet)',
        Color = '   (Color)',
        File = '   (File)',
        Reference = '   (Reference)',
        Folder = '   (Folder)',
        EnumMember = '   (EnumMember)',
        Constant = ' ﲀ  (Constant)',
        Struct = ' ﳤ  (Struct)',
        Event = '   (Event)',
        Operator = '   (Operator)',
        TypeParameter = '   (TypeParameter)'
    }

    cmp.setup {
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            }),
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
            ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})
        },
        formatting = {
            format = function(entry, item)
                item.kind = lsp_symbols[item.kind]
                item.menu = ({
                    nvim_lsp = '[LSP]',
                    buffer = '[Buffer]',
                    path = '[Path]',
                    vsnip = '[Vsnip]'
                })[entry.source.name]
                return item
            end
        },
        sources = {
            { name = 'nvim_lsp' }, { name = 'vsnip' }, { name = 'path' },
            { name = 'buffer' }
        },
        snippet = {
            expand = function(args)
                vim.fn['vsnip#anonymous'](args.body)
            end
        }
    }
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
