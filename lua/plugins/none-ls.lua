return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Formatters
                null_ls.builtins.formatting.stylua, -- This is for LUA, which the config is written in
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.biome,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.shfmt,
                -- Linters
                null_ls.builtins.diagnostics.checkstyle.with({
                    extra_args = { "-c", "/sun_checks.xml" },
                }),
                -- null_ls.builtins.diagnostics.pylint,
            },
        })
        -- this is the keybind for formatting
        vim.keymap.set("n", "<leader>g", vim.lsp.buf.format, {})
        vim.keymap.set("n", "<leader>fi", "gg=G<CR>", {})
    end,
}
