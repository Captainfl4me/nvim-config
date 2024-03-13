local M = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	cmd = "Neotree",
	keys = {
		{ '<leader>ee', '<cmd>Neotree<cr>',            desc = "Focus Neotree filesystem" },
	},
	opts = {
		window = {
			mappings = {
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
			}
		}
	}
}

return M
