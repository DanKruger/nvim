return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = {
        "Neotree",
    },
    keys = {
        { "<C-e>", "<cmd>Neotree focus filesystem reveal left <CR>", desc = "Open filesystem to the left" },
    },
    config = function()
        require("neo-tree").setup({
            use_libuv_file_watcher = true,
            close_if_last_window = true,
            filesystem = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                filtered_items = {
                    always_show = {
                        ".gitignore",
                        ".env",
                        ".gitlab-ci.yml",
                    },
                },
            },
            buffers = {
                bind_to_cwd = true,
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
            },
        })
    end,
}
