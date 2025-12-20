return {
    'nvim-telescope/telescope.nvim',
    dependencies = 
    {
    { 'nvim-lua/plenary.nvim' },
    {   'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' 
    },
    { "nvim-tree/nvim-web-devicons", opts = {} },
    },
    tag = 'v0.2.0',
    config = function(_, opts)
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope [F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

        vim.keymap.set('n', '<leader>fv', function()
        builtin.find_files({
            cwd = vim.fn.stdpath('config'),
            prompt_title = 'Neovim Config Files',
        })
        end, { desc = 'Find Neovim config files' })

    end
}
