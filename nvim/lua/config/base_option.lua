vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 基本設定
vim.opt.compatible = false
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.clipboard = "unnamed"
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "ucs-bom", "iso-2022-jp-3", "iso-2022-jp", "eucjp-ms", "euc-jisx0213", "euc-jp", "sjis", "cp932" }
vim.opt.backup = false
vim.opt.undofile = false

-- ファイルタイプ、インデント、プラグイン有効化
vim.cmd("filetype indent plugin on")

-- 編集関連
vim.opt.hidden = true       -- バッファ未保存時移動許可
vim.opt.wildmenu = true     -- CMDファイル名保管
vim.opt.showcmd = true      -- CMD途中でも表示
vim.opt.cmdheight = 1       -- コマンドライン高さ

-- 検索設定
vim.opt.hlsearch = true     -- 検索ハイライト
vim.opt.ignorecase = true   -- 大文字小文字無視
vim.opt.smartcase = true    -- 大文字を含む場合は区別

-- その他
vim.opt.startofline = false -- 移動コマンド時の位置抑制
vim.opt.laststatus = 2      -- ステータスライン常時表示
vim.opt.confirm = true      -- バッファ変更時の確認
vim.opt.visualbell = true   -- ビジュアルベル

-- 日本語入力固定
vim.g.IM_CtrlMode = 4

-- インデント関連
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0

-- テキストの折り返し設定
vim.opt.wrap = true
vim.opt.breakat = " "
vim.opt.showbreak = "+ "

-- カーソルの外観
vim.opt.termguicolors = true
vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor", -- ノーマル/ビジュアル/コマンド
  "i:ver25",  -- 挿入モード
  "r:hor20",  -- 置換モード
}

-- カーソルライン設定
vim.opt.cursorline = false
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    vim.opt.cursorline = not vim.opt.cursorline:get()
  end,
})