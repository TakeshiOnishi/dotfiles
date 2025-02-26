-- キーマッピング用関数
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- 検索結果を中央に
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- 設定ファイルを編集・再読み込み
map("n", "<F4>", ":edit $MYVIMRC<CR>", opts)
map("n", "<F5>", ":source $MYVIMRC<CR>", opts)

-- ウィンドウ管理
map("n", "<C-s>1", ":only<CR>", opts)
map("n", "<C-s>2", ":sp<CR>", opts)
map("n", "<C-s>3", ":vsp<CR>", opts)

-- ウィンドウサイズ変更
vim.api.nvim_set_keymap("n", "[winsize]j", ":resize +5<CR>", opts)
vim.api.nvim_set_keymap("n", "[winsize]k", ":resize -5<CR>", opts)
vim.api.nvim_set_keymap("n", "[winsize]l", ":vertical resize +50<CR>", opts)
vim.api.nvim_set_keymap("n", "[winsize]h", ":vertical resize -50<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-s>", "[winsize]", opts) -- マッピングモード

-- 現在の日時を挿入
map("i", "<Leader>date", "<C-R>=strftime('%Y/%m/%d (%a) %H:%M:%S')<CR>", opts)

-- 文字コード変換
map("n", ",ee", ":e ++enc=euc-jp<CR>", opts)
map("n", ",es", ":e ++enc=cp932<CR>", opts)
map("n", ",eu", ":e ++enc=utf-8<CR>", opts)

-- ファイルタイプの自動設定
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.less",
  command = "set filetype=css",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.phtml,*.tpl",
  command = "set filetype=html",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "**/ansible/*.yml",
  command = "set filetype=yaml.ansible",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  command = "setlocal sw=2",
})

-- 疑似キー移動
map("i", "A", "<Up>", opts)
map("i", "B", "<Down>", opts)
map("i", "C", "<Right>", opts)
map("i", "D", "<Left>", opts)

-- 改行コード変更
map("n", ":fw", ":e ++ff=dos<CR>", opts)
map("n", ":fu", ":e ++ff=unix<CR>", opts)

-- HTML 改行入力 Shift + Enter
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html,xhtml",
  callback = function()
    vim.api.nvim_set_keymap("i", "<S-CR>", "<br /><CR>", opts)
    vim.api.nvim_set_keymap("n", "<S-CR>", "$a<br /><Esc><S-J>i<CR><ESC>$", opts)
  end,
})

-- 閉じ括弧の自動補完
map("i", "{", "{}<Left>", opts)
map("i", "[", "[]<Left>", opts)

-- 背景透過切り替え
function ToggleTransparency()
  if vim.o.transparency == 15 then
    vim.o.transparency = 0
  else
    vim.o.transparency = 15
  end
end

vim.api.nvim_set_keymap("n", "<Space>oT", ":lua ToggleTransparency()<CR>", opts)

-- ESCを2回押して検索ハイライト解除
map("n", "<ESC><ESC>", ":nohlsearch<CR><ESC>", opts)
