---@diagnostic disable: undefined-field
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		-- Single global statusline across splits.
		vim.o.laststatus = 3
	end,
	config = function()
		local function noice_mode()
			local noice = package.loaded["noice"]
			if noice and noice.api and noice.api.status and noice.api.status.mode.has() then
				return noice.api.status.mode.get()
			end
			return ""
		end

		local function noice_mode_cond()
			local noice = package.loaded["noice"]
			return noice and noice.api and noice.api.status and noice.api.status.mode.has()
		end

		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"alpha",
						"dashboard",
						"help",
						"lazy",
						"mason",
						"neo-tree",
						"oil",
						"qf",
						"snacks_dashboard",
						"snacks_notif",
						"snacks_win",
						"TelescopePrompt",
					},
					winbar = {},
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed = "[No Name]",
						},
					},
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
					},
					{
						noice_mode,
						cond = noice_mode_cond,
						color = { fg = "#ff9e64" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "quickfix" },
		})
	end,
}
