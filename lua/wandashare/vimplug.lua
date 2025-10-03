local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- telescome for fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug ('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
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

-- git gutter to show the changes
-- Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'

-- lsp server
--  Uncomment these if you want to manage LSP servers from neovim
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
-- LSP Support
Plug 'neovim/nvim-lspconfig'
-- Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'

-- nvim tmux navigator
Plug 'alexghergh/nvim-tmux-navigation'

-- remove trailing whitespace
Plug 'cappyzawa/trim.nvim'

-- show function argument hints
Plug 'ray-x/lsp_signature.nvim'

-- rainbow indent
Plug 'lukas-reineke/indent-blankline.nvim'

-- python refactoring
Plug 'python-rope/ropevim'

-- neovim statusline
Plug 'nvim-lualine/lualine.nvim'
-- If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'

-- Not support in KDE konsole !
-- vim pets
-- Plug 'giusgad/hologram.nvim'
-- Plug 'MunifTanjim/nui.nvim'
-- Plug ('giusgad/pets.nvim', { requires = {'giusgad/hologram.nvim', 'MunifTanjim/nui.nvim'}})

-- Python Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'ldelossa/nvim-dap-projects'
Plug 'nvim-neotest/nvim-nio'
Plug 'theHamsta/nvim-dap-virtual-text'

-- File Explorer
Plug 'stevearc/oil.nvim'

-- Mini AI (text selector)
Plug 'nvim-mini/mini.ai'

-- AI Tool
-- Some of deps already installed above
-- Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'

-- Optional deps
-- Plug 'hrsh7th/nvim-cmp'
-- Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'
Plug 'stevearc/dressing.nvim' -- for enhanced input UI
Plug 'folke/snacks.nvim' -- for modern input UI

-- Yay, pass source=true if you want to build from source
Plug ('yetone/avante.nvim', {branch='main', ['do']='make' })

vim.call('plug#end')
