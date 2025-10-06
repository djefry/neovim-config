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

--vim.api.nvim_create_autocmd("BufWritePost", {
--  pattern = "*.py",
--  callback = function()
--    local ruff_bin = vim.fn.expand("$HOME/.pyenv/versions/3.12.0/envs/py3nvim/bin/ruff")
--    -- fix lint issues
--    vim.fn.system({ruff_bin, "check", "--fix", vim.fn.expand("%")})
--    -- format code (adds trailing commas, rewraps long lines, etc.)
--    vim.fn.system({ruff_bin, "format", vim.fn.expand("%")})
--    -- reload buffer after external change
--    vim.cmd("edit")
--  end,
--})

-- Ruff format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ async = false, name = "ruff" })
  end,
})

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
