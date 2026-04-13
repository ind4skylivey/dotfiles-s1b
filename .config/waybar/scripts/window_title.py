#!/usr/bin/env python3
import subprocess
import json

def get_active_window_title():
    try:
        active_window_id = subprocess.check_output(
            ["qdbus6", "org.kde.KWin", "/KWin", "org.kde.KWin.activeWindow"],
            stderr=subprocess.DEVNULL
        ).decode().strip()

        if not active_window_id or active_window_id == "-1":
            return "Desktop"

        title = subprocess.check_output(
            ["qdbus6", "org.kde.KWin", "/KWin", "org.kde.KWin.windowTitle", active_window_id],
            stderr=subprocess.DEVNULL
        ).decode().strip()

        return title
    except:
        return "System"

if __name__ == "__main__":
    title = get_active_window_title()
    if len(title) > 40: title = title[:37] + "..."
    print(json.dumps({"text": title}))
