vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = {enable = true, priority = 20},
        underline = true
    })

local L = {}

if not packer_plugins['cmp-nvim-lsp'].loaded then
    vim.cmd [[packadd cmp-nvim-lsp]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
L.capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

function L.enhance_attach(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}

    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<A-d>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<A-D>', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<A-i>', '<Cmd>lua vim.lsp.buf.implementation()<CR>',
                   opts)
    buf_set_keymap('n', '<A-r>', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

end

return L
