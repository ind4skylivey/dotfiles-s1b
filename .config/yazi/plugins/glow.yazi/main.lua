local M = {}

-- Prefer a locally bundled glow binary (built into this config) to avoid PATH issues.
local function glow_cmd()
	local local_glow = "/home/il1v3y/.config/yazi/.gopath/bin/glow"
	local handle = io.open(local_glow, "rb")
	if handle then
		handle:close()
		return local_glow
	end
	return "glow"
end

local function warn(msg)
	ya.notify({
		title = "glow.yazi",
		content = msg,
		level = "warn",
	})
end

function M:peek(job)
	-- Fixed preview width to keep wrapping consistent inside Yazi
	local preview_width = 55
	local file_path = tostring(job.file.url):gsub("^file://", "")
	file_path = file_path:gsub("^//", "/")

	local ok, child = pcall(function()
		return Command(glow_cmd())
			:arg("--style")
			:arg("dark")
			:arg("--width")
			:arg(tostring(preview_width))
			:arg(file_path)
			:env("CLICOLOR_FORCE", "1")
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:spawn()
	end)

	if not ok or not child then
		warn("Failed to spawn glow; falling back to code preview")
		return require("code").peek(job)
	end

	local limit = job.area.h
	local i, lines = 0, ""
	repeat
		local next, event = child:read_line()
		if event == 1 then
			warn("Glow returned an error; showing plain text")
			return require("code").peek(job)
		elseif event ~= 0 then
			break
		end

		i = i + 1
		if i > job.skip then
			lines = lines .. next
		end
	until i >= job.skip + limit

	child:start_kill()
	if lines == "" or lines:match("^%s*$") then
		warn("Glow produced no output; showing plain text")
		return require("code").peek(job)
	end

	if job.skip > 0 and i < job.skip + limit then
		ya.manager_emit("peek", { 
			tostring(math.max(0, i - limit)), 
			only_if = job.file.url,
			upper_bound = true 
		})
	else
		local tab_sz = (rt and rt.preview and rt.preview.tab_size) or 4
		lines = lines:gsub("\t", string.rep(" ", tab_sz))
		local widget = ui.Text.parse(lines):area(job.area)
		if ya.preview_widget then
			ya.preview_widget(job, widget)
		else
			-- Backward compatibility with older Yazi versions
			ya.preview_widgets(job, { widget })
		end
	end
end

function M:seek(job)
	local h = cx.active.current.hovered
	if not h or h.url ~= job.file.url then
		return
	end
	ya.manager_emit('peek', {
		math.max(0, cx.active.preview.skip + job.units),
		only_if = job.file.url,
	})
end

return M
