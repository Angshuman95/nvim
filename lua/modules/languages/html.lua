local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

local capabilities = lsp.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
    cmd = {
        'node', data_dir ..
            '/lsp_servers/html/node_modules/vscode-langservers-extracted/bin/vscode-html-language-server',
        '--stdio'
    },
    on_attach = lsp.enhance_attach,
    capabilities = capabilities
}
