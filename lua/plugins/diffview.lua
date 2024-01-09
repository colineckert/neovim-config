return {
  'sindrets/diffview.nvim',
  config = function ()
    require('diffview').setup({
      diff_binaries = false,    -- Show diffs for binaries
    })

    vim.keymap.set('n', '<leader>df', ':DiffviewFileHistory<CR>')
    vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>')
  end
}
