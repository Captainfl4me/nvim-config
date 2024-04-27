vim.g.mapleader = " "

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('i', '<C-c>', '<esc>')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- replace currently selected text with default register without yanking it
vim.keymap.set('v', '<leader>p', '"_dP', { desc = "Replace without yank" })
