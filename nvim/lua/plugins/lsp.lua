return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, 
    dependencies = {
      "williamboman/mason.nvim", 
      "williamboman/mason-lspconfig.nvim", 
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",      
          "pyright",       
          "solargraph",    
          "terraformls",   
          "tflint",        
          "ansiblels",     
          "clangd",        
          "bashls",        
          "intelephense",
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")

      local on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { desc = "Rename Symbol" })
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to Definition" })
        vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Show Diagnostics" })
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format Document" })
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover Info" })
        vim.keymap.set("n", "<leader>ll", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
        vim.keymap.set("n", "<leader>lm", "<cmd>Mason<CR>", { desc = "Mason UI" })
        vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
        vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "Find References" })
        vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "Find Type Definition" })
      end

      local servers = {
        ts_ls = {},
        pyright = {},
        solargraph = {},
        terraformls = {},
        tflint = {},
        ansiblels = {},
        clangd = {},
        bashls = {},
      }

      for server, config in pairs(servers) do
        lspconfig[server].setup(vim.tbl_extend("force", {
          on_attach = on_attach,
          flags = {
            debounce_text_changes = 150,
          },
        }, config))
      end
    end
  }
}
