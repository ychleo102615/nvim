require('neogen').setup {
    -- enabled             = true,
    input_after_comment = true,
    snippet_engine      = "luasnip",
    languages = {
        lua = {
            template = {
                annotation_convention = "ldoc" -- for a full list of annotation_conventions, see supported-languages below,
            }
        },
    }
};
