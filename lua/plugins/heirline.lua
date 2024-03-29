local M = {
	'rebelot/heirline.nvim',
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"lewis6991/gitsigns.nvim",
		"nvim-lua/lsp-status.nvim",
	},
	event = 'UIEnter',
	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		local function setup_colors()
			return {
				bright_bg = utils.get_highlight("Folded").bg,
				bright_fg = utils.get_highlight("Folded").fg,
				red = utils.get_highlight("DiagnosticError").fg,
				dark_red = utils.get_highlight("DiffDelete").bg,
				green = utils.get_highlight("String").fg,
				blue = utils.get_highlight("Function").fg,
				gray = utils.get_highlight("NonText").fg,
				orange = utils.get_highlight("Constant").fg,
				purple = utils.get_highlight("Statement").fg,
				cyan = utils.get_highlight("Special").fg,
				diag_warn = utils.get_highlight("DiagnosticWarn").fg,
				diag_error = utils.get_highlight("DiagnosticError").fg,
				diag_hint = utils.get_highlight("DiagnosticHint").fg,
				diag_info = utils.get_highlight("DiagnosticInfo").fg,
				git_del = utils.get_highlight("diffRemoved").fg,
				git_add = utils.get_highlight("diffAdded").fg,
				git_change = utils.get_highlight("diffChanged").fg,
			}
		end

		require("heirline").load_colors(setup_colors())
		vim.api.nvim_create_augroup("Heirline", { clear = true })
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				utils.on_colorscheme(setup_colors)
			end,
			group = "Heirline",
		})

		-- Vim current mode
		local ViMode = {
			-- get vim current mode, this information will be required by the provider
			-- and the highlight functions, so we compute it only once per component
			-- evaluation and store it as a component attribute
			init = function(self)
				self.mode = vim.fn.mode(1) -- :h mode()
			end,
			-- Now we define some dictionaries to map the output of mode() to the
			-- corresponding string and color. We can put these into `static` to compute
			-- them at initialisation time.
			static = {
				mode_names = { -- change the strings if you like it vvvvverbose!
					n = "N",
					no = "N?",
					nov = "N?",
					noV = "N?",
					["no\22"] = "N?",
					niI = "Ni",
					niR = "Nr",
					niV = "Nv",
					nt = "Nt",
					v = "V",
					vs = "Vs",
					V = "V_",
					Vs = "Vs",
					["\22"] = "^V",
					["\22s"] = "^V",
					s = "S",
					S = "S_",
					["\19"] = "^S",
					i = "I",
					ic = "Ic",
					ix = "Ix",
					R = "R",
					Rc = "Rc",
					Rx = "Rx",
					Rv = "Rv",
					Rvc = "Rv",
					Rvx = "Rv",
					c = "C",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "T",
				},
				mode_colors = {
					n = "red",
					i = "green",
					v = "cyan",
					V = "cyan",
					["\22"] = "cyan",
					c = "orange",
					s = "purple",
					S = "purple",
					["\19"] = "purple",
					R = "orange",
					r = "orange",
					["!"] = "red",
					t = "red",
				}
			},
			-- We can now access the value of mode() that, by now, would have been
			-- computed by `init()` and use it to index our strings dictionary.
			-- note how `static` fields become just regular attributes once the
			-- component is instantiated.
			-- To be extra meticulous, we can also add some vim statusline syntax to
			-- control the padding and make sure our string is always at least 2
			-- characters long. Plus a nice Icon.
			provider = function(self)
				return " %2(" .. self.mode_names[self.mode] .. "%)"
			end,
			-- Same goes for the highlight. Now the foreground will change according to the current mode.
			hl = function(self)
				local mode = self.mode:sub(1, 1) -- get only the first mode character
				return { fg = self.mode_colors[mode], bold = true, }
			end,
			-- Re-evaluate the component only on ModeChanged event!
			-- Also allows the statusline to be re-evaluated when entering operator-pending mode
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}
		ViMode = utils.surround({ "█", "" }, "bright_bg", ViMode)

		-- FileName and friends
		local FileNameBlock = {
			-- let's first set up some attributes needed by this component and it's children
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
		}
		local FileIcon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension,
					{ default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end
		}
		local FileName = {
			provider = function(self)
				-- first, trim the pattern relative to the current directory. For other
				-- options, see :h filename-modifers
				local filename = vim.fn.fnamemodify(self.filename, ":.")
				if filename == "" then return "[No Name]" end
				-- now, if the filename would occupy more than 1/4th of the available
				-- space, we trim the file path to its initials
				-- See Flexible Components section below for dynamic truncation
				if not conditions.width_percent_below(#filename, 0.25) then
					filename = vim.fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { fg = utils.get_highlight("Directory").fg },
		}
		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = "[+]",
				hl = { fg = "green" },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = "",
				hl = { fg = "orange" },
			},
		}
		-- Now, let's say that we want the filename color to change if the buffer is
		-- modified. Of course, we could do that directly using the FileName.hl field,
		-- but we'll see how easy it is to alter existing components using a "modifier"
		-- component
		local FileNameModifer = {
			hl = function()
				if vim.bo.modified then
					-- use `force` because we need to override the child's hl foreground
					return { fg = "cyan", bold = true, force = true }
				end
			end,
		}
		FileNameBlock = utils.insert(FileNameBlock,
			FileIcon,
			utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
			FileFlags,
			{ provider = '%<' }             -- this means that the statusline is cut here when there's not enough space
		)

		local FileType = {
			provider = function()
				return string.upper(vim.bo.filetype)
			end,
			hl = { fg = utils.get_highlight("Type").fg, bold = true },
		}

		local Git = {
			condition = conditions.is_git_repo,

			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
					self.status_dict.changed ~= 0
			end,

			hl = { fg = "orange" },


			{ -- git branch name
				provider = function(self)
					return " " .. self.status_dict.head
				end,
				hl = { bold = true }
			},
			-- You could handle delimiters, icons and counts similar to Diagnostics
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = "("
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ("+" .. count)
				end,
				hl = { fg = "git_add" },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ("-" .. count)
				end,
				hl = { fg = "git_del" },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ("~" .. count)
				end,
				hl = { fg = "git_change" },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = ")",
			},
		}

		local Diagnostics = {

			condition = conditions.has_diagnostics,

			static = {
				error_icon = " ",
				warn_icon = " ",
				info_icon = " ",
				hint_icon = " ",
			},

			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,

			update = { "DiagnosticChanged", "BufEnter" },

			{
				provider = "![",
			},
			{
				provider = function(self)
					-- 0 is just another output, we can decide to print it or not!
					return self.errors > 0 and (self.error_icon .. self.errors .. " ")
				end,
				hl = { fg = "diag_error" },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
				end,
				hl = { fg = "diag_warn" },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. " ")
				end,
				hl = { fg = "diag_info" },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints)
				end,
				hl = { fg = "diag_hint" },
			},
			{
				provider = "]",
			},
		}

		local Copilot = {
			condition = conditions.is_active(), -- always active
			provider = function()
				local status = {
					icons = {
						enabled = " ",
						sleep = " ",
						disabled = " ",
						warning = " ",
						unknown = " "
					},
				}
				local copilot_loaded = package.loaded["copilot"] ~= nil
				if not copilot_loaded then
					return status.icons.unknown
				end

				local copilot = require("copilot.client")
				local api = require("copilot.api")
				if not copilot.buf_is_attached(vim.api.nvim_get_current_buf()) or copilot.is_disabled() then
					return status.icons.disabled
				elseif api.status.data.status == "Warning" then
					return status.icons.warning
				elseif vim.b.copilot_suggestion_auto_trigger then
					return status.icons.sleep
				else
					return status.icons.enabled
				end
			end,
			hl = function()
				local status = {
					hl = {
						enabled = "diag_hint",
						sleep = "diag_info",
						disabled = "cyan",
						warning = "diag_warn",
						unknown = "diag_error"
					}
				}
				local copilot_loaded = package.loaded["copilot"] ~= nil
				if not copilot_loaded then
					return { fg = status.hl.unknown }
				end

				local copilot = require("copilot.client")
				local api = require("copilot.api")
				if not copilot.buf_is_attached(vim.api.nvim_get_current_buf()) or copilot.is_disabled() then
					return { fg = status.hl.disabled }
				elseif api.status.data.status == "Warning" then
					return { fg = status.hl.warning }
				elseif vim.b.copilot_suggestion_auto_trigger then
					return { fg = status.hl.sleep }
				else
					return { fg = status.hl.enabled }
				end
			end,
		}

		local LSPActive = {
			condition = conditions.lsp_attached,
			update    = { 'LspAttach', 'LspDetach' },

			-- You can keep it simple,
			-- provider = " [LSP]",

			-- Or complicate things a bit and get the servers names
			provider  = function()
				local names = {}
				for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " [" .. table.concat(names, " ") .. "]"
			end,
			hl        = { fg = "green", bold = true },
		}
		local LSPMessages = {
			provider = require("lsp-status").status(),
			hl = { fg = "gray" },
		}


		local TerminalName = {
			-- we could add a condition to check that buftype == 'terminal'
			-- or we could do that later (see #conditional-statuslines below)
			provider = function()
				local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
				return " " .. tname
			end,
			hl = { fg = "blue", bold = true },
		}

		-- Cursor position: Ruler and ScrollBar
		-- We're getting minimalists here!
		local Ruler = {
			-- %l = current line number
			-- %L = number of lines in the buffer
			-- %c = column number
			-- %P = percentage through file of displayed window
			provider = "%7(%l/%3L%):%2c %P",
		}


		local Align = { provider = "%=" }
		local Space = { provider = " " }

		local DefaultStatusline = {
			ViMode, Space, FileNameBlock, Space, Git, Space, Diagnostics, Align,
			Copilot, Space, LSPActive, Space, LSPMessages, Space, FileType, Space, Ruler
		}
		local InactiveStatusline = {
			condition = conditions.is_not_active,
			FileType,
			Space,
			FileName,
			Align,
		}
		local SpecialStatusline = {
			condition = function()
				return conditions.buffer_matches({
					buftype = { "nofile", "prompt", "help", "quickfix" },
					filetype = { "^git.*", "fugitive" },
				})
			end,

			FileType,
			Space,
			Align,
		}
		local TerminalStatusline = {
			condition = function()
				return conditions.buffer_matches({ buftype = { "terminal" } })
			end,

			hl = { bg = "dark_red" },

			-- Quickly add a condition to the ViMode to only show it when buffer is active!
			{ condition = conditions.is_active, ViMode, Space },
			FileType,
			Space,
			TerminalName,
			Align,
		}

		local StatusLines = {

			hl = function()
				if conditions.is_active() then
					return "StatusLine"
				else
					return "StatusLineNC"
				end
			end,

			-- the first statusline with no condition, or which condition returns true is used.
			-- think of it as a switch case with breaks to stop fallthrough.
			fallthrough = false,

			SpecialStatusline,
			TerminalStatusline,
			InactiveStatusline,
			DefaultStatusline,
		}

		require("heirline").setup({ statusline = StatusLines })
	end
}

return M
