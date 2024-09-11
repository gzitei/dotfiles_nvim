vim.opt.nu = true
vim.o.exrc = true
vim.o.secure = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.g.mapleader = " "
vim.cmd("set nrformats+=alpha")
vim.api.nvim_set_option_value("guicursor", "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor21", {})
vim.g.netrw_browse_x = "subl"
vim.g.netrw_browsex_viewer = "subl"
vim.cmd("source ~/.config/nvim/lua/setup/packer.lua")
vim.cmd([[highlight Cursor guifg=#FFFFFF guibg=#FF0000]])
vim.cmd([[highlight lCursor guifg=#FFFFFF guibg=#FF0000]])
vim.opt.cursorline = true
vim.cmd([[highlight CursorLine ctermbg=235 guibg=#131313]])
vim.cmd([[highlight ColorColumn ctermbg=235 guibg=#131313]])
vim.api.nvim_command("iabbrev ;; /")
vim.api.nvim_command("iabbrev zz \\")
vim.api.nvim_command("iabbrev ZZ \\|")

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"css",
		"vue",
		"html",
		"prisma",
	},
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})
