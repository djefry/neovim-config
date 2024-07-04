local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.diagnostic.config({
    virtual_text = true
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls', 'cucumber_language_server', 'dockerls', 'docker_compose_language_service',
    'jsonls', 'ltex', 'marksman', 'spectral', 'sqlls', 'yamlls',
    'lua_ls'
  },
  handlers = {
    lsp_zero.default_setup,
  },
})


require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      keys = {
          { "K", false },
      },
      plugins = {
        pycodestyle = {
          enabled = true,
          maxLineLength = 120
        },
        pylint = {
          enabled = false,
        },
        pydocstyle = {
          ignore = {"D203", "D204", "D404", "D407", "D205", "D212", "D400", "D415"},
          enabled = true
        },
        pylsp_mypy = {
          enabled = false
        },
        pylsp_rope = {
          enabled = true
        },
        flake8 = {
          enabled = false
        },
        isort = {
          enabled = true
        },
        jedi = {
          auto_import_modules = true
        },
        jedi_completion = {
          enabled = true
        },
        jedi_definition = {
          enabled = false
        },
        jedi_references = {
          enabled = false
        }
      }
    }
  }
}

require'lspconfig'.pyright.setup{
  settings = {
  }
}
