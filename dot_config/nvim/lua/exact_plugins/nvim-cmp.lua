return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", 
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", 
      "hrsh7th/cmp-buffer", 
      "hrsh7th/cmp-path", 
      "hrsh7th/cmp-cmdline", 
      "L3MON4D3/LuaSnip", 
      "saadparwaiz1/cmp_luasnip", 
      "onsails/lspkind.nvim", 
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) 
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(), 
          ["<C-p>"] = cmp.mapping.select_prev_item(), 
          ["<C-b>"] = cmp.mapping.scroll_docs(-4), 
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), 
          ["<C-e>"] = cmp.mapping.abort(), 
          ["<CR>"] = cmp.mapping.confirm({ select = true }), 
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, 
          { name = "luasnip" }, 
          { name = "buffer" }, 
          { name = "path" }, 
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", 
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        experimental = {
          ghost_text = true, 
        },
      })

      
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end
  }
}

