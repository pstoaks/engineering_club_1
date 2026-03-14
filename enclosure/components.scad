use <rounded_cube.scad>
include <esp32_mounts.scad>

$fn = 80;
in = 25.4;
mm = 1.0;

// General 3D printing parameters
LAYER_THICKNESS = 0.28 * mm;
NOZZLE_DIA = 0.6 * mm;
WALL_THICKNESS = 2.0 * NOZZLE_DIA;     // 2 * nozzle width or roughly 4 * layer depth

BOX_WIDTH = 30 * mm;
BOX_LEN   = 53 * mm;
BOX_DEPTH = 27.5 * mm;                 // Deep enough to accommodate bend radius of dupont wires.
TARGET_BOX = [BOX_WIDTH, BOX_LEN, BOX_DEPTH];

DEV_BOARD_TYPE_IDX = ESP32_TYPEC_IDX;  // The ESP32 dev board type we're generating for. See esp32_mounts.scad library.
// I have set this to the distance from the front edge of the PCB to the center of the
// screw hole.
BOARD_OFFSET_FROM_FRONT = 3.0;         // The offset of the board edge along the Y-axis. Set to 0 to center board.
BUTTON_SHAFT_DIA = 4.0 * mm;           // The diameter of the button actuator shaft.

// DHT11 Breakout Board Dimensions
DHT11_LEN = 38.0 * mm;                 // Length of the board with dupont connectors attached (bent up)
DHT11_WIDTH = 15.0 * mm;               // Width of the board with small keepout
DHT11_DEPTH = 18.0 * mm;               // Depth with connectors attached (bent up to shorten).
DHT11_PCB_THICK = 1.5 * mm;            // The thickness of the PCB
DHT11_STANDOFF_LENGTH = 4.0 * mm;      // The length of the standoff (support height)
MOUNT_HOLE_X = DHT11_WIDTH/2.0;        // Offset of mounting hole from long edge
MOUNT_HOLE_Y = 23.0 * mm;              // Offset of mounting hole from sensor end

// LED Strip dimensions and dimensions for enclosure
NUM_LEDS = 10;                         // The number of LEDs in the strip
LED_PITCH = 16.5 * mm;                 // Pitch between LEDs
LED_STRIP_LENGTH = (NUM_LEDS) * LED_PITCH;         // Length of the LED strip
LED_STRIP_WIDTH = 10.0 * mm;           // Actually 9.5, but cavity should be this width.
LED_STRIP_DEPTH = 2.2 * mm;             // The maximum depth of the LED strip
FIRST_LED_OFFSET = 8.6 * mm;           // Distance to first LED from base of the strip
LED_ENCL_EXTENSION = 7.0 * mm;   // Enclosure extension down
LED_ENCL_LENGTH = LED_STRIP_LENGTH + LED_ENCL_EXTENSION;
LED_ENCL_FIRST_LED_OFFSET = LED_ENCL_EXTENSION + FIRST_LED_OFFSET;
NUMBER_FONT = "Arial:style=Bold";      // Check Help -> Font List for more
TEXT_DEPTH = 4*LAYER_THICKNESS;        // The text depth (engraved)

// Some useful functions
function dht11_envelope() = [DHT11_WIDTH, DHT11_LEN, DHT11_DEPTH+DHT11_STANDOFF_LENGTH];

if (0) // Render all of the objects defined here
{
   dht11_base();
   translate([dht11_envelope()[0]+10, 0, 0])
   {
      esp32_pcb_mount(dev_board_type=ESP32_BOARDS[DEV_BOARD_TYPE_IDX], 
         target_box=TARGET_BOX, 
         front_offset=BOARD_OFFSET_FROM_FRONT, 
         usb_cable_aperture=[11.0*mm, 6.8 * mm], 
         BUTTON_SHAFT_DIA, 
         WALL_THICKNESS);
      translate([TARGET_BOX[0]+10, 0, 0])
      {
         LED_Strip_Encl(false);
         translate([25, 0, 0])
            button(ESP32_BOARDS[DEV_BOARD_TYPE_IDX], BUTTON_SHAFT_DIA);
      }
   }
}

if (0)
{
   esp32_pcb_mount(dev_board_type=ESP32_BOARDS[DEV_BOARD_TYPE_IDX], 
      target_box=TARGET_BOX, 
      front_offset=BOARD_OFFSET_FROM_FRONT, 
      usb_cable_aperture=[11.0*mm, 6.8 * mm], 
      BUTTON_SHAFT_DIA, 
      WALL_THICKNESS);
}

if (1) // This is the LED strip enclosure itself, with lettering.
   rotate([90, 0, 90])
   {
      LED_Strip_Encl(false);
   }
   

if (0) // This creates a shape that is useful for creating a cutout that the LED strip enclosure fits into.
   scale([1.05, 1.05, 1.0])
      LED_Strip_Encl(true);

if (0)
   button(ESP32_BOARDS[DEV_BOARD_TYPE_IDX], BUTTON_SHAFT_DIA);

module button(dev_board_type, button_shaft_dia)
{
   BUTTON_HEAD_DIA = button_shaft_dia * 1.8;
   BUTTON_HEAD_HEIGHT = 2.0 * mm;
   BUTTON_EXTENSION = 1.5 * mm;

   union()
   {
      // Head, on the bottom
      cylinder(h=BUTTON_HEAD_HEIGHT, d=BUTTON_HEAD_DIA);
      // shaft, above
      translate([0, 0, BUTTON_HEAD_HEIGHT])
         cylinder(h=button_shaft_length(dev_board_type, WALL_THICKNESS)+BUTTON_EXTENSION, d=button_shaft_dia);
   }

} // button()

module LED_Strip_Encl(cutout = false)
{
   // Consider thicker, with offset to allow for inset lettering on the front.
   INTERNAL_MARGIN = 0.8 * mm; // Internal margin to ensure that strip will slip in.
   external_width = LED_STRIP_WIDTH + 2*WALL_THICKNESS + 2*INTERNAL_MARGIN;
   external_depth = LED_STRIP_DEPTH + 3*WALL_THICKNESS + 2*INTERNAL_MARGIN;
   edge_radius = external_width * 0.2;
   internal_width = LED_STRIP_WIDTH + 2*INTERNAL_MARGIN;
   internal_depth = LED_STRIP_DEPTH + 2*INTERNAL_MARGIN;

   difference()
   {
      roundedcube([external_width, external_depth, LED_ENCL_LENGTH+WALL_THICKNESS*2.0], false, edge_radius, "zmax");
      // Insertion depth marker
      translate([external_width/2.0, -0.1, LED_ENCL_EXTENSION])
      {
         cube([internal_width, 0.6, 0.5], true);
      } 

      if (!cutout)
      {
         // cavity
         translate([WALL_THICKNESS, 2*WALL_THICKNESS, -0.1])
         {
            cube([internal_width, internal_depth, LED_ENCL_LENGTH]);
         }

         // Lettering
         translate([external_width/2.0, TEXT_DEPTH-0.1, LED_ENCL_FIRST_LED_OFFSET])
         {
            TEMP_TEXT_SIZE = 5;

            // Temperature numbers
            for (temp = [30:10:90]) // Generate temperature numbers from 30 deg to 90 deg in steps of 10
            {
               z = (floor((temp-30)/10))*LED_PITCH;
               // echo("Temp: ", temp, " Z: ", z);
               translate([0, 0, z]) rotate([90, 0, 0])
               {
                  centered_string(str(temp), NUMBER_FONT, TEMP_TEXT_SIZE, TEXT_DEPTH);
               }
            }

            // Humidity Text
            HUMID_TEXT = ["L", "M", "H"];
            HUMID_TEXT_SIZE = 5;
            for (humid = [0:2]) // Generate humidity indices
            {
               zh = (humid+7)*LED_PITCH;
               translate([0, 0, zh]) rotate([90, 0, 0])
               {
                  centered_string(HUMID_TEXT[humid], NUMBER_FONT, HUMID_TEXT_SIZE, TEXT_DEPTH);
               }
            }
         }
      }
   }

} // LED_Strip_Encl()

module centered_string(text, font, size, height)
{
   // The text will be centered horizontally and vertically
   // text: The text to create
   // font: The font specification
   // size: The size of the text (XY-plane)
   // height: The 3D height of hte text (z-axis)
   linear_extrude(height)
   {
      text(text, size = size, font = font, halign = "center", valign = "center", $fn = 64);
   }

}  // centered_string()

module dht11_base()
{
   SCREW_HOLE_DIA = 1.5 * mm;
   STANDOFF_DIA = 5.0 * mm;
   STANDOFF_HOLE_DIA = 1.5 * mm;

   // Using "cover" module to ensure correct fit with the cover, if used.
   // width, length, and depth are outer dimensions
   cover([DHT11_WIDTH, DHT11_LEN, 2.0], WALL_THICKNESS, false);

   // Standoff
   translate([MOUNT_HOLE_X, MOUNT_HOLE_Y, 0])
   {
      standoff_with_hole(STANDOFF_HOLE_DIA, STANDOFF_DIA, DHT11_STANDOFF_LENGTH, DHT11_STANDOFF_LENGTH);
   }
   
} // dht11_base()
