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
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
local M = {}
local match_node = {
  query = [[
        (fenced_code_block
          (fenced_code_block_delimiter)
          (info_string
            (language) @variable.language
            (#eq? (@variable.language) "mermaid")
          )
          (block_continuation) @prefix
          (code_fence_content))
      ]],
  query_lang = "markdown",
}
function M.setup()
  treesitter_postfix({
    trig = "lr",
    matchTSNode = match_node,
  }, {
    t("flowchart LR\n  "),
    i(1, "node1"),
    t("[\"`"),
    i(2, "Label (markdown)"),
    t("`\"]"),
    t("flowchart LR\n  "),
    i(1, "node2"),
    t("[\"`"),
    i(2, "Label (markdown)"),
    t("`\"]"),
  })
end

return M
