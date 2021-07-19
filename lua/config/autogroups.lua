local A = require('utils.autogroup')

A.augroups({
    highlight_yank = {
        'TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}'
    },
    set_cursor_shape = {
        'VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50' ..
            ',a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor' ..
            ',sm:block-blinkwait175-blinkoff150-blinkon175'
    },
    restore_cursor_shape = {
        'VimLeave,VimSuspend * set guicursor=a:ver90-blinkwait300-blinkon200-blinkoff150'
    }
})
