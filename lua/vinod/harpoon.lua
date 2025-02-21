local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()

-- KEYMAPS
vim.keymap.set("n", "<leader>a", function()
    harpoon:list():append()
end, { desc = "Add file to Harpoon" })

vim.keymap.set("n", "<leader>h", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon quick menu" })

vim.keymap.set("n", "<leader>1", function()
    harpoon:list():select(1)
end, { desc = "Navigate to Harpoon file 1" })

vim.keymap.set("n", "<leader>2", function()
    harpoon:list():select(2)
end, { desc = "Navigate to Harpoon file 2" })

vim.keymap.set("n", "<leader>3", function()
    harpoon:list():select(3)
end, { desc = "Navigate to Harpoon file 3" })

vim.keymap.set("n", "<leader>4", function()
    harpoon:list():select(4)
end, { desc = "Navigate to Harpoon file 4" })
