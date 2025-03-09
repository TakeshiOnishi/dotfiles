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
        progress = {
          enabled = false,
        }
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
}
