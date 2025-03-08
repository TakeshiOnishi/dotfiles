return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- [Eviline config for lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua)
      -- Author: shadmansaleh
      -- Credit: glepnir
      -- [[Edited by me!]]

      local colors = {
        bg       = '#202328',
        fg       = '#bbc2cf',
        yellow   = '#ECBE7B',
        cyan     = '#008080',
        darkblue = '#081633',
        green    = '#98be65',
        orange   = '#FF8800',
        violet   = '#a9a1e1',
        magenta  = '#c678dd',
        blue     = '#51afef',
        red      = '#ec5f67',
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand('%:p:h')
          local gitdir = vim.fn.finddir('.git', filepath .. ';')
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      local config = {
        options = {
          component_separators = '',
          section_separators = '',
          theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = '#505050', bg = '#222222' } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
      }

      local function ins_inactive_left(component)
        table.insert(config.inactive_sections.lualine_c, component)
      end

      local function ins_inactive_right(component)
        table.insert(config.inactive_sections.lualine_x, component)
      end

      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left {
        function()
          return '▊'
        end,
        color = { fg = colors.blue }, -- Sets highlighting of component
        padding = { left = 0, right = 1 }, -- We don't need space before this
      }

      ins_left {
        -- mode component
        function()
          return ''
        end,
        color = function()
          -- auto change color according to neovims mode
          local mode_color = {
            n = colors.green,
            i = colors.red,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
      }

      ins_left {
        'filename',
        cond = conditions.buffer_not_empty,
        path = 1,
        color = { fg = colors.magenta },
      }

      ins_left {
        'filetype',
        colored = true,
        icon_only = true,
        icon = { align = 'right' },
      }

      ins_left { 'location' }

      ins_left { 'progress', color = { fg = colors.fg } }

      ins_left {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
        },
      }

      -- Insert mid section. 
      ins_left {
        function()
          return '%='
        end,
      }

      ins_left {
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' LSP:',
        color = { fg = '#ffffff', gui = 'bold' },
      }

      ins_right {
        'searchcount',
        maxcount = 999,
        timeout = 500,
      }

      ins_right {
        'selectioncount',
      }

      ins_right {
        'o:encoding',
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.green },
        show_bomb = true,
      }

      ins_right {
        'fileformat',
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green },
      }

      ins_right {
        'branch',
        icon = '',
        color = { fg = colors.violet },
      }

      ins_right {
        function()
          return '▊'
        end,
        color = { fg = colors.blue },
        padding = { left = 1 },
      }


      --------------------------------
      -- inactive sections
      --------------------------------
      ins_inactive_left {
        'filename',
        cond = conditions.buffer_not_empty,
        path = 1,
      }

      ins_inactive_left {
        'filetype',
        icon_only = true,
        icon = { align = 'right' },
      }

      ins_inactive_right {
        'o:encoding',
        fmt = string.upper,
        cond = conditions.hide_in_width,
        show_bomb = true,
      }

      ins_inactive_right {
        'fileformat',
        fmt = string.upper,
        icons_enabled = false,
      }


      --TODO: 画面幅小さくなったときにactive - leftのみ表示する
      
      require("lualine").setup(config)
    end
  }
}
