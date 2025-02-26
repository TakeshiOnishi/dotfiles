return {
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "c",
          "css",
          "csv",
          "diff",
          "git_config",
          "go",
          "html",
          "javascript",
          "jinja",
          "jsdoc",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "prisma",
          "php",
          "python",
          "query",
          "regex",
          "ruby",
          "rust",
          "scss",
          "terraform",
          "tsv",
          "tsx",
          "typescript",
          "vim",
          "xml",
          "yaml",
        },
      },
  
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    }
  }
  