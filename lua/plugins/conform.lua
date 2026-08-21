return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>g",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		notify_no_formatters = true,
		format_on_save = function(bufnr)
			if vim.b[bufnr].skip_format_on_save then
				vim.b[bufnr].skip_format_on_save = nil
				return
			end
			local ft = vim.bo[bufnr].filetype
			local lsp_format_opt = (ft == "c" or ft == "cpp") and "never" or "fallback"
			return {
				timeout_ms = 1000,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			go = { "goimports", "gofumpt" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			lua = { "stylua" },
			dart = { "dart_format" },
			astro = { "prettierd", "prettier", stop_after_first = true },
			vue = { "prettierd", "prettier", stop_after_first = true },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", "cbfmt", stop_after_first = false },
			mdx = { "prettierd", "prettier", "cbfmt", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			jsonc = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			scss = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
		},
	},
}
