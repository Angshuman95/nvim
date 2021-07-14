local config = {}


function config.lsp_configs()
    require("modules.lsp")
    require("modules.lsp.languages")

    if not packer_plugins["nvim-bqf"].loaded then
        vim.cmd [[packadd nvim-bqf]]
    end
end


function config.lspsaga()
    if not packer_plugins['lspsaga.nvim'].loaded then
        vim.cmd [[packadd lspsaga.nvim]]
    end

    require("lspsaga").init_lsp_saga()
end


function config.jdtls()
    local data_dir = vim.fn.stdpath('data')
    require('jdtls').start_or_attach(
        {
            cmd = {data_dir .. '/lspinstall/java/launch_jdtls'},
            filetypes = {"java"}
        }
    )

    vim.api.nvim_buf_set_keymap(0,'n','K','<cmd>lua vim.lsp.buf.hover()<CR>',
        {noremap = true, silent = true})

    vim.cmd[[command! -buffer JdtCompile lua require('jdtls').compile()]]
    vim.cmd[[command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()]]
    vim.cmd[[command! -buffer JdtJol lua require('jdtls').jol()]]
    vim.cmd[[command! -buffer JdtBytecode lua require('jdtls').javap()]]
    vim.cmd[[command! -buffer JdtJshell lua require('jdtls').jshell()]]
end


function config.treesitter()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        highlight = {enable = true},
        indent = {enable = {"javascriptreact"}},
        autotag = {enable = true},
        rainbow = {enable = true},
        context_commentstring = {
            enable = true,
            config = {javascriptreact = {style_element = "{/*%s*/}"}}
        }
    }
end


function config.symbols()
    require("symbols-outline").setup {
        highlight_hovered_item = true,
        show_guides = true
    }
end


return config
