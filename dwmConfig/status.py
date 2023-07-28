import subprocess
import time
import re


btry_emty = ""
btry_half = ""
btry_full = ""  # Same as battery, since the Unicode code point is the same
btry_charge = ""
wifi_connect = ""
volume_ic = ""
brightness_ic = ""
temp_ic = ""
ram_ic = ""
clock_ic = ""

def runCmd(cmd):
    result = subprocess.run([cmd], shell=True, capture_output=True, text=True)
    return result


def read_cpu_temperature():
    try:
        with open('/sys/class/thermal/thermal_zone0/temp', 'r') as temp_file:
            temperature_millidegrees = int(temp_file.read().strip())
            temperature_celsius = temperature_millidegrees / 1000.0
            return temperature_celsius
    except Exception as e:
        # print(f"Error: {e}")
        return None


def battery_percentage():
    return runCmd("cat /sys/class/power_supply/BAT0/capacity").stdout.strip()

def str_brightness():
    bri = runCmd("cat /sys/class/backlight/intel_backlight/brightness").stdout.strip()
    totalbright = runCmd("cat /sys/class/backlight/intel_backlight/max_brightness").stdout.strip()
    return f"{brightness_ic} {bri}"

def str_ram():
    ramdata = runCmd("free | grep Mem:").stdout.strip().split(" ")
    filter_data = list(filter(lambda x: x!="", ramdata))[1:3]
    st = [round(int(i)/1024, 2) for i in filter_data]
    string = f"{ram_ic} {st[1]:.1f}"
    return string

def str_battery():
    status = runCmd("cat /sys/class/power_supply/BAT0/status").stdout.strip()
    percent = battery_percentage()
    btry = btry_full
    if status == "Charging":
        btry = btry_charge
    char = f'{btry} {percent}%'
    return char

def str_volume():
    data = runCmd("pactl list sinks | grep -E 'Volume:.*front-left|Volume:.*front-right'").stdout.strip()
    # Use regular expression to find the volume percentage
    percentage_pattern = r"front-(left|right):\s*\d+\s*\/\s*(\d+)%"
    matches = re.findall(percentage_pattern, data)
    if matches:
        left_per, right_per = int(matches[0][1]), int(matches[1][1])
        return f"{volume_ic} {right_per}%"
    return f"{None}%"


def str_temprature():
    data = read_cpu_temperature()
    if data is not None:
        return f"{temp_ic} {data:.1f}°C"
    else:
        return "None"

while True:
    str_ram()
    cmd = f'xsetroot -name "| {str_battery()} | {str_brightness()} | {str_ram()}MB | {str_temprature()} | {str_volume()} | {clock_ic} {time.strftime("%I:%M:%S %p")} |"'
    runCmd(cmd)
    time.sleep(1)
