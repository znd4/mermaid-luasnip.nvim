local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
local M = {}
local match_node = {
  query = [[
        (fenced_code_block
          (fenced_code_block_delimiter)
          (info_string
            ((language) @language
              (#eq? @language "mermaid")
            )
          )
          (block_continuation) @prefix
        )
      ]],
  query_lang = "markdown",
}
function M.setup()
  ls.add_snippets("markdown", {
    treesitter_postfix({
      trig = "lr",
      matchTSNode = match_node,
    }, fmt([[
      flowchart LR
        {n1}["`{t1}`"]
        {n2}["`{t2}`"]
        {n1} --> {n2}
    ]], {
      n1 = i(1, "node1"),
      t1 = i(2, "Contents **markdown supported**"),
      n2 = i(3, "node2"),
      t2 = i(4, "Contents **markdown supported**"),
    }))
  })
end

return M
