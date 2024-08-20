return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                -- Install necessary formatters and linters
                ensure_installed = { "shfmt", "prettier", "black", "checkstyle", "pylint" },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = true,
                -- Install necessary LSP
                ensure_installed = {
                    "lua_ls",
                    "lemminx",
                    "bashls",
                    "pylsp",
                    "tsserver",
                    "cssls",
                    "html",
                    "markdown_oxide",
                    "jdtls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "antosha417/nvim-lsp-file-operations", config = true },
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lsp_config = require("lspconfig")
            lsp_config.pylsp.setup({ capabilities = capabilities })
            lsp_config.lemminx.setup({ capabilities = capabilities })
            lsp_config.bashls.setup({ capabilities = capabilities })
            lsp_config.tsserver.setup({ capabilities = capabilities })
            lsp_config.html.setup({ capabilities = capabilities })
            lsp_config.cssls.setup({ capabilities = capabilities })
            lsp_config.lua_ls.setup({ capabilities = capabilities })
            lsp_config.jdtls.setup({ capabilities = capabilities })
            lsp_config.markdown_oxide.setup({ capabilities = capabilities })

            vim.keymap.set({ "n", "v" }, "<C-n>", vim.lsp.buf.code_action, {}) -- Control + n
            local _border = "single"
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
            vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border })
            vim.diagnostic.config({ float = { border = _border } })
        end,
    },
}
