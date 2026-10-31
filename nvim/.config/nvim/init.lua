vim.loader.enable()

vim.opt.termguicolors = true

vim.cmd.colorscheme("habamax")

local function set_transparent()
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
	vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })
	vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
	vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
end

if vim.fn.has("mac") == 0 then
	set_transparent()
end

-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.laststatus = 2 -- pairs with lualine globalstatus = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 2 -- obsidian requirement
vim.opt.concealcursor = ""
vim.opt.synmaxcol = 300
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 50
vim.opt.autoread = true
vim.opt.autowrite = false

vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "inclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true

vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.diffopt:append("linematch:60")
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlights" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })
vim.keymap.set("n", "<leader>v", "ggVG", { desc = "Select all" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- ============================================================================
-- AUTOCMDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"')
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "markdown",
	callback = function(args)
		vim.keymap.set(
			"n",
			"<leader>cp",
			"<cmd>MarkdownPreviewToggle<cr>",
			{ buffer = args.buf, desc = "Markdown preview" }
		)
	end,
})

local function civicrm_log(expr, line)
	expr = vim.trim(expr)
	if not expr:match("^%$") then
		expr = "$" .. expr
	end
	local label = expr:sub(2):gsub("'", "\\'")
	local indent = vim.fn.getline(line):match("^%s*")
	vim.api.nvim_buf_set_lines(0, line, line, false, {
		indent .. "\\Civi::log()->debug('" .. label .. "', ['" .. label .. "' => " .. expr .. "]);",
	})
end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "php",
	callback = function(args)
		vim.keymap.set("n", "<leader>cl", function()
			civicrm_log(vim.fn.expand("<cword>"), vim.fn.line("."))
		end, { buffer = args.buf, desc = "CiviCRM log variable" })
		vim.keymap.set("x", "<leader>cl", function()
			local text = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
			local last = math.max(vim.fn.line("v"), vim.fn.line("."))
			vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
			civicrm_log(table.concat(text, " "), last)
		end, { buffer = args.buf, desc = "CiviCRM log selection" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	desc = "No comment continuation on new lines",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================
vim.api.nvim_create_autocmd("PackChanged", {
	group = augroup,
	callback = function(ev)
		local data = ev.data
		if data.spec.name == "markdown-preview.nvim" and (data.kind == "install" or data.kind == "update") then
			vim.system({ "bash", "install.sh" }, { cwd = data.path .. "/app" })
		end
	end,
})

vim.pack.add({
	"https://www.github.com/echasnovski/mini.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/folke/which-key.nvim",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	"https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/coder/claudecode.nvim",
	"https://github.com/iamcco/markdown-preview.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	{
		-- NOTE: blink.cmp v2 is now the actively developed branch (breaking
		-- changes vs v1). Staying pinned to v1 here deliberately for stability.
		-- Revisit this pin when ready to migrate — v2 requires installing
		-- blink.lib as a native dependency outside vim.pack.
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
})

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
		"vim",
		"vimdoc",
		"php",
		"html",
		"css",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"typescript",
		"vue",
		"svelte",
		"bash",
		"yaml",
		"tsx",
		"scss",
		"dockerfile",
		"phpdoc",
		"jsdoc",
		"regex",
		"diff",
		"gitcommit",
	}

	local config = require("nvim-treesitter.config")

	local already_installed = config.get_installed()
	local parsers_to_install = {}

	for _, parser in ipairs(ensure_installed) do
		if not vim.tbl_contains(already_installed, parser) then
			table.insert(parsers_to_install, parser)
		end
	end

	if #parsers_to_install > 0 then
		treesitter.install(parsers_to_install)
	end

	local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(config.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

setup_treesitter()

-- treesitter-aware comment strings (correct comment syntax inside embedded
-- regions, e.g. JS inside JSX/Vue/Svelte) — mini.comment picks this up below
require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

local nvim_tree_loaded = false
local function load_nvim_tree()
	if nvim_tree_loaded then
		return
	end
	nvim_tree_loaded = true
	require("nvim-tree").setup({
		view = {
			width = 35,
		},
		filters = {
			dotfiles = false,
		},
		renderer = {
			group_empty = true,
		},
		update_focused_file = {
			enable = true,
		},
	})
end

-- `nvim <dir>` needs nvim-tree set up before startup finishes to replace netrw
if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
	load_nvim_tree()
end

vim.keymap.set("n", "<leader>e", function()
	load_nvim_tree()
	require("nvim-tree.api").tree.toggle({ find_file = true })
end, { desc = "Toggle NvimTree" })

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files({
		no_ignore = true,
		cwd_prompt = false,
		fd_opts = "--color=never --type f --type l --exclude .git --exclude .jj --exclude node_modules"
			.. " --exclude '**/wp-content/uploads' --exclude '**/sites/*/files'",
	})
end, { desc = "Files (incl. ignored)" })
vim.keymap.set("n", "<leader>fF", function()
	require("fzf-lua").files({ no_ignore = true, cwd_prompt = false })
end, { desc = "Files (everything)" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep({ prompt = "> " })
end, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "Diagnostics Workspace" })
vim.keymap.set("n", "<leader>gs", function()
	require("fzf-lua").git_status()
end, { desc = "Git status (changed files)" })
vim.keymap.set("n", "<leader>gh", function()
	require("fzf-lua").git_hunks({ ref = "HEAD" })
end, { desc = "Git diff (all hunks)" })

require("mini.ai").setup({})
require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
		end,
	},
})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
vim.keymap.set("n", "<leader>bd", function()
	require("mini.bufremove").delete()
end, { desc = "Delete buffer (keep window)" })
require("mini.notify").setup({})
require("mini.icons").setup({})

require("render-markdown").setup({})
vim.keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown rendering" })

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "branch", icon = "\u{e725}" } }, -- nf-dev-git_branch
		lualine_c = { { "filename", path = 0 } },
		lualine_x = {
			function()
				local size = vim.fn.getfsize(vim.fn.expand("%"))
				if size < 0 then
					return ""
				elseif size < 1024 then
					return size .. "B"
				elseif size < 1024 * 1024 then
					return string.format("%.1fK", size / 1024)
				else
					return string.format("%.1fM", size / 1024 / 1024)
				end
			end,
			{ "filetype", icon_only = false },
		},
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_c = { { "filename", path = 0 } },
		lualine_x = { "filetype" },
	},
})

require("which-key").setup({
	spec = {
		{ "<leader>b", group = "buffer" },
		{ "<leader>a", group = "claude code" },
		{ "<leader>c", group = "code" },
		{ "<leader>f", group = "find" },
		{ "<leader>g", group = "goto/git" },
		{ "<leader>h", group = "git hunk" },
		{ "<leader>s", group = "split" },
		{ "<leader>t", group = "toggle" },
		{ "s", group = "surround", mode = { "n", "x" } },
		{
			mode = { "o", "x" },
			{ "af", desc = "function call" },
			{ "if", desc = "function call" },
			{ "aa", desc = "argument" },
			{ "ia", desc = "argument" },
			{ "aq", desc = "any quote" },
			{ "iq", desc = "any quote" },
			{ "a?", desc = "user prompt" },
			{ "i?", desc = "user prompt" },
		},
	},
})

require("mini.sessions").setup({})

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "▎" },
	},
})

require("mini.git").setup({})

local MiniDiff = require("mini.diff")
vim.keymap.set("n", "]h", function()
	MiniDiff.goto_hunk("next")
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function()
	MiniDiff.goto_hunk("prev")
end, { desc = "Prev git hunk" })
vim.keymap.set("n", "<leader>hs", function()
	local line = vim.fn.line(".")
	MiniDiff.do_hunks(0, "apply", { line_start = line, line_end = line })
end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", function()
	local line = vim.fn.line(".")
	MiniDiff.do_hunks(0, "reset", { line_start = line, line_end = line })
end, { desc = "Discard hunk" })
vim.keymap.set("n", "<leader>hp", function()
	MiniDiff.toggle_overlay()
end, { desc = "Preview diff overlay" })
vim.keymap.set("n", "<leader>hb", function()
	require("mini.git").show_at_cursor()
end, { desc = "Git blame/show" })

vim.keymap.set("n", "<leader>gg", function()
	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		border = "rounded",
		style = "minimal",
	})
	vim.fn.jobstart({ "lazygit" }, {
		term = true,
		on_exit = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
			vim.cmd("checktime")
		end,
	})
	vim.cmd("startinsert")
end, { desc = "Lazygit" })

require("mason").setup({})

local mason_packages = {
	"bash-language-server",
	"efm",
	"eslint_d",
	"fixjson",
	"lua-language-server",
	"luacheck",
	"phpactor",
	"prettierd",
	"pyright",
	"ruff",
	"shellcheck",
	"shfmt",
	"stylua",
	"tailwindcss-language-server",
	"typescript-language-server",
}
vim.schedule(function()
	local mason_registry = require("mason-registry")
	mason_registry.refresh(function()
		for _, name in ipairs(mason_packages) do
			local pkg = mason_registry.get_package(name)
			if not pkg:is_installed() and not pkg:is_installing() then
				vim.notify("Mason: installing " .. name)
				pkg:install()
			end
		end
	end)
end)

-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
local diagnostic_signs = {
	Error = "\u{f057} ",
	Warn = "\u{f071} ",
	Hint = "\u{ea61}",
	Info = "\u{f05a}",
}

vim.diagnostic.enable(false)

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local function opts(desc)
		return { noremap = true, silent = true, buffer = bufnr, desc = desc }
	end

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts("Go to definition (fzf)"))

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts("Go to definition"))

	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts("Go to definition in vsplit"))

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts("Line diagnostics"))
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts("Cursor diagnostics"))
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts("Next diagnostic"))

	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts("Previous diagnostic"))

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))

	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts("Find references"))
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts("Find type definitions"))
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts("Find document symbols"))
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts("Find workspace symbols"))
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts("Find implementations"))

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				require("conform").format({ bufnr = bufnr })
			end, 50)
		end, opts("Organize imports"))
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
		["<C-y>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		menu = {
			auto_show = function()
				return vim.bo.filetype ~= "markdown"
			end,
		},
	},
	signature = { enabled = true },
	sources = { default = { "lsp", "path", "buffer", "snippets" } },
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})

require("claudecode").setup({})

vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
vim.keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
vim.keymap.set("x", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "NvimTree",
	callback = function(args)
		vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = args.buf, desc = "Add file" })
	end,
})
vim.keymap.set({ "n", "x" }, "<C-,>", "<cmd>ClaudeCodeFocus<cr>", { desc = "Go to Claude" })
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	pattern = "*claude*",
	callback = function(args)
		vim.keymap.set("t", "<C-,>", "<C-\\><C-n><C-w>p", { buffer = args.buf, desc = "Back to editor" })
	end,
})

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("phpactor", {})
vim.lsp.config("tailwindcss", {})

do
	local luacheck = require("efmls-configs.linters.luacheck")
	local ruff_lint = require("efmls-configs.linters.ruff")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local shellcheck = require("efmls-configs.linters.shellcheck")

	vim.g.php_standard = vim.g.php_standard or "Drupal"

	-- drupal/coder sniffs crash on PHP 8.5 deprecations; large files exceed the default 128M
	local php_args = { "-d", "memory_limit=-1", "-d", "error_reporting=E_ALL & ~E_DEPRECATED" }
	local composer_bin = vim.env.HOME .. "/.config/composer/vendor/bin/"

	local function phpcs_lint(standard)
		return {
			{
				prefix = "phpcs",
				lintCommand = "php "
					.. table.concat(vim.tbl_map(vim.fn.shellescape, php_args), " ")
					.. " "
					.. composer_bin
					.. "phpcs --no-colors --report=emacs --standard="
					.. standard
					.. " -q --stdin-path='${INPUT}' -",
				lintStdin = true,
				lintIgnoreExitCode = true,
				lintFormats = { "%.%#:%l:%c: %trror - %m", "%.%#:%l:%c: %tarning - %m" },
			},
		}
	end

	vim.lsp.config("efm", {
		filetypes = {
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"php",
			"python",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
		settings = {
			languages = {
				javascript = { eslint_d },
				javascriptreact = { eslint_d },
				json = { eslint_d },
				jsonc = { eslint_d },
				lua = { luacheck },
				php = phpcs_lint(vim.g.php_standard),
				python = { ruff_lint },
				sh = { shellcheck },
				typescript = { eslint_d },
				typescriptreact = { eslint_d },
				vue = { eslint_d },
				svelte = { eslint_d },
			},
		},
	})

	require("conform").setup({
		formatters_by_ft = {
			css = { "prettierd" },
			scss = { "prettierd" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			vue = { "prettierd" },
			svelte = { "prettierd" },
			markdown = { "prettierd" },
			yaml = { "prettierd" },
			json = { "fixjson" },
			jsonc = { "fixjson" },
			lua = { "stylua" },
			python = { "ruff_format" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			php = { "phpcbf" },
		},
		formatters = {
			phpcbf = {
				inherit = false,
				command = "php",
				args = function(_, ctx)
					return vim.list_extend(vim.deepcopy(php_args), {
						composer_bin .. "phpcbf",
						"--standard=" .. vim.g.php_standard,
						"-q",
						"--stdin-path=" .. ctx.filename,
						"-",
					})
				end,
				stdin = true,
				-- phpcbf exits 1 when it outputs the code; 0 means it skipped the file and printed a report
				exit_codes = { 1 },
			},
		},
		format_on_save = function()
			if vim.g.disable_autoformat then
				return
			end
			return { timeout_ms = 10000 }
		end,
	})

	vim.keymap.set("n", "<leader>tf", function()
		vim.g.disable_autoformat = not vim.g.disable_autoformat
		vim.notify("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
	end, { desc = "Toggle format on save" })

	local function set_php_standard(standard, description)
		vim.api.nvim_create_user_command(standard .. "Standard", function()
			vim.g.php_standard = standard
			local lint = phpcs_lint(standard)
			vim.lsp.config("efm", { settings = { languages = { php = lint } } })
			for _, client in ipairs(vim.lsp.get_clients({ name = "efm" })) do
				client.settings.languages.php = lint
				client:notify("workspace/didChangeConfiguration", { settings = client.settings })
			end
			vim.notify(description .. " coding standard is set.")
		end, { desc = "Set " .. description .. " coding standard for PHP" })
	end

	set_php_standard("Drupal", "CiviCRM (Drupal)")
	set_php_standard("WordPress", "WordPress")
end

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"bashls",
	"ts_ls",
	"phpactor",
	"tailwindcss",
	"efm",
})
