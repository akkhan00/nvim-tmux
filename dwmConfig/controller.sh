#!/bin/bash

# Function to set the brightness using sudo and tee
function set_brightness() {
    local brightness="$1"
    echo "$brightness" | sudo tee /sys/class/backlight/intel_backlight/brightness
}

# Function to adjust the volume using pactl
function adjust_volume() {
    local volume="$1"
    pactl set-sink-volume @DEFAULT_SINK@ "$volume"
}

# Check if the number of arguments is correct
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 --brightness (max=741) | --volume <value>"
    exit 1
fi

# Extract the option (brightness or volume) and value from the arguments
option="$1"
value="$2"

case "$option" in
    --brightness)
        # Check if the brightness value is a valid number
        if ! [[ "$value" =~ ^[0-9]+$ ]]; then
            echo "Error: Invalid brightness value. Please provide an integer."
            exit 1
        fi
        # Set the brightness using the provided value
        set_brightness "$value"
        ;;
    --volume)
        # Check if the volume adjustment value is a valid number
        if ! [[ "$value" =~ ^[-+]?[0-9]*\.?[0-9]+%?$ ]]; then
            echo "Error: Invalid volume adjustment value. Please provide a percentage value."
            exit 1
        fi
        # Adjust the volume using the provided value
        adjust_volume "$value"
        ;;
    *)
        echo "Usage: $0 --brightness|--volume <value>"
        exit 1
        ;;
esac

