## This is my Neovim configuration
- The master branch is the base configuration that I use.
- Check branch for language specific setup and environment

### How to use:
1. Backup your neovim config in ~/.config/nvim
2. From your home directory `cd .config` then run `mv nvim nvim-backup`
3. Clone this repo to your .config directory `git clone https://github.com/djefry/neovim-config`
4. Rename the directory to nvim `mv neovim-config nvim`
5. Install vim-plug (simple vim plugin manager)
6. `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'` or can check here https://github.com/junegunn/vim-plug
7. Open the neovim, there will be error because we haven't install the plugin, press any key or q until you get into the neovim editor
8. Install the plugin by typing `:PlugInstall` after finish close and open again, there should be no error
9. Install your respective programming langguage syntax-coloring using treesitter can check the supported language [here](https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages)
10. You can install one by one or multiple like this `:TSInstall python` or `:TSInstall graphql html hjson java javascript kotlin latex lua comment`
11. Install the LSP (Language Server Protocol) to enable auto-completion suggestion and error check
12. In the configuration itself I've default LSP that will auto-install on start if not available can check in this file
    ~/.config/nvim/after/plugin/lsp.lua
    ```
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        'marksman', 'lua_ls'
      },
      handlers = {
        lsp_zero.default_setup,
      },
    })
    ```
13. To install additional LSP, from inside neovim normal mode press `:Mason`
14. Press number 2 to list all the LSP
15. Press `/python` and press Enter to search python for example if you want to install other language just change the terms after /
16. Press `i` to install
17. Press `gg` to go to the top of the line to see the installation progress
18. Press `q` to exit from mason
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

Note: all the search will exclude dotfiles and files inside .gitignore


### Python
1. I'm using pyenv to manage every virtual environment
2. LSP: [pylsp, pyright]  (check the configuration to avaoid clash between LSP)
3. Debug: debugpy
