require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = {
			"goimports",
			"gofmt",
		},
		python = { "autopep8" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
	},
	format_on_save = {
		enabled = true,
		pattern = "*.(py|go|lua|js|jsx|ts|tsx)",
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
--[[
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function()
        vim.api.nvim_command("silent!autopep8 -vaaai %")
    end,
})
]]
