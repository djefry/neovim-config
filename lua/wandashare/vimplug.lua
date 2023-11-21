local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- telescome for fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug ('nvim-telescope/telescope.nvim', { tag = '0.1.4' })
-- or                                , { branch = '0.1.x' }

-- nvim colorscheme
Plug ('folke/tokyonight.nvim', { as = tokyonight,
config = function()
	vim.cmd[[colorscheme tokyonight]]
end })

-- beter colorization
Plug ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
Plug 'nvim-treesitter/playground'

-- easy navigation within marked files
Plug 'ThePrimeagen/harpoon'

-- historical edit
Plug 'mbbill/undotree'

-- git fungitive
Plug 'tpope/vim-fugitive'

-- lsp server
--  Uncomment these if you want to manage LSP servers from neovim
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
-- LSP Support
Plug 'neovim/nvim-lspconfig'
-- Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

Plug ('VonHeikemen/lsp-zero.nvim', { branch = 'v3.x'})

-- nvim tmux navigator
Plug 'alexghergh/nvim-tmux-navigation'

-- vim pets
-- Plug 'giusgad/hologram.nvim'
-- Plug 'MunifTanjim/nui.nvim'
-- Plug ('giusgad/pets.nvim', { requires = {'giusgad/hologram.nvim', 'MunifTanjim/nui.nvim'}})

-- Python Debugger
-- Plug 'mfussenegger/nvim-dap'
-- Plug 'rcarriga/nvim-dap-ui'
-- Plug 'mfussenegger/nvim-dap-python'

vim.call('plug#end')
