---@diagnostic disable: undefined-field
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local theme = require("kanagawa.colors").setup().theme
        local kanagawa = {}
        kanagawa.normal = {
            a = { bg = theme.syn.fun, fg = theme.ui.bg_m3 },
            b = { bg = theme.diff.change, fg = theme.syn.fun },
            c = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
        }
        kanagawa.insert = {
            a = { bg = theme.diag.ok, fg = theme.ui.bg },
            b = { bg = theme.ui.bg, fg = theme.diag.ok },
        }
        kanagawa.command = {
            a = { bg = theme.syn.operator, fg = theme.ui.bg },
            b = { bg = theme.ui.bg, fg = theme.syn.operator },
        }
        kanagawa.visual = {
            a = { bg = theme.syn.keyword, fg = theme.ui.bg },
            b = { bg = theme.ui.bg, fg = theme.syn.keyword },
        }
        kanagawa.replace = {
            a = { bg = theme.syn.constant, fg = theme.ui.bg },
            b = { bg = theme.ui.bg, fg = theme.syn.constant },
        }
        kanagawa.inactive = {
            a = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            b = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim, gui = "bold" },
            c = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
        require("lualine").setup({
            options = {
                -- theme = "palenight",
                theme = kanagawa,
                component_separators = { left = "│", right = "│" },
                section_separators = { left = "", right = "" },
                -- section_separators = { left = "" , right = "" },
                -- section_separators = { left = " ", right = "" },
            },
            sections = {
                lualine_x = {
                    {
                        require("noice").api.status.mode.get,
                        cond = require("noice").api.status.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                },
            },
        })
    end,
}
