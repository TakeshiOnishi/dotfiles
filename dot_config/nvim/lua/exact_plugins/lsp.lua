return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 使うサーバー。インストールと自動起動の両方をこの一覧に限る
      local servers = { "ts_ls", "pyright", "solargraph", "terraformls", "intelephense", "bashls" }

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = servers,
      })

      -- サーバー専用の on_attach に上書きされないよう、LspAttach で登録する
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          map("<leader>lR", vim.lsp.buf.rename, "Rename Symbol")
          map("<leader>la", vim.lsp.buf.code_action, "Code Action")
          map("<leader>ld", vim.lsp.buf.definition, "Go to Definition")
          map("<leader>le", vim.diagnostic.open_float, "Show Diagnostics")
          map("<leader>lf", vim.lsp.buf.format, "Format Document")
          map("<leader>lh", vim.lsp.buf.hover, "Hover Info")
          map("<leader>ll", "<cmd>LspRestart<CR>", "Restart LSP")
          map("<leader>lm", "<cmd>Mason<CR>", "Mason UI")
          map("<leader>ln", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")
          map("<leader>lp", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous Diagnostic")
          map("<leader>lr", vim.lsp.buf.references, "Find References")
          map("<leader>lt", vim.lsp.buf.type_definition, "Find Type Definition")
        end,
      })

      -- 全サーバー共通の設定。サーバーの起動は mason-lspconfig の automatic_enable が行う
      vim.lsp.config("*", {
        flags = {
          debounce_text_changes = 150,
        },
      })
    end
  }
}
