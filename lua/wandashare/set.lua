vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = {"120"}

vim.g.mapleader = " "

vim.g.python3_host_prog = "$HOME/.pyenv/versions/3.12.0/envs/py3nvim/bin/python3"


-- Two spaces tabstop settings
local two_space_filetypes = {
  "javascript", "typescript", "typescriptreact",
  "json", "jsonc", "yaml", "yml",
  "css", "scss", "sass", "html", "vue", "markdown"
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = two_space_filetypes,
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Toggleable Auto Format on Save
-- Global flag
_G.auto_format_enabled = true

-- Toggle function
vim.keymap.set('n', '<leader>fos', function()
  _G.auto_format_enabled = not _G.auto_format_enabled
  print("AutoFormat: " .. (_G.auto_format_enabled and "ON" or "OFF"))
end, { desc = 'Toggle auto format on save' })
