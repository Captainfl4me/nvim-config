local M = {
	"folke/tokyonight.nvim",
	enable = ColorScheme == "tokyonight",
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

		if ColorScheme == "tokyonight" then
			vim.cmd("colorscheme tokyonight")
		end
	end,
}

return M
