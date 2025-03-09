vim.keymap.set("n", "n", "nzz", { remap = false, silent = true })
vim.keymap.set("n", "N", "Nzz", { remap = false, silent = true })
vim.keymap.set("n", ",,", "gcc", { remap = true, silent = true })
vim.keymap.set("v", ",,", "gc", { remap = true, silent = true })
vim.keymap.set("n", "<ESC><ESC>", ":nohlsearch<CR><ESC>", { noremap = true, silent = true, desc = "Clear search highlight" })
