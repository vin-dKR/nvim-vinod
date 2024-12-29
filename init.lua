require("vinod")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true

-- vim.api.nvim_set_keymap('n', 'vv', ':Vex<CR>', {noremap = true, silent = true})


vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })

vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>W", ":w!<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")

-- Yank Highlighter
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 80 })
    end,
    desc = "Highlight text on yank",
})

-- exec files
vim.api.nvim_set_keymap('n', '<leader>x', ':!chmod +x %<CR>', { noremap = true, silent = true })

-- Set diagnostic signs for better visual distinction
vim.fn.sign_define("LspDiagnosticsError", { text = "✗", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define("LspDiagnosticsWarning", { text = "!", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define("LspDiagnosticsInformation", { text = "i", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define("LspDiagnosticsHint", { text = "?", texthl = "LspDiagnosticsDefaultHint" })

-- Set diagnostic options
vim.diagnostic.config({
  virtual_text = {
    prefix = "", -- Prefix for virtual text (could be an icon or text)
    spacing = 2,
  },
  signs = true, -- Show signs in the gutter
  underline = true, -- Underline errors and warnings
  update_in_insert = false, -- Update diagnostics in insert mode
})

