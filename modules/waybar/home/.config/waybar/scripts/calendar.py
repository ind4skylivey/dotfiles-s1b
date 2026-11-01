#!/usr/bin/env python3
import subprocess
import sys
from datetime import datetime

def show_calendar():
    try:
        result = subprocess.run(
            ["zenity", "--calendar", "--title=Calendario"],
            capture_output=True,
            text=True
        )
        if result.returncode == 0:
            print(f"Selected: {result.stdout.strip()}")
    except FileNotFoundError:
        try:
            subprocess.run(
                ["kdialog", "--calendar", "Selecciona una fecha"],
                stderr=subprocess.DEVNULL,
                stdout=subprocess.DEVNULL
            )
        except FileNotFoundError:
            import json
            print(json.dumps({"text": "Calendario no disponible"}))

if __name__ == "__main__":
    show_calendar()
