local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

require'lspconfig'.tsserver.setup {
    cmd = { data_dir .. '/lspinstall/typescript/node_modules/.bin/typescript-language-server',
        '--stdio' },
    on_attach = lsp.enhance_attach,
    root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json",
        "jsconfig.json", ".git")
}
