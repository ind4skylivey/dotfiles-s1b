#!/usr/bin/env python3
import subprocess
import json
import re

def get_workspaces():
    try:
        current = subprocess.check_output(
            ["qdbus6", "org.kde.KWin", "/VirtualDesktopManager", "org.kde.KWin.VirtualDesktopManager.current"],
            stderr=subprocess.DEVNULL
        ).decode().strip()
        
        desktops_raw = subprocess.check_output(
            ["qdbus6", "--literal", "org.kde.KWin", "/VirtualDesktopManager", "org.kde.KWin.VirtualDesktopManager.desktops"],
            stderr=subprocess.DEVNULL
        ).decode().strip()
        
        uuids = re.findall(r'"([a-f0-9\-]+)"', desktops_raw)
        
        output = ""
        for i, uuid in enumerate(uuids):
            if i > 0:
                output += " | "
            if uuid == current:
                output += f"<span color='#ff0000' weight='bold'>⬤ {i+1}</span>"
            else:
                output += f"○ {i+1}"
        
        return output
    except Exception as e:
        return " ○ 1 | ○ 2 | ○ 3 | ○ 4 "

if __name__ == "__main__":
    print(json.dumps({"text": get_workspaces()}))
