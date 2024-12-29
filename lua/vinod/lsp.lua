-- lsp_config.lua or the LSP configuration file you're using

local lspconfig = require('lspconfig')

-- Setup for ts_ls (TypeScript/JavaScript)
lspconfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    -- Enable completion triggered by <Tab> and <CR>
    vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

    -- Configure tab to navigate completion
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<Tab>', [[pumvisible() ? "<C-n>" : "<Tab>"]], { expr = true, noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<S-Tab>', [[pumvisible() ? "<C-p>" : "<S-Tab>"]], { expr = true, noremap = true })

    local opts = { noremap = true, silent = true }       
    -- go to definition
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- Hover information
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- Rename symbol
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- Find references
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
     -- Key mapping to format the current buffer
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    -- Example settings for TypeScript/JavaScript
    javascript = {
      format = {
        enable = true,
      },
    },
    typescript = {
      format = {
        enable = true,
      },
    },
  },
})



-- Function to show diagnostics in a floating window
function show_diagnostics_in_float()
    -- Get the current line number and column number from the cursor position
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line, col = cursor[1], cursor[2]

    -- Get diagnostics at the cursor position
    local diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line - 1) -- line - 1 because LSP is 0-indexed

    -- Check if there are any diagnostics at the cursor position
    if #diagnostics == 0 then
        return
    end

    -- Extract the message from the first diagnostic (you can modify this if you want to show more)
    local diagnostic_message = diagnostics[1].message

    -- Show the diagnostic in a floating window with the error message
    vim.lsp.util.open_floating_preview({ diagnostic_message }, "markdown", {
        border = "rounded",
        focusable = false,
        scope = "cursor",
        height = 10,
        width = 50,
    })
end

vim.api.nvim_set_keymap('n', '<Leader>d', ':lua show_diagnostics_in_float()<CR>', { noremap = true, silent = true })

