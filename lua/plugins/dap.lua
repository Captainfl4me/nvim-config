local M = {
	"mfussenegger/nvim-dap",

	dependencies = {
		-- fancy UI for the debugger
		{
			"rcarriga/nvim-dap-ui",
			keys = {
				{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
				{ "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
			},
			opts = {},
			config = function(_, opts)
				vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'Error', linehl = '', numhl = '' })

				local dap, dapui = require("dap"), require("dapui")
				dapui.setup(opts)
				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end
			end,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},
		-- mason.nvim integration
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = "mason.nvim",
			cmd = { "DapInstall", "DapUninstall" },
			opts = {
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					"codelldb"
				},
			},
		},
	},
	keys = {
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		{ "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
		{ "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
		{ "<leader>dj", function() require("dap").down() end,              desc = "Down" },
		{ "<leader>dk", function() require("dap").up() end,                desc = "Up" },
		{ "<leader>do", function() require("dap").step_out() end,          desc = "Step Out" },
		{ "<leader>dO", function() require("dap").step_over() end,         desc = "Step Over" },
		{ "<leader>dt", function() require("dap").terminate() end,         desc = "Terminate" },
	},
	config = function()
		local dap = require('dap')
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}',
				stopOnEntry = false,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = {
			{
				name = "Launch package",
				type = "codelldb",
				request = "launch",
				cargo = {
					args = { "build" },
				},
				cwd = '${workspaceFolder}',
				stopOnEntry = false,
			},
		}

		-- Replace config with per project config if it existif not pcall(require, "dap") then
		local config_paths = { "./.nvim-dap/nvim-dap.lua", "./.nvim-dap.lua", "./.nvim/nvim-dap.lua" }
		local project_config = ""
		for _, p in ipairs(config_paths) do
			local f = io.open(p)
			if f ~= nil then
				f:close()
				project_config = p
				break
			end
		end
		if project_config ~= "" then
			vim.notify("Found nvim-dap configuration at." .. project_config, vim.log.levels.INFO, nil)
			vim.cmd(":luafile " .. project_config)
		end
	end,
}

return M
