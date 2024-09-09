local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

-- LSP setup
lsp.preset("recommended")
lsp.set_preferences({
	suggest_lsp_servers = true,
	sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "⚑",
		info = "»",
	},
})

-- Mason setup
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"eslint",
		"lua_ls",
		"emmet_language_server",
		"emmet_ls",
		"rust_analyzer",
		"tailwindcss",
		"pyright",
		"pylsp",
		"ts_ls",
		"vtsls",
	},
	handlers = {
		lsp.default_setup,
	},
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	client.server_capabilities.documentFormattingProvider = true
	client.server_capabilities.documentRangeFormattingProvider = true

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end)

-- CMP (Completion) setup
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

luasnip.filetype_extend("javascript", { "html" })
luasnip.filetype_extend("typescript", { "html" })
luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("typescriptreact", { "html" })

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	formatting = lsp.cmp_format(),
	window = {
		completion = { border = "rounded" },
		documentation = { border = "rounded" },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<C-y>"] = cmp.mapping.complete(),
	}),
})

-- Specific language server setups
lspconfig.gopls.setup({
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})

lspconfig.lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")) then
			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			})
		end
	end,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

--[[
require("typescript-tools").setup({
	settings = {
		tsserver_path = vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server",
		tsserver_plugins = {},
		tsserver_max_memory = "auto",
		tsserver_format_options = {},
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "literals",
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
		},
	},
})
]]

lspconfig.pyright.setup({
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				inlayHints = {
					variableTypes = true,
					functionReturnTypes = true,
				},
			},
		},
	},
})

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = true,
})

-- Custom commands
vim.api.nvim_create_user_command("ToggleInlayHints", function()
	local buf = vim.api.nvim_get_current_buf()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
end, {})

vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>EmmetWrap<CR>", { noremap = true, silent = true })

-- Go-specific autocommand for organizing imports
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(res.client_id) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end,
})

lsp.setup()
