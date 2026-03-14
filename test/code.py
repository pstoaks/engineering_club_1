# This test program provides minimum capability to test the circuitry.
# This will be used to production-test the kits and will still be loaded on the 
# microcontrollers when the students receive the kit. It will demonstrate that the
# student has properly wired the circuit.
#
# Test criteria:
#    * Temperature readings (printed to terminal) are within (+/- 10 deg F) of reference.
#    * Humidity readings (printed to terminal) are within (+/- 10%) of reference.
#    * Onboard LED flashes at about 0.5 Hz.
#    * All LEDs in the strip, and all LEDs in each pixel, light when appropriate.
#    * Button presses are registered (see messages printed to REPL)

#
# The following libraries must be installed on the board from the CircuitPython bundle file
# https://github.com/adafruit/Adafruit_CircuitPython_Bundle
# adafruit_dht.mpy
# adafruit_ds18x20.mpy
# adafruit_pixelbuf.mpy
# neopixel.mpy

import time
import board
import digitalio as dio
import keypad
import neopixel
import adafruit_dht as dht
import test_mode        # Default test mode

# The Neopixel library provides the control interface for WS2812 addressable LEDs
# Neopixel library page: https://learn.adafruit.com/circuitpython-essentials/circuitpython-neopixel
# Neopixel library documentation: https://docs.circuitpython.org/projects/neopixel/en/latest/

# DHT library documentation page: https://docs.circuitpython.org/projects/dht/en/latest/
# AM2302/DHT22 datasheet: https://cdn-shop.adafruit.com/datasheets/Digital+humidity+and+temperature+sensor+AM2302.pdf
# Second source for datasheet: https://cdn.sparkfun.com/assets/f/7/d/9/c/DHT22.pdf

# Define some color constants
RED = (255, 0, 0, 0)
YELLOW = (255, 150, 0, 0)
GREEN = (0, 255, 0, 0)
CYAN = (0, 255, 255, 0)
BLUE = (0, 0, 255, 0)
PURPLE = (180, 0, 255, 0)
BLACK = (0, 0, 0, 0)
WHITE = (255, 255, 255)

# Define the device pins that will be used
OB_LED_PIN = board.IO2      # Onboard blue LED pin for this board
NEO_PIN = board.IO13        # WS2812B LED string data pin
DHT_PIN = board.IO18        # DHT11 sensor data pin
BUTTON_PIN = board.IO0      # Mode button pin (using BOOT button on the board)

# Setup the onboard LED as an output. We'll blink this LED.
onboard_led = dio.DigitalInOut(OB_LED_PIN)
onboard_led.direction = dio.Direction.OUTPUT
onboard_led.value = False   # Set the initial state of the onboard LED

# Define the object that will represent our LED string
NUM_LEDS = 10               # The number of LEDs in our string
INITIAL_BRIGHTNESS = 0.1    # The initial brightness of the LED string
leds = neopixel.NeoPixel(NEO_PIN, NUM_LEDS)
leds.brightness = INITIAL_BRIGHTNESS


# Define the temperature sensor object. Use DHT22 for a DHT22.
dht = dht.DHT11(DHT_PIN)

# Define the buttons object for handling button input
buttons = keypad.Keys((BUTTON_PIN,), value_when_pressed=False, pull=True)

# Define the mode variable
mode = 0        # Mode is advanced with each button press. Ranges from 0 to mode_count-1.

# Define the list of supported modes
MODE_LIST = [
    test_mode      # The default test mode
]

# A few miscellaneous global variables
ob_LED_last_time = time.monotonic()     # The last time the onboard LED was updated
dht_read_last_time = time.monotonic()   # The last time the DHT sensor was updated

SLEEP_TIME_BETWEEN_LOOPS = 0.03         # Defines the sleep time between loop iterations.
OB_LED_UPDATE_PERIOD = 1.0              # Defines the time between onboard LED updates
DHT_READ_PERIOD = 2.0                   # Defines the time between DHT reads

while True:

    # Update the state of the onboard LED
    if ( (time.monotonic() - ob_LED_last_time) > OB_LED_UPDATE_PERIOD ):
        onboard_led.value = not onboard_led.value # Toggle LED state
        ob_LED_last_time = time.monotonic()

    # Check to see if there has been a button event
    event = buttons.events.get()
    if event:
        if event.pressed:
            print("Button Pressed!")

    # Tell the mode to update
    MODE_LIST[mode].update(dht, leds)

    # Read the DHT11
    if ( (time.monotonic() - dht_read_last_time) > DHT_READ_PERIOD ):
        try:
            temp = ( dht.temperature * (9/5) ) + 32 # Converted to Fahrenheit
            humid = dht.humidity
            print("Temp: {:.1f}F Humidity: {}% ".format(temp, humid))
        except RuntimeError as error:
            print(error.args[0])

        dht_read_last_time = time.monotonic()

    # Sleep for just a bit so that we aren't in a tight loop and hogging the processor.
    time.sleep(SLEEP_TIME_BETWEEN_LOOPS)
    

