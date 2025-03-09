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
          "tsserver",      
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
        local opts = { buffer = bufnr, noremap = true, silent = true }

        local wk = require("which-key")
        wk.register({
          l = {
            name = "LSP",
            d = { vim.lsp.buf.definition, "Go to Definition" },
            t = { vim.lsp.buf.type_definition, "Find Type Definition" },
            r = { vim.lsp.buf.references, "Find References" },
            h = { vim.lsp.buf.hover, "Hover Info" },
            R = { vim.lsp.buf.rename, "Rename Symbol" },
            a = { vim.lsp.buf.code_action, "Code Action" },
            e = { vim.diagnostic.open_float, "Show Diagnostics" },
            p = { vim.diagnostic.goto_prev, "Previous Diagnostic" },
            n = { vim.diagnostic.goto_next, "Next Diagnostic" },
            f = { vim.lsp.buf.format, "Format Document" },
            m = { "<cmd>Mason<CR>", "Mason UI" },
            l = { "<cmd>LspRestart<CR>", "Restart LSP" },
          },
        }, { prefix = "<leader>" })

        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<leader>lm", "<cmd>Mason<CR>", opts)
        vim.keymap.set("n", "<leader>ll", "<cmd>LspRestart<CR>", opts)
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
