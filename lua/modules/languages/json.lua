local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

require'lspconfig'.jsonls.setup {
    cmd = {
        "node", data_dir ..
            "/lsp_servers/jsonls/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server",
        "--stdio"
    },
    on_attach = lsp.common_on_attach,
    capabilities = lsp.capabilities,

    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
            end
        }
    }
}
