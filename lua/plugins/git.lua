local M = {
	{
		'lewis6991/gitsigns.nvim',
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		keys = {
			{ '<leader>ed', '<cmd>DiffviewOpen<cr>',  desc = "Open Git Diff view" },
			{ '<leader>cd', '<cmd>DiffviewClose<cr>', desc = "Close Git Diff view" },
		},
	},
	{
        "kdheepak/lazygit.nvim",
    	cmd = {
    		"LazyGit",
    		"LazyGitConfig",
    		"LazyGitCurrentFile",
    		"LazyGitFilter",
    		"LazyGitFilterCurrentFile",
    	},
		keys = {
			{ '<leader>eg', '<cmd>LazyGit<cr>', desc = "Focus Neotree git_status" },
		},
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
}

return M
