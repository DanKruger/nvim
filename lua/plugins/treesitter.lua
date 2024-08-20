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
            ensure_installed = { "java", "javascript", "html", "css", "markdown", "python", "lua", "xml", "json" },
            modules = {},
            auto_install = true,
            sync_install = true,
            ignore_install = {},
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        })
    end,
}
