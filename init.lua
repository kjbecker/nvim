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
					accept_line = "<F7>",
					next = "<F8>",
					prev = "<F6>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
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
    {'pbrisbin/vim-mkdir'},
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',  -- LSP source
            'hrsh7th/cmp-buffer',    -- Buffer source
            'hrsh7th/cmp-path',      -- Path source
            'hrsh7th/cmp-cmdline',   -- Command line source
            'L3MON4D3/LuaSnip',      -- Snippet engine
            'saadparwaiz1/cmp_luasnip',  -- Snippet source
        },
        config = function()
              local cmp = require'cmp'
              cmp.setup({
                snippet = {
                  expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                  end,
                },
                mapping = cmp.mapping.preset.insert({
                  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                  ['<C-f>'] = cmp.mapping.scroll_docs(4),
                  ['<C-Space>'] = cmp.mapping.complete(),
                  ['<C-e>'] = cmp.mapping.abort(),
                  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
                }),
                sources = cmp.config.sources({
                  { name = 'nvim_lsp' },
                  { name = 'luasnip' },
                }, {
                  { name = 'buffer' },
                })
              })

              -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
              cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                  { name = 'buffer' }
                }
              })

              -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
              cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                  { name = 'path' }
                }, {
                  { name = 'cmdline' }
                })
              })

              local capabilities = require('cmp_nvim_lsp').default_capabilities()
        end
    }


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

	  incremental_selection = {
	    enable = true,
	    keymaps = {
	      init_selection = "gnn",
	      node_incremental = "grn",
	      scope_incremental = "grc",
	      node_decremental = "grm",
	    },
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
vim.cmd([[set tabstop=4]])
vim.cmd([[set expandtab]])
vim.cmd [[
  command! -nargs=0 MakeRunTerminal :botright terminal make run
]]
vim.cmd [[
  command! -nargs=0 MakeTestTerminal :botright terminal make test
]]


vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end
})

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

