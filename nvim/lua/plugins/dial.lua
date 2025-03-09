return {
  {
    "monaqa/dial.nvim",
    event = "BufReadPost",
    config = function()
      local dial = require("dial.map")

      vim.keymap.set("n", "<C-a>", dial.inc_normal(), { desc = "Increment", noremap = true })
      vim.keymap.set("n", "<C-x>", dial.dec_normal(), { desc = "Decrement", noremap = true })
      vim.keymap.set("v", "<C-a>", dial.inc_visual(), { desc = "Increment", noremap = true })
      vim.keymap.set("v", "<C-x>", dial.dec_visual(), { desc = "Decrement", noremap = true })


      local augend = require("dial.augend")
      require("dial.config").augends:register_group{
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%Y年%-m月%-d日"],
          augend.date.alias["%H:%M"],
          augend.date.alias["%H:%M:%S"],
          augend.constant.alias.ja_weekday,
          augend.constant.alias.ja_weekday_full
        }
      }
    end
  }
}
