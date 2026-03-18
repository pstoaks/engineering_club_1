
# Defines the temp_mode
# The temp mode reads the temperature and humidity and updates the LED string
# to display them.
#    
# Updates once per second
# 
# The specification for this mode is:
#   Display humidity as low, medium, and high on top three LEDs.
#      Color of LED reflects location in range?
#   Display temperature on 7 LEDs from 30 to 100 degrees F. 
#      One LED per 10 deg.
#      Use spectrum (blue to red with rising temperature)

import time
import math

UPDATE_PERIOD = 1.0             # Update occurs every second
TEMP_TRIM = 0.0                 # Amount to trim temperature for greater accuracy
last_time = time.monotonic()    # This global variable will keep track of when we last updated.

# Define the colors we're going to use. These are 7 equally spaced values in the
# spectrum.
COLOR_LIST = [
    (40, 0, 40),      # Violet
    (45, 0, 190),     # Indigo
    (0, 0, 255),      # Blue
    (0, 200, 0),      # Green
    (200, 200, 0),    # Yellow
    (200, 120, 0),    # Orange
    (200, 0, 0)       # Red
]

WHITE = (255, 255, 255) # Define white, for convenience
BLACK = (0, 0, 0)     # Define black, for convenience

def _update_temp_leds(leds, temp):
    """
    Private function that updates the temperature LEDs.
    The temperature display LEDs are numbers 0 through 6.

    Args:
        leds (NeoPixel object): _description_
        temp (float): _description_
    """
    FIRST_TEMP_LED = 0
    LAST_TEMP_LED = 6

    last_led_number = round((temp - 30.0) / 10.0)  # Divide the temperature range into 7 parts
    if ( last_led_number < FIRST_TEMP_LED ):
        last_led_number = FIRST_TEMP_LED
    if ( last_led_number > LAST_TEMP_LED ):
        last_led_number = LAST_TEMP_LED
    # Light the LEDs that should be lit
    for led in range(FIRST_TEMP_LED, last_led_number+1): # Ensure that the range limit is included
        leds[led] = COLOR_LIST[led]
    # Clear the LEDS that should not be lit (the remaining LEDs)
    for led in range(int(last_led_number+1), LAST_TEMP_LED+1):
        leds[led] = BLACK


def _update_humid_leds(leds, humid):
    """
    Private function that updates the humidity LEDs.
    The humidity LEDs are numbers 7 through 9.

    Args:
        leds (NeoPixel object): _description_
        humid (float): _description_
    """
    FIRST_LED_OFFSET = 7
    FIRST_HUMID_LED = 0  # The first LED will actually be LED #7
    LAST_HUMID_LED = 2

    last_led_number = int(humid // 33);  # Divide the humidity range into 3 parts
    if ( last_led_number < FIRST_HUMID_LED ):
        last_led_number = FIRST_HUMID_LED
    if ( last_led_number > LAST_HUMID_LED ):
        last_led_number = LAST_HUMID_LED
    color_index = math.trunc((humid - (last_led_number * 33)) / 4.71) # Divide the remainder by 7 parts
    last_led_number = FIRST_LED_OFFSET + last_led_number
    # Light the LEDs that should be lit
    for led in range(FIRST_LED_OFFSET+FIRST_HUMID_LED, last_led_number): # One short of the last LED, because we want to write it specially
        leds[led] = WHITE
    leds[last_led_number] = COLOR_LIST[color_index]
    # Clear the LEDS that should not be lit (the remaining LEDs)
    for led in range(last_led_number+1, FIRST_LED_OFFSET+LAST_HUMID_LED+1): # Ensure that the range limit is included
        leds[led] = BLACK    


def get_name():
    """ Returns the name of the mode. """
    return "Display Temp/Humid"


def init(status, leds):
    """
    Initializes the mode. Must be called before the first call to update()
    Args:
        status (current_status object): The device's current status.
        leds (NeoPixel object): The NeoPixel object that controls the LEDs.
    """
    global last_time

    leds.fill(BLACK)
    last_time = time.monotonic()


def update(status, leds):
    """
    Performs the update function for this mode. Reads the temperature and humidity
    sensor and updates the display accordingly.
    Args:
        status (current_status object): The device's current status.
        leds (NeoPixel object): The NeoPixel object that controls the LEDs.
    """
    global last_time
    
    if ( (time.monotonic() - last_time) > UPDATE_PERIOD ):
        try:
            temp = status["temperature"]
            humid = status["humidity"]
            _update_temp_leds(leds, temp)
            _update_humid_leds(leds, humid)
        except RuntimeError as error:
            print(error.args[0])

        last_time = time.monotonic()


def reset(status, leds):
    """
    Clears the mode state. Should be called as the mode is exited to
    get things ready for the next mode's initialization.

    Args:
        status (current_status object): The device's current status.
        leds (NeoPixel object): The NeoPixel object that controls the LEDs.
    """
    leds.fill(BLACK) # Turn all of the LEDs off
