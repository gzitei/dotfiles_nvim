require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    go = {"gofmt", "goimports"},
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },
  },
})

