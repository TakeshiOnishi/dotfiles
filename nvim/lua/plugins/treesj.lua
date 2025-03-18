return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local treesj = require("treesj")
    vim.keymap.set("n", "<leader>tt", treesj.toggle, { desc = "Tree Toggle" })
    vim.keymap.set("n", "<leader>ts", treesj.toggle, { desc = "Tree Split" })
    vim.keymap.set("n", "<leader>tj", treesj.toggle, { desc = "Tree Join" })
  end,
}
