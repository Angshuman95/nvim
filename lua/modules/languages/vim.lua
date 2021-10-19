local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

require'lspconfig'.vimls.setup {
    cmd = {
        data_dir .. "/lspinstall/vim/node_modules/.bin/vim-language-server",
        "--stdio"
    },
    on_attach = lsp.common_on_attach,
    capabilities = lsp.capabilities
}
