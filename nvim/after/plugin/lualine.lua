local function current_directory()
	local path = vim.fn.expand("%:p:h")
	return path
end

require("lualine").setup({
	options = {
		theme = "auto",
		position = "bottom",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			current_directory,
			"filename",
		},
		lualine_x = { "encoding", "filesize", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

--[[
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        --component_separators = { left = '|', right = '|'},
        --section_separators = { left = '|', right = '|'},
        --disabled_filetypes = {
        --statusline = {},
        --winbar = {},
        --},
        --ignore_focus = {},
        --always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },

        --inactive_sections = {
        --lualine_a = {},
        --lualine_b = {},
        --lualine_c = {'filename'},
        --lualine_x = {'location'},
        --lualine_y = {},
        --lualine_z = {}
        --},
        --tabline = {},
        --winbar = {},
        --inactive_winbar = {},
        --extensions = {}
    }
}

]]
