return {
    "SmiteshP/nvim-navbuddy",
    requires = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
        "numToStr/Comment.nvim", -- Optional
        "nvim-telescope/telescope.nvim", -- Optional
    },
    opts = {
        window = { size = "70%" },
        lsp = { auto_attach = true },
    },
    cmd = { "Navbuddy" },
    keys = {
        { "<leader>nb", "<cmd>Navbuddy<CR>", desc = "Open navbuddy to brows symbols in your buffer" },
    },
}
