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

-- Pyright LSP config
vim.lsp.config["pyright"] = {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
    pyright = {
      disableOrganizeImports = true,
      disableLanguageServices = false,
      autoImportCompletion = false,
    },
  },
}

-- Ruff LSP config
vim.lsp.config["ruff"] = {
  filetypes = { "python" },
  settings = {
    args = {},
    ruff = {
      extendSelect = { "D", "E", "F", "I", "UP", "N" },
      extendIgnore = { "D203", "D205", "D212", "D400", "D407", "D409", "D415" },
      format = { "I" },
      unsafeFixes = false,
      preview = true,
    }
  }
}

-- Ruff format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    if _G.auto_format_enabled then
      vim.lsp.buf.format({ async = false, name = "ruff" })
    end
  end,
})
