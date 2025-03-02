return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = 'c' },
          delete       = { text = 'd' },
        },
      })
      local wk = require("which-key")
      wk.add(
        {
          { "<leader>gD", "<cmd>Gitsigns toggle_deleted<CR>", desc = "Toggle Deleted" },
          { "<leader>gb", "<cmd>Gitsigns blame<CR>", desc = "Blame" },
          { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview Hunk" },
          { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset Hunk" },
        }
      )
    end,
  },
}
