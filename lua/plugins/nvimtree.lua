return {
    "nvim-tree/nvim-tree.lua",
    name = "nvim-tree",
    opts = {
        sort = {
            sorter = "case_sensitive",
        },
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
            highlight_git = true,
        },
        filters = {
            dotfiles = true,
        },
    },
    config = function(_, opts)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require('nvim-tree').setup(opts)

        vim.keymap.set("n", "<leader>ee", vim.cmd.NvimTreeToggle, { desc = "toggle the directory tree" })
        vim.keymap.set("n", "<leader>ef", vim.cmd.NvimTreeFindFile, { desc = "find the file in directory tree"})
        vim.keymap.set("n", "<leader>er", vim.cmd.NvimTreeRefresh, { desc = "refresh the directory tree" })
        vim.keymap.set("n", "<leader>et", vim.cmd.NvimTreeFocus, { desc = "focus the directory tree" })
        vim.keymap.set("n", "<leader>ec", vim.cmd.NvimTreeCollapse, { desc = "close the directory tree recursively" })

        vim.keymap.set(
            "n",
            "<leader>ei",
            function()
                vim.cmd("NvimTreeResize +10")
            end,
            { desc = "increase NvimTree width" }
        )
        vim.keymap.set(
        "n",
        "<leader>ed",
        function()
            vim.cmd("NvimTreeResize -10")
        end,
        { desc = "decrease NvimTree width" }
        )


    end
}