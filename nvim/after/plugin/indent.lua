--[[
require("indent_blankline").setup {
    --[[whitespace = {
        highlight = {
            "LineNr",
        }
    },
    scope = { enabled = false },
    exclude = {
        filetypes = {
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
    },
    space_char_blankline = " ",
    show_current_context = true,
}
]]

require("mini.indentscope").setup{
    symbol = "▎",
    symbolOff = "▎",
}
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
            vim.b.miniindentscope_disable = false
        end,
    })
end
init()
