return {
  {
    'L3MON4D3/LuaSnip',
    config = function()
      -- See :help luasnip-loaders
      require('luasnip.loaders.from_vscode').lazy_load()

      -- example code from https://sbulav.github.io/vim/neovim-setting-up-luasnip/
      local ls = require("luasnip")
      -- some shorthands...
      local snip = ls.snippet
      local node = ls.snippet_node
      local text = ls.text_node
      local insert = ls.insert_node
      local func = ls.function_node
      local choice = ls.choice_node
      local dynamicn = ls.dynamic_node
      local types = require("luasnip.util.types")

      local date = function() return { os.date('%Y-%m-%d') } end

      -- Does not work.
      -- ls.ext_opts = {
      --   [types.insertNode] = {
      --     unvisited = { hl_group = 'CurSearch' }
      --   }
      -- }

      local cssKeyframes = snip({ trig = "¬keyframes", name = "@keyframes animation" }, {
        text('@keyframes '),
        insert(1, "animation-name"),
        text({ ' {', '  0% {' }),
        insert(2, "opacity: 0"),
        text({ '}', '' }),
        insert(0),
        text('  '),
        insert(3, "80%, "),
        text(' 100% {'),
        insert(4, "opacity: 1"),
        text({ '}', '}' }),
      })

      local jsDomLoad = snip({ trig = "¬domload", name = "Call function when DOMContentLoaded" }, {
        text({ "document.addEventListener('DOMContentLoaded', () => {", '  ' }),
        insert(0),
        text({ '', '});', '' }),
      })

      local jsAnonFunction = snip({ trig = "¬afSimple", priority = 1001, name = "my arrow function" }, {
        text('('),
        insert(1, 'arg'),
        text({ ') => {' }),
        insert(0),
        text({ '', '  return ' }),
        insert(2, 'arg'),
        text({ ';', '}' }),
      })
      local jsSelectorForEach = snip({ trig = "¬eachQueryMatch", name = "forEach on querySelectAll results" }, {
        text('[].forEach.call('),
        insert(1, 'document'),
        text('.querySelectAll("'),
        insert(2, 'div.what'),
        text({ '"), el => {', '' }),
        insert(3),
        text({ '', '});' }),
        insert(0),
      })

      ls.add_snippets(nil, {
        all = {
          snip({
            trig = "date",
            name = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
          }, {
            func(date, {}),
          }),
          snip({ trig = "db", name = "docblock" }, {
            text({ '/**', ' * ' }),
            insert(1),
            text({ '', ' * ', ' */' }),
          })
        },
        php = {
          snip({ trig = "function", name = "my function" }, {
            text('function '),
            insert(1, "fname"),
            text('('),
            insert(2),
            text(')'),
            insert(3, ": "),
            text({ ' {', '  ' }),
            insert(4),
            text({ '', '}', '' }),
          })
        },
        javascript = {
          jsAnonFunction,
          jsDomLoad,
          jsSelectorForEach,
        },
        css = { cssKeyframes },
        scss = { cssKeyframes }
      })
    end,
  },
  { 'rafamadriz/friendly-snippets' },
}
