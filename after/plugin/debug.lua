-- local util = require('lspconfig.util')
require('dap-python').setup("/home/wandashare/.pyenv/versions/debugpy/bin/python")

-- Custom setup to run debug
table.insert(require('dap').configurations.python, {
  name = 'Flask',
  type = 'python',
  request = 'launch',
  module = "flask",
  env = {["FLASK_APP"] = "wsgi.py", ["FLASK_ENV"] = "development"}, -- change wsgi.py to your main app
  args = {"run", "--no-debugger"},  -- "--no-debugger" to avoid debugger clash we only use debugger from debugpy
  pythonArgs = {"-Xfrozen_modules=off", "-Xdev"}, -- disable frozen module
  console= "integratedTerminal"
})

-- Custom setup to run debug with eager-load
table.insert(require('dap').configurations.python, {
  name = 'Flask Eager Load with Gevent',
  type = 'python',
  request = 'launch',
  module = "flask",
  env = {["FLASK_APP"] = "wsgi.py", ["FLASK_ENV"] = "development"}, -- change wsgi.py to your main app
  args = {"run", "--eager-loading", "--no-debugger" },  -- "--no-debugger" t to avoid debugger clash we only use debugger from debugpy
  pythonArgs = {"-Xfrozen_modules=off", "-Xdev"}, -- disable frozen module
  console = "integratedTerminal",
  gevent = true
})

table.insert(require('dap').configurations.python, {
  name= "Pytest: Current File",
  type= "python",
  request= "launch",
  module= "pytest",
  args= {
      "${file}",
      "-sv",
      "--log-cli-level=INFO",
      "--log-file=test_out.log"
  },
  console= "integratedTerminal",
})

-- Custom setup to run using container
-- table.insert(require('dap').configurations.python, {
--   name = 'Flask Container Run',
--   type = 'python',
--   request = 'attach',
--   pythonArgs = "docker command debugpy --wait-for-client --listen 0.0.0.0:5678",
--   connect = function()
--     local host = vim.fn.input('Host [127.0.0.1]: ')
--     host = host ~= '' and host or '127.0.0.1'
--     local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
--     return { host = host, port = port }
--   end,
--   pathMappings = function()
--     local cwd = '${workspaceFolder}'
--     local local_path = vim.fn.input('Local path mapping [' .. cwd .. ']: ')
--     local_path = local_path ~= '' and local_path or cwd
--     local remote_path = vim.fn.input('Remote path mapping [.]: ')
--     remote_path = remote_path ~= '' and remote_path or '.'
--     return { { localRoot = local_path, remoteRoot = remote_path }, }
--   end
-- })

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
