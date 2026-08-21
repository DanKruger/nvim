vim.g.have_nerd_font = true

vim.g.netrw_liststyle = 3
vim.g.mapleader = " " -- Set the leader key
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.breakindent = true
vim.g.undofile = true -- Save undo history

vim.hl.priorities.semantic_tokens = 95

require("core.options")
require("core.keymaps")
vim.cmd.colorscheme("deep-ocean")

vim.api.nvim_create_user_command("Wnf", function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.b[bufnr].skip_format_on_save = true
	local ok, err = pcall(vim.cmd.write)
	vim.b[bufnr].skip_format_on_save = nil
	if not ok then
		error(err)
	end
end, { desc = "Write the buffer without formatting" })

-- User commands must start with an uppercase letter; make :wnf resolve to :Wnf.
vim.cmd([[cnoreabbrev <expr> wnf getcmdtype() ==# ':' && getcmdline() ==# 'wnf' ? 'Wnf' : 'wnf']])
require("config.lazy")
