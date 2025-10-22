local M = {}

function M.get()
	return {
		-- Highlight only: strings, constants, comments, top-level definitions
		Comment = { fg = C.fg_comment, style = O.styles.comments }, -- just comments
		SpecialComment = { link = "Comment" }, -- special things inside a comment

		-- Constants (numbers, booleans, built-in constants)
		Constant = { fg = C.constant }, -- (preferred) any constant
		Number = { fg = C.constant, style = O.styles.numbers or {} }, --   a number constant: 234, 0xff
		Float = { link = "Number" }, --    a floating point constant: 2.3e10
		Boolean = { fg = C.constant, style = O.styles.booleans or {} }, --  a boolean constant: TRUE, false

		-- Strings
		String = { fg = C.string, style = O.styles.strings or {} }, -- a string constant: "this is a string"
		Character = { fg = C.string }, --  a character constant: 'c', '\n'

		-- Top-level definitions only (not calls)
		Function = { fg = C["function"], style = O.styles.functions or {} }, -- function name (also: methods for classes)

		-- Don't highlight: keywords, operators, variables, function calls
		Identifier = { fg = C.fg_primary, style = O.styles.variables or {} }, -- (preferred) any variable name
		Statement = { fg = C.fg_primary }, -- (preferred) any statement
		Conditional = { fg = C.fg_primary, style = O.styles.conditionals or {} }, --  if, then, else, endif, switch, etc.
		Repeat = { fg = C.fg_primary, style = O.styles.loops or {} }, --   for, do, while, etc.
		Label = { fg = C.fg_primary }, --    case, default, etc.
		Operator = { fg = C.fg_primary, style = O.styles.operators or {} }, -- "sizeof", "+", "*", etc.
		Keyword = { fg = C.fg_primary, style = O.styles.keywords or {} }, --  any other keyword
		Exception = { fg = C.fg_primary, style = O.styles.keywords or {} }, --  try, catch, throw

		PreProc = { fg = C.fg_primary }, -- (preferred) generic Preprocessor
		Include = { fg = C.fg_primary, style = O.styles.keywords or {} }, --  preprocessor #include
		Define = { link = "PreProc" }, -- preprocessor #define
		Macro = { fg = C.fg_primary }, -- same as Define
		PreCondit = { link = "PreProc" }, -- preprocessor #if, #else, #endif, etc.

		StorageClass = { fg = C.fg_primary }, -- static, register, volatile, etc.
		Structure = { fg = C.fg_primary }, --  struct, union, enum, etc.
		Special = { fg = C.fg_primary }, -- (preferred) any special symbol
		Type = { fg = C.fg_primary, style = O.styles.types or {} }, -- (preferred) int, long, char, etc.
		Typedef = { link = "Type" }, --  A typedef
		SpecialChar = { link = "Special" }, -- special character in a constant
		Tag = { fg = C.info }, -- you can use CTRL-] on this
		Delimiter = { fg = C.fg_subtle }, -- character that needs attention (dimmed)
		Debug = { link = "Special" }, -- debugging statements

		Underlined = { style = { "underline" } }, -- (preferred) text that stands out, HTML links
		Bold = { style = { "bold" } },
		Italic = { style = { "italic" } },
		-- ("Ignore", below, may be invisible...)
		-- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

		Error = { fg = C.error }, -- (preferred) any erroneous construct
		Todo = { bg = C.variable, fg = C.bg_primary, style = { "bold" } }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
		qfLineNr = { fg = C.type },
		qfFileName = { fg = C["function"] },
		htmlH1 = { fg = C.special },
		htmlH2 = { fg = C["function"] },
		-- mkdHeading = { fg = C.constant, style = { "bold" } },
		-- mkdCode = { bg = C.terminal_black, fg = C.fg_primary },
		mkdCodeDelimiter = { bg = C.bg_primary, fg = C.fg_primary },
		mkdCodeStart = { fg = C.string },
		mkdCodeEnd = { fg = C.string },
		-- mkdLink = { fg = C["function"], style = { "underline" } },

		-- debugging
		debugPC = { bg = O.transparent_background and C.none or C.bg_sunken }, -- used for highlighting the current line in terminal-debug
		debugBreakpoint = { bg = C.bg_primary, fg = C.fg_nontext }, -- used for breakpoint colors in terminal-debug
		-- illuminate
		illuminatedWord = { bg = C.border },
		illuminatedCurWord = { bg = C.border },
		-- diff
		diffAdded = { fg = C.string },
		diffRemoved = { fg = C.error },
		diffChanged = { fg = C["function"] },
		diffOldFile = { fg = C.type },
		diffNewFile = { fg = C.constant },
		diffFile = { fg = C["function"] },
		diffLine = { fg = C.fg_nontext },
		diffIndexLine = { fg = C.character },
		DiffAdd = { bg = U.darken(C.string, 0.18, C.bg_primary) }, -- diff mode: Added line |diff.txt|
		DiffChange = { bg = U.darken(C["function"], 0.07, C.bg_primary) }, -- diff mode: Changed line |diff.txt|
		DiffDelete = { bg = U.darken(C.error, 0.18, C.bg_primary) }, -- diff mode: Deleted line |diff.txt|
		DiffText = { bg = U.darken(C["function"], 0.30, C.bg_primary) }, -- diff mode: Changed text within a changed line |diff.txt|
		-- NeoVim
		healthError = { fg = C.error },
		healthSuccess = { fg = C.character },
		healthWarning = { fg = C.type },
		-- misc

		-- glyphs
		GlyphPalette1 = { fg = C.error },
		GlyphPalette2 = { fg = C.character },
		GlyphPalette3 = { fg = C.type },
		GlyphPalette4 = { fg = C["function"] },
		GlyphPalette6 = { fg = C.character },
		GlyphPalette7 = { fg = C.fg_primary },
		GlyphPalette9 = { fg = C.error },

		-- rainbow
		rainbow1 = { fg = C.error },
		rainbow2 = { fg = C.constant },
		rainbow3 = { fg = C.type },
		rainbow4 = { fg = C.string },
		rainbow5 = { fg = C.label },
		rainbow6 = { fg = C.info },

		-- csv
		csvCol0 = { fg = C.error },
		csvCol1 = { fg = C.constant },
		csvCol2 = { fg = C.type },
		csvCol3 = { fg = C.string },
		csvCol4 = { fg = C.operator },
		csvCol5 = { fg = C["function"] },
		csvCol6 = { fg = C.info },
		csvCol7 = { fg = C.keyword },
		csvCol8 = { fg = C.special },

		-- markdown
		markdownHeadingDelimiter = { fg = C.constant },
		markdownCode = { fg = C.string },
		markdownCodeBlock = { fg = C.string },
		markdownLinkText = { fg = C["function"], style = { "underline" } },
		markdownH1 = { link = "rainbow1" },
		markdownH2 = { link = "rainbow2" },
		markdownH3 = { link = "rainbow3" },
		markdownH4 = { link = "rainbow4" },
		markdownH5 = { link = "rainbow5" },
		markdownH6 = { link = "rainbow6" },
	}
end

return M
