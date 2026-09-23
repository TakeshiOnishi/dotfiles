return { 
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true,
      },
      messages = {
        enabled = true,
        view = "mini",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      popupmenu = {
        enabled = true,
      },
      commands = {
        enabled = true,
      },
      notify = {
        enabled = false,
      },
      lsp = {
        progress = {
          enabled = false,
        }
      },
      routes = {
        {
          filter = { find = "# Plugin Updates" },
          opts = { skip = true },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
}
