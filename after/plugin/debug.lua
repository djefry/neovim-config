-- local util = require('lspconfig.util')
require('dap-python').setup("/home/wandashare/.pyenv/versions/debugpy/bin/python")

-- local function pwd()
--   return util.root_pattern('.git', 'setup.py', 'Makefile')(vim.fn.expand('%:p:h')) or vim.fn.getcwd()
-- end

-- Custom setup to run debug
-- table.insert(require('dap').configurations.python, {
--   type = 'python',
--   request = 'launch',
--   name = 'File Run',
--   program = "${file}",
--   cwd = pwd().."/",  -- Use Neovim's current working directory
--   env = {["PYTHONPATH"] = pwd().."/"},
-- })
--
-- table.insert(require('dap').configurations.python, {
--   type = 'python',
--   request = 'launch',
--   name = 'Flask Run',
--   program = "wsgi.py",
--   cwd = pwd().."/",  -- Use Neovim's current working directory
--   env = {["PYTHONPATH"] = pwd().."/"},
-- })
-- table.insert(require("dap").configurations.python, {
--   type = "python",
--   request = "attach",
--   connect = {
--     port = 5001,
--     host = "0.0.0.0",
--   },
--   mode = "remote",
--   name = "Container Attach (with choose remote dir)",
--   cwd = vim.fn.getcwd(),
--   pathMappings = {
--     {
--       localRoot = vim.fn.getcwd(),
--       remoteRoot = function()
--         -- NEED to choose correct folder for set breakpoints
--         return vim.fn.input("Container code folder > ", ".", "file")
--       end,
--     },
--   },
-- })

require('nvim-dap-projects').search_project_config()

-- Enable virtual text
require("nvim-dap-virtual-text").setup()

local dap, dapui = require("dap"), require("dapui")
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Make the breakpoints look nicer
vim.fn.sign_define('DapBreakpoint',{ text ='', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

-- Debug key mapping, can use this or click the button on nvim-dap-gui
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', dap.step_over)
vim.keymap.set('n', '<F7>', dap.step_into)
vim.keymap.set('n', '<F8>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
