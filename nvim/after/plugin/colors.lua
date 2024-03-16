
function ColorMyPencils(color)
	color = color or 'catppuccin'
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd("highlight LineNr guifg=#94a3b8")
    vim.cmd("highlight CursorLineNr guifg=#FFFFFF")
end

ColorMyPencils()
