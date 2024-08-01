return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = {
		"Neotree",
	},
	keys = {
		{ "<C-e>", "<cmd>Neotree filesystem reveal left<CR>", desc = "Open filesystem to the left" },
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			filesystem = {
				always_show = {
					".gitignore",
					".gitlab-ci.yml",
				},
			},
			follow_current_file = {
				enabled = false,
			},
		})
	end,
}
