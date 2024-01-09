return {
  'nvim-telescope/telescope.nvim', version = '0.1.4',
  dependencies = {
    {'nvim-lua/plenary.nvim'},
    {'debugloop/telescope-undo.nvim'},
  },
  config = function ()
    local builtin = require('telescope.builtin')
    require("telescope").load_extension("undo")

    vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
    vim.keymap.set('n', '<C-f>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<leader>sr', builtin.resume, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<cr>")
  end
}

-- REFERENCE
-- undo = {
--   mappings = {
--     i = {
--       ["<cr>"] = require("telescope-undo.actions").yank_additions,
--       ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
--       ["<C-cr>"] = require("telescope-undo.actions").restore,
--       -- alternative defaults, for users whose terminals do questionable things with modified <cr>
--       ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
--       ["<C-r>"] = require("telescope-undo.actions").restore,
--     },
--     n = {
--       ["y"] = require("telescope-undo.actions").yank_additions,
--       ["Y"] = require("telescope-undo.actions").yank_deletions,
--       ["u"] = require("telescope-undo.actions").restore,
--     },
--   },
-- },
