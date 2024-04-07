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
        "SidOfc/carbon.nvim"
    },
	{
	  "zbirenbaum/copilot.lua",
	  cmd = "Copilot",
	  build = ":Copilot auth",
	  opts = {
	    suggestion = { 
		enabled = true ,
		auto_trigger = true,
		keymap = {
			accept_line = "<C-k>",
			next = "<C-j>",
			prev = "<C-h>",
		}
			
		},
	    panel = { enabled = false },
	    filetypes = {
	      markdown = true,
	      help = true,
	    },
	  },
	},
    {"nvim-treesitter/nvim-treesitter"},
	{
	  "nvim-treesitter/nvim-treesitter",
	  opts = function(_, opts)
	    opts.ensure_installed = opts.ensure_installed or {}
	    vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
	  end,
	},
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
    -- or                              , branch = '0.1.x',
          dependencies = { 'nvim-lua/plenary.nvim' }
    },
	
		


}
)


require('carbon').setup()

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "rust", "lua", "vim", "vimdoc", "query", "python", "html", "css", "json", "yaml", "typescript", "javascript", "tsx", "cpp", "c", "bash", "dockerfile"},
    sync_install = false,
    auto_install = true,
  
    highlight = {        
      enable = true,
      additional_vim_regex_highlighting = true,
    },
  }

vim.cmd[[colorscheme slate]]
vim.cmd[[set number]]

-- REMAPS
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<leader>aa', ':Lcarbon<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cp', ':lua require("copilot.suggestion").is_visible()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-S>', ':Copilot panel<CR>', { noremap = true, silent = true })
