return  {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      sort = { "manual" },
      preset = "helix",
      spec = {
        { "<leader>f", group = "telescope" },
        { "<leader>g", group = "Git" },
        { "<leader>t", name = "trees-j" },
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
    },
  }
}
