local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

local capabilities = lsp.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
    cmd = {
        "node", data_dir ..
            "/lsp_servers/cssls/node_modules/vscode-langservers-extracted/bin/vscode-css-language-server",
        "--stdio"
    },
    on_attach = lsp.common_on_attach,
    capabilities = capabilities
}
