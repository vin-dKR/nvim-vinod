-- Basic diagnostic setup
vim.diagnostic.config({
    virtual_text = { prefix = "●" },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        max_width = 80,
        max_height = 20,
    }
})

-- Better diagnostic highlights
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff5555" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffb86c" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#8be9fd" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#50fa7b" })

-- Key mappings
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set('n', '[d', vim.diagnostic.get_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.get_next, { desc = "Next diagnostic" })

-- Common LSP on_attach function
local on_attach = function(client, bufnr)
    -- Enable completion
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

-- Native LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Configure ts_ls (TypeScript/JavaScript LSP)
require('lspconfig').ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        typescript = {
            completions = {
                completeFunctionCalls = true
            }
        },
        javascript = {
            completions = {
                completeFunctionCalls = true
            }
        }
    }
})

-- Configure lua_ls
require('lspconfig').lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
            telemetry = { enable = false },
        }
    }
})

-- Auto-show diagnostics on hover
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
            border = 'rounded',
            source = 'if_many',
        }
        vim.diagnostic.open_float(nil, opts)
    end
})
