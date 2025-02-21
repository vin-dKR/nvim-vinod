require("vinod")

-- vim.api.nvim_set_keymap('n', 'vv', ':Vex<CR>', {noremap = true, silent = true})

-- Yank Highlighter
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 80 })
    end,
    desc = "Highlight text on yank",
})

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
