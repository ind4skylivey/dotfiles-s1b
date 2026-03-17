-- Simple zoxide jumper for Yazi.
local function notify(msg)
	ya.notify({ title = "zoxide.yazi", content = msg, level = "warn" })
end

local function entry()
	local out, err = Command("zoxide")
		:arg("query")
		:arg("-i")
		:stdin(Command.INHERIT)
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not out then
		return notify("zoxide failed: " .. (err or "unknown"))
	end

	local target = (out.stdout or ""):gsub("^%s+", ""):gsub("%s+$", "")
	if target == "" then
		return
	end

	ya.manager_emit("cd", { target })
end

return { entry = entry }
