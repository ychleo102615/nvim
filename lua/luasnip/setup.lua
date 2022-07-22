-- require("luasnip.loaders.from_vscode").load({paths = "./luasnip/snippets"});
--require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/lua/luasnip/snippets"})
require("luasnip.loaders.from_vscode").lazy_load();

local ls      = require("luasnip");
local s       = ls.snippet;
local sn      = ls.snippet_node;
local isn     = ls.indent_snippet_node;
local t       = ls.text_node;
local i       = ls.insert_node;
local f       = ls.function_node;
local c       = ls.choice_node;
local d       = ls.dynamic_node;
local r       = ls.restore_node;
local events  = require("luasnip.util.events");
local ai      = require("luasnip.nodes.absolute_indexer");
local fmt     = require("luasnip.extras.fmt").fmt;
local m       = require("luasnip.extras").m;
local lambda  = require("luasnip.extras").l;
local postfix = require("luasnip.extras.postfix").postfix;

-- from luasnip/util/environ.lua
local function FILENAME_BASE()
	return vim.fn.expand("%:t:s?\\.[^\\.]\\+$??")
end

-- ls.add_snippets("all", { });
ls.add_snippets("lua", {
    s(
        { trig = "class_make", name = "Class" },
        {
            t {
                "--------------------------------------------------    require   --------------------------------------------------",
                "",
                "-------------------------------------------------- const member --------------------------------------------------",
                "",
                "-------------------------------------------------- class define --------------------------------------------------",
                "local Module = class(\"Module\", function(...)",
                "    return {};",
                "end);",
                "",
                "--------------------------------------------------  constructor --------------------------------------------------",
                "function Module.create(...)",
                "    return Module.new(...);",
                "end;",
                "",
                "-- function Module:getInstance()",
                "--     if self._instance == nil then",
                "--         self._instance = Module.new();",
                "--     end",
                "--     return self._instance;",
                "-- end",
                "",
                "function Module:ctor()",
                "    -- member",
                "",
                "    -- init",
                "    self:setNodeEventEnabled(true);",
                "end",
                "",
                "--------------------------------------------------  life cycle  --------------------------------------------------",
                "function Module:onEnter()",
                "end",
                "",
                "function Module:onExit()",
                "end",
                "",
                "--------------------------------------------------    public    --------------------------------------------------",
                "",
                "--------------------------------------------------   register   --------------------------------------------------",
                "",
                "--------------------------------------------------    event     --------------------------------------------------",
                "",
                "--------------------------------------------------    logic     --------------------------------------------------",
                "",
                "--------------------------------------------------     tool     --------------------------------------------------",
                "",
                "--------------------------------------------------    create    --------------------------------------------------",
                "",
                "return Module;",
            },
        }
    ),
});

