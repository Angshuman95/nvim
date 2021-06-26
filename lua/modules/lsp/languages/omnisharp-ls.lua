local pid = vim.fn.getpid()
local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

local omnisharp_bin = data_dir .. "/lspinstall/csharp/omnisharp/run"

require'lspconfig'.omnisharp.setup {
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
    on_attach = lsp.enhance_attach,
    filetypes = {"cs", "vb"},
    init_options = {};
    autostart = true;
    root_dir = require'lspconfig'.util.root_pattern("*.csproj", "*.sln");
}
