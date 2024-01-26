vim.g.mapleader = ' '

-- Mappings
function noremap(mode, seq, cmd)
	vim.keymap.set(mode, seq, cmd .. '<CR>', { noremap = true })
end

function lnmap(keys, command)
	noremap('n', '<Leader>' .. keys, command)
end

lnmap('ws', ':w')
lnmap('wq', ':q')

vim.keymap.set('i', 'jk', '<esc>', { noremap = true })
vim.keymap.set('c', 'jk', '<c-c>', { noremap = true })
vim.keymap.set('t', 'jk', '<c-\\><c-n>', { noremap = true })


lnmap('gs', ':Git')
lnmap('gb', ':Git blame')
lnmap('gd', ':Gdiff')
lnmap('gp', ':Git push')
lnmap('gl', ':Git pull')
lnmap('gf', ':Git fetch')

vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.timeoutlen = 500
vim.o.number = true
vim.o.wildmenu = true
vim.o.syntax = 'enable'
vim.o.cursorline = true
vim.o.lazyredraw = true
vim.o.showmatch = true
vim.o.incsearch = true
vim.o.confirm = true
vim.o.foldenable = true
vim.o.swapfile = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.completeopt = "menuone,noselect"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		'cocopon/iceberg.vim', -- theme
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme iceberg]])
		end,
	},

	{
		'neovim/nvim-lspconfig',
		keys = {
			{ "gd",         function() vim.lsp.buf.definition() end },
			{ "gD",         function() vim.lsp.buf.declaration() end },
			{ "K",          function() vim.lsp.buf.hover() end },
			{ "gr",         function() vim.lsp.buf.references() end },
			{ "gi",         function() vim.lsp.buf.implementation() end },
			{ "<c-k>",      function() vim.lsp.buf.signature_help() end },
			{ "<leader>lr", function() vim.lsp.buf.rename() end },
			{ "<leader>lf", function() vim.lsp.buf.format({ async = true }) end },
			{ "<leader>ca", function() vim.lsp.buf.code_action() end },
		},
		lazy = false,
		priority = 999,
		config = function()
			local lspconfig = require('lspconfig')
			lspconfig.tsserver.setup {}
			lspconfig.lua_ls.setup {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT"
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
							}
						},
						format = {
							defaultConfig = {
								indent_style = "space",
								indent_size = "2",
							}
						}
					}
				},
			}
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').setup {
				indent = { enable = true },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
				auto_install = true,
				ensure_installed = { 'lua', 'javascript', 'typescript' }
			}
		end
	},

	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
		},
		keys = {
			{ "<leader>ff", function() require('telescope.builtin').find_files() end },
			{ "<leader>fg", function() require('telescope.builtin').live_grep() end },
			{ "<leader>fb", function() require('telescope.builtin').buffers() end },
			{ "<leader>fm", function() require('telescope.builtin').keymaps() end },
			{ "<leader>fq", function() require('telescope.builtin').quickfix() end },
			{ "<leader>fs", function() require('telescope.builtin').lsp_workspace_symbols() end },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = { 'rg', '--color=never', '--no-heading',
						'--with-filename', '--line-number', '--column',
						'--smart-case', '--hidden', '--follow',
						'--glob', '!**/.git/*' },
					file_ignore_patterns = { ".git/", "node_modules" }
				}
			})
		end,
	},
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	{
		'hrsh7th/nvim-cmp',
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-CR>"] = cmp.mapping.confirm({ select = true }),
				})
			})
		end
	},
	'numToStr/Comment.nvim',
	'folke/which-key.nvim',
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup({
				options = {
					theme = "iceberg"
				}
			})
		end
	},
	'tpope/vim-fugitive',
})
