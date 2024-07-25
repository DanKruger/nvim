return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [['||\   ||`  '||''''|  .|''''|,  \\       //  |''||''|  '||\   /||` ]],
            [[ ||\\  ||    ||   .   ||    ||   \\     //      ||      ||\\.//||  ]],
            [[ || \\ ||    ||'''|   ||    ||    \\   //       ||      ||     ||  ]],
            [[ ||  \\||    ||       ||    ||     \\ //        ||      ||     ||  ]],
            [[.||   \||.  .||....|  `|....|'      \\/      |..||..|  .||     ||. ]],
        }
        -- Set menu keys
        dashboard.section.buttons.val = {
            dashboard.button("e", "󰝒  > New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("f", "󰈞  > Find file", ":cd ./ | Telescope find_files<CR>"),
            dashboard.button("S", "󰙅  > Open file tree", "<cmd>Neotree filesystem reveal left<CR>"),
            dashboard.button("r", "󱋡  > Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("q", "󰅙  > Quit NVIM", ":qa<CR>"),
        }

        alpha.setup(dashboard.opts)

        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}
