local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')
local dap = require('dap')

require'lspconfig'.tsserver.setup {
    cmd = { data_dir .. '/lspinstall/typescript/node_modules/.bin/typescript-language-server',
        '--stdio' },
    on_attach = lsp.enhance_attach,
    root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json",
        "jsconfig.json", ".git")
}

dap.adapters.javascript = {
    type = 'executable',
    command = 'node',
    args = {vim.fn.stdpath('data') .. '/dapinstall/jsnode_dbg/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
    {
        type = 'javascript',
        request = 'launch',
        program = function()
            return vim.fn.input("Path to executable: ",
                vim.fn.getcwd() .. '/', "file")
        end,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
    },
}

dap.adapters.typescript = {
    type = 'executable',
    command = 'node',
    args = {vim.fn.stdpath('data') .. '/dapinstall/jsnode_dbg/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.typescript = {
    {
        type = 'typescript',
        request = 'launch',
        program = function()
            return vim.fn.input("Path to executable: ",
                vim.fn.getcwd() .. '/', "file")
        end,
        cwd = "${workspaceFolder}",
        preLaunchTask = "tsc: build - tsconfig.json",
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        outFiles = {"${workspaceFolder}/out/**/*.js"}
    },
}
