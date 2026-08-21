return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"sharkdp/fd",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		require("telescope").setup({
			pickers = {
				-- find_files = { theme = 'ivy' },
				-- live_grep = { theme = 'ivy' }
			},
			defaults = {
				border = true,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				layout_strategy = "vertical",
				layout_config = {
					width = 0.95,
					vertical = { width = 0.7 },
				},
				sorting_strategy = "descending",
			},
			extensions = {
				fzf = {},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local function first_changed_lnum(cwd, relpath)
			local function from_diff(args)
				local output = vim.fn.systemlist(args)
				if vim.v.shell_error ~= 0 then
					return nil
				end
				for _, line in ipairs(output) do
					local lnum = line:match("^@@ %-%d+,?%d* %+(%d+),?%d* @@")
					if lnum then
						return tonumber(lnum)
					end
				end
				return nil
			end

			return from_diff({ "git", "-C", cwd, "diff", "--unified=0", "--", relpath })
				or from_diff({ "git", "-C", cwd, "diff", "--cached", "--unified=0", "--", relpath })
		end

		local function git_new_changes()
			builtin.git_status({
				prompt_title = "New Git Changes",
				attach_mappings = function(prompt_bufnr, _)
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						local picker = action_state.get_current_picker(prompt_bufnr)
						actions.close(prompt_bufnr)

						if not selection then
							return
						end

						local cwd = (picker and picker.cwd) or vim.fn.getcwd()
						local relpath = selection.value
						local filepath = selection.path or (cwd .. "/" .. relpath)
						local stat = (vim.uv or vim.loop).fs_stat(filepath)
						if not stat then
							vim.notify("Cannot open deleted/missing file: " .. relpath, vim.log.levels.WARN)
							return
						end

						vim.cmd.edit(vim.fn.fnameescape(filepath))

						local lnum = first_changed_lnum(cwd, relpath)
						if lnum and lnum > 0 then
							pcall(vim.api.nvim_win_set_cursor, 0, { lnum, 0 })
							vim.cmd("normal! zz")
						end
					end)
					return true
				end,
			})
		end

		vim.keymap.set("n", "<C-p>", builtin.find_files, {})
		vim.keymap.set("n", "<C-g>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
		vim.keymap.set("n", "<leader>gn", git_new_changes, { desc = "Git new/uncommitted changes" })
		vim.keymap.set("n", "<leader>gs", git_new_changes, { desc = "Git status (jump to change on enter)" })
		vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
		vim.keymap.set("n", "gr", builtin.lsp_references, {})
	end,
}
