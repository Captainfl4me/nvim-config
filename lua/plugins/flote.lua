local M = {
	{
		"Captainfl4me/flote.nvim",
		cmd = { "Flote" },
		keys = {
			{ "<leader>no", "<cmd>Flote<CR>",        desc = "Open current project note" },
			{ "<leader>nm", "<cmd>Flote manage<CR>", desc = "Open flote notes folder" },
			{ "<leader>ng", "<cmd>Flote global<CR>", desc = "Open flote global note" },
		},
		opts = {},
	},
	{
		"opdavies/toggle-checkbox.nvim",
		keys = { "n", "<leader>cc", desc = "Toggle current line markdown checkbox"  },
		config = function()
			vim.keymap.set("n", "<leader>cc", function() require('toggle-checkbox').toggle() end)
		end
	}
}

return M
