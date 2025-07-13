return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-tree-sitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest").setup {
            adapters = {
                require("neotest-python")({
                    runner = "pytest",
                    python = "/Users/kaleempeeroo/venv/bin/python",
                    args = { "--disable-warnings", "--tb=short" },
                }),
            },
            status = {
                virtual_text = true,
            },
            output = {
                enabled = true,
                open_on_run = "short",
            },
            output_panel = {
                enable = true,
                open = "botright split | resize 20 | wincmd p",
            },
            floating = {
                max_height = 0.9,
                max_width = 0.9,
            },
            summary = {
                animated = true,
                count = true,
            }
        }
    end,
    keys = {
        {
            "t",
            function() require("neotest").run.run() end,
            desc = "Run nearest test"
        },
        {
            "T",
            function() require("neotest").run.run(vim.fn.expand("%")) end,
            desc = "Run all tests in file"
        },
        {
            "tv",
            function() require("neotest").summary.toggle() end,
            desc = "Toggle test summary"
        },
        {
            "to",
            function() require("neotest").output.open() end,
            desc = "Open test output"
        },
    }
}
