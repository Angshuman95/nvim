local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

require'lspconfig'.pyright.setup {
    cmd = { data_dir .. "/lspinstall/python/node_modules/.bin/pyright-langserver", "--stdio" },
    on_attach = lsp.common_on_attach,
	settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    }
}
