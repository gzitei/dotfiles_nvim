local mini = require("mini.indentscope")
mini.setup({
	symbol = "▎",
	symbolOff = "",
	options = {
		try_as_border = false,
	},
	draw = {
		animation = mini.gen_animation.none(),
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

vim.cmd([[highlight MiniIndentscopeSymbol guifg=#c3c3c3 gui=nocombine]])
