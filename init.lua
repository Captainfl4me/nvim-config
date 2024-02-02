-- General Configs
vim.wo.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.updatetime = 300


-- Lazy config (package manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Get the directory of the current script file 
local script_dir = debug.getinfo(1, 'S').source:match[[^@?(.*[\/])[^\/]-$]]
-- Add the directory to the package.path
package.path = package.path .. ';' .. script_dir .. '?.lua'

require("lua.keymaps")
require("lua.lazy")
