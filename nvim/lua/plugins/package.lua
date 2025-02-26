return {
    -- 開発補助ツール
    { "mattn/emmet-vim" }, -- HTML/CSS の Emmet
    { "tyru/open-browser.vim" }, -- URL を開く
    { "tpope/vim-fugitive" }, -- Git 操作
    { "fuenor/im_control.vim" }, -- 日本語入力の制御
    { "gko/vim-coloresque" }, -- CSSのカラーコード表示
    { "previm/previm" }, -- Markdown プレビュー
    { "AndrewRadev/linediff.vim" }, -- 2つの行の差分比較
    { "maxmellon/vim-jsx-pretty" }, -- JSXのシンタックスハイライト
  
    -- UI / 視覚的改善
    { "tomasr/molokai" }, -- カラースキーム
    { "itchyny/calendar.vim" }, -- カレンダー表示
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- ステータスライン（airline の代替）
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } }, -- ファイルツリー（NERDTree の代替）
}    
  