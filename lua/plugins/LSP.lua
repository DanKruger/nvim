return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
			{ "SmiteshP/nvim-navbuddy" },
			{ "SmiteshP/nvim-navic" },
		},
		config = function()
			local function open_lsp_actions()
				local builtin = require("telescope.builtin")
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				local conf = require("telescope.config").values
				local telescope_actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				local items = {
					{ label = "Go to definition", run = builtin.lsp_definitions },
					{ label = "Go to declaration", run = vim.lsp.buf.declaration },
					{ label = "Go to references", run = builtin.lsp_references },
					{ label = "Go to implementation", run = builtin.lsp_implementations },
					{ label = "Go to type definition", run = builtin.lsp_type_definitions },
					{ label = "Document symbols", run = builtin.lsp_document_symbols },
					{ label = "Workspace symbols", run = builtin.lsp_dynamic_workspace_symbols },
					{ label = "Rename symbol", run = vim.lsp.buf.rename },
					{ label = "Code action", run = vim.lsp.buf.code_action },
					{ label = "Hover documentation", run = vim.lsp.buf.hover },
				}

				pickers
					.new({}, {
						prompt_title = "LSP Actions",
						finder = finders.new_table({
							results = items,
							entry_maker = function(item)
								return { value = item, display = item.label, ordinal = item.label }
							end,
						}),
						sorter = conf.generic_sorter({}),
						attach_mappings = function(prompt_bufnr, map)
							local function run_selected()
								local selection = action_state.get_selected_entry()
								telescope_actions.close(prompt_bufnr)
								if selection and selection.value and selection.value.run then
									selection.value.run()
								end
							end

							telescope_actions.select_default:replace(run_selected)
							map("i", "<CR>", run_selected)
							map("n", "<CR>", run_selected)
							return true
						end,
					})
					:find()
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- (Rest of your existing mappings...)
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<C-d><C-r>", vim.lsp.buf.rename, "[R]e[n]ame", { "n", "v" })
					map("<C-d><C-d>", vim.lsp.buf.definition, "Definition", { "n", "v" })
					map("<C-n>", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "v" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("<leader>la", open_lsp_actions, "LSP [A]ctions")

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup(
							"kickstart-lsp-highlight-" .. event.buf,
							{ clear = true }
						)
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- Change diagnostic symbols in the sign column (gutter)

			if vim.g.have_nerd_font then
				local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
				local diagnostic_signs = {}
				for type, icon in pairs(signs) do
					diagnostic_signs[vim.diagnostic.severity[type]] = icon
				end
				vim.diagnostic.config({ signs = { text = diagnostic_signs } })
			end

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

			local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
			local vue_language_server_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

			local servers = {
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
					},
				},
				gopls = {
					settings = {
						gopls = {
							gofumpt = true,
							analyses = {
								unusedparams = true,
							},
							staticcheck = true,
						},
					},
				},
				vtsls = {
					cmd = { mason_bin .. "/vtsls", "--stdio" },
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
					root_dir = function(bufnr, on_dir)
						on_dir(vim.fs.root(bufnr, {
							"package.json",
							"tsconfig.json",
							"jsconfig.json",
							"vite.config.js",
							"vite.config.ts",
							"vue.config.js",
							"vue.config.ts",
							".git",
						}) or vim.fn.getcwd())
					end,
					settings = {
						vtsls = {
							tsserver = {
								globalPlugins = {
									{
										name = "@vue/typescript-plugin",
										location = vue_language_server_path,
										languages = { "vue" },
										configNamespace = "typescript",
									},
								},
							},
						},
					},
				},
				vue_ls = {
					cmd = { mason_bin .. "/vue-language-server", "--stdio" },
					root_markers = {
						"package.json",
						"vite.config.js",
						"vite.config.ts",
						"vue.config.js",
						"vue.config.ts",
						".git",
					},
				},
				yamlls = {
					settings = {
						yaml = {
							format = { enable = true },
							validate = true,
							completion = true,
						},
					},
				},
				jsonls = {
					settings = {
						json = {
							validate = { enable = true },
							format = { enable = true },
						},
					},
				},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`vtsls`) will work just fine
				-- vtsls = {},
				--

				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
				prismals = {},
			}

			-- Ensure the servers and tools above are installed
			--
			-- To check the current status of installed tools and/or manually install
			-- other tools, you can run
			--    :Mason
			--
			-- You can press `g?` for help in this menu.
			--
			-- `mason` had to be setup earlier: to configure its options see the
			-- `dependencies` table for `nvim-lspconfig` above.
			--
			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			-- LSP servers are installed by mason-lspconfig below. Keep this list
			-- limited to CLI tools so the two Mason installers do not duplicate work.
			local tools = {
				"stylua", -- Used to format Lua code
				"shfmt",
				"prettier",
				"prettierd",
				"clang-format",
				"gofumpt",
				"goimports",
				"golangci-lint",
				"markdownlint",
				"black",
				"checkstyle",
				"pylint",
			}
			require("mason-tool-installer").setup({
				ensure_installed = tools,
				start_delay = 1000,
				debounce_hours = 24,
			})

			for server_name, server in pairs(servers) do
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				vim.lsp.config(server_name, server)
			end

			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = {
					"lua_ls", -- Lua LSP for config
					-- WebDev
					"vtsls",
					"vue_ls",
					"yamlls",
					"jsonls",
					"cssls",
					"html",
					"emmet_ls",
					"astro",

					"lemminx",
					"bashls",
					"pyright",
					"clangd",
					"gopls",
					"prismals",
					"markdown_oxide",
					"jdtls",
				},
			})
		end,
	},
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-k>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-j>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{
						name = "lazydev",
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},
}
