vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set scrolloff=10")

vim.g.mapleader = " "                      -- Set the leader key
vim.keymap.set("n", "<leader>w", ":w<CR>") -- Write File (Save)
vim.opt.updatetime = 100                   -- Set buffer update time

-- Line number configuration
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "auto:9"

--[[ vim.opt.statuscolumn = '%#NonText# %{&nu?v:lnum:""} %=' ]]

-- Tab navigation
vim.keymap.set("n", "<C-j>", ":tabp<CR>") -- Switch to tab on left
vim.keymap.set("n", "<C-k>", ":tabn<CR>") -- Switch to tab on right
vim.keymap.set("n", "<C-T>", ":tabe<CR>") -- Create new tab
vim.keymap.set("n", "<C-x>", ":tabc<CR>") -- Close current tab

-- Window management
vim.keymap.set("n", "<leader>k", "<C-w>s") -- Create new window on the side
vim.keymap.set("n", "<leader>j", "<C-w>v") -- Create new window below
vim.keymap.set("n", "<leader>q", "<C-w>q") -- Close window (same as :q)

-- Window resizing
vim.keymap.set("n", "<A-Right>", ":vert res +5<CR>") -- horizontally by 5
vim.keymap.set("n", "<A-Left>", ":vert res -5<CR>")  -- horizontally by -5
vim.keymap.set("n", "<A-Up>", ":res +5<CR>")         -- vertically by 5
vim.keymap.set("n", "<A-Down>", ":res -5<CR>")       -- vertically by -5

-- Window navigation
vim.keymap.set("n", "<A-l>", "<C-w>l") -- Switch to window on the right
vim.keymap.set("n", "<A-h>", "<C-w>h") -- Switch to window on the left
vim.keymap.set("n", "<A-k>", "<C-w>k") -- Switch to window above
vim.keymap.set("n", "<A-j>", "<C-w>j") -- Switch to window below
