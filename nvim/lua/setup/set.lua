vim.opt.nu = true
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
vim.opt.guicursor = {
  'n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
  'i-ci:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
  'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100'
}
vim.g.mapleader = " "
vim.cmd('set nrformats+=alpha')
--vim.cmd('source $HOME/.config/nvim/lua/setup/packer.lua')
--vim.cmd('cd /mnt/AdditionalDisk/coding/projects/')
--vim.g.netrw_dir = '/mnt/AdditionalDisk/coding/projects/'
vim.g.netrw_liststyle = 3
--vim.g.netrw_browse_x = 'subl'
--vim.g.netrw_browsex_viewer = "subl"
