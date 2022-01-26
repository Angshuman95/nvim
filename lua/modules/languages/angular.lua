local data_dir = vim.fn.stdpath('data')
local languageServerPath = data_dir .. "/lsp_servers/angularls"
local lsp = require('modules.lsp')

local tsProbeLoc = data_dir .. "/lsp_servers/tsserver/node_modules"

local cmd = {
    "node",
    languageServerPath .. "/node_modules/@angular/language-server/index.js",
    "--stdio", "--tsProbeLocations", tsProbeLoc, "--ngProbeLocations",
    languageServerPath .. "/node_modules/@angular/language-server/node_modules/@angular"
}

require'lspconfig'.angularls.setup {
    cmd = cmd,
    on_attach = lsp.enhance_attach,
    capabilities = lsp.capabilities,
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd = cmd
    end,
    root_dir = require'lspconfig'.util.root_pattern('angular.json', '.git')
}
