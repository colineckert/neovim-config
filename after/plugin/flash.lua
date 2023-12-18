vim.keymap.set('n', '<leader>ls', function() require("flash").jump() end)
vim.keymap.set('n', '<leader>lt', function() require("flash").treesitter() end)
vim.keymap.set('n', '<leader>lr', function() require("flash").treesitter_search() end)

