return {
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function() 
    require("todo-comments").setup {}

    vim.keymap.set('n', '<leader>tt', ':TodoTelescope<CR>')
    vim.keymap.set('n', '<leader>tl', ':TodoLocList<CR>')
  end
}
