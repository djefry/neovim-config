require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { 'marksman', 'lua_ls'},
  automatic_installation = true,
  handlers = {},
})

-- Nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Define your on_attach
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  -- Example: disable hover for pylsp
  if client.name == "pylsp" then
    client.server_capabilities.hoverProvider = false
  end

  -- Keymaps
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

vim.diagnostic.config({
  virtual_text = true,
})

-- Lua LSP config
vim.lsp.config["lua_ls"] = {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
}

-- Pylsp LSP config
vim.lsp.config["pylsp"] = {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      keys = {
        { "K", false },
      },
      plugins = {
        black = { enabled = false },
        ruff = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        pylint = {
          enabled = true,
          args = { "--max-line-length=120 --disable=import-error,unused-import" }
        },
        pydocstyle = { enabled = true, ignore = { "D203", "D204", "D404", "D407", "D205", "D212", "D400", "D415" } },
        pylsp_mypy = { enabled = true },
        pylsp_rope = { enabled = true },
        flake8 = { enabled = false },
        isort = { enabled = true },
        jedi = { enabled = false },
        jedi_completion = { enabled = true },
        jedi_definition = { enabled = false },
        jedi_references = { enabled = false },
        jedi_hover = { enabled = false },
        jedi_signature_help = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        mccabe = { enabled = false },
      }
    }
  }
}

-- Autostart servers on FileType
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "python" },
  callback = function()
    local ft = vim.bo.filetype
    local server = ({
      lua = "lua_ls",
      python = "pylsp",
    })[ft]
    if server then
      vim.lsp.start(vim.lsp.config[server])
    end
  end,
})

--require("lspconfig").pyright.setup {
--  settings = {
--    python = {
--      analysis = {
--        autoImportCompletions = true,  -- Enable auto-imports
--        typeCheckingMode = "basic",    -- Ensure type checking is on
--      }
--    }
--  }
--}

--require('lspconfig').ruff.setup{
--  filetypes = { "python" },  -- Run only for Python files
--  settings = {
--    args = {},  -- Add any extra arguments if needed
--  }
--}
