vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/Saghen/blink.lib",
	"https://github.com/Saghen/blink.cmp",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/kdheepak/lazygit.nvim",
})

-- Theme
vim.cmd.colorscheme("tokyonight")

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"pyright",
		"typescript-language-server",
		"ruff",
		"lua-language-server",
		"stylua",
	},
})

-- Completion
require("blink.cmp").setup({
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
})

-- Diagnostics
vim.diagnostic.config({ virtual_text = false })
require("tiny-inline-diagnostic").setup()

-- Formatting
local conform_util = require("conform.util")

local function has_config(names)
	return function(_, ctx)
		return vim.fs.find(names, { upward = true, path = vim.fs.dirname(ctx.filename) })[1] ~= nil
	end
end

require("conform").setup({
	formatters = {
		prettier = {
			command = "node_modules/.bin/prettier",
			cwd = conform_util.root_file({ "package.json" }),
			require_cwd = true,
			condition = has_config({
				".prettierrc",
				".prettierrc.json",
				".prettierrc.js",
				".prettierrc.cjs",
				".prettierrc.mjs",
				".prettierrc.yaml",
				".prettierrc.yml",
				"prettier.config.js",
				"prettier.config.cjs",
				"prettier.config.mjs",
			}),
		},
		eslint = {
			command = "node_modules/.bin/eslint",
			cwd = conform_util.root_file({ "package.json" }),
			require_cwd = true,
			condition = has_config({
				".eslintrc",
				".eslintrc.js",
				".eslintrc.cjs",
				".eslintrc.json",
				".eslintrc.yaml",
				".eslintrc.yml",
				"eslint.config.js",
				"eslint.config.cjs",
				"eslint.config.mjs",
				"eslint.config.ts",
			}),
		},
	},
	formatters_by_ft = {
		javascript = { "eslint", "prettier" },
		typescript = { "eslint", "prettier" },
		javascriptreact = { "eslint", "prettier" },
		typescriptreact = { "eslint", "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		python = { "ruff_format" },
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})

-- File tree
require("nvim-tree").setup()

-- Flash
require("flash").setup()
