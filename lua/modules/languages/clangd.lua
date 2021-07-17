local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

require'lspconfig'.clangd.setup {
    cmd = { data_dir .. '/lspinstall/cpp/clangd/bin/clangd' },
    on_attach = lsp.enhance_attach
}

require('dap').adapters.cpp = {
    type = "executable",
    attach = {pidProperty = "pid", pidSelect = "ask"},
    command = "lldb-vscode",
    name = "lldb"
}

require('dap').configurations.cpp = {
    {
        type = "cpp",
        request = "launch",
        name = "Launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = {},
        cwd = "${workspaceFolder}",
        env = function()
            local variables = {}
            for k, v in pairs(vim.fn.environ()) do
                table.insert(variables, string.format("%s=%s", k, v))
            end
            return variables
        end,
        stopOnEntry = false
    }
}
