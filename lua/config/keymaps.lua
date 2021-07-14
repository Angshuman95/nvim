local K = require('utils.keymap')

K.g({
    { 'n', '<C-n>', ':set invrelativenumber<CR>' },
    { 'n', '<Esc>', '<Esc>:nohlsearch<CR><Esc>', { noremap = true, silent = true } },

-- Cut copy paste
    { 'v', 'mc', '"+y' },
    { 'n', 'mc', '"+y', { noremap = true } },
    { 'n', 'mcc', '"+yy', { noremap = true } },
    { 'v', 'md', '"+d' },
    { 'n', 'md', '"+d', { noremap = true } },
    { 'n', 'mdd', '"+dd', { noremap = true } },
    { 'n', 'zp', '"+p' },
    { 'n', 'zP', '"+P' },

-- Indent multiple lines
    { 'v', '>', '>gv', { noremap = true } },
    { 'v', '<', '<gv', { noremap = true } },

    { 'n', '<C-Left>', ':vertical resize -2<CR>' },
    { 'n', '<C-Right>', ':vertical resize +2<CR>' },
    { 'n', '<C-Up>', ':resize +2<CR>' },
    { 'n', '<C-Down>', ':resize -2<CR>' },

-- Move blocks of selected code
    {'v', 'K', ":move '<-2<CR>gv-gv"}, -- Move up
    {'v', 'J', ":move '>+1<CR>gv-gv"} -- Move down
})
