require('dap-python').setup("/home/wandashare/.pyenv/versions/debugpy/bin/python")
-- Custom setum to run debug
-- table.insert(require('dap').configurations.python, {
--   type = 'python',
--   request = 'launch',
--   name = 'My Configurations',
--   program = "flask",
--   args = {"run", "--eager-load"}
-- })

require('nvim-dap-projects').search_project_config()
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
vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

-- Debug key mapping, can use this or click the button on nvim-dap-gui
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', dap.step_over)
vim.keymap.set('n', '<F7>', dap.step_into)
vim.keymap.set('n', '<F8>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
