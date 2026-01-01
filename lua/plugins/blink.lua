return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies =
    {
      'rafamadriz/friendly-snippets',
      "fang2hou/blink-copilot",
      opts = {
        max_completions = 1,
        max_attempts = 2,
      },
      "ray-x/cmp-sql",
      "ribru17/blink-cmp-spell",
    },

    version = '*',
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = {
          auto_show = true,
          draw = {
            columns = {
              { "label",      "label_description", gap = 1 },
              { "kind",       "kind_icon" },
              { "source_name" },
            },
            components = {
              label = {
                kind_icon = {
                  highlight =
                      function(ctx)
                        return { { group = ctx.kind_hl, priority = 20000 } }
                      end
                }

              }
            }

          },
        }
      },

      signature = { enabled = true },

      sources = {
        default = { 'lsp', 'copilot', 'path', 'buffer', 'sql', 'spell' },
        providers = {
          spell = {
            name = 'Spell',
            module = 'blink-cmp-spell',
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
                  if cap.capture == 'spell' then
                    in_spell_capture = true
                  elseif cap.capture == 'nospell' then
                    return false
                  end
                end
                return in_spell_capture
              end,
            },
          },
          sql = {
            name = "sql",
            module = "blink.compat.source",

            score_offset = 100,

            opts = {},
            should_show_items = function()
              return vim.tbl_contains(
                { "sql" },
                vim.o.filetype
              )
            end,
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 400,
            async = true,
            opts = {
              max_completions = 3
            }
          },
          lsp = {
            score_offset = 500,
          },
          path = {
            score_offset = 300,
          },
          snippets = {
            score_offset = 350,
          }
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          function(a, b)
            local sort = require('blink.cmp.fuzzy.sort')
            if a.source_id == 'spell' and b.source_id == 'spell' then
              return sort.label(a, b)
            end
          end,
          'score',
          'kind',
          'label',
        },
      }
    },

    opts_extend = { "sources.default" },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
    end
  },
}
