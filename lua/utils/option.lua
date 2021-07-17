local Type = {GLOBAL_OPTION = 'o', WINDOW_OPTION = 'wo', BUFFER_OPTION = 'bo'}

local add_options = function(option_type, id, options)
    if type(options) ~= 'table' then
        error('Option must be tables ' .. option_type)
        return
    end

    for key, value in pairs(options) do
        if id == 0 then
            vim[option_type][key] = value
        else
            vim[option_type][id][key] = value
        end
    end
end

local Options = {}

Options.g = function(options) add_options(Type.GLOBAL_OPTION, 0, options) end

Options.w = function(options, id)
    if id == nil then id = 0 end
    add_options(Type.WINDOW_OPTION, id, options)
end

Options.b = function(options, id)
    if id == nil then id = 0 end
    add_options(Type.BUFFER_OPTION, id, options)
end

return Options
