return {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
  
      map("n", "<space>td", "<Plug>(coc-type-definition)", opts)
      map("n", "<space>df", "<Plug>(coc-definition)", opts)
      map("n", "<space>rf", "<Plug>(coc-references)", opts)
      map("n", "<space>rn", "<Plug>(coc-rename)", opts)
      map("v", "<space>fmt", "<Plug>(coc-format-selected)", opts)
      map("n", "<space>fmta", "<Plug>(coc-format)", opts)
      map("v", "<space>ff", "<Plug>(coc-fix-current)", opts)
      map("n", "<space>ffa", "<Plug>(coc-codeaction)", opts)
      map("n", "<space>reg", ":exe CocAction('CocList lines')<CR>", opts)
      map("n", "K", ":lua ShowDocumentation()<CR>", opts)

      function ShowDocumentation()
        if vim.fn.CocAction("hasProvider", "hover") == 1 then
          vim.fn.CocActionAsync("doHover")
        end
      end
      
    end
  }
  