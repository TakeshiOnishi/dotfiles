#!/bin/sh

vim -c "CocInstall coc-lists" \
  -c "CocInstall coc-json" \
  -c "CocInstall coc-html" \
  -c "CocInstall coc-tsserver" \
  -c "CocInstall coc-solargraph"

vim -c "CocInstall coc-sh" \
  -c "CocInstall coc-pyright" \
  -c "CocInstall coc-prettier" \
  -c "CocInstall coc-css" \
  -c "CocInstall coc-clangd" \
  -c "CocInstall coc-markdownlint"
