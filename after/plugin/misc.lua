
local m = require('functions.keymap')
-- general settings
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.expandtab = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.nu = true
vim.o.tabstop = 4
vim.o.wildmode = 'longest,list'
vim.o.inccommand = 'nosplit'
vim.o.scrolloff = 30
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.scl = "yes"
vim.o.relativenumber = true



m.keys{ -- undo tags
    {'i', ',', [[<C-g>u,]]},
    {'i', '.', [[<C-g>u.]]},
    {'i', '!', [[<C-g>u!]]},
    {'i', '?', [[<C-g>u?]]},
    {'i', ';', [[<C-g>u;]]},
}

m.keys{ -- vblock moves
    {'v', 'K', [[:m '<-2<cr>gv=gv]]},
    {'v', 'J', [[:m '>+1<cr>gv=gv]]},
}

m.keys{ -- closing files
    {'n', '<leader>q', [[<cmd>bdelete<cr>]]},
    {'n', '<leader>Q', [[<cmd>q!<cr>]]},
}

m.keys{ -- clipboard
    {'v', '<leader>y', '"+y'},
    {'n', '<leader>y', '"+y'},
    {'n', '<leader>Y', '"+Y'},
    {'v', '<leader>p', '"+p'},
    {'n', '<leader>p', '"+p'},
    {'n', '<leader>P', '"+P'},
}

m.keys{ -- tmux
    {'n', '<leader>t', [[<cmd>!tmux split-window -h -c %:p:h<cr><cmd>redraw!<cr>]]},
    {'n', '<leader>gr', [[<cmd>!tmux split-window -h -c `git rev-parse --show-toplevel`<cr><cmd>redraw!<cr>]]}
}

m.keys{ -- qfl
    {'n', '<C-p>', [[<cmd>cprev<cr>]]},
    {'n', '<C-n>', [[<cmd>cnext<cr>]]},
    {'n', '<C-q>', [[<cmd>copen<cr>]]},
    {'n', '<C-c>', [[<cmd>cclose<cr>]]},
    {'n', '*', [[:execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc<cr>]]}
}

m.keys{ -- misc
    {'n', '<leader>fe', [[<cmd>e ~/.config/nvim/init.lua<cr>]] },
    {'n', 'n', [[nzzzv]]},
    {'n', 'N', [[Nzzzv]]},
    {'n', 'J', [[mzJ`z]]},
}



-- autopairs
require('nvim-autopairs').setup {
    check_ts = true,
}

-- comments
require("Comment").setup{}

-- undotree
vim.g.undotree_WindowLayout = 2
vim.g.undotree_SetFocusWhenToggle = true
m.key('n', 'U', [[<cmd>UndotreeToggle<cr>]])

require('tmux').setup {
    copy_sync = {
        enable = true,
    },
    navigation = {
        enable_default_keybindings = true,
    },
}

