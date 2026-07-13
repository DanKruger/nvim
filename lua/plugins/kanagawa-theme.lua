return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			theme = "wave",
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function()
				return {
					NoiceCmdlinePopup = { bg = "none" },
					NoiceCmdlinePopupBorder = { bg = "none" },
					NoiceCmdlinePopupBorderCalculator = { bg = "none" },
					NoiceCmdlinePopupBorderCmdline = { bg = "none" },
					NoiceCmdlinePopupBorderFilter = { bg = "none" },
					NoiceCmdlinePopupBorderHelp = { bg = "none" },
					NoiceCmdlinePopupBorderIncRename = { bg = "none" },
					NoiceCmdlinePopupBorderInput = { bg = "none" },
					NoiceCmdlinePopupBorderLua = { bg = "none" },
					NoiceCmdlinePopupBorderSearch = { bg = "none" },
					NoicePopup = { bg = "none" },
					NoicePopupBorder = { bg = "none" },
					NoicePopupmenu = { bg = "none" },
					NoicePopupmenuBorder = { bg = "none" },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa-wave")
	end,
}
