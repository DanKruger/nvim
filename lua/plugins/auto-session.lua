return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")
		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/.desktop/" },
		})
		local keybind = vim.keymap
		keybind.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save session" })
		keybind.set("n", "<leader>sr", "<cmd>SessionRestore<CR>", { desc = "Restore previously saved session" })
	end,
}
