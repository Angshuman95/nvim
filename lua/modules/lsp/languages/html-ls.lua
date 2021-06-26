local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
    cmd = { 'node', data_dir .. '/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js', '--stdio' },
    on_attach = lsp.enhance_attach,
    capabilities = capabilities
}
