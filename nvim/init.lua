vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.autoread = true
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "checktime",
})

require("plugins")
require("keymaps")
