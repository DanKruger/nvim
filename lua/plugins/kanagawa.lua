return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			-- theme = "dragon",
			theme = "wave",
		})
		vim.cmd.colorscheme("kanagawa-wave")
	end,
}
