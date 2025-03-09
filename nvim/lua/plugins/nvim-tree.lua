return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local api = require("nvim-tree.api")

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
        vim.keymap.set("n", "md", api.fs.remove, opts("Delete"))
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

