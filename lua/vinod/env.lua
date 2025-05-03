local ns = vim.api.nvim_create_namespace("env_stars")
local masked = true -- Initial state

local function mask_env()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for i, line in ipairs(lines) do
        local equals_pos = line:find("=")
        if equals_pos then
            vim.api.nvim_buf_set_extmark(0, ns, i - 1, equals_pos, {
                virt_text = { { "******************************  YO MFs ******************************", "Conceal" } },
                virt_text_pos = "overlay",
                hl_mode = "combine",
            })
        end
    end
    masked = true
    print("🔒 Env values masked")
end

local function unmask_env()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    masked = false
    print("🔓 Env values revealed")
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.env*",
    callback = function()
        mask_env() -- Mask by default when opening
    end,
})

vim.api.nvim_create_user_command("MaskEnv", function()
    if masked then
        unmask_env()
    else
        mask_env()
    end
end, {})
