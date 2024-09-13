-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
--
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("meain/vim-jsontogo")
	use({ "davidgranstrom/nvim-markdown-preview" })
	use("eldritch-theme/eldritch.nvim")
	--use({ "projekt0n/github-nvim-theme" })
	use({
		"ellisonleao/glow.nvim",
		config = function()
			require("glow").setup()
		end,
	})
	use({ "echasnovski/mini.ai", version = "*" })
	use("Mofiqul/vscode.nvim")
	use({ "nyoom-engineering/oxocarbon.nvim" })
	use("shaunsingh/nord.nvim")
	use({ "embark-theme/vim", as = "embark" })
	use({
		"nvim-telescope/telescope.nvim",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "rose-pine/neovim", as = "rose-pine" })
	use({
		"stevearc/conform.nvim",
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use({ "folke/tokyonight.nvim", as = "tokyonight" })
	use("folke/trouble.nvim")
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
	use({
		"nvim-lualine/lualine.nvim",
	})
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
	})
	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		config = function()
			require("nvim-lsp-ts-utils").setup({
				enable_inlay_hints = true,
			})
		end,
	})
	use({ "ellisonleao/gruvbox.nvim" })
	use({ "echasnovski/mini.indentscope" })
	use({
		"loctvl842/monokai-pro.nvim",
	})
	use({
		"aca/emmet-ls",
	})
	use("jay-babu/mason-nvim-dap.nvim")
	use("mfussenegger/nvim-dap")
	use("leoluz/nvim-dap-go")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
	use("theHamsta/nvim-dap-virtual-text")
	use("nvim-telescope/telescope-dap.nvim")
	-- Use your plugin manager to install
	use({
		"mxsdev/nvim-dap-vscode-js",
		requires = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
			"jayp0521/mason-nvim-dap.nvim",
		},
	})
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm --prefix "
			.. vim.fn.stdpath("data")
			.. "/site/pack/packer/opt/vscode-js-debug/"
			.. " install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out && rm -rf .git",
	})
	use("mfussenegger/nvim-dap-python")
	use({
		"Joakker/lua-json5",
		run = "./install.sh",
	})
	use("pmizio/typescript-tools.nvim")
	use("laytan/cloak.nvim")
	use({
		"MeanderingProgrammer/render-markdown.nvim",
		after = { "nvim-treesitter" },
		requires = { "echasnovski/mini.nvim", opt = true }, -- if you use the mini.nvim suite
	})
	use("epwalsh/obsidian.nvim")
	use({ "echasnovski/mini.icons" })
	use({ "norcalli/nvim-colorizer.lua" })

	use({
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	})
end)
