local data_dir = vim.fn.stdpath('data')
local lsp = require('modules.lsp')

require'lspconfig'.pyright.setup {
    cmd = { data_dir .. "/lspinstall/python/node_modules/.bin/pyright-langserver", "--stdio" },
    on_attach = lsp.common_on_attach,
	settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    }
}

require('dap').adapters.python = {
    type = 'executable';
    command = 'python';
    args = { '-m', 'debugpy.adapter' };
}

require('dap').configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python'
        else
            return '/usr/bin/python'
        end
        end;
    },
}
