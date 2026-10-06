return {
  {
    'nvimdev/dashboard-nvim',
    config = function()
      require('dashboard').setup {
        theme = 'doom',
        hide = {
          statusline = false,
        },
        config = {
          week_header = {
            enable = true,
          },
          center = {
            { 
              action = function() vim.api.nvim_input("<cmd>qa<cr>") end, 
              desc = "  ＼(^o^)／ ", 
              icon = "󰚑", 
              key = "q" 
            },
            { 
              action = function() vim.api.nvim_input("<cmd>enew<cr>") end, 
              desc = "  ﾄﾆｶｸｻﾜﾙｾﾞ ┗(^o^ )┓ ", 
              icon = "󰮢", 
              key = "i" 
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return {  ms .. "ms |←" .. stats.loaded .. "/" .. stats.count .. "| ┗(^o^ )┓ " }
          end,
          vertical_center = true,
        },
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  }
}
