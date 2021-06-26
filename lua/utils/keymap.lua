local keymap = {}

keymap.g = function (maps)
    for _, map in ipairs(maps) do
        if map[4] == nil then
            map[4] = {}
        end

        vim.api.nvim_set_keymap(
            map[1],
            map[2],
            map[3],
            map[4]
        )
    end
end


keymap.b = function (maps)
    for _, map in ipairs(maps) do
        if map[5] == nil then
            map[5] = {}
        end

        vim.api.nvim_buf_set_keymap(
            map[1],
            map[2],
            map[3],
            map[4],
            map[5]
        )
    end
end

return keymap