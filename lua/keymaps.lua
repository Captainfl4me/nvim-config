vim.g.mapleader = " "

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- replace currently selected text with default register without yanking it
vim.keymap.set('v', '<leader>p', '"_dP')
