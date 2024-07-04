local dap_python require('dap-python').setup("/home/wandashare/.pyenv/versions/debugpy/bin/python")
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require('nvim-dap-projects').search_project_config()
-- vim.keymap.set("n", "<leader>dn", require('dap-python').test_method())
-- vim.keymap.set("n", "<leader>df", require('dap-python').test_class())
-- vim.keymap.set("v", "<leader>ds", require('dap-python').debug_selection())
