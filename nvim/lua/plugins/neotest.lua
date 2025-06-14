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
                    python = "/Users/kaleem/venv/bin/python",
                    args = { "--disable-warnings", "-s" },
                }),
            },
            status = {
                virtual_text = true,
            },
            output = {
                open_on_run_with_errors = true,
                strategy = "split",
                location = "bottom"
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
