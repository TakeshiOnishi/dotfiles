return {
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        local api = require("nvim-tree.api")
  
        -- nvim-tree のキーマッピングを設定
        local function on_attach(bufnr)
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
  
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set("n", "<C-e>", api.tree.toggle, opts("Toggle NvimTree"))
          vim.keymap.set("n", "L", "Lzz", opts("Move to Bottom of View"))
          vim.keymap.set("n", "H", "Hzz", opts("Move to Top of View"))
         end
  
        require("nvim-tree").setup({
          on_attach = on_attach, -- 正しくマッピングを適用
          view = {
            width = 45, -- デフォルト幅
          },
          filters = {
            dotfiles = false, -- 隠しファイルを表示
            custom = {}, -- 特定のファイルを非表示にしない
          },
          git = {
            ignore = false, -- `.gitignore` の影響を受けない
          },
        })

        vim.keymap.set("n", "<C-e>", api.tree.toggle, { noremap = true, silent = true, desc = "Toggle NvimTree" })
      end
    }
  }
  