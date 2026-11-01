#!/usr/bin/env python3
import json

apps = {
    "terminal": {"icon": "󰓛", "cmd": "alacritty || konsole || xterm"},
    "browser": {"icon": "󰊯", "cmd": "firefox || chromium || google-chrome"},
    "editor": {"icon": "󰨳", "cmd": "code || gedit || nvim"},
    "file_manager": {"icon": "󰉋", "cmd": "dolphin || nautilus || pcmanfm"},
}

output = "  "
for app, data in apps.items():
    output += f'<span color="#ff0000">{data["icon"]}</span> '

print(json.dumps({"text": output}))
