#!/usr/bin/env python3
import subprocess
import json
import os

def get_wallpaper_info():
    try:
        result = subprocess.run(
            ["bash", os.path.expanduser("~/.config/waybar/scripts/wallpaper.sh"), "current"],
            capture_output=True,
            text=True,
            timeout=2
        )
        current = result.stdout.strip()
        
        count_result = subprocess.run(
            ["bash", os.path.expanduser("~/.config/waybar/scripts/wallpaper.sh"), "count"],
            capture_output=True,
            text=True,
            timeout=2
        )
        count = count_result.stdout.strip()
        
        if current:
            name = os.path.basename(current).split('.')[0]
            return {"text": f"🖼 {name} ({count})", "class": "normal"}
        else:
            return {"text": "🖼 No wallpaper", "class": "normal"}
    
    except Exception as e:
        return {"text": "🖼 Error", "class": "normal"}

if __name__ == "__main__":
    result = get_wallpaper_info()
    print(json.dumps(result))
