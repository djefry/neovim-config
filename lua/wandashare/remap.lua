-- use spase key as leader

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- moving line under visual cursor up one line
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- moving line under visual cursor down one line

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- replace but preserve the yank memory
vim.keymap.set("x", "<leader>p", "\"_dP")

-- find and replace current buffer
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- make the file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

local function copy_to_clipboard(text, label)
  if text == "" or not text then
    vim.notify("No file associated with this buffer!", vim.log.levels.WARN)
    return
  end
  vim.fn.setreg("+", text)
  vim.notify('Copied ' .. label .. ': "' .. text .. '"', vim.log.levels.INFO)
end

-- copy absolute path
vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  copy_to_clipboard(path, "absolute path")
end, { desc = "Copy absolute file path" })

-- copy relative path (git root if available, else CWD)
vim.keymap.set("n", "<leader>cr", function()
  local path = vim.fn.expand("%:p")
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local rel
  if vim.v.shell_error == 0 and git_root and git_root ~= "" then
    rel = vim.fn.fnamemodify(path, ":." .. git_root)
  else
    rel = vim.fn.fnamemodify(path, ":.")
  end
  copy_to_clipboard(rel, "relative path")
end, { desc = "Copy relative file path" })

-- copy filename only
vim.keymap.set("n", "<leader>cfn", function()
  local fname = vim.fn.expand("%:t")
  copy_to_clipboard(fname, "filename")
end, { desc = "Copy filename only" })
