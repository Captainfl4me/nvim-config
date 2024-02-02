local M = {
	"folke/tokyonight.nvim",
	-- enable = false,
	lazy = false,
	priority = 1000,
	opts = function()
		return {
			style = "moon",
			transparent = false,
			styles = {},
		}
	end,

	config = function(_, opts)
		local tokyonight = require("tokyonight")
		tokyonight.setup(opts)
		tokyonight.load()

		vim.cmd("colorscheme tokyonight")
	end,
}

return M
