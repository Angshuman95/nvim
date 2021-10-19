local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

require'lspconfig'.bashls.setup {
    cmd = {
        data_dir .. "/lspinstall/bash/node_modules/.bin/bash-language-server",
        "start"
    },
    on_attach = lsp.common_on_attach,
    capabilities = lsp.capabilities,
    filetypes = {"sh", "zsh"}
}
