local M = {
	"folke/tokyonight.nvim",
	-- enable = false,
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd("colorscheme tokyonight")
	end
}

return M
