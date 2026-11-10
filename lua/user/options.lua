local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true
opt.cindent = true
opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = vim.env.HOME .. "/.vim/undodir"
opt.undofile = true

opt.colorcolumn = "80"
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.updatetime = 50
opt.incsearch = true
opt.hlsearch = true

-- views can only be fully collapsed with the global statusline
opt.laststatus = 3
opt.splitkeep = "screen"

-- Rounded borders for every floating window (hover, diagnostics, Mason, ...)
opt.winborder = "rounded"

-- Native as-you-type completion: language server first ("o"), then buffer words
opt.autocomplete = true
opt.complete = "o,.,w,b"
opt.completeopt = { "menuone", "noselect", "noinsert", "popup", "fuzzy" }
