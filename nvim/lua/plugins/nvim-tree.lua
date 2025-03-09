return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local api = require("nvim-tree.api")

      local function duplicate_file()
        local node = api.tree.get_node_under_cursor()

        if not node or node.type ~= "file" then
          vim.notify("ファイルの上で実行してください", vim.log.levels.WARN)
          return
        end

        local old_path = node.absolute_path
        local default_new_path = vim.fn.fnamemodify(old_path, ":h") .. "/" .. node.name
        local new_path = vim.fn.input("新しいパスを入力: ", default_new_path, "file")

        if new_path == "" then
          vim.notify("キャンセルされました", vim.log.levels.INFO)
          return
        end
        
        if vim.fn.filereadable(new_path) == 1 then
          vim.notify("エラー: 既にファイルが存在します → " .. new_path, vim.log.levels.ERROR)
          return
        end

        local new_dir = vim.fn.fnamemodify(new_path, ":h")
        if vim.fn.isdirectory(new_dir) == 0 then
          vim.fn.mkdir(new_dir, "p")
        end

        vim.fn.system({ "cp", old_path, new_path })

        api.tree.reload()
        vim.notify("ファイル複製: " .. new_path, vim.log.levels.INFO)
      end

      -- 旧個人設定
      local function on_attach(bufnr)
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "<C-e>", api.tree.toggle, opts("Toggle NvimTree"))
        vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
        vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "ma", api.fs.create, opts("Create File Or Directory"))
        vim.keymap.set("n", "mm", api.fs.rename_full, opts("Rename: Full Path"))
        vim.keymap.set("n", "md", api.fs.trash, opts("Trash"))
        vim.keymap.set("n", "mc", duplicate_file, { buffer = bufnr, desc = "Duplicate File" })
        vim.keymap.set("n", "L", "Lzz", opts("Move to Bottom of View"))
        vim.keymap.set("n", "H", "Hzz", opts("Move to Top of View"))
      end

      opts = {
        on_attach = on_attach,
        view = {
          width = 45,
        },
        filters = {
          dotfiles = false,
          custom = {},
        },
        git = {
          ignore = false,
        },
        actions = {
          open_file =  {
            window_picker = {
              enable = false,
            }
          },
        }
      }

      require("nvim-tree").setup(opts)

      vim.keymap.set("n", "<C-e>", api.tree.toggle, { noremap = true, silent = true, desc = "Toggle NvimTree" })
    end
  }
}

