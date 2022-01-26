local pid = vim.fn.getpid()
local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

local omnisharp_bin = data_dir .. "/lsp_servers/omnisharp/omnisharp/run"

require'lspconfig'.omnisharp.setup {
    cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid)},
    on_attach = lsp.enhance_attach,
    capabilities = lsp.capabilities,
    filetypes = {"cs", "vb"},
    init_options = {},
    autostart = true,
    root_dir = require'lspconfig'.util.root_pattern("*.csproj", "*.sln")
}

require('dap').adapters.netcoredbg = {
    type = 'executable',
    command = vim.fn.stdpath('data') ..
        '/dapinstall/dnetcs_dbg/netcoredbg/netcoredbg',
    args = {'--interpreter=vscode'}
}

require('dap').configurations.cs = {
    {
        type = "netcoredbg",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/',
                                'file')
        end
    }
}
