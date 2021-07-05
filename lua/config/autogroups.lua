local A = require('utils.autogroup')

A.augroups({
    highlight_yank = {
        'TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}'
    }
})
