local M = {}

function M.get()
	return {
		terminal_color_0 = C.fg_nontext,
		terminal_color_8 = C.fg_subtle,

		terminal_color_1 = C.error,
		terminal_color_9 = C.error,

		terminal_color_2 = C.string,
		terminal_color_10 = C.string,

		terminal_color_3 = C.type,
		terminal_color_11 = C.type,

		terminal_color_4 = C["function"],
		terminal_color_12 = C["function"],

		terminal_color_5 = C.special,
		terminal_color_13 = C.special,

		terminal_color_6 = C.operator,
		terminal_color_14 = C.operator,

		terminal_color_7 = C.fg_primary,
		terminal_color_15 = C.fg_primary,
	}
end

return M
