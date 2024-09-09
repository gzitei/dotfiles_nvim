require("render-markdown").setup({})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.md", "*.markdown" },
	callback = function()
		vim.cmd("RenderMarkdown")
	end,
})
