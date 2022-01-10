local M = {}

local function get_char_highlights()
	vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 blend=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B blend=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 blend=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 blend=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF blend=nocombine]])
	vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD blend=nocombine]])
	return {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	}
end

M.autopairs = function()
	local present1, autopairs = pcall(require, "nvim-autopairs")
	local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

	if present1 and present2 then
		autopairs.setup({
			check_ts = true,
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			map_cr = true,
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0, -- Offset from pattern match
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		})

		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
		cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
	end
end

M.luasnip = function()
	local present, luasnip = pcall(require, "luasnip")
	if present then
		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
		})

		require("luasnip/loaders/from_vscode").load({ paths = {} })
		require("luasnip/loaders/from_vscode").load()
	end
end

M.null_ls = function()
	local present, null_ls = pcall(require, "null-ls")

	if present then
		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			debug = false,
			sources = {
				formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
				formatting.stylua,
			},
			on_attach = function(client)
				if client.resolved_capabilities.document_formatting then
					vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
				end
			end,
		})
	end
end

M.comment = function()
	local present, nvim_comment = pcall(require, "Comment")
	if present then
		nvim_comment.setup()
	end
end

M.blankline = function()
	require("indent_blankline").setup({
		use_treesitter = true,
		context_highlight_list = get_char_highlights(),
		show_current_context = true,
		filetype_exculde = {
			"alhpa",
			"packer",
			"NvimTree",
			"lsp-install",
			"help",
			"dashboard",
			"TelescopePrompt",
			"TelescopeResults",
		},
		buftype_exclude = { "terminal", "nofile" },
		context_patterns = {
			"class",
			"return",
			"function",
			"method",
			"^if",
			"^while",
			"jsx_element",
			"^for",
			"^object",
			"^table",
			"block",
			"arguments",
			"if_statement",
			"else_clause",
			"jsx_element",
			"jsx_self_closing_element",
			"try_statement",
			"catch_clause",
			"import_statement",
			"operation_type",
		},
	})
end

M.colorizer = function()
	local present, colorizer = pcall(require, "colorizer")
	if present then
		colorizer.setup({ "*" }, {
			RGB = true, -- #RGB hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			names = false, -- "Name" codes like Blue
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn

			-- Available modes: foreground, background
			mode = "background", -- Set the display mode.
		})

		vim.cmd("ColorizerReloadAllBuffers")
	end
end

return M
