-- [[ Autocomplete Engine ]]

vim.pack.add({
	{
		src = "https://github.com/saghen/blink.compat",
		name = "blink.compat",
	},
	{
		src = "https://github.com/saghen/blink.cmp",
		name = "blink.cmp",
	},
	{
		src = "https://github.com/zbirenbaum/copilot.lua",
		name = "copilot.lua",
	},
	{
		src = "https://github.com/fang2hou/blink-copilot",
		name = "blink-copilot",
	},
	{
		src = "https://github.com/ray-x/cmp-sql",
		name = "cmp-sql",
	},
	{
		src = "https://github.com/ribru17/blink-cmp-spell",
		name = "blink-cmp-spell",
	},
})

require("copilot").setup({
	suggestion = {
		enabled = false,
	},
	panel = {
		enabled = false,
	},
})

require("blink.cmp").setup({
	keymap = {
		preset = "default",
	},

	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},

		menu = {
			auto_show = true,

			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind", "kind_icon" },
					{ "source_name" },
				},

				components = {
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
	},

	sources = {
		default = {
			"copilot",
			"lsp",
			"path",
			"buffer",
			"sql",
			"spell",
		},

		providers = {
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 400,
				async = true,
				opts = {
					max_completions = 3,
					max_attempts = 2,
				},
			},

			sql = {
				name = "sql",
				module = "blink.compat.source",
				score_offset = 100,
				opts = {},
				should_show_items = function()
					return vim.tbl_contains({ "sql" }, vim.bo.filetype)
				end,
			},

			spell = {
				name = "Spell",
				module = "blink-cmp-spell",
				score_offset = 50,
				opts = {
					enable_in_context = function()
						local curpos = vim.api.nvim_win_get_cursor(0)

						local captures = vim.treesitter.get_captures_at_pos(
							0,
							curpos[1] - 1,
							curpos[2] - 1
						)

						local in_spell_capture = false

						for _, cap in ipairs(captures) do
							if cap.capture == "spell" then
								in_spell_capture = true
							elseif cap.capture == "nospell" then
								return false
							end
						end

						return in_spell_capture
					end,
				},
			},

			lsp = {
				score_offset = 500,
			},

			path = {
				score_offset = 300,
			},

			buffer = {
				score_offset = 200,
			},
		},
	},

	cmdline = {
		keymap = {
			preset = "inherit",
		},
		completion = {
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ":"
				end,
			},
		},
	},

	fuzzy = {
		implementation = "prefer_rust_with_warning",
		sorts = {
			function(a, b)
				local sort = require("blink.cmp.fuzzy.sort")

				if a.source_id == "spell" and b.source_id == "spell" then
					return sort.label(a, b)
				end
			end,
			"score",
			"kind",
			"label",
		},
	},

	signature = {
		enabled = true,
	},
})