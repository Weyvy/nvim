return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    {
        "tpope/vim-fugitive",
        config = function(_, opts)
            -- Helpful keymaps for Git operations
            vim.keymap.set('n', '<leader>gs', ':Git<CR>')
            vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>')
            vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
            vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
            vim.keymap.set('n', '<leader>gm', ':Git mergetool<CR>')
            vim.keymap.set('n', '<leader>gr', ':Gread!<CR>', { desc = 'Git restore file (HEAD)' })

            -- Improve diff experience
            vim.opt.diffopt:append('algorithm:patience')
            vim.opt.diffopt:append('indent-heuristic')
        end
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua",              -- optional
            "nvim-mini/mini.pick",           -- optional
            "folke/snacks.nvim",             -- optional
        },
        cmd = "Neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
        }
    }
}
