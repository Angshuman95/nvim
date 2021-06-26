local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

require'lspconfig'.clangd.setup {
    cmd = { data_dir .. '/lspinstall/cpp/clangd/bin/clangd' },
    on_attach = lsp.enhance_attach
}
