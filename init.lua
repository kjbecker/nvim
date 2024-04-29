local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"SidOfc/carbon.nvim",
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept_line = "<C-j>",
					next = "<C-l>",
					prev = "<C-h>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
	{ "nvim-treesitter/nvim-treesitter" },
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"neovim/nvim-lspconfig",
		servers = {
			"rust_analyzer",
			"tsserver",
			"pyright",
			"clangd",
			"bashls",
			"dockerls",
			"html",
			"cssls",
			"jsonls",
			"yamlls",
		},
	},
})

require("carbon").setup()

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"rust",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"python",
		"html",
		"css",
		"json",
		"yaml",
		"typescript",
		"javascript",
		"tsx",
		"cpp",
		"c",
		"bash",
		"dockerfile",
	},
	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
	},
})

vim.cmd([[colorscheme slate]])
vim.cmd([[set number]])

vim.cmd [[
  command! -nargs=0 MakeRunTerminal :botright terminal make run
]]
vim.cmd [[
  command! -nargs=0 MakeTestTerminal :botright terminal make test
]]
-- REMAPS
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>mr", ":MakeRunTerminal<CR>", { noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>mt", ":MakeTestTerminal<CR>", { noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>aa", ":Lcarbon<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>cp",
	':lua require("copilot.suggestion").is_visible()<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>fmt", ":lua require('conform').format()", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<S-S>", ":Copilot panel<CR>", { noremap = true, silent = true })


--Autothings
vim.cmd[[
autocmd InsertLeave * write
]]

