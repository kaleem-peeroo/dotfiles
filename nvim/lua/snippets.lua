local ls = require('luasnip')
local snip = ls.snippet
local snip_node = ls.snippet_node
local text = ls.text_node
local ins = ls.insert_node
local f = ls.function_node
local choice = ls.choice_node
local dynamic = ls.dynamic_node
local lambda = require('luasnip.extras').lambda
local format = require('luasnip.extras.fmt').fmt

ls.add_snippets("python", {
    -- The trigger is "cpr":
    -- console.print(f"", style="")
    snip("cpr", {
        text({"console.print(f\""}),
        ins(0),
        text({"\", style=\"\")"}),
    }),
    -- The trigger is "imp1":
    -- imports: pandas, numpy, os, sys, rich console, and rich progress
    snip("imp1", {
        text({"import os", ""}),
        text({"import sys", ""}),
        text({"", ""}),
        text({"import pandas as pd", ""}),
        text({"", ""}),
        text({"from rich.console import Console", ""}),
        text({"", ""}),
        text({"console = Console()", ""}),
    })
})
