local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key mutherfucker to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Setup lazy.nvim
require("lazy").setup({
    "folke/tokyonight.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    
    -- TypeScript/JavaScript LSP
    {
        "neovim/nvim-lspconfig", -- Core LSP configuration plugin
    },
    { "neovim/nvim-lspconfig" },

  -- Autocompletion 
    {
        "hrsh7th/nvim-cmp", -- Autocompletion plugin
        dependencies = {
              "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
              "hrsh7th/cmp-buffer",   -- Buffer source for nvim-cmp
              "hrsh7th/cmp-path",     -- Path source for nvim-cmp
              "hrsh7th/cmp-cmdline",  -- Command-line source for nvim-cmp
              "L3MON4D3/LuaSnip",     -- Snippet engine
        },
    },

  -- Prettier 
    {
        "MunifTanjim/prettier.nvim", -- Prettier plugin
    },
    { 
        'wakatime/vim-wakatime', lazy = false 
    },
    {
       "ThePrimeagen/harpoon",
        branch = "harpoon2", -- Make sure to use Harpoon v2
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("vinod.harpoon")
        end 
    }
  })
