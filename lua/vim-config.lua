local global = vim.g
local option = vim.opt
local keybind = vim.keymap

global.netrw_liststyle = 3
global.mapleader = " " -- Set the leader key
global.have_nerd_font = true
global.breakindent = true

-- Indent configuration
option.tabstop = 4 -- Tab size
option.shiftwidth = 4 -- indent width
option.scrolloff = 10
option.softtabstop = 4
option.expandtab = true -- Expand tab to spaces
option.autoindent = true -- copy indent of current line to new line

option.list = true
-- option.listchars = [[lead:⋅]]

option.listchars:append({
	tab = "┊╴",
	multispace = "⋅",
	lead = "⋅",
	trail = "⋅",
	nbsp = "⋅",
})
option.cursorline = true -- Highlight line cursor is on
option.updatetime = 100 -- Set buffer update time

-- Search settings
option.ignorecase = true -- Ignore case while searching
option.smartcase = true -- if includes mixed case, assume you mean case sensitive

option.termguicolors = true
option.background = "dark" -- set background to dark version of theme

-- Clipboard configuration
option.clipboard:append("unnamedplus")

-- Line number configuration
option.number = true
option.relativenumber = true
option.signcolumn = "auto:9"
--[[ option.statuscolumn = '%#NonText# %{&nu?v:lnum:""} %=' ]]

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
-- Diagnostics
keybind.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
keybind.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
keybind.set("n", "<leader>oe", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
keybind.set("n", "<leader>oq", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

keybind.set("i", "jj", "<Esc>") -- Exit insert mode
keybind.set("n", "<leader>w", "<cmd>w<CR>") -- Write File (Save)

-- Tab navigation
keybind.set("n", "<A-j>", "<cmd>tabp<CR>") -- Switch to tab on left
keybind.set("n", "<A-k>", "<cmd>tabn<CR>") -- Switch to tab on right
keybind.set("n", "<C-t>", "<cmd>tabe<CR>") -- Create new tab
keybind.set("n", "<A-x>", "<cmd>tabc<CR>") -- Close current tab

-- Window management
option.splitright = true -- Windows will split to the right
option.splitbelow = true -- Windows will split below
keybind.set("n", "<leader>k", "<C-w>s") -- Create new window on the side
keybind.set("n", "<leader>j", "<C-w>v") -- Create new window below
keybind.set("n", "<leader>q", "<C-w>q") -- Close window (same as :q)

-- Window resizing
keybind.set("n", "<A-Right>", "<cmd>vert res +5<CR>") -- horizontally by 5
keybind.set("n", "<A-Left>", "<cmd>vert res -5<CR>") -- horizontally by -5
keybind.set("n", "<A-Up>", "<cmd>res +5<CR>") -- vertically by 5
keybind.set("n", "<A-Down>", "<cmd>res -5<CR>") -- vertically by -5

-- Clear search highlights
keybind.set("n", "<leader>hl", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- Remap terminal exit mode
keybind.set("t", "<Esc-t>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Highlight when yanking stuff
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
