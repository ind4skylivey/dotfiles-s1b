-- Quick file jump using fd + fzf. Opens the chosen path in Yazi.
local function notify(msg)
	ya.notify({ title = "fzf.yazi", content = msg, level = "warn" })
end

local function entry()
	local cwd = cx.active.current.cwd
	if not cwd then
		return notify("no current directory")
	end

	local cmd = "fd --type f --type d --hidden --follow --exclude .git | fzf --ansi"
	local out, err = Command("sh")
		:arg({ "-c", cmd, "sh" })
		:cwd(tostring(cwd))
		:stdin(Command.INHERIT)
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not out then
		return notify("fzf failed: " .. (err or "unknown"))
	end

	local path = (out.stdout or ""):match("([^\r\n]+)")
	if not path or path == "" then
		return
	end

	local url
	if path:match("^/") or path:match("^%a:[/\\]") then
		url = Url(path)
	else
		url = cwd:join(path)
	end
	if not url then
		return notify("invalid path: " .. path)
	end

	local cha = fs.cha(url)
	if cha and cha.is_dir then
		ya.manager_emit("cd", { url })
	else
		ya.manager_emit("open", { url })
	end
end

return { entry = entry }
