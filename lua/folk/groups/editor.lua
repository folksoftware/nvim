local M = {}

function M.get()
	return {
		ColorColumn = { bg = C.border_subtle }, -- used for the columns set with 'colorcolumn'
		Conceal = { fg = C.fg_subtle }, -- placeholder characters substituted for concealed text (see 'conceallevel')
		Cursor = { fg = C.bg_primary, bg = C.cursor }, -- character under the cursor
		lCursor = { fg = C.bg_primary, bg = C.cursor }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
		CursorIM = { fg = C.bg_primary, bg = C.cursor }, -- like Cursor, but used when in IME mode |CursorIM|
		CursorColumn = { bg = C.bg_elevated }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorLine = {
			bg = U.vary_color({ latte = U.lighten(C.bg_elevated, 0.70, C.bg_primary) }, U.darken(C.border_subtle, 0.64, C.bg_primary)),
		}, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if forecrust (ctermfg OR guifg) is not set.
		Directory = { fg = C["function"] }, -- directory names (and other special names in listings)
		EndOfBuffer = { fg = O.show_end_of_buffer and C.border or C.bg_primary }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
		ErrorMsg = { fg = C.error, style = { "bold", "italic" } }, -- error messages on the command line
		VertSplit = { fg = O.transparent_background and C.border or C.bg_sunken }, -- the column separating vertically split windows
		Folded = { fg = C["function"], bg = O.transparent_background and C.none or C.border }, -- line used for closed folds
		FoldColumn = { fg = C.fg_nontext }, -- 'foldcolumn'
		SignColumn = { fg = C.border }, -- column where |signs| are displayed
		SignColumnSB = { bg = C.bg_sunken, fg = C.border }, -- column where |signs| are displayed
		Substitute = { bg = C.border, fg = U.vary_color({ latte = C.error }, C.special) }, -- |:substitute| replacement text highlighting
		LineNr = { fg = C.border }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		CursorLineNr = { fg = C.info }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line. highlights the number in numberline.
		MatchParen = { fg = C.constant, bg = C.border, style = { "bold" } }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg = { fg = C.fg_primary, style = { "bold" } }, -- 'showmode' message (e.g., "-- INSERT -- ")
		-- MsgArea = { fg = C.fg_primary }, -- Area for messages and cmdline, don't set this highlight because of https://github.com/neovim/neovim/issues/17832
		MsgSeparator = {}, -- Separator for scrolled messages, `msgsep` flag of 'display'
		MoreMsg = { fg = C["function"] }, -- |more-prompt|
		NonText = { fg = C.fg_nontext }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		Normal = { fg = C.fg_primary, bg = O.transparent_background and C.none or C.bg_primary }, -- normal text
		NormalNC = {
			fg = C.fg_primary,
			bg = (O.transparent_background and O.dim_inactive.enabled and C.dim)
				or (O.dim_inactive.enabled and C.dim)
				or (O.transparent_background and C.none)
				or C.bg_primary,
		}, -- normal text in non-current windows
		NormalSB = { fg = C.fg_primary, bg = C.bg_sunken }, -- normal text in non-current windows
		NormalFloat = { fg = C.fg_primary, bg = (O.float.transparent and vim.o.winblend == 0) and C.none or C.bg_elevated }, -- Normal text in floating windows.
		FloatBorder = O.float.solid
				and ((O.float.transparent and vim.o.winblend == 0) and { fg = C.border_strong, bg = C.none } or {
					fg = C.bg_elevated,
					bg = C.bg_elevated,
				})
			or { fg = C["function"], bg = (O.float.transparent and vim.o.winblend == 0) and C.none or C.bg_elevated },
		FloatTitle = O.float.solid and {
			fg = C.bg_sunken,
			bg = C.info,
		} or { fg = C.fg_tertiary, bg = (O.float.transparent and vim.o.winblend == 0) and C.none or C.bg_elevated }, -- Title of floating windows
		FloatShadow = { fg = (O.float.transparent and vim.o.winblend == 0) and C.none or C.fg_nontext },
		Pmenu = {
			bg = (O.transparent_background and vim.o.pumblend == 0) and C.none or C.bg_elevated,
			fg = C.fg_comment,
		}, -- Popup menu: normal item.
		PmenuSel = { bg = C.border_subtle, style = { "bold" } }, -- Popup menu: selected item.
		PmenuSbar = { bg = C.border_subtle }, -- Popup menu: scrollbar.
		PmenuThumb = { bg = C.fg_nontext }, -- Popup menu: Thumb of the scrollbar.
		PmenuExtra = { fg = C.fg_nontext }, -- Popup menu: normal item extra text.
		PmenuExtraSel = {
			bg = C.border_subtle,
			fg = C.fg_nontext,
			style = { "bold" },
		}, -- Popup menu: selected item extra text.
		Question = { fg = C["function"] }, -- |hit-enter| prompt and yes/no questions
		QuickFixLine = { bg = C.border, style = { "bold" } }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		Search = { bg = U.darken(C.operator, 0.30, C.bg_primary), fg = C.fg_primary }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
		IncSearch = { bg = U.darken(C.operator, 0.90, C.bg_primary), fg = C.bg_elevated }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		CurSearch = { bg = C.error, fg = C.bg_elevated }, -- 'cursearch' highlighting: highlights the current search you're on differently
		SpecialKey = { link = "NonText" }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' textspace. |hl-Whitespace|
		SpellBad = { sp = C.error, style = { "undercurl" } }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		SpellCap = { sp = C.type, style = { "undercurl" } }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		SpellLocal = { sp = C["function"], style = { "undercurl" } }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		SpellRare = { sp = C.string, style = { "undercurl" } }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
		StatusLine = { fg = C.fg_primary, bg = O.transparent_background and C.none or C.bg_elevated }, -- status line of current window
		StatusLineNC = { fg = C.border, bg = O.transparent_background and C.none or C.bg_elevated }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		TabLine = { bg = C.bg_sunken, fg = C.fg_nontext }, -- tab pages line, not active tab page label
		TabLineFill = { bg = O.transparent_background and C.none or C.bg_elevated }, -- tab pages line, where there are no labels
		TabLineSel = { link = "Normal" }, -- tab pages line, active tab page label
		TermCursor = { fg = C.bg_primary, bg = C.cursor }, -- cursor in a focused terminal
		TermCursorNC = { fg = C.bg_primary, bg = C.fg_comment }, -- cursor in unfocused terminals
		Title = { fg = C["function"], style = { "bold" } }, -- titles for output from ":set all", ":autocmd" etc.
		Visual = { bg = C.border, style = { "bold" } }, -- Visual mode selection
		VisualNOS = { bg = C.border, style = { "bold" } }, -- Visual mode selection when vim is "Not Owning the Selection".
		WarningMsg = { fg = C.type }, -- warning messages
		Whitespace = { fg = C.border }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
		WildMenu = { bg = C.fg_nontext }, -- current match in 'wildmenu' completion
		WinBar = { fg = C.cursor },
		WinBarNC = { link = "WinBar" },
		WinSeparator = { fg = O.transparent_background and C.border or C.bg_sunken },

		-- Lazy.nvim
		LazyButton = { bg = C.border_subtle, fg = C.fg_primary },
		LazyButtonActive = { bg = C.border, fg = C.fg_primary, style = { "bold" } },
	}
end

return M
