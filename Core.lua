-- SharedMedia_Criccafonts
-- Registers the bundled font faces with LibSharedMedia-3.0.

local addonName = ... or "SharedMedia_Criccafonts"

local LSM = LibStub and LibStub("LibSharedMedia-3.0", true)
if not LSM then
	return
end

local FONT = LSM.MediaType.FONT
local FONT_DIR = ("Interface\\Addons\\%s\\Fonts\\"):format(addonName)

-- Every entry produces one "font" media item in the LibSharedMedia dropdown.
-- Adding a family here is enough; no registration call needs to be written by hand.
local families = {
	{
		-- Weight names map onto "Pretendard-<Weight>.otf".
		label = "Pretendard",
		pattern = "Pretendard-%s.otf",
		locales = { "koKR", "western" },
		faces = {
			"Thin",
			"ExtraLight",
			"Light",
			"Regular",
			"Medium",
			"SemiBold",
			"Bold",
			"ExtraBold",
			"Black",
		},
	},
	{
		-- Families whose file names do not follow a pattern list them explicitly.
		locales = { "western" },
		faces = {
			{ "Google Sans Code", "GoogleSansCode.ttf" },
			{ "Google Sans Code Italic", "GoogleSansCode-Italic.ttf" },
		},
	},
}

local function localeMask(names)
	local mask = 0
	for _, name in ipairs(names) do
		local bit = LSM["LOCALE_BIT_" .. name]
		if bit then
			mask = mask + bit
		end
	end
	return mask
end

local function mediaName(family, face)
	if type(face) == "table" then
		return face[1]
	end
	return family.label .. " " .. face
end

local function mediaFile(family, face)
	if type(face) == "table" then
		return face[2]
	end
	return family.pattern:format(face)
end

for _, family in ipairs(families) do
	local mask = localeMask(family.locales)
	for _, face in ipairs(family.faces) do
		LSM:Register(FONT, mediaName(family, face), FONT_DIR .. mediaFile(family, face), mask)
	end
end
