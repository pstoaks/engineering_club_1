# This is the main loop definition for the Intro to Engineering device code.
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
import neopixel
import adafruit_dht as dht_lib
import keypad
import test_mode        # Default test mode
import temp_mode        # Display temperature and humidity
import random_mode      # Random colors mode

# The Neopixel library provides the control interface for WS2812 addressable LEDs
# Neopixel library page: https://learn.adafruit.com/circuitpython-essentials/circuitpython-neopixel
# Neopixel library documentation: https://docs.circuitpython.org/projects/neopixel/en/latest/

# DHT library documentation page: https://docs.circuitpython.org/projects/dht/en/latest/
# AM2302/DHT22 datasheet: https://cdn-shop.adafruit.com/datasheets/Digital+humidity+and+temperature+sensor+AM2302.pdf
# Second source for datasheet: https://cdn.sparkfun.com/assets/f/7/d/9/c/DHT22.pdf

# To find out what the pin names are for the board, use dir(board)

# Running the script described in Download Project Bundle on this page will help identify aliases:
# https://learn.adafruit.com/circuitpython-essentials/circuitpython-pins-and-modules

# Define some time constants for use later.
SLEEP_TIME_BETWEEN_LOOPS = 0.03         # (sec) Defines the sleep time between loop iterations.
OB_LED_UPDATE_PERIOD = 1.0              # (sec) Defines the time between onboard LED updates
DHT_READ_PERIOD = 10.0                  # (sec) Defines the time between DHT reads

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
dht = dht_lib.DHT11(DHT_PIN)

# Define the buttons object for handling button input
buttons = keypad.Keys((BUTTON_PIN,), value_when_pressed=False, pull=True)

# Define the list of supported modes
MODE_LIST = [
    temp_mode, 		# The temperature & humidity display mode
    random_mode,	# The random colors mode
    test_mode		# The default test mode
]

# A few miscellaneous global variables
ob_LED_last_time = time.monotonic()     # The last time the onboard LED was updated
dht_read_last_time = time.monotonic()   # The last time the DHT sensor was updated

# Current status. This data structure contains the current status of the device,
# all in one place for convenience. It is updated by various functions as information
# changes.
current_status = {
    "mode": 0,				# The current device mode (number)
    "mode_name": "",		# The name of the current mode. Filled in when status is retrieved.
    "temperature": 0.0,		# The current temperature (deg. Fahrenheit). Filled in on update.
    "humidity": 0.0,		# The current humidity (%). Filled in on update.
    "max_temp": 0.0,		# The maximum temperature detected. Filled in on update.
    "min_temp": 10000.0,	# The minimum temperature detected. Filled in on update.
    "max_humidity": 0.0,	# The maximum humidity detected. Filled in on update.
    "min_humidity": 100.0, 	# The minimum humidity detected. Filled in on update.
    "modes": {},			# The list of modes
}
current_status["modes"] = [mode_obj.get_name() for mode_obj in MODE_LIST]


# Define utility functions update and get the device status.

def _set_mode(new_mode):
    """ Private function to set the current mode to the mode passed in.
        Args:
            new_mode (integer): The mode number to change to.
    """
    global current_status
    global MODE_LIST
    current_mode = current_status["mode"]
    
    if 0 <= new_mode < len(MODE_LIST):
        print(f"Leaving mode: {current_mode}")
        MODE_LIST[current_mode].reset(current_status, leds) # Leaving the old mode
        current_status["mode"] = new_mode
        current_status["mode_name"] = MODE_LIST[new_mode].get_name()
        print(f"Entering mode: {new_mode}")
        MODE_LIST[new_mode].init(current_status, leds)  # Entering the new mode
        return True
    
    return False


def _get_status():
    """ Private function to return the current environmental monitor status.
        Args: none.
    """
    global current_status
    
    return current_status


# The Super Loop. Runs forever.
while True:

    # Update the state of the onboard LED
    if ( (time.monotonic() - ob_LED_last_time) > OB_LED_UPDATE_PERIOD ):
        onboard_led.value = not onboard_led.value # Toggle LED state
        ob_LED_last_time = time.monotonic()

    # Check to see if there has been a button event
    event = buttons.events.get()
    if event:
        if event.pressed:
            # Increment the mode
            old_mode = current_status["mode"]
            _set_mode( (old_mode + 1) % len(MODE_LIST) )

    # Read the DHT11
    if (time.monotonic() - dht_read_last_time) > DHT_READ_PERIOD:
        try:
            temp = ( dht.temperature * (9/5) ) + 32 # Converted to Fahrenheit
            humid = dht.humidity
            print("Temp: {:.1f}F Humidity: {}% ".format(temp, humid))
            current_status["temperature"] = temp
            current_status["humidity"] = humid
            # Update min and max temps, if appropriate
            if temp > current_status["max_temp"]:
                current_status["max_temp"] = temp
            elif temp < current_status["min_temp"]: 
                current_status["min_temp"] = temp 
            if humid > current_status["max_humidity"]:
                current_status["max_humidity"] = humid 
            elif humid < current_status["min_humidity"]:
                current_status["min_humidity"] = humid 
        except RuntimeError as error:
            print(error.args[0])

        dht_read_last_time = time.monotonic()

    # Tell the mode to update
    MODE_LIST[current_status["mode"]].update(current_status, leds)
    
    # Sleep for just a bit so that we aren't in a tight loop and hogging the processor.
    time.sleep(SLEEP_TIME_BETWEEN_LOOPS)
    

