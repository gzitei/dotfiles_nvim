local mini = require("mini.indentscope")
mini.setup({
	symbol = "▎",
	symbolOff = "",
	options = {
		try_as_border = true,
	},
	draw = {
		animation = mini.gen_animation.none(),
		priority = 100,
	},
})
local init = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"help",
			"alpha",
			"dashboard",
			"neo-tree",
			"Trouble",
			"trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
		},
		callback = function()
			vim.b.miniindentscope_disable = true
		end,
	})
end
init()

vim.cmd([[highlight MiniIndentscopeSymbol guifg=#6e6a86 gui=nocombine]])
