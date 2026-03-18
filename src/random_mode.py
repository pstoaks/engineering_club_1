
# Defines the random_mode
#    The random mode randomly generates colors for each of the LEDs and
#    then fades them. Updates the string every time that the update() 
#    function is called.

import time
import random

UPDATE_PERIOD = 0.075          # 10 times per second (100 msec)
last_time = time.monotonic() # This global variable will keep track of when we last updated.

BLACK = (0, 0, 0)       # Define black for convenience

GRANULARITY = 10        # The granularity we will use. RGB components will be multiples of this value
FADE_CONST = 2          # The amount that we fade each iteration.


def _random_color(granularity):
    """ Private function that returns a random color tuple.

    Args:
        granularity (integer): The RGB components will be in multiples of this value from 0 to < 255.
    """
    return (random.randrange(0, 255, granularity), random.randrange(0, 255, granularity), random.randrange(0, 255, granularity))


def _fade(pixel, fade):
    """Private function that fades a pixel by the given amount

    Args:
        pixel (color tuple): The color to fade.
        fade (integer): The amount to fade each time we're called
    """
    pixel_list = list(pixel)
    for i in range(0, len(pixel_list)):
        pixel_list[i] = pixel_list[i] - fade if (pixel_list[i] - fade) > 0 else 0

    return tuple(pixel_list)


def get_name():
    """ Returns the name of the mode. """
    return "Random Color"


def init(status, leds):
    """
    Initializes the mode.
    Args:
        status (current_status object): The device's current status.
        leds (NeoPixel object): The NeoPixel object that controls the LEDs.
    """
    global last_time

    for i in range(0, len(leds)):
        leds[i] = _random_color(GRANULARITY)

    last_time = time.monotonic()    


loop_counter = 0
time_accumulator = 0.0

def update(status, leds):
    """
    Performs the update function for this mode.
    Args:
        status (current_status object): The device's current status.
        leds (NeoPixel object): The NeoPixel object that controls the LEDs.
    """
    global last_time
    global color_index
    global loop_counter
    global time_accumulator
    
    if ( (time.monotonic() - last_time) > UPDATE_PERIOD ):
        for i in range(0, len(leds)):
            leds[i] = _fade(leds[i], FADE_CONST)
            # If we have faded to black, assign a new random color
            if (leds[i] == BLACK):
                leds[i] = _random_color(GRANULARITY)

        # Show the average update time
        loop_counter += 1
        time_accumulator += (time.monotonic() - last_time)
        if ( (loop_counter % 50) == 0 ):
            print("Average update period: {:.1f} msec".format(time_accumulator/50.0*1000.0))
            loop_counter = 0
            time_accumulator = 0.0

        last_time = time.monotonic()


def reset(status, leds):
    """
    Clears the mode state, ready for the next mode.

    Args:
        status (current_status object): The device's current status.
        leds (NeoPixel object): The NeoPixel object that controls the LEDs.
    """
    leds.fill(BLACK) # Turn all of the LEDs off
