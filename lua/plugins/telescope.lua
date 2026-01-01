return {
    'nvim-telescope/telescope.nvim',
    dependencies =
    {
        { 'nvim-lua/plenary.nvim' },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build =
            'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
        },
        { "nvim-tree/nvim-web-devicons", opts = {} },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        telescope.setup({
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        telescope.load_extension("fzf")

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope Find Files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>f;', builtin.registers, { desc = 'Telescope Find Rregisters' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>f.', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope Find Symbols' })
        vim.keymap.set('n', '<leader>fi', builtin.lsp_incoming_calls, { desc = 'Telescope Find Incoming calls' })
        vim.keymap.set('n', '<leader>fo', builtin.lsp_outgoing_calls, { desc = 'Telescope Find Outgoing calls' })
        vim.keymap.set('n', '<leader>fu', builtin.lsp_references, { desc = 'Telescope Find References' })
        vim.keymap.set("n", "<leader>fr", function()
            require("telescope.builtin").oldfiles({
                cwd_only = true,
            })
        end, { desc = "[F]ind [R]ecent (cwd)" })
        vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols,
            { desc = 'Telescope Find Workspace Symbols' })
        vim.keymap.set('n', '<leader>fq', builtin.diagnostics, { desc = 'Telescope Find Diagnostics' })
        vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })
        vim.keymap.set('n', '<leader>fv', function()
            builtin.find_files({
                cwd = vim.fn.stdpath('config'),
                prompt_title = 'Neovim Config Files',
            })
        end, { desc = 'Find Neovim config files' })
        vim.keymap.set("n", "gD", builtin.lsp_type_definitions, { desc = "[G]oto [T]ype definiton" })
        vim.keymap.set("n", "<leader>cs", "<cmd>Telescope colorscheme<CR>", {
            desc = "Live colorscheme preview",
        })
    end
}
