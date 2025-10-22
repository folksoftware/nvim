local M = {}

function M.get()
	if vim.treesitter.highlighter.hl_map then
		vim.notify_once(
			[[Folk (info):
nvim-treesitter integration requires neovim 0.8
If you want to stay on nvim 0.7, pin folk tag to v0.2.4 and nvim-treesitter commit to 4cccb6f494eb255b32a290d37c35ca12584c74d0.
]],
			vim.log.levels.INFO
		)
		return {}
	end

	local colors = { -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
		-- Identifiers - don't highlight regular variables
		["@variable"] = { fg = C.fg_primary, style = O.styles.variables or {} }, -- Any variable name that does not have another highlight.
		["@variable.builtin"] = { fg = C.fg_primary, style = O.styles.properties or {} }, -- Variable names that are defined by the languages, like this or self.
		["@variable.parameter"] = { fg = C.fg_primary, style = O.styles.variables or {} }, -- For parameters of a function.
		["@variable.member"] = { fg = C.fg_primary }, -- For fields.

		["@constant"] = { link = "Constant" }, -- For constants
		["@constant.builtin"] = { fg = C.constant, style = O.styles.keywords or {} }, -- For constant that are built in the language: nil in Lua.
		["@constant.macro"] = { link = "Constant" }, -- For constants that are defined by macros: NULL in C.

		["@module"] = { fg = C.fg_primary, style = O.styles.miscs or {} }, -- For identifiers referring to modules and namespaces.
		["@label"] = { link = "Label" }, -- For labels: label: in C and :label: in Lua.

		-- Literals
		["@string"] = { link = "String" }, -- For strings.
		["@string.documentation"] = { fg = C.character, style = O.styles.strings or {} }, -- For strings documenting code (e.g. Python docstrings).
		["@string.regexp"] = { fg = C.special, style = O.styles.strings or {} }, -- For regexes.
		["@string.escape"] = { fg = C.special, style = O.styles.strings or {} }, -- For escape characters within a string.
		["@string.special"] = { link = "Special" }, -- other special strings (e.g. dates)
		["@string.special.path"] = { link = "Special" }, -- filenames
		["@string.special.symbol"] = { fg = C.variable }, -- symbols or atoms
		["@string.special.url"] = { fg = C["function"], style = { "italic", "underline" } }, -- urls, links and emails
		["@punctuation.delimiter.regex"] = { link = "@string.regexp" },

		["@character"] = { link = "Character" }, -- character literals
		["@character.special"] = { link = "SpecialChar" }, -- special characters (e.g. wildcards)

		["@boolean"] = { link = "Boolean" }, -- For booleans.
		["@number"] = { link = "Number" }, -- For all numbers
		["@number.float"] = { link = "Float" }, -- For floats.

		-- Types
		["@type"] = { link = "Type" }, -- For types.
		["@type.builtin"] = { fg = C.fg_primary, style = O.styles.properties or {} }, -- For builtin types.
		["@type.definition"] = { link = "Type" }, -- type definitions (e.g. `typedef` in C)

		["@attribute"] = { link = "Constant" }, -- attribute annotations (e.g. Python decorators)
		["@property"] = { fg = C.fg_primary, style = O.styles.properties or {} }, -- For fields, like accessing `bar` property on `foo.bar`. Overriden later for data languages and CSS.

		-- Functions - only highlight definitions, not calls
		["@function"] = { link = "Function" }, -- For function (calls and definitions).
		["@function.builtin"] = { fg = C.constant, style = O.styles.functions or {} }, -- For builtin functions: table.insert in Lua.
		["@function.call"] = { fg = C.fg_primary }, -- function calls - don't highlight
		["@function.macro"] = { fg = C.fg_primary, style = O.styles.functions or {} }, -- For macro defined functions (calls and definitions): each macro_rules in Rust.

		["@function.method"] = { link = "Function" }, -- For method definitions.
		["@function.method.call"] = { fg = C.fg_primary }, -- For method calls - don't highlight

		["@constructor"] = { fg = C.fg_primary }, -- For constructor calls and definitions: = { } in Lua, and Java constructors.
		["@operator"] = { fg = C.fg_primary }, -- For any operator: +, but also -> and * in C - don't highlight

		-- Keywords - don't highlight
		["@keyword"] = { link = "Keyword" }, -- For keywords that don't fall in previous categories.
		["@keyword.modifier"] = { link = "Keyword" }, -- For keywords modifying other constructs (e.g. `const`, `static`, `public`)
		["@keyword.type"] = { link = "Keyword" }, -- For keywords describing composite types (e.g. `struct`, `enum`)
		["@keyword.coroutine"] = { link = "Keyword" }, -- For keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
		["@keyword.function"] = { fg = C.fg_primary, style = O.styles.keywords or {} }, -- For keywords used to define a function.
		["@keyword.operator"] = { fg = C.fg_primary, style = O.styles.keywords or {} }, -- For new keyword operator
		["@keyword.import"] = { link = "Include" }, -- For includes: #include in C, use or extern crate in Rust, or require in Lua.
		["@keyword.repeat"] = { link = "Repeat" }, -- For keywords related to loops.
		["@keyword.return"] = { fg = C.fg_primary, style = O.styles.keywords or {} },
		["@keyword.debug"] = { link = "Exception" }, -- For keywords related to debugging
		["@keyword.exception"] = { link = "Exception" }, -- For exception related keywords.

		["@keyword.conditional"] = { link = "Conditional" }, -- For keywords related to conditionnals.
		["@keyword.conditional.ternary"] = { fg = C.fg_primary }, -- For ternary operators (e.g. `?` / `:`)

		["@keyword.directive"] = { link = "PreProc" }, -- various preprocessor directives & shebangs
		["@keyword.directive.define"] = { link = "Define" }, -- preprocessor definition directives
		-- JS & derivative
		["@keyword.export"] = { fg = C.fg_primary, style = O.styles.keywords },

		-- Punctuation - dim to make names stand out
		["@punctuation.delimiter"] = { link = "Delimiter" }, -- For delimiters (e.g. `;` / `.` / `,`).
		["@punctuation.bracket"] = { fg = C.fg_subtle }, -- For brackets and parenthesis - dimmed.
		["@punctuation.special"] = { fg = C.fg_subtle }, -- For special punctuation that does not fall in the categories before (e.g. `{}` in string interpolation).

		-- Comment
		["@comment"] = { link = "Comment" },
		["@comment.documentation"] = { link = "Comment" }, -- For comments documenting code

		["@comment.error"] = { fg = C.bg_primary, bg = C.error },
		["@comment.warning"] = { fg = C.bg_primary, bg = C.type },
		["@comment.hint"] = { fg = C.bg_primary, bg = C["function"] },
		["@comment.todo"] = { fg = C.bg_primary, bg = C.variable },
		["@comment.note"] = { fg = C.bg_primary, bg = C.cursor },

		-- Markup
		["@markup"] = { fg = C.fg_primary }, -- For strings considerated text in a markup language.
		["@markup.strong"] = { fg = C.fg_primary, style = { "bold" } }, -- bold - keep styling but don't highlight
		["@markup.italic"] = { fg = C.fg_primary, style = { "italic" } }, -- italic - keep styling but don't highlight
		["@markup.strikethrough"] = { fg = C.fg_primary, style = { "strikethrough" } }, -- strikethrough text
		["@markup.underline"] = { link = "Underlined" }, -- underlined text

		["@markup.heading"] = { fg = C["function"] }, -- titles like: # Example
		["@markup.heading.markdown"] = {}, -- markdown headings inherit from @markup.heading

		["@markup.math"] = { fg = C["function"] }, -- math environments (e.g. `$ ... $` in LaTeX)
		["@markup.quote"] = { fg = C.special }, -- block quotes
		["@markup.environment"] = { fg = C.special }, -- text environments of markup languages
		["@markup.environment.name"] = { fg = C["function"] }, -- text indicating the type of an environment

		["@markup.link"] = { fg = C["function"] }, -- text references, footnotes, citations, etc.
		["@markup.link.label"] = { fg = C["function"] }, -- link, reference descriptions
		["@markup.link.url"] = { fg = C["function"], style = { "underline" } }, -- urls, links and emails

		["@markup.raw"] = { fg = C.string }, -- used for inline code in markdown and for doc in python (""")

		["@markup.list"] = { fg = C.character },
		["@markup.list.checked"] = { fg = C.string }, -- todo notes
		["@markup.list.unchecked"] = { fg = C.fg_subtle }, -- todo notes

		-- Diff
		["@diff.plus"] = { link = "diffAdded" }, -- added text (for diff files)
		["@diff.minus"] = { link = "diffRemoved" }, -- deleted text (for diff files)
		["@diff.delta"] = { link = "diffChanged" }, -- deleted text (for diff files)

		-- Tags
		["@tag"] = { fg = C["function"] }, -- Tags like HTML tag names.
		["@tag.builtin"] = { fg = C["function"] }, -- JSX tag names.
		["@tag.attribute"] = { fg = C.fg_primary, style = O.styles.miscs or {} }, -- XML/HTML attributes (foo in foo="bar").
		["@tag.delimiter"] = { fg = C.fg_subtle }, -- Tag delimiter like < > / - dimmed

		-- Misc
		["@error"] = { link = "Error" },

		-- Language specific:

		-- Bash
		["@function.builtin.bash"] = { fg = C.constant, style = O.styles.miscs or {} },
		["@variable.parameter.bash"] = { fg = C.fg_primary },

		-- markdown
		["@markup.heading.1.markdown"] = { link = "rainbow1" },
		["@markup.heading.2.markdown"] = { link = "rainbow2" },
		["@markup.heading.3.markdown"] = { link = "rainbow3" },
		["@markup.heading.4.markdown"] = { link = "rainbow4" },
		["@markup.heading.5.markdown"] = { link = "rainbow5" },
		["@markup.heading.6.markdown"] = { link = "rainbow6" },

		-- Java
		["@constant.java"] = { fg = C.character },

		-- CSS - properties are more important in CSS than in regular code
		["@property.css"] = { fg = C["function"] },
		["@property.scss"] = { fg = C["function"] },
		["@property.id.css"] = { fg = C["function"] },
		["@property.class.css"] = { fg = C["function"] },
		["@type.css"] = { fg = C.fg_primary },
		["@type.tag.css"] = { fg = C["function"] },
		["@string.plain.css"] = { fg = C.fg_primary },
		["@number.css"] = { fg = C.constant },
		["@keyword.directive.css"] = { link = "Keyword" }, -- CSS at-rules: https://developer.mozilla.org/en-US/docs/Web/CSS/At-rule.

		-- HTML
		["@string.special.url.html"] = { fg = C.string }, -- Links in href, src attributes.
		["@markup.link.label.html"] = { fg = C.fg_primary }, -- Text between <a></a> tags.
		["@character.special.html"] = { fg = C.constant }, -- Symbols such as &nbsp;.

		-- Lua
		["@constructor.lua"] = { link = "@punctuation.bracket" }, -- For constructor calls and definitions: = { } in Lua.

		-- Python
		["@constructor.python"] = { fg = C.fg_primary }, -- __init__(), __new__().

		-- YAML
		["@label.yaml"] = { fg = C.fg_primary }, -- Anchor and alias names.

		-- Ruby
		["@string.special.symbol.ruby"] = { fg = C.constant },

		-- PHP
		["@function.method.php"] = { link = "Function" },
		["@function.method.call.php"] = { fg = C.fg_primary },

		-- C/CPP
		["@keyword.import.c"] = { fg = C.fg_primary },
		["@keyword.import.cpp"] = { fg = C.fg_primary },

		-- C#
		["@attribute.c_sharp"] = { link = "Constant" },

		-- gitcommit
		["@comment.warning.gitcommit"] = { fg = C.fg_comment },

		-- gitignore
		["@string.special.path.gitignore"] = { fg = C.fg_primary },

		-- Misc
		gitcommitSummary = { fg = C.fg_primary, style = O.styles.miscs or {} },
		zshKSHFunction = { link = "Function" },
	}

	-- Legacy highlights
	colors["@parameter"] = colors["@variable.parameter"]
	colors["@field"] = colors["@variable.member"]
	colors["@namespace"] = colors["@module"]
	colors["@float"] = colors["@number.float"]
	colors["@symbol"] = colors["@string.special.symbol"]
	colors["@string.regex"] = colors["@string.regexp"]

	colors["@text"] = colors["@markup"]
	colors["@text.strong"] = colors["@markup.strong"]
	colors["@text.emphasis"] = colors["@markup.italic"]
	colors["@text.underline"] = colors["@markup.underline"]
	colors["@text.strike"] = colors["@markup.strikethrough"]
	colors["@text.uri"] = colors["@markup.link.url"]
	colors["@text.math"] = colors["@markup.math"]
	colors["@text.environment"] = colors["@markup.environment"]
	colors["@text.environment.name"] = colors["@markup.environment.name"]

	colors["@text.title"] = colors["@markup.heading"]
	colors["@text.literal"] = colors["@markup.raw"]
	colors["@text.reference"] = colors["@markup.link"]

	colors["@text.todo.checked"] = colors["@markup.list.checked"]
	colors["@text.todo.unchecked"] = colors["@markup.list.unchecked"]

	colors["@comment.note"] = colors["@comment.hint"]

	-- @text.todo is now for todo comments, not todo notes like in markdown
	colors["@text.todo"] = colors["@comment.todo"]
	colors["@text.warning"] = colors["@comment.warning"]
	colors["@text.note"] = colors["@comment.note"]
	colors["@text.danger"] = colors["@comment.error"]

	-- @text.uri is now
	-- > @markup.link.url in markup links
	-- > @string.special.url outside of markup
	colors["@text.uri"] = colors["@markup.link.uri"]

	colors["@method"] = colors["@function.method"]
	colors["@method.call"] = colors["@function.method.call"]

	colors["@text.diff.add"] = colors["@diff.plus"]
	colors["@text.diff.delete"] = colors["@diff.minus"]

	colors["@type.qualifier"] = colors["@keyword.modifier"]
	colors["@keyword.storage"] = colors["@keyword.modifier"]
	colors["@define"] = colors["@keyword.directive.define"]
	colors["@preproc"] = colors["@keyword.directive"]
	colors["@storageclass"] = colors["@keyword.storage"]
	colors["@conditional"] = colors["@keyword.conditional"]
	colors["@exception"] = colors["@keyword.exception"]
	colors["@include"] = colors["@keyword.import"]
	colors["@repeat"] = colors["@keyword.repeat"]

	colors["@symbol.ruby"] = colors["@string.special.symbol.ruby"]

	colors["@variable.member.yaml"] = colors["@field.yaml"]

	colors["@text.title.1.markdown"] = colors["@markup.heading.1.markdown"]
	colors["@text.title.2.markdown"] = colors["@markup.heading.2.markdown"]
	colors["@text.title.3.markdown"] = colors["@markup.heading.3.markdown"]
	colors["@text.title.4.markdown"] = colors["@markup.heading.4.markdown"]
	colors["@text.title.5.markdown"] = colors["@markup.heading.5.markdown"]
	colors["@text.title.6.markdown"] = colors["@markup.heading.6.markdown"]

	colors["@method.php"] = colors["@function.method.php"]
	colors["@method.call.php"] = colors["@function.method.call.php"]

	return colors
end

return M
