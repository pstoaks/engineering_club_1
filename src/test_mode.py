
# Defines the test_mode
#    The test mode simply lights all LEDs in the LED strip with each of the three
#    colors that the WS2812 LED contains.
#    Transitions at once per second

import time

UPDATE_PERIOD = 1.0             # Update occurs every second
last_time = time.monotonic()    # This global variable will keep track of when we last updated.
color_index = 0                 # This global variable keeps track of the color in the color array

# defines the colors we're going to cycle through
COLOR_LIST = [
    (255, 0, 0),        # Red
    (0, 255, 0),        # Green
    (0, 0, 255),        # Blue
    (255, 255, 255)     # White -- All LEDs on full
]

BLACK = (0, 0, 0)       # Define black for convenience

def get_name():
    """ Returns the name of the mode. """
    return "System Test"


def init(status, leds):
    """
    Initializes the mode.
    Args:
        status (current_status object): The device's current status.
        leds (NeoPixel object): The NeoPixel object that controls the LEDs.
    """
    global last_time
    global color_index

    color_index = 0
    leds.fill(COLOR_LIST[color_index])
    last_time = time.monotonic()    


def update(status, leds):
    """
    Performs the update function for this mode.
    Args:
        status (current_status object): The device's current status.
        leds (NeoPixel object): The NeoPixel object that controls the LEDs.
    """
    global last_time
    global color_index
    
    if ( (time.monotonic() - last_time) > UPDATE_PERIOD ):
        color_index = (color_index + 1) % len(COLOR_LIST)
        leds.fill(COLOR_LIST[color_index])

        last_time = time.monotonic()


def reset(status, leds):
    """
    Clears the mode state, ready for the next mode.
    Args:
        status (current_status object): The device's current status.
        leds (NeoPixel object): The NeoPixel object that controls the LEDs.
    """
    leds.fill(BLACK) # Turn all of the LEDs off
