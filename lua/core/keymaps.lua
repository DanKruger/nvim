vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- very good


-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>oe", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
vim.keymap.set("n", "<leader>oq", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

-- Tab navigation
vim.keymap.set("n", "<A-j>", "<cmd>tabp<CR>") -- Switch to tab on left
vim.keymap.set("n", "<A-k>", "<cmd>tabn<CR>") -- Switch to tab on right
vim.keymap.set("n", "<A-t>", "<cmd>tabe<CR>") -- Create new tab
vim.keymap.set("n", "<A-x>", "<cmd>tabc<CR>") -- Close current tab

-- Windows
vim.keymap.set("n", "<leader>k", "<C-w>s") -- Create new window on the side
vim.keymap.set("n", "<leader>j", "<C-w>v") -- Create new window below
vim.keymap.set("n", "<leader>q", "<C-w>q") -- Close window (same as :q)

-- Window resizing
vim.keymap.set("n", "<A-Right>", "<cmd>vert res +5<CR>") -- horizontally by 5
vim.keymap.set("n", "<A-Left>", "<cmd>vert res -5<CR>") -- horizontally by -5
vim.keymap.set("n", "<A-Up>", "<cmd>res +5<CR>") -- vertically by 5
vim.keymap.set("n", "<A-Down>", "<cmd>res -5<CR>") -- vertically by -5

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
