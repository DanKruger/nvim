return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	ft = { "markdown", "codecompanion" }, -- load for markdown files
	opts = {
		file_types = { "markdown" },
		checkbox = {
			enabled = true,
			-- Custom render icons for checkboxes
			unChecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
			checked = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
			-- custom custom states can be added here
		},
		bullet = {
			enabled = true,
			icons = { "●", "○", "◆", "◇" },
		},
	},
	config = function(_, opts)
		require("render-markdown").setup(opts)

		-- Optional: Create a quick keymap to toggle checkboxes in normal mode
		vim.keymap.set("n", "<leader>mc", function()
			local line = vim.api.nvim_get_current_line()
			if line:match("%[%s%]") then
				vim.api.nvim_set_current_line(line:gsub("%[%s%]", "[x]", 1))
			elseif line:match("%[x%]") then
				vim.api.nvim_set_current_line(line:gsub("%[x%]", "[ ]", 1))
			end
		end, { desc = "Toggle Markdown Checkbox" })
	end,
}
