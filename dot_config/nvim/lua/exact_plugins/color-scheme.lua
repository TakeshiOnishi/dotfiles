return {
  {
    "folke/tokyonight.nvim",
    lazy = false, 
    priority = 1000, 
    opts = {
      style = "night",
      styles = {
        functions = {}
      },
      on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = "#ff0000"
      end
    },
    config = function()
      vim.cmd("colorscheme tokyonight-night")
    end
  }
}
