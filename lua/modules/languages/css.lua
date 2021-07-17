local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
    cmd = {
        "node", data_dir ..
            "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
        "--stdio"
    },
    on_attach = lsp.common_on_attach,
    capabilities = capabilities
}
