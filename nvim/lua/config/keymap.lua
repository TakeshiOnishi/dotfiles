vim.keymap.set("n", "n", "nzz", { remap = false, silent = true })
vim.keymap.set("n", "N", "Nzz", { remap = false, silent = true })
vim.keymap.set("n", ",,", "gcc", { remap = true, silent = true })
vim.keymap.set("v", ",,", "gc", { remap = true, silent = true })
vim.keymap.set("n", "<ESC><ESC>", ":nohlsearch<CR><ESC>", { noremap = true, silent = true, desc = "Clear search highlight" })

vim.keymap.set("n", "<leader>Ee", ":e ++enc=euc-jp<CR>", { desc = "Open as EUC-JP", silent = true })
vim.keymap.set("n", "<leader>Es", ":e ++enc=cp932<CR>", { desc = "Open as CP932", silent = true })
vim.keymap.set("n", "<leader>Eu", ":e ++enc=utf-8<CR>", { desc = "Open as UTF-8", silent = true })
vim.keymap.set("n", "<leader>Ew", ":e ++ff=dos<CR>", { desc = "Set Fileformat to DOS", silent = true })
vim.keymap.set("n", "<leader>Ex", ":e ++ff=unix<CR>", { desc = "Set Fileformat to UNIX", silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "lspinfo", "help" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>cclose<CR>|<cmd>lclose<CR>", { buffer = true, silent = true })
    vim.keymap.set("n", "<Esc>", "<cmd>cclose<CR>|<cmd>lclose<CR>", { buffer = true, silent = true })
    vim.keymap.set("n", "<CR>", "<CR><cmd>cclose<CR>|<cmd>lclose<CR>", { buffer = true, silent = true }) 
  end,
})
