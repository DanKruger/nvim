return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "sharkdp/fd",
            {
                "nvim-telescope/telescope-fzf-native.nvim", build = "make"
            }
        },
        config = function()
            require("telescope").setup({
                pickers = {
                    -- find_files = { theme = 'ivy' },
                    -- live_grep = { theme = 'ivy' }
                },
                defaults = {
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = { width = 0.7 },
                    },
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
            vim.keymap.set("n", "<C-p>", builtin.find_files, {})
            vim.keymap.set("n", "<C-g>", builtin.git_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
            vim.keymap.set("n", "gr", builtin.lsp_references, {})
        end,
    },
}
