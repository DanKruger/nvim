return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        -- this is where you add language support for highlighting and syntax
        treesitter.setup({
            ensure_installed = { "java", "javascript", "html", "css", "python", "lua", "xml", "json" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
        })
    end,
}
