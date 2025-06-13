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
                    args = { "--disable-warnings" },
                }),
            },
            status = {
                virtual_text = true,
            },
        }
    end,
    keys = {
        {
            "<leader>t",
            function() require("neotest").run.run() end,
            desc = "Run nearest test"
        },
        {
            "<leader>T",
            function() require("neotest").run.run(vim.fn.expand("%")) end,
            desc = "Run all tests in file"
        },
        {
            "<leader>tv",
            function() require("neotest").summary.toggle() end,
            desc = "Toggle test summary"
        },
        {
            "<leader>to",
            function() require("neotest").output.open() end,
            desc = "Open test output"
        },
        {
            "<leader>td",
            function() require("neotest").run.run({ strategy = "dap" }) end,
            desc = "Debug nearest test"
        }
    }
}
