return {
  "kevinhwang91/nvim-hlslens",
  event = "BufRead",
  config = function()
    opts = {
      override_lens = function(render, posList, nearest, idx, relIdx)
        local _ = relIdx
        local lnum, col = unpack(posList[idx])

        local text, chunks
        text = ('[%d/%d]'):format(idx, #posList)
        chunks = {{' ', 'Ignore'}, {text, 'Comment'}}
        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
      end
    }

    require("hlslens").setup(opts)
  end
}
