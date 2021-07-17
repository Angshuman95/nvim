local global = require('main.global')

-- Create cache dir (if deleted)
local createdir = function()
    local data_dir = {
        global.cache_dir .. 'backup', global.cache_dir .. 'session',
        global.cache_dir .. 'swap', global.cache_dir .. 'tags',
        global.cache_dir .. 'undo'
    }

    -- Check if cache dir exists
    if vim.fn.isdirectory(global.cache_dir) == 0 then
        os.execute('mkdir -p' .. global.cache_dir)

        -- Create sub dirs
        for _, v in pairs(data_dir) do
            if vim.fn.isdirectory(v) == 0 then
                os.execute('mkdir -p' .. v)
            end
        end

    end

end

-- set <Space> as mapleader
local leader_map = function()
    vim.g.mapleader = " "
    vim.api.nvim_set_keymap('n', ' ', '', {noremap = true})
    vim.api.nvim_set_keymap('x', ' ', '', {noremap = true})
end

local load_nvim = function()
    local pack = require('main.pack')
    createdir()
    leader_map()

    pack.ensure_plugins()

    require('config')

    pack.load_compile()
end

load_nvim()
