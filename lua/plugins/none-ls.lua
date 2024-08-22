--[[This module is used for Code Formatting and Linting]]
return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local sources = {
            -- Formatters
            null_ls.builtins.formatting.stylua.with({
                extra_args = { { "indent_type", "spaces" }, { "collapse_simple_statement", "always" } }, -- This is for LUA, which the config is written in
            }),
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.prettier.with({ extra_args = { "--tab-width", 4 } }),
            null_ls.builtins.formatting.shfmt,

            null_ls.builtins.completion.tags,

            -- Linters
            -- null_ls.builtins.diagnostics.checkstyle.with({ extra_args = { "-c", "/sun_checks.xml" } }),
        }
        null_ls.setup({ sources = sources })

        -- this is the keybind for formatting
        vim.keymap.set("n", "<leader>g", vim.lsp.buf.format, {})
        vim.keymap.set("n", "<leader>fi", "gg=G<C-o>", {}) -- Indent whole file
    end,
}
