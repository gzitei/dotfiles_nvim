local patterns = {
	"*.{js,jsx,ts,tsx,html,htm,css,scss}",
	"*.{json,yaml,yml,toml}",
	"*.{py,rb,lua,go,rs,php}",
	"*.sql",
	"*.md",
	"*.xml",
}

local function format_callback(err, did_edit)
	if err then
		vim.notify("Formatting failed: " .. err, vim.log.levels.WARN)
		print("Failed while formatting...")
	elseif did_edit then
		vim.notify("Formatted successfully", vim.log.levels.INFO)
		print("Formatted by Conform")
	else
		vim.notify("No formatting changes needed", vim.log.levels.INFO)
		print("Already Conform ;D")
	end
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = {
			"goimports",
			"gofmt",
		},
		yaml = { "yamlfix" },
		python = { "autopep8" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		sql = { "sql_formatter" },
	},
	format_on_save = {
		enabled = true,
		pattern = patterns,
		timeout_ms = 2000,
		lsp_fallback = true,
		callback = format_callback,
	},
	formatters = {
		sql_formatter = {
			command = "sql-formatter",
			args = { "--language", "postgresql" },
		},
		yamlfix = {
			command = "yamlfix",
			args = { "--verbose", "-" },
			stdin = true,
		},
		autopep8 = {
			command = "autopep8",
			args = {
				"--verbose",
				"--aggressive",
				"--aggressive",
				"--aggressive",
				--"--in-place",
				"--max-line-length",
				"79",
				"-",
			},
		},
	},
})
