local data_dir = vim.fn.stdpath('data')
local languageServerPath = data_dir .. "/lspinstall/angular"
local lsp = require('modules.lsp')

local tsProbeLoc = data_dir .. "/lspinstall/typescript/node_modules"

local cmd = { "node", languageServerPath .. "/node_modules/@angular/language-server/index.js",
                "--stdio", "--tsProbeLocations", tsProbeLoc, "--ngProbeLocations",
                languageServerPath }

require'lspconfig'.angularls.setup {
    cmd = cmd,
    on_attach = lsp.enhance_attach,
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd = cmd
    end
}
