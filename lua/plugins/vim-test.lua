return {
	{
		"vim-test/vim-test",
		-- config = function()
		--     vim.keymap.set("n", "<leader>tt", "<cmd>TestNearest<CR>")
		--     vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>")
		-- end,
		keys = {
			{ "<leader>tt", "<cmd>TestNearest<CR>", desc = "Test Nearest Test" },
			{ "<leader>tf", "<cmd>TestFile<CR>", desc = "Test Current File" },
		},
	},
}
