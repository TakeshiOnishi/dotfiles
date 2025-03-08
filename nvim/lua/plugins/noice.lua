return { 
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true,
      },
      messages = {
        enabled = false,
      },
      popupmenu = {
        enabled = true,
      },
      commands = {
        enabled = true,
      },
      notify = {
        enabled = true,
        view = "notify",
      },
      lsp = {
        enabled = true,
        view = "mini",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
}
