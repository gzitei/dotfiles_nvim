# nvim_config
neovim config based on theprimeagens video from 0 to LSP

to use it make sure that in linux directories `$HOME/.config/nvim/` and `$HOME/.local/share/nvim/` are empty.

the same goes for `%LOCALAPPDATA%\nvim-data\` and `%LOCALAPPDATA%\nvim\` in windows.

lso make sure no files in in linux or  won't conflict your new configuration.

go to [packer.nvim](https://github.com/wbthomason/packer.nvim) and follow instructions to download Packer to your system.

when packer is downloaded to the corresponding folder of your os, you are read to copy `nvim` folder to your `$HOME/.config/` in linux or `%LOCALAPPDATA%\nvim\` in windows.

in your newly created `nvim` folder go to lua > setup > packer.lua, source the file (`:so`) and run `:PackerSync`.
