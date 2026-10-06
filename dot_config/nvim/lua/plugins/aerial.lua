return {
  'stevearc/aerial.nvim',
  opts = {},
  vim.keymap.set("n", "<leader>a", "<cmd>AerialOpen<CR>", { desc = "Aerial Tree" }),
  dependencies = {
     "nvim-tree/nvim-web-devicons"
  },
}
