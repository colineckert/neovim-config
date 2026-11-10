local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex)

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Center buffer while navigating
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "{", "{zz")
map("n", "}", "}zz")
map("n", "G", "Gzz")
map("n", "gg", "ggzz")
map("n", "gd", "gdzz")
map("n", "<C-i>", "<C-i>zz")
map("n", "<C-o>", "<C-o>zz")
map("n", "%", "%zz")
map("n", "*", "*zz")
map("n", "#", "#zz")

map("n", "L", "$")
map("n", "H", "^")

map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map("n", "Q", "<nop>")
map("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics
map("n", "gh", vim.diagnostic.open_float)
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

map("n", "<leader>rw", "<cmd>RotateWindows<cr>", { desc = "[R]otate [W]indows" })
map("n", "gx", ":sil !open <cWORD><cr>", { silent = true })

-- Keep the selection after indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Treesitter incremental selection, native in 0.12 (`an` grows, `in` shrinks)
map("n", "<C-space>", "van", { remap = true, desc = "Start incremental selection" })
map("x", "<C-space>", "an", { remap = true, desc = "Grow selection" })
map("x", "<bs>", "in", { remap = true, desc = "Shrink selection" })

-- Native undotree (bundled with Nvim 0.12)
vim.cmd.packadd("nvim.undotree")
map("n", "<leader>u", vim.cmd.Undotree, { desc = "Toggle [U]ndotree" })
