return {
	"SmiteshP/nvim-navbuddy",
	dependencies = {
		"neovim/nvim-lspconfig",
		"SmiteshP/nvim-navic",
		"MunifTanjim/nui.nvim",
		"numToStr/Comment.nvim", -- Optional
		"nvim-telescope/telescope.nvim", -- Optional
	},
	opts = {
		window = {
			border = "rounded",
			size = { height = "100%", width = "100%" },
			position = { row = "0%", col = "0%" },
			sections = {
				left = { size = "20%" },
				mid = { size = "40%" },
				right = { size = "40%" },
			},
		},
		lsp = { auto_attach = true },
	},
	cmd = "Navbuddy",
	keys = {
		{ "<leader>nb", "<cmd>Navbuddy<CR>", desc = "Open navbuddy to browse symbols in your buffer" },
	},
}
