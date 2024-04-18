
function ColorMyPencils(color)
	color = color or 'tokyonight'
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    vim.cmd("highlight LineNr guifg=#94a3b8")
    vim.cmd("highlight CursorLineNr guifg=#FFFFFF")
    vim.cmd [[highlight Cursor guifg=#FFFFFF guibg=#FF0000]]


end

ColorMyPencils()
