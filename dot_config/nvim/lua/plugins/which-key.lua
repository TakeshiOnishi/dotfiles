return  {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      sort = { "manual" },
      preset = "helix",
      icons = {
        separator = "",
        separator = "",
        group = " | ",
      },
      spec = {
        { "<leader>f", name = "telescope" },
        { "<leader>g", name = "Git" },
        { "<leader>c", name = "Copilot Chat",   icon = { icon = "", color = "purple" } },
        { "<leader>t", name = "結んで開いて",   icon = { icon = "", color = "green" } },
        { "<leader>e", name = "File Encoding",  icon = { icon = "󰼭", color = "grey" } },
        { "<leader>a", name = "ファイル構造",   icon = { icon = "", color = "grey" } },
        { "<leader>l", name = "LSP",            icon = { icon = "", color = "azure" } },
        { "<leader>q", "<esc>" },
        {
          mode = "v",
          { "<leader>c", name = "Copilot Chat", icon = { icon = "", color = "purple" } },
          { "<leader>g", name = "Git" },
        },
      },
    },
  }
}
