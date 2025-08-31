local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require('luasnip.extras').rep

ls.add_snippets('typescriptreact', {
    s('rfc', {
        t({ "import React from 'react'", "" }),
        t("const "), i(1, "ComponentName"),
        t({ ": React.FC = () => {",
            "    return (",
            "        <div>" }),
        i(0),
        t({
            "",
            "        </div>",
            "    )",
            "}",
            "",
            "export default "
        }),
        rep(1),
    }),
})

return {}