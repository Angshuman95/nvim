local fn, uv, api = vim.fn, vim.loop, vim.api
local global = require('main.global')
local data_dir = global.data_dir

local packer_compiled = data_dir .. 'packer_compiled.vim'
local compile_to_lua = data_dir .. 'lua/_compiled.lua'

local packer = nil

local Packer = {}
Packer.__index = Packer

function Packer:load_plugins()
    self.repos = {}

    local modules = require('modules.plugins')
    for repo, conf in pairs(modules) do
        if conf ~= false then
            self.repos[#self.repos + 1] = vim.tbl_extend('force', {repo}, conf)
        end
    end
end

function Packer:load_packer()
    if not packer then
        api.nvim_command('packadd packer.nvim')
        packer = require('packer')
    end

    packer.init({
        compile_path = packer_compiled,
        git = {clone_timeout = 120},
        disable_commands = true
    })

    packer.reset()

    local use = packer.use

    self:load_plugins()

    use {'wbthomason/packer.nvim', opt = true}

    for _, repo in ipairs(self.repos) do use(repo) end
end

function Packer:init_ensure_plugins()
    local packer_dir = data_dir .. 'pack/packer/opt/packer.nvim'

    local state = uv.fs_stat(packer_dir)
    if not state then
        local cmd = '!git clone https://github.com/wbthomason/packer.nvim ' ..
                        packer_dir
        api.nvim_command(cmd)

        uv.fs_mkdir(data_dir .. 'lua', 511,
                    function() assert('make compile path dir failed') end)

        self:load_packer()
    end
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        if not packer then Packer:load_packer() end
        return packer[key]
    end
})

-- Script Entry point
function plugins.ensure_plugins() Packer:init_ensure_plugins() end

function plugins.convert_compile_file()
    local lines = {}
    local lnum = 1
    lines[#lines + 1] = 'vim.cmd [[packadd packer.nvim]]\n'

    for line in io.lines(packer_compiled) do
        lnum = lnum + 1
        if lnum > 15 then
            lines[#lines + 1] = line .. '\n'
            if line == 'END' then break end
        end
    end
    table.remove(lines, #lines)

    if fn.isdirectory(data_dir .. 'lua') ~= 1 then
        os.execute('mkdir -p ' .. data_dir .. 'lua')
    end

    if fn.filereadable(compile_to_lua) == 1 then os.remove(compile_to_lua) end

    local file = io.open(compile_to_lua, "w")
    for _, line in ipairs(lines) do file:write(line) end
    file.close()

    os.remove(packer_compiled)
end

function plugins.magic_compile()
    plugins.compile()
    plugins.convert_compile_file()
end

function plugins.load_compile()
    if fn.filereadable(compile_to_lua) == 1 then
        require('_compiled')
    else
        assert('Missing packer compile file - Run PackerCompile or ' ..
                   'PackerInstall to fix')
    end

    vim.cmd [[command! PackerCompile lua require('main.pack').magic_compile()]]
    vim.cmd [[command! PackerInstall lua require('main.pack').install()]]
    vim.cmd [[command! PackerUpdate lua require('main.pack').update()]]
    vim.cmd [[command! PackerSync lua require('main.pack').sync()]]
    vim.cmd [[command! PackerClean lua require('main.pack').clean()]]
    vim.cmd [[autocmd User PackerComplete lua require('main.pack').magic_compile()]]
    vim.cmd [[command! PackerStatus lua require('main.pack').status()]]
end

return plugins
