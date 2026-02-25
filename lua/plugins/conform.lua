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
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt = disable_filetypes[vim.bo[bufnr].filetype] and "never" or "fallback"
			return {
				timeout_ms = 1000,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			dart = { "dart_format" },
			astro = { "prettier", "prettierd", stop_after_first = true },
			javascript = { "prettier", "prettierd", stop_after_first = true },
			javascriptreact = { "prettier", "prettierd", stop_after_first = true },
			typescript = { "prettier", "prettierd", stop_after_first = true },
			typescriptreact = { "prettier", "prettierd", stop_after_first = true },
			markdown = { "prettier", "prettierd", stop_after_first = true },
			json = { "prettier", "prettierd", stop_after_first = true },
			jsonc = { "prettier", "prettierd", stop_after_first = true },
			css = { "prettier", "prettierd", stop_after_first = true },
			scss = { "prettier", "prettierd", stop_after_first = true },
			html = { "prettier", "prettierd", stop_after_first = true },
			yaml = { "prettier", "prettierd", stop_after_first = true },
		},
	},
}
