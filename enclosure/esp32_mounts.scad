// Defines parameters of different ESP32 development boards
// and modules to generate mounting for them.

$fn = 80;
in = 25.4;
mm = 1.0;

// PCB "struct" constructor
function esp32_dev_board(
    pcb_thick,                         // PCB thickness
    standoff_pin_dia,                  // Locating pin dia (just a little smaller than the mounting hole dia)
    standoff_hole_dia,                 // Screw pilot hole dia
    standoff_support_height,           // The distance the board should be supported off the base (consider screw length)
    standoff_rect,                     // Array. X and Y distances beteween standoffs
    usb_port_width,                    // The width of the USB port on the PCB (not the opening width)
    usb_x_offset,                      // Offset to the center of the USB port from the center of the mounting hole
    usb_z_offset,                      // Height of connector above the top of the board.
    button_width,                      // Width (X-dimension) of the buttons on the board
    button_offset_x,                   // Center of button from center of standoff (X-dimension). Buttons are assumed to be symmetrical around center.
    button_offset_y,                   // Center of button from center of standoff (Y)
    button_height                     // Allow this for the height of the un-pressed button
) = [
      pcb_thick,
      standoff_pin_dia,
      standoff_hole_dia,
      standoff_support_height,
      standoff_rect,
      usb_port_width,
      usb_x_offset,
      usb_z_offset,
      button_width,
      button_offset_x,
      button_offset_y,
      button_height
];

// Accessors
function pcb_thick(p)                  = p[0];
function pcb_standoff_pin_dia(p)       = p[1];
function pcb_standoff_hole_dia(p)      = p[2];
function pcb_standoff_support_height(p)= p[3];
function pcb_standoff_rect(p)          = p[4];
function pcb_usb_port_width(p)         = p[5];
function pcb_usb_x_offset(p)           = p[6];
function pcb_usb_z_offset(p)           = p[7];
function pcb_button_width(p)           = p[8];
function pcb_button_offset_x(p)        = p[9];
function pcb_button_offset_y(p)        = p[10];
function pcb_button_height(p)          = p[11];
function button_shaft_length(p, wall_thickness) = pcb_standoff_support_height(p) + wall_thickness - pcb_button_height(p);
function pin_x_offset(p, target_box) = (target_box[0]-pcb_standoff_rect(p)[0])/2.0;
function pin_y_offset(p, front_offset, target_box) = (front_offset > 0.0) ? front_offset : (target_box[1]-pcb_standoff_rect(p)[1])/2.0;


// These index constants are indexes into the ESP32_BOARDS
// array, so they must be kept in the same order as the entries there.
ESP32_DEVKITV1_IDX = 0;                 // https://www.amazon.com/dp/B08D5ZD528?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_13&th=1
ESP32_TYPEC_IDX = 1;                    // https://www.amazon.com/dp/B0B18NK2MS?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_1&th=1
ESP32S3_USB_IDX = 2;                    // https://www.amazon.com/dp/B0DG8L7MQ9?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_3&th=1

ESP32_BOARDS= [
   esp32_dev_board( // ESP32_DEVKITV1_IDX
      pcb_thick              = 1.5 * mm,
      standoff_pin_dia       = 2.3 * mm,
      standoff_hole_dia      = 1.5 * mm,
      standoff_support_height= 5.5 * mm,
      standoff_rect          = [23.7 * mm, 46.7 * mm],
      usb_port_width         = 7.45 * mm,
      usb_x_offset           = 23.7 * mm / 2.0,
      usb_z_offset           = 2.32 * mm,
      button_width           = 3.0 * mm,
      button_offset_x        = 4.0 * mm,
      button_offset_y        = 1.36 * mm,
      button_height          = 2.50 * mm
   ),
   esp32_dev_board( // ESP32_TYPEC_IDX
      pcb_thick              = 1.5 * mm,
      standoff_pin_dia       = 2.5 * mm,
      standoff_hole_dia      = 1.5 * mm,
      standoff_support_height= 5.5 * mm,
      standoff_rect          = [23.5 * mm, 47.0 * mm],
      usb_port_width         = 8.9 * mm,
      usb_x_offset           = 11.725 * mm,
      usb_z_offset           = 3.24 * mm,
      button_width           = 3.0 * mm,
      button_offset_x        = 4.5 * mm,
      button_offset_y        = 1.36 * mm,
      button_height          = 2.50 * mm
   )
]; 

module esp32_pcb_mount(dev_board_type, target_box, front_offset, usb_cable_aperture, button_shaft_dia, wall_thickness)
{
   // Creates an enclosure that has the envelope dimensions specified in target_box, has a bottom and a front wall,
   // with standoffs, button guides, ventilation holes, and a rectangular opening for USB cable penetration.
   // dev_board_type: Entry in the ESP32_BOARDS array (not the index, should be ESP32_BOARDS[index].)
   // target_box: (Array[3]) The box that the mount has to fit into. The fit is asserted.
   // front_offset: The distance that the usb-end standoffs should be offset from the inside of the front wall.
   // usb_cable_aperture: (Array[2]) The rectangular opening to allow for insertion of the cable
   // button_shaft_dia: The diameter of the cylinder that button actuators will slide through.
   // wall_thickness: The thickness of the solid front wall and bottom.

   VENTILATION_HOLE_DIA = 3.0 * mm;
   VENTILATION_HOLE_PITCH = VENTILATION_HOLE_DIA + 2.0 * mm;

   translate([0, wall_thickness, 0])
   {   
      // Base with standoffs
      difference()
      {
         echo("Net Button Shaft Length: ", button_shaft_length(dev_board_type, wall_thickness));
         button_hole_dia = button_shaft_dia + 0.75;

         union()
         {
            controller_base(dev_board_type, target_box, front_offset, wall_thickness, 0.0, false);

            // Button slides
            translate([pin_x_offset(dev_board_type, target_box), pin_y_offset(dev_board_type, front_offset, target_box), 0])
            {
               slide_dia = button_hole_dia + wall_thickness;
               translate([pcb_button_offset_x(dev_board_type), pcb_button_offset_y(dev_board_type), 0])
               {
                  cylinder(h=button_shaft_length(dev_board_type, wall_thickness), d=slide_dia);
               }
                     
               translate([pcb_standoff_rect(dev_board_type)[0]-pcb_button_offset_x(dev_board_type), pcb_button_offset_y(dev_board_type), 0])
               {
                  cylinder(h=button_shaft_length(dev_board_type, wall_thickness), d=slide_dia);
               }
            }
         }

         translate([pin_x_offset(dev_board_type, target_box), pin_y_offset(dev_board_type, front_offset, target_box), -0.01])
         {
            // Holes for buttons
            translate([pcb_button_offset_x(dev_board_type), pcb_button_offset_y(dev_board_type), 0])
            {
               cylinder(h=button_shaft_length(dev_board_type, wall_thickness)+2.0, d=button_hole_dia);
            }
                  
            translate([pcb_standoff_rect(dev_board_type)[0]-pcb_button_offset_x(dev_board_type), pcb_button_offset_y(dev_board_type), 0])
            {
               cylinder(h=button_shaft_length(dev_board_type, wall_thickness)+2.0, d=button_hole_dia);
            }

            // Ventilation Holes
            ventilation_x_offset = VENTILATION_HOLE_PITCH/2.0 + button_hole_dia;
            ventilation_y_offset = button_hole_dia*2.0;
            hole_rect = 
            [
               pcb_standoff_rect(dev_board_type)[0] - ventilation_x_offset - pcb_standoff_pin_dia(dev_board_type), 
               pcb_standoff_rect(dev_board_type)[1] - ventilation_y_offset - pcb_standoff_pin_dia(dev_board_type)
            ];
            translate([ventilation_x_offset, ventilation_y_offset, -0.1])
            {
               rectangular_hole_pattern(
                  rect = hole_rect, 
                  hole_dia = VENTILATION_HOLE_DIA, 
                  hole_pitch = VENTILATION_HOLE_PITCH, 
                  hole_depth = 2.0*wall_thickness
               );
            }
         }
      }

      // Front wall
      difference()
      {
         translate([0, -wall_thickness, 0])
         {
            cube([target_box[0], wall_thickness, target_box[2]]);
         }

         // Cutout for USB
         cutout_x_offset = pin_x_offset(dev_board_type, target_box)-usb_cable_aperture[0]/2.0+pcb_usb_x_offset(dev_board_type);
         translate([cutout_x_offset, -wall_thickness/2.0-1.0, pcb_standoff_support_height(dev_board_type)-pcb_usb_z_offset(dev_board_type)])
         {
            cube([usb_cable_aperture[0], wall_thickness*2.0, usb_cable_aperture[1]]);
         }
      }

      // Gussets on sides to provide more strength
      gusset_length = target_box[2] * 0.325;
      translate([wall_thickness, -wall_thickness, 1.0]) rotate([0, 0, 90]) gusset(gusset_length, wall_thickness);
      translate([target_box[0], -wall_thickness, 1.0]) rotate([0, 0, 90]) gusset(gusset_length, wall_thickness);
   }

} // esp32_pcb_mount()

module rectangular_hole_pattern(rect, hole_dia, hole_pitch, hole_depth)
{
   // Fills a rectangle with holes
   // rect: Rectangle to fill with holes. [width_x, length_y]
   // hole_dia: The diameter of the holes to make
   // hole_pitch: The spacing betweeen hole centers
   // hole_depth: The depth to make the holes (in positive Z direction)
   num_columns = floor(rect[0] / hole_pitch);
   num_rows = floor(rect[1] / hole_pitch);

   linear_extrude(hole_depth)
   {
      for(i=[0:num_columns])
         for(j=[0:num_rows])
            translate([i*hole_pitch, j*hole_pitch])
               circle(d = hole_dia);
   }
} // rectangular_hole_pattern()

module cover(target_box, wall_thick = 1.0, with_ventilation = true)
{
   // target_box: Outer dimensions of the box we need to fit into
   // wall_thick: The wall thickness for 3D printing
   // with_ventilation: Set to true if ventilation slots are required.
   difference()
   {
      cube(target_box);

      translate([wall_thick, wall_thick, wall_thick])
      {
         cube([target_box[0] - wall_thick*2, target_box[1] - wall_thick*2, target_box[2]]);
      }

      if (with_ventilation)
      {
         // top_slots
         slots(2.0, 5.0, target_box[0], target_box[1]);

         // Side slots
         rotate([0, -90, 0])
            slots(2.0, 5.0, target_box[2], target_box[1]);
         translate([target_box[0], 0, 0])
         {
            rotate([0, -90, 0])
               slots(2.0, 5.0, target_box[2], target_box[1]);
         }
      }
   }
} // cover()

module controller_base(dev_board_type, target_box, front_offset, wall_thick, inset_depth, sides=false)
{
   INTERFERENCE = 0.2 * mm; // Sets the amount of size difference for proper fit.
   LAYER_THICKNESS = 0.3 * mm; // Sets a nominal thickness to ensure that we don't punch through.

   // Using "cover" module to ensure correct fit with the cover, if used.
   // cover_box are outer dimensions
   cover_box = (sides) ? target_box : [target_box[0], target_box[1], 2.0 * mm];

   cover(cover_box, wall_thick, false);

   // Inset.
   if (inset_depth > 0.0)
   {
      ins_wall = wall_thick + INTERFERENCE;
      translate([ins_wall, ins_wall, target_box[2]])
      {
         difference()
         {
            cube([width-ins_wall*2, length-ins_wall*2, inset_depth]);

            translate([ins_wall, ins_wall, -inset_depth/2])
            {
               cube([width-ins_wall*4, length-ins_wall*4, inset_depth*2]);
            }
         }
      }
   }

   // Support pins
   translate([pin_x_offset(dev_board_type, target_box), pin_y_offset(dev_board_type, front_offset, target_box), LAYER_THICKNESS])
   {
      support_pins(pcb_standoff_pin_dia(dev_board_type), pcb_standoff_hole_dia(dev_board_type), 
         pcb_thick(dev_board_type), pcb_standoff_support_height(dev_board_type)+wall_thick-LAYER_THICKNESS, 
         pcb_standoff_rect(dev_board_type), true);
   }

} // controller_base()

module support_pins(pin_dia, hole_dia, board_thick, support_height, pin_rect, two_pins=false)
{
   // Can make standoffs with locating pins or screw holes. By default, it makes 4 standoffs
   // with screw holes having the specified hole diameter. If two_pins is set to true, it 
   // creates 4 standoffs, two having pins and two having holes.
   // pin_dia is the pin diameter
   // hole_dia is the hole diameter
   // board_thick is the thickness of the PCB
   // support_height is the distance the board should be supported off the base (standoff height)
   // two_pins: Set to true if two of the support pins should have pins; false if all four should be holes
   //    If two_pins is true, then the second pin and the third pin will have pins instead of holes

   standoff_dia = 1.75 * pin_dia; // Simply multiplying the pin diameter by 2 for the standoffs.

   for (x=[0:1])
   {
      for (y=[0:1])
      {
         pin = ((x==0) && (y==1) || (x==1) && (y==0));
         translate([x*pin_rect[0], y*pin_rect[1], 0.0])
         {
            if (pin)
               standoff_with_pin(pin_dia, standoff_dia, board_thick*2.0, support_height);
            else
               standoff_with_hole(hole_dia, standoff_dia, board_thick*2.0, support_height);
         }
      }
   }
} // support_pins()

module standoff_with_pin(pin_dia, standoff_dia, pin_height, support_height)
{
   // Creates a standoff with a locating pin. 
   // pin_dia is the pin diameter
   // standoff_dia is the diameter of the standoff (provides the shoulder)
   // pin_height is the length of the protrusion of the pin above the standoff
   // support_height is the height at which the board should be supported (the length of the standoff)

   // Standoff
   translate([0, 0, support_height/2.0])
   {
      cylinder(h = support_height, d = standoff_dia, center = true);
   }

   // Pin
   translate([0, 0, support_height+pin_height/2.0-1.0])
   {
      cylinder(h = pin_height+1.0, d = pin_dia, center = true);
   }

} // standoff_with_pin()

module standoff_with_hole(hole_dia, standoff_dia, hole_depth, support_height)
{
   // Creates a standoff with a screw hole. 
   // hole_dia is the hole diameter
   // standoff_dia is the diameter of the standoff (provides the shoulder)
   // hole_depth is the depth of the hole
   // support_height is the height at which the board should be supported (the length of the standoff)

   difference()
   {
      // Standoff
      translate([0, 0, support_height/2.0])
      {
         cylinder(h = support_height, d = standoff_dia, center = true);
      }

      // Make a hole
      translate([0, 0, support_height-hole_depth/2.0]) // hole is centered around the Z-axis too
      {
         cylinder(h = hole_depth+0.1, d = hole_dia, center = true);
      }
   }
} // standoff_with_hole()

module slot(width, length)
{
   DEPTH = 5.0 * mm;

   translate([width/2.0, -width/2.0, 0])
      cube([length-width, width, DEPTH]);
   translate([width/2.0, 0, 0])
      cylinder(h=DEPTH, d=width);
   translate([length-width/2.0, 0, 0])
      cylinder(h=DEPTH, d=width);
} // slot()

module slots(slot_width, slot_spacing, panel_width, panel_length)
{
   // Laid out in the Y direction
   // Slots in a surface
   slot_length = 0.75*panel_width;
   translate([(panel_width-slot_length)/2.0, (slot_width+slot_spacing)/2.0, -2.5])
   {
      for (y = [0:(panel_length-(slot_width+slot_spacing))/(slot_width+slot_spacing)])
         translate([0, y*(slot_width+slot_spacing), 0])
            slot(slot_width, slot_length);
   }
} // slots()

module gusset(length, wall_thickness)
{
   // Creates a triangular gusset (right triangle)
   // length is the length of the gusset
   // wall_thickness is the thickness of the wall
   difference()
   {
      cube([length, wall_thickness, length]);

      translate([length, wall_thickness+0.2, length]) rotate([90, 0, 0])
      {
         cylinder(h=2.0*wall_thickness, r=length*0.9);
      }
      
   }
} // gusset()

///////////////////////////////////////////////////////////////
// The following is an old module from a previous project.
// It demonstrates how build an entire enclosure with ventilation.
///////////////////////////////////////////////////////////////
module controller_box(width, length, depth, board_thick, board_hole_dia, pin_rect_width, pin_rect_length, support_height, wall_thick = 1.0)
{
   LID_HEIGHT = 4.0;
   PC_HEIGHT = LID_HEIGHT + 11.0 + 0.5; // 11 mm is the power connector height
   BOARD_OFFSET_FROM_FRONT = 4.0; // Set to 0 if board should be centered lengthwise
   
   if (0)
   {
      difference()
      {
         lower_box(width, length, depth);

         // USB Connector cutout
         translate([20, -2, depth - (LID_HEIGHT+3)])
               cube([8, 10, 10]);
      }
   }

   // Lid
   translate([width + 5.0, 0, 0])
   {
      controller_base(width, length, LID_HEIGHT);
   }
} // controller_box()

