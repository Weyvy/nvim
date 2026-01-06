return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		sections = {
			-- pick the section where you currently show filename
			-- most setups use lualine_c for filename
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
		},
	},
}
