## This is my Neovim configuration
- The master branch is the base configuration that I use.
- Check branch for language specific setup and environment, you can check the additional setting at very botom of every branch

### How to use:
1. Backup your neovim config in ~/.config/nvim
2. From your home directory `cd .config` then run `mv nvim nvim-backup`
3. Clone this repo to your .config directory `git clone https://github.com/djefry/neovim-config`
4. Rename the directory to nvim `mv neovim-config nvim`
5. Install vim-plug (simple vim plugin manager)
   ```
   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   ```
   or can check here https://github.com/junegunn/vim-plug
8. Open the neovim, there will be error because we haven't install the plugin, press any key or q until you get into the neovim editor
9. Install the plugin by typing `:PlugInstall` after finish close and open again, there should be no error
10. Install your respective programming langguage syntax-coloring using treesitter can check the supported language [here](https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages)
11. You can install one by one or multiple like this `:TSInstall python` or `:TSInstall graphql html hjson java javascript kotlin latex lua comment`
12. Install the LSP (Language Server Protocol) to enable auto-completion suggestion and error check
13. In the configuration itself I've default LSP that will auto-install on start if not available can check in this file
    ~/.config/nvim/after/plugin/lsp.lua
    ```
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

    vim.diagnostic.config({
        virtual_text = true
    })

    -- Lua LSP config
    vim.lsp.config["lua_ls"] = {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
        },
      },
    }
    ```
14. To install additional LSP, from inside neovim normal mode press `:Mason`
15. Press number 2 to list all the LSP
16. Press `/python` and press Enter to search python for example if you want to install other language just change the terms after /
17. Press `i` to install
18. Press `gg` to go to the top of the line to see the installation progress
19. Press `q` to exit from mason
18. Your neovim is ready to use.

Note: If you don't have ripgrep installed in your machine you need to install it to support file searching using telescope

### General
1. Vim `<leader>` change to `Space` can change in basic configuration `~/.config/nvim/lua/wandashare/`
2. Using default directory management can be access using shortcut `<leader> + p + v`


### Shortcut Key
You can configure and change the shortcut key according to your need, but these are the shortcut key that mostly used.
- LSP shortcut key: ~/.config/nvim/after/plugin/lsp.lua
- Telescope shortcut key: ~/.config/nvim/after/plugin/telescope.lua
1. Go to file definition `gd` to go back to previous pointer can use default shortcut `<Ctrl> + o`
2. Peek to function definition or constant `K` (Shift + k)
3. If your LSP support code action you can access via `<leader> + vca`
4. To list all function caller or refferences press `<leader> + vrr`
5. To rename function name and refactor all the caller use `<leader> + vrn` don't forget to save all before running another rename using `:wa`
6. To find all file in project dir commit and uncommit can use `<leader> + pf`
7. To find all committed file use `<Ctrl> + p`
8. To find a word in all committed file use `<leader> + ps`
9. Use :G to open git, press `-` to stage and unstage
10. Want to stage per-chunk use :G add -p then input y/n (if you accidentally move the scrollbar press a before inputing y/n)

Note: all the search will exclude dotfiles and files inside .gitignore

### Rust Language
Install the LSP and formatter using Mason.
1. Access Manson using `:Mason`
2. Search for `rust` using `/rust`
3. You'll found `rust-analyzer` then press i to install or u to update
