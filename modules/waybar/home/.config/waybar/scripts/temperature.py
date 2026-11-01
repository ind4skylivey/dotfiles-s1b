#!/usr/bin/env python3
import subprocess
import json
import os
import glob

def get_temperature():
    try:
        # Intenta obtener de /sys/class/thermal (preferido)
        thermal_files = glob.glob("/sys/class/thermal/thermal_zone*/temp")
        if thermal_files:
            try:
                with open(thermal_files[0]) as f:
                    temp_millidegrees = int(f.read().strip())
                    temp_celsius = temp_millidegrees / 1000
                    return format_temp(temp_celsius)
            except:
                pass
        
        # Intenta hwmon
        hwmon_files = glob.glob("/sys/class/hwmon/*/temp*_input")
        if hwmon_files:
            try:
                with open(hwmon_files[0]) as f:
                    temp_millidegrees = int(f.read().strip())
                    temp_celsius = temp_millidegrees / 1000
                    return format_temp(temp_celsius)
            except:
                pass
        
        # Intenta con sensors command
        try:
            result = subprocess.check_output(
                ["sensors", "-u", "-A"],
                stderr=subprocess.DEVNULL,
                timeout=2
            ).decode()
            
            for line in result.split('\n'):
                if 'Core' in line or 'Package' in line:
                    if '+' in line and '°C' in line:
                        parts = line.split('+')
                        if len(parts) > 1:
                            temp_str = parts[1].split('°')[0].strip()
                            try:
                                temp_celsius = float(temp_str)
                                return format_temp(temp_celsius)
                            except:
                                continue
        except:
            pass
        
        # Si no encuentra nada, retorna vacío para no mostrar nada
        return {"text": "", "class": "normal"}
    
    except:
        return {"text": "", "class": "normal"}

def format_temp(temp_celsius):
    icon = "󰔏"
    css_class = "normal"
    
    if temp_celsius > 80:
        css_class = "hot"
        icon = "󰻠"
    elif temp_celsius > 60:
        css_class = "warm"
        icon = "󰔆"
    
    return {"text": f"{icon} {temp_celsius:.0f}°C", "class": css_class}

if __name__ == "__main__":
    result = get_temperature()
    print(json.dumps(result))
