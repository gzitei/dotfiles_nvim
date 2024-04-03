require("trouble").setup()

vim.keymap.set("n", "<leader>qf", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>dn", function() require("trouble").next({skip_groups = true, jump = true}) end)
vim.keymap.set("n", "<leader>dp", function() require("trouble").previous({skip_groups = true, jump = true}) end)

