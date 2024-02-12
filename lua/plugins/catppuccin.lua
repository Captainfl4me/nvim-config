local M = {
	"catppuccin/nvim",
	lazy = not (ColorScheme == "catppuccin"),
	name = "catppuccin",
	priority = 1000,
	opts = function()
		return {
			flavour = "frappe",
			background = {
				light = "latte",
				dark = "frappe",
			},
			transparent_background = IsTransparent,
		}
	end,

	config = function(_, opts)
		local catppuccin = require("catppuccin")
		catppuccin.setup(opts)

		if ColorScheme == "catppuccin" then
			vim.cmd("colorscheme catppuccin")
		end
	end,
}

return M
