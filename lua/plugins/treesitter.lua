---@module "lazy"
---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				max_lines = 4,
				multiline_threshold = 2,
			},
		},
	},
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		-- State tracking
		local parsers_loaded = {}
		local parsers_failed = {}
		local parser_available = {}
		local install_attempted = {}
		local pending_by_buf = {}
		local queue_scheduled = false

		local function has_parser(lang)
			local cached = parser_available[lang]
			if cached ~= nil then
				return cached
			end
			local ok = pcall(vim.treesitter.language.inspect, lang)
			parser_available[lang] = ok
			return ok
		end

		-- Helper to start highlighting and indentation
		local function start(buf, lang)
			if not vim.api.nvim_buf_is_valid(buf) then
				return false
			end
			local ok = pcall(vim.treesitter.start, buf, lang)
			if ok then
				parsers_loaded[lang] = true
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
			return ok
		end

		local function drain_pending()
			queue_scheduled = false
			local pending = pending_by_buf
			pending_by_buf = {}

			for buf, lang in pairs(pending) do
				if has_parser(lang) then
					if not start(buf, lang) then
						parsers_failed[lang] = true
					end
				end
			end
		end

		local function queue_start(buf, lang)
			pending_by_buf[buf] = lang
			if queue_scheduled then
				return
			end
			queue_scheduled = true
			vim.schedule(drain_pending)
		end

		local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

		local ignore_filetypes = {
			checkhealth = true,
			lazy = true,
			mason = true,
			snacks_dashboard = true,
			snacks_notif = true,
			snacks_win = true,
		}

		-- Auto-install parsers and enable highlighting on FileType
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			desc = "Enable treesitter highlighting and indentation (non-blocking)",
			callback = function(event)
				if ignore_filetypes[event.match] then
					return
				end

				local lang = vim.treesitter.language.get_lang(event.match) or event.match
				local buf = event.buf

				if parsers_failed[lang] then
					return
				end

				if has_parser(lang) then
					if parsers_loaded[lang] then
						start(buf, lang)
					else
						queue_start(buf, lang)
					end
					return
				end

				if install_attempted[lang] then
					return
				end

				install_attempted[lang] = true
				local ok = pcall(ts.install, { lang })
				if not ok then
					parsers_failed[lang] = true
				else
					-- Re-check parser availability on the next FileType event.
					parser_available[lang] = nil
				end
			end,
		})
	end,
}
