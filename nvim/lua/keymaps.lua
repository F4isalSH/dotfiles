local map = vim.keymap.set

-- General
map("i", "hh", "<Esc>", { desc = "Exit insert mode" })
map("t", "hh", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>qq", "<cmd>q!<cr>", { desc = "Quit without saving" })
map("n", "<leader>ss", "<cmd>w<cr>", { desc = "Save file" })

-- Telescope
local telescope = require("telescope.builtin")
map("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
map("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", telescope.buffers, { desc = "Buffers" })

-- Windows: switch
map("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
map("n", "<leader>wl", "<C-w>l", { desc = "Window right" })

-- Windows: create
map("n", "<leader>wch", "<cmd>vsplit<cr>", { desc = "Split horizontal" })
map("n", "<leader>wcv", "<cmd>split<cr>", { desc = "Split vertical" })

-- Windows: close
map("n", "<leader>wq", "<cmd>close<cr>", { desc = "Close window" })

-- File tree
map("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })

-- Terminal
map("n", "<leader>tt", "<cmd>terminal<cr>", { desc = "Open terminal" })

-- Flash
map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash jump" })

-- Lazygit
map("n", "<leader>gg", "<cmd>LazyGit<cr>")

-- Custom popup terminal
map("n", "<leader>gt", function()
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	})
	vim.fn.termopen(vim.o.shell)
	vim.cmd("startinsert")
end, { desc = "Toggle terminal" })
