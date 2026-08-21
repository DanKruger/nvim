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
		local colors = {
			bg = "#0f111a",
			bg_active = "#292d3e",
			fg = "#8f93a2",
			bright = "#ffffff",
			blue = "#82aaff",
			cyan = "#89ddff",
			green = "#c3e88d",
			purple = "#c792ea",
			red = "#ff5370",
			yellow = "#ffcb6b",
		}

		local function mode_section(color)
			return {
				a = { fg = colors.bg, bg = color, gui = "bold" },
				b = { fg = color, bg = "NONE" },
				c = { fg = colors.fg, bg = "NONE" },
			}
		end

		local deep_ocean = {
			normal = mode_section(colors.blue),
			insert = mode_section(colors.green),
			visual = mode_section(colors.purple),
			replace = mode_section(colors.red),
			command = mode_section(colors.yellow),
			terminal = mode_section(colors.cyan),
			inactive = {
				a = { fg = colors.fg, bg = "NONE" },
				b = { fg = colors.fg, bg = "NONE" },
				c = { fg = colors.fg, bg = "NONE" },
			},
		}

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
				theme = deep_ocean,
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
				lualine_a = {
					{
						"mode",
						separator = { left = "", right = "" },
						padding = { left = 1, right = 1 },
					},
				},
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
						color = { fg = colors.yellow },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = {
					{
						"location",
						separator = { left = "", right = "" },
						padding = { left = 1, right = 1 },
					},
				},
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
