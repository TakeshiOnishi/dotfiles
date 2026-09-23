return {
  'stevearc/aerial.nvim',
  opts = {},
  vim.keymap.set("n", "<leader>a", "<cmd>AerialOpen<CR>", { desc = "Aerial Tree" }),
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
}
