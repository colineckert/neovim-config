-- ctrl+hjkl moves between nvim windows and, at the edge window, out to the
-- neighbouring tmux or Rex pane. Inside tmux this defers to vim-tmux-navigator;
-- inside Rex, ~/.config/rex/init.lua passes ctrl+hjkl through to nvim and this
-- hands focus back to Rex with `rex focus`.
vim.g.tmux_navigator_no_mappings = 1

local directions = {
	h = { wincmd = "h", tmux = "TmuxNavigateLeft", rex = "left" },
	j = { wincmd = "j", tmux = "TmuxNavigateDown", rex = "down" },
	k = { wincmd = "k", tmux = "TmuxNavigateUp", rex = "up" },
	l = { wincmd = "l", tmux = "TmuxNavigateRight", rex = "right" },
}

local function navigate(direction)
	if vim.env.TMUX then
		vim.cmd(direction.tmux)
		return
	end
	local window = vim.api.nvim_get_current_win()
	vim.cmd.wincmd(direction.wincmd)
	if vim.api.nvim_get_current_win() == window and vim.env.REX_SESSION then
		vim.system({ "rex", "focus", "-s", vim.env.REX_SESSION, direction.rex })
	end
end

for key, direction in pairs(directions) do
	vim.keymap.set("n", "<C-" .. key .. ">", function()
		navigate(direction)
	end, { silent = true, desc = "Navigate " .. direction.rex })
end
