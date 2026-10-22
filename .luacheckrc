-- Lua 5.1, matching the interpreter embedded in the WoW client.
std = "lua51"
max_line_length = false
codes = true

-- Bundled third-party libraries are not linted.
exclude_files = {
	"Libs/**/*.lua",
}

globals = {
	"LibStub",
}
