local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("kyazdani42/nvim-web-devicons")

	-- 主题
	use("lunarvim/onedarker.nvim")

	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")

	-- cmp
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	-- use 'hrsh7th/cmp-path'
	-- use 'hrsh7th/cmp-cmdline'

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("windwp/nvim-ts-autotag")
	use("windwp/nvim-autopairs")
	use("p00f/nvim-ts-rainbow")

	use("nvim-lualine/lualine.nvim")
	use("akinsho/bufferline.nvim")

	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	use("nvim-telescope/telescope.nvim")

	use("norcalli/nvim-colorizer.lua")

	use("lewis6991/gitsigns.nvim")

	use("goolord/alpha-nvim")

	use("lukas-reineke/indent-blankline.nvim")

	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use("jose-elias-alvarez/null-ls.nvim")

	use({ "akinsho/toggleterm.nvim" })

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
