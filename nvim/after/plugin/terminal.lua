-- Global variables to store terminal buffer and window
local term_buf = nil
local term_win = nil

local function toggle_floating_terminal()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		-- Terminal window exists, so hide it
		vim.api.nvim_win_hide(term_win)
		term_win = nil
	else
		-- Create or show terminal window
		local width = vim.api.nvim_get_option("columns")
		local height = vim.api.nvim_get_option("lines")

		-- Calculate floating window size
		local win_height = math.ceil(height * 0.3 - 4)
		local win_width = math.ceil(width * 0.8)

		-- Calculate starting position
		local col = math.ceil((width - win_width) / 2)

		-- Set some options
		local opts = {
			style = "minimal",
			relative = "editor",
			width = win_width,
			height = win_height,
			row = height,
			col = col,
			border = "rounded",
		}

		if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
			-- Reuse existing buffer
			term_win = vim.api.nvim_open_win(term_buf, true, opts)
		else
			-- Create a new buffer for the terminal
			term_buf = vim.api.nvim_create_buf(false, true)
			term_win = vim.api.nvim_open_win(term_buf, true, opts)

			-- Change to the directory of the current buffer
			vim.api.nvim_command("lcd %:p:h")

			-- Open a terminal in the new buffer
			vim.fn.termopen(vim.o.shell, {
				cwd = vim.fn.getcwd(),
			})
		end

		-- Enter insert mode
		vim.api.nvim_command("startinsert")
	end
end

-- Create a user command to call this function
vim.api.nvim_create_user_command("TermFloat", toggle_floating_terminal, {})
vim.api.nvim_set_keymap("n", "<C-g>", ":TermFloat<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-g>", "<C-\\><C-n>:TermFloat<CR>", { noremap = true, silent = true })
