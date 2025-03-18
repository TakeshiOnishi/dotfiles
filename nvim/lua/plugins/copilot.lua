return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      question_header = '< 拙者 > ',
      answer_header = 'そなた [(^o^ )]',

      prompts = {
        Explain = {
          prompt = "/COPILOT_EXPLAIN 選択したコードを詳細に説明してください。理解しやすい例や補足を含めてください。",
          mapping = "<leader>ce",
          description = "コードの説明をする。",
        },
        Review = {
          prompt = "/COPILOT_REVIEW 選択したコードをレビューし、改善点や問題点を指摘してください。",
          mapping = "<leader>cr",
          description = "コードのレビューをする。",
        },
        Fix = {
          prompt = "/COPILOT_FIX 選択したコードのバグを特定し、適切に修正してください。",
          mapping = "<leader>cf",
          description = "コードのバグ修正をする。",
        },
        Optimize = {
          prompt = "/COPILOT_OPTIMIZE 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
          mapping = "<leader>co",
          description = "コードの最適化をする。",
        },
        Docs = {
          prompt = "/COPILOT_DOCS 選択したコードに適切なコメントを追加し、ドキュメントを作成してください。",
          mapping = "<leader>cd",
          description = "コードのドキュメントを作成する。",
        },
        Tests = {
          prompt = "/COPILOT_TESTS 選択したコードに対して、詳細な単体テストを作成してください。",
          mapping = "<leader>ct",
          description = "コードのテストを作成する。",
        },
        Commit = {
          prompt = "変更内容に基づいて、コミットメッセージを作成してください。タイトルは50文字以内でprefixはcommitizenのルールに従ってくださいい。本文はなるべく簡潔な日本語にしてください。",
          mapping = "<leader>cm",
          description = "コミットメッセージを作成する。",
          context = 'git:staged',
        },
        Chat = {
          prompt = "選択内容について会話をしたい。",
          mapping = "<leader>cc",
          description = "選択内容について会話・議論をする。",
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      vim.api.nvim_set_keymap("n", "<leader>ct", "<cmd>lua require('CopilotChat').toggle()<CR>", { desc="Copilot Chat Toggle", noremap = true, silent = true })
    end
  },
}
