#!/bin/sh
set -x -e

# Perform the actions to erase a dev board, load the CircuitPython firmware
# and the board-level test software.

# This must be run from a shell that already has the tools virtual environment
# initialized.
# Must be executed from the root folder of the repository.
# On Linux, ensure that the user is a member of the dialout group.

# Assumes the port is /dev/ttyUSB0

# Erase the device's flash
esptool --port /dev/ttyUSB0 erase-flash

# Load CircuitPython
esptool --chip esp32 --port /dev/ttyUSB0 --baud 460800 write-flash -z --flash-mode dio --flash-freq 40m --flash-size detect 0x0 firmware/adafruit-circuitpython-espressif_esp32_devkitc_v4_wroom_32e-en_US-10.1.1.bin

# Load the necessary Adafruit libraries onto the board
ampy --port /dev/ttyUSB0 put firmware/lib/adafruit_dht.mpy lib/adafruit_dht.mpy
ampy --port /dev/ttyUSB0 put firmware/lib/adafruit_ds18x20.mpy lib/adafruit_ds18x20.mpy
ampy --port /dev/ttyUSB0 put firmware/lib/adafruit_pixelbuf.mpy lib/adafruit_pixelbuf.mpy
ampy --port /dev/ttyUSB0 put firmware/lib/neopixel.mpy lib/neopixel.mpy 

# Copy the board-level test code to the board
ampy --port /dev/ttyUSB0 put test/code.py
ampy --port /dev/ttyUSB0 put test/test_mode.py
