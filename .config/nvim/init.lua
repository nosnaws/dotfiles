-- normal mode remap
local function noremap(mode, seq, cmd, desc)
	vim.keymap.set(mode, seq, cmd, { noremap = true, desc = desc })
end

-- leader normal mode remap
local function lnmap(keys, command, desc)
	noremap('n', '<leader>' .. keys, command, desc)
end

-- TODO: Write a function to map a list of keys
-- write another function to pull the mapping out to use in lazy loading

vim.g.mapleader = ' '

lnmap('ws', ':w<cr>', "Save current file")
lnmap('wq', ':q<cr>', "Close current file")

noremap('i', 'jk', '<esc>', "")
noremap('c', 'jk', '<c-c>', "")
noremap('t', 'jk', '<c-\\><c-n>', "")


lnmap('gs', ':Git<cr>', "Open git fugitive")
lnmap('gb', ':Git blame<cr>', "Git blame")
lnmap('gd', ':Gdiff<cr>', "Git diff")
lnmap('gp', ':Git push<cr>', "Git push")
lnmap('gl', ':Git pull<cr>', "Git pull")
lnmap('gf', ':Git fetch<cr>', "Git fetch")

vim.o.termguicolors = true
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

-- Spaces instead of tabs
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- Always show the auto complete menu
vim.o.completeopt = "menuone"

-- Bootstrap package manager
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
-- End bootstrap

require("lazy").setup({
	{
		'folke/tokyonight.nvim', -- theme
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("set background=dark")
			vim.cmd("colorscheme tokyonight-storm")
		end,
	},

	{
		'neovim/nvim-lspconfig',
		lazy = false,
		priority = 999,
		config = function()
			local lspconfig = require('lspconfig')

			lspconfig.rust_analyzer.setup {
				settings = {
					['rust-analyzer'] = {
						diagnostics = {
							enable = false
						}
					}
				}
			}
			lspconfig.astro.setup {}
			lspconfig.gleam.setup {}
			lspconfig.tsserver.setup {}
			lspconfig.elixirls.setup {
				cmd = { "/Users/alecswanson/code/elixir-ls/language_server.sh" }
			}
			lspconfig.lua_ls.setup {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT"
						},
						diagnostics = {
							globals = {
								"vim",
								"require",
							}
						},
						workspace = {
							-- Recognize vim runtime
							library = vim.api.nvim_get_runtime_file("", true),
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

			noremap("n", "gd", vim.lsp.buf.definition, "LSP definition")
			noremap("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
			noremap("n", "K", vim.lsp.buf.hover, "LSP hover doc")
			noremap("n", "gr", vim.lsp.buf.references, "LSP references")
			noremap("n", "gi", vim.lsp.buf.implementation, "LSP implementations")
			noremap("n", "<c-k>", vim.lsp.buf.signature_help, "LSP signature_help")
			noremap("n", "<leader>lr", vim.lsp.buf.rename, "LSP rename")
			noremap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "LSP format")
			noremap("n", "<leader>ca", vim.lsp.buf.code_action, "LSP code_action")
			noremap("n", "<leader>ld", vim.diagnostic.open_float, "diags")
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		config = function()
			require('nvim-treesitter.configs').setup({
				indent = { enable = true },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
				auto_install = true,
				ensure_installed = { 'lua', 'javascript', 'typescript' }
			})
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
		},
		config = function()
			local teleFns = require('telescope.builtin')
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = { 'rg', '--color=never', '--no-heading',
						'--with-filename', '--line-number', '--column',
						'--smart-case', '--hidden', '--follow',
						'--glob', '!**/.git/*' },
					file_ignore_patterns = { ".git/", "node_modules" }
				}
			})

			lnmap("ff", function() teleFns.find_files({ hidden = true }) end, "Find files")
			lnmap("fg", teleFns.live_grep, "Live grep")
			lnmap("fb", teleFns.buffers, "Find buffers")
			lnmap("fm", teleFns.keymaps, "Find keymaps")
			lnmap("fq", teleFns.quickfix, "Find in quickfix list")
			lnmap("fs", teleFns.lsp_document_symbols, "Find symbols in document")
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
	{
		'nvim-lualine/lualine.nvim',
		lazy = false,
		priority = 998,
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require('lualine').setup({
        options = { theme = "tokyonight" }
      })
		end
	},
	'tpope/vim-fugitive',
	'tpope/vim-commentary',
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			triggers = "auto",
			triggers_blacklist = {
				i = { "j", "k" },
				v = { "j", "k" },
				c = { "j", "k" },
			}
		}
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filtypes = { "markdown" }
		end,
		config = function()
			lnmap("mp", ":MarkdownPreview<cr>", "Preview markdown file")
		end,
		ft = { "markdown" }
	},
})
