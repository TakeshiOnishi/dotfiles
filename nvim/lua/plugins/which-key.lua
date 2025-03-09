return  {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>f", group = "telescope" },
        { "<leader>g", group = "Git" },
        { "<leader>E", name = "File Encoding" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<leader>l",
        ":Lazy<CR>",
        desc = "Open Lazy.nvim",
        silent = true,
      },
      { "<leader>Ee", ":e ++enc=euc-jp<CR>", desc = "Open as EUC-JP", silent = true },
      { "<leader>Es", ":e ++enc=cp932<CR>", desc = "Open as CP932", silent = true },
      { "<leader>Eu", ":e ++enc=utf-8<CR>", desc = "Open as UTF-8", silent = true },
      { "<leader>Ew", ":e ++ff=dos<CR>", desc = "Set Fileformat to DOS", silent = true },
      { "<leader>Ex", ":e ++ff=unix<CR>", desc = "Set Fileformat to UNIX", silent = true },
    },
  }
}
