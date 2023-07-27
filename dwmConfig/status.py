import subprocess
import time
import re


battery_charging = "\U0001F50C"
battery_full = "\U0001F50B"  # Same as battery, since the Unicode code point is the same



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
        print(f"Error: {e}")
        return None


def battery_percentage():
    return runCmd("cat /sys/class/power_supply/BAT0/capacity").stdout.strip()

def str_brightness():
    bri = runCmd("cat /sys/class/backlight/intel_backlight/brightness").stdout.strip()
    totalbright = runCmd("cat /sys/class/backlight/intel_backlight/max_brightness").stdout.strip()
    return f"{bri}-{totalbright}"

def str_ram():
    ramdata = runCmd("free | grep Mem:").stdout.strip().split(" ")
    filter_data = list(filter(lambda x: x!="", ramdata))[1:3]
    st = [round(int(i)/1024, 2) for i in filter_data]
    string = f"{st[0]}-{st[1]}"
    return string

def str_battery():
    status = runCmd("cat /sys/class/power_supply/BAT0/status").stdout.strip()
    btry = battery_full
    percent = battery_percentage()
    if status == "Charging":
        btry = battery_charging
    char = f'({btry} {percent})'
    return char

def str_volume():
    data = runCmd("pactl list sinks | grep -E 'Volume:.*front-left|Volume:.*front-right'").stdout.strip()
    # Use regular expression to find the volume percentage
    percentage_pattern = r"front-(left|right):\s*\d+\s*\/\s*(\d+)%"
    matches = re.findall(percentage_pattern, data)
    if matches:
        left_per, right_per = int(matches[0][1]), int(matches[1][1])
        return f"{left_per}-{right_per}%"
    return f"{None}%"


def str_temprature():
    data = read_cpu_temperature()
    if data is not None:
        return f"{data:.1f}°C"
    else:
        return "None"

while True:
    str_ram()
    cmd = f'xsetroot -name "|   {str_battery()}   |   {str_brightness()}   |   {str_ram()}MB    |   {str_temprature()}    |   {str_volume()}   |   {time.strftime("%I:%M:%S %p")}   |"'
    print(cmd)
    runCmd(cmd)
    time.sleep(1)
