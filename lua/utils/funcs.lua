local utils = {}

local global = require('global')

utils.augroups = function (definitions) 
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup' .. group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
    end
end

utils.commands = function (commands)
    for name, c in pairs(commands) do
        local command
        if c.buffer then 
            command = 'command!-buffer'
        else
            command = 'command!'
        end
        vim.cmd(command .. ' -nargs=' .. c.nargs .. ' ' .. name .. ' ' .. c.cmd)
    end
end

return utils
