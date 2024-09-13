vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>0", vim.cmd.Alpha)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.api.nvim_set_keymap("n", "<leader>gb", ":lua vim.lsp.buf.back()<CR>", { noremap = true, silent = true })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.api.nvim_set_keymap("n", "<leader>q", ":bd<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader><leader>", "<cmd>:source %<CR>", { silent = true })

vim.api.nvim_create_user_command("Cwd", function()
	local current = vim.fn.expand("%:p:h")
	vim.fn.system("echo " .. current .. " | xclip -selection clipboard")
	print(current)
end, {})
vim.api.nvim_create_user_command("SO", function()
	local current_file = vim.fn.expand("%:p")
	vim.fn.system("source " .. current_file)
	print("Current file sourced.")
end, {})

vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>")
