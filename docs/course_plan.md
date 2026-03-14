# Introduction to Engineering Course Plan

## 5-Week Course for Ages 12-18

### Course Overview

This course introduces students to the engineering process and disciplines (mechanical, electrical, and software) through hands-on learning. Students will build a complete IoT environmental monitor that senses temperature/humidity and displays the data using colorful LED patterns in a 3D-printed enclosure. OpenSCAD, STL and Tinkercad building blocks are provided to help with the more difficult 3D design bits.

- Week 1: Introduction to Engineering and Requirements Analysis
- Week 2: Mechanical Engineering
- Week 3: Electrical/Electronics Engineering
- Week 4: Software Development
- Week 5: Putting it all together: integration

### Learning Objectives

- Understand what engineers do in electrical, mechanical, and software disciplines
- Experience the engineering design process from requirements to final product
- Gain hands-on experience with circuits, programming, and 3D design
- Develop problem-solving and troubleshooting skills
- Make informed decisions about pursuing engineering education and careers

### Final Project

**IoT Environmental Monitor**

- ESP32 microcontroller development board
- Temperature/humidity sensor (DHT11)
- Addressable LED strip (WS2812B, 10 LEDs)
- Multiple display modes with plug-in architecture for students to design their own
- Optional web server with web application to monitor temperature and humidity and to control the mode.
- Custom, student-designed, 3D-printed enclosure
- USB power

### Purchased parts used in this course:
* ESP32 Microcontroller Development Board: https://www.amazon.com/DORHEA-Development-Bluetooth-ESP-WROOM-32-ESP32-DevKitC-32/dp/B0B18NK2MS/ref=sims_dp_d_dex_ai_rank_model_1_d_v1_d_sccl_2_3/146-9491196-6849001?pd_rd_w=fpkVx&content-id=amzn1.sym.bb4a0aac-c2b4-4b4b-a0c8-9aa89b28dce3&pf_rd_p=bb4a0aac-c2b4-4b4b-a0c8-9aa89b28dce3&pf_rd_r=46MY5HP3BMB7036C1MFB&pd_rd_wg=FuUJy&pd_rd_r=a62e4606-3e53-4602-be0b-5d40a18b7b4e&pd_rd_i=B0B18MCYFH&th=1
* DHT11 Temperature & Humidity Sensor: https://www.amazon.com/dp/B0DTKB16MD?ref_=ppx_hzsearch_conn_dt_b_fed_asin_title_1
* WS2812B LED strip, 10 LEDs, 16.5 mm pitch.

A description of the development board being used can be found here:
https://lastminuteengineers.com/esp32-pinout-reference/

### Software Used:
  - Thonny for software development (https://thonny.org/)
  - Tinkercad for 3D modeling and design (https://www.tinkercad.com/)
  - On computers using a Microsoft Windows operating system, the CH340C driver may be required to communicate with the development board.
    - Plug the development board into the computer with a USB-C cable that supports data transfer.
    - Use Windows Device Manager to verify that a COM port has appeared, or attempt to connec to the board with Thonny.
    - If no COM port appears, or device manager states that the driver is not loaded, a driver will have to be installed.
    - The CH34XX driver can be downloaded from the manufacturer at: https://www.wch-ic.com/downloads/CH341SER_ZIP.html
    - This YouTube video describes how to install it: https://youtu.be/UUQ84VKg3oM?si=FLEs7Xpsqvz_CDct

---

## Week 1: Introduction & Requirements Analysis

### Topics

- Class overview: What are we going to be doing? (Syllabus)
- What is engineering? Problem-solving and design.
- Overview of electrical, mechanical, and software engineering disciplines
- Introduction to the engineering design process
- Requirements analysis and specification

### Activities

**Introduction (15 minutes)**

- Instructor introduction: Short (5 min) overview of education and experience.
- Class overview using the syllabus.
- Introductions around the room. What's your handle?
- What is engineering? Discussion of engineering as creative problem-solving. Requirements -> Design -> Implement -> Test.
  * Draw a diagram showing how the design progresses through the process and how the engineer incorporates science
    and technology to create the design.
  * Test what you fly, fly what you test. What do you think this means?
- Show completed IoT environmental monitor example
- Explain how all three disciplines work together to create this device

**Requirements Analysis (20 minutes)**

- Introduce the concept: "Before building anything, engineers must understand what they're building and why"
- Guided exercise: Define requirements for our device. One or more huddles to discuss these.
  - **The Need**: We need a product that is attractive and suitable for inclusion in a child's room that is capable of displaying temperature and humidity visually (at a glance) and via WiFI.
  - **Functional requirements**: What must it do?
    - Measure temperature
    - Measure humidity
    - Display data visually (with LEDs)
    - Pushbutton for user interaction (mode selection)
    - Be powered by USB
    - Update readings regularly
    - Labeling, overlay, etc.
  - **Non-functional (performance) requirements**: How well must it work?
    - Accuracy
    - Response time
    - Durability (thermal, vibration, shock, electrical immunity)
    - Size & weight constraints
    - Electromagnetic susceptibility
    - User-friendliness
    - Aesthetics
  - **Constraints**: What limits us?
    - Manufacturability
    - Regulations (safety, electromagnetic emissions, DO-178 for software, medical)
    - Budget (affects component selection, team size, manufacturing options, etc.) One-time costs vs. per-unit costs.
    - Time (5 weeks)
    - Skill level
    - Available components

**Component Exploration (20 minutes)**

- Unbox and examine components
**STATIC ELECTRICITY KILLS ELECTRONICS**
**Be Gentle, please!**
   * ESP32: The "brain" (software engineering)
   * DHT11 sensor: The "senses" (electrical engineering)
   * LED strip: The "display" (electrical engineering)
   * Enclosure: The "body" (mechanical engineering)
   * Software: Invisible stuff inside. Infinitely malleable.
   * Identify how each component addresses our requirements

**Discipline Breakdown (5 minutes)**

- Map each requirement to the engineering discipline that addresses it
- Preview what we'll learn each week (mechanical, electrical, software)

### Materials Needed

- Completed example device
- Component kits for each student (don't open yet)
- Whiteboard/screen for requirements discussion
- Any slides? Or are we better off drawing the diagrams as needed in order
  to keep it more interactive?
- Extra of everything (dev boards, dupont wires, DHT11s, etc.)

### Homework/Preparation

- Think about: What questions do you have about the project?
- Think about: What do you want your device to look like? (The shape of the base and any decoration.)
- Optional: Research what ESP32 boards are used for in real products
- Optional: Lookup Python and CircuitPython on the web
- Optional: Play with Tinkercad at home.

------

## Week 2: Mechanical Engineering - Giving It a Body: Design & Protection

### Topics

- What mechanical engineers do
- Purpose of enclosures: protection, aesthetics, usability
- Introduction to 3D design and CAD software
- Design constraints and considerations
- Iteration in design

### Activities

**Introduction (10 minutes)**

- What do mechanical engineers do? Design physical systems, structures, machines
- Why does our device need an enclosure?
  - Protect electronics
  - Make it safer (cover exposed connections)
  - Look professional, cool, and/or attractive
  - Easier to use/mount
- Show examples of enclosure designs
- Discuss design constraints: must fit components, allow sensor airflow, show LEDs, access USB port, button,
  thermal considerations (such as exposing the sensor to heat dissipated by the MCU)

**Tinkercad Tutorial (20 minutes)**

- Quick introduction to Tinkercad interface (browser-based, free)
- Basic operations:
  - Adding shapes
  - Moving and rotating
  - Resizing
  - Creating holes
  - Grouping
- Demonstrate measuring components and creating appropriate spaces

Demonstrate basics of building the device:
* Duplicate the Core_Geometries sketch
* (Paul) Create a slide that identifies all of the pieces in the Core_Geometries
* Name the design
* Make a shape for the base and position it over the cylindrical cavity (hole)
    - Import your bulldog and use it to help position
    - The cavity needs to be able to completely contain the ESP32 base
* Group (Union) the cavity and the base so that the hole appears
* Make a hole solid that is the same size as the ESP32 base. Extend it, if necessary, being
  careful to ensure that the base will fit in with the USB port exposed.
* Group (Union) the base and the hole
* Flip the ESP32 base over (180) and position it in the base with the USB port
  towards the outside.
* Move the LED strip enclosure (hole) to the desired location. Should be on the left
  of the ESP32 base when looking at the USB port. Note that it must
  protrude into the cavity as we need to be able to route the wires to the ESP32.
* Flip the DHT11 base on its side. We'll need it facing out so that it can get outside air.
* Create a hole to represent the cavity that the temperature sensor needs to fit into. The cavity must
  provide room for the wires to get to the ESP32 on the USB end.
  - Ensure that you'll be able to get the module into position (manufacturability).
  - Also, think about how to protect the sensor from heat being generated by the ESP32
    module.
* Duplicate the vents (holes) as necessary and position them so that they penetrate
  the shell.
* Group to finalize the vents
* Verify that everything is the way you want it, then select the base and export it 
  as STL, ready for 3d-printing.

**Design Activity (60 minutes)**

- Provide starter template file (Core_Geometries) with:
  - Basic box sized for components
  - ESP32 & DHT11 mounting solutions
  - LED strip cutout
  - Basic ventilation slots
  - Component measurements provided
- Students customize their enclosure:
  - Choose the base shape and get it into shape
  - Add ventilation holes for sensor
  - Personalize exterior (name, decorations, etc.)
  - Ensure USB port accessibility
- Save and export designs as STL files for printing

**Wrap-Up (5 minutes)**

- Submit designs for review and 3D printing
- Preview: Designs will be reviewed before next week
- Mechanical engineering careers: automotive, aerospace, robotics, manufacturing, product design

### Materials Needed

- Computers with internet access (Tinkercad is web-based)
- Tinkercad accounts created (free)
- Starter template file shared with students
- Component dimension reference sheet
- Calipers or rulers for measuring components
- Example enclosures to examine
- Access to 3D printer for instructor

### Pre-Session Preparation

- Create and test starter template design
- Set up Tinkercad class/accounts
- Create slide with component descriptions
- Prepare component measurement reference sheet
- Test print starter template to verify fit
- Plan printing schedule (may need to print overnight or between sessions)
- Bring an SEL electronic device for show and tell
- Bring LED strip with WLED.
- 

### Homework/Preparation

- Optional: Learn more about 3D printing
- Study ESP32 pinout and capabilities

--------

## Week 3: Electrical Engineering - Making Connections

### Topics

- Basic electrical concepts: circuits, voltage, current, signals, ohms law
- Reading wiring diagrams
- Component interfaces (I2C, digital pins)
- Troubleshooting electrical connections
- Introduction to test equipment (DVM, oscilloscope, logic analyzer, etc.)

### Activities

**Conceptual Introduction (10 minutes)**

- What do electrical engineers do?
- Basic concepts explained through analogy:
  - Voltage = pressure in a water pipe
  - Current = flow of water
  - Circuit = complete loop
  - Ohms Law
- Why proper connections matter
  - The importance of conventions (which we're not following)
- Overview of hardware architecture:
  - ESP32 dev board schematic, pinout, etc.
  - WS2812B (neopixel) schematic and description. How does it work and communicate?
  - DHT11 description. How does it work and communicate?

**Guided Wiring Activity (40 minutes)**

- Provide clear, color-coded wiring diagram
- Step-by-step connection process:
  1. Identify power rails on breadboard
  2. Connect ESP32 to breadboard
  3. Connect temperature/humidity sensor (3-4 wires)
  4. Connect LED strip (3 wires: power, ground, data)
- Checkpoints: Verify each connection before proceeding
- Load pre-written test code to ESP32
- Verify everything works (sensor reads, LEDs light up)

**Troubleshooting (5 minutes)**

- Common issues and solutions
- How to systematically check connections
- Using the serial monitor to see sensor data

**Career Discussion (5 minutes)**

- What electrical engineers do: power systems, circuit design, electronics, telecommunications
- Real-world applications

### Materials Needed

- ESP32 development boards (pre-soldered headers recommended)
- DHT11, DHT22, or DS18B20
- WS2812B LED strips (8-12 LED segments)
- Breadboards (May not be necessary depending on header availability and necessary dupont wires.)
- Jumper wires (color-coded set)
- USB cables
- Pre-written test code
- Clear wiring diagrams (printed or on screen)

### Pre-Session Preparation

- ESP32 pinout and feature slides prepared.
- Example ESP32 applications
- Hardware architecture and wiring diagram slides prepared.
- WS2812B introduction: https://www.elecfreaks.com/blog/post/get-to-know-ws2812b.html
- Test all components beforehand
- Load test code on one device to demonstrate
- Prepare backup components

### Homework/Preparation

- Keep device safe for next week
- Optional: Observe what happens when you change temperature (breathe on sensor, use ice pack)

---

## Week 4: Software Engineering - Bringing It to Life

### Topics

- What software engineers do
- Code structure and organization
- Variables, conditionals, and functions
- Reading sensor data and controlling outputs
- Iterative development and testing
- Thonny IDE introduction

### Activities

**Introduction (10 minutes)**

- What is software? Instructions that control hardware
- Overview of what the code does:
  1. Read sensor & pushbutton
  2. Process data (convert to temperature/humidity)
  3. Make decisions (if temp > X, then...)
  4. Control LEDs (colors, patterns)
  5. Repeat (super loop)
- Discuss the code structure (files and major sections).

**Guided Code Exploration (15 minutes)**

- Walk through the base program section by section
- Identify key parts students will modify:
  - Temperature thresholds
  - Color mappings
  - LED patterns
  - Update frequency
  - Mode
- Demonstrate: Change one value, upload, observe result

**Hands-On Modification (30 minutes)**

- Provide working base code with modification guide
- Suggested experiments (in order of complexity):
  1. Calibrate the temperature
  2. Change color for "cold" temperature range
  3. Adjust temperature thresholds
  4. Change LED animation speed
  5. Modify humidity color mapping
  6. Create custom color pattern
  7. Add new temperature range/color
  8. Fun new modes?
- Students work through modifications, testing each change
- Encourage experimentation: "What happens if...?"

**Sharing & Discussion (5 minutes)**

- Quick demos of interesting modifications
- What was challenging? What was satisfying?
- Software engineering careers: app development, web development, AI/ML, embedded systems

### Materials Needed

- Assembled devices from Week 3
- Thermometer for calibration
- Base code with clear comments and modification guide
- Reference sheet with color codes (RGB values)
- Backup pre-programmed ESP32 boards

### Pre-Session Preparation

- Test base code thoroughly
- Software architecture and state machine diagrams
- Create clear modification guide with examples
- Set up code with helpful comments
- Prepare troubleshooting guide for common code errors

### Homework/Preparation

- Keep experimenting with code at home (optional)
- Think about: What would make the device more useful or cool?

---

## Week 5: Integration, Testing & Future Pathways

### Topics

- System integration
- Testing and troubleshooting
- Engineering careers and education pathways
- Reflection on the engineering design process

### Activities

**Assembly (15 minutes)**

- Distribute printed enclosures
- Install devices in enclosures
- Cable management
- Final assembly checks

**Testing & Troubleshooting (15 minutes)**

- Does everything still work?
- Systematic testing approach:
  - Power on
  - Check sensor readings
  - Verify LED display
  - Test pushbutton and modes
  - Test in different conditions
- Problem-solving session for any issues
- Make final code adjustments if desired

**Demonstrations (15 minutes)**

- Each student briefly shows their device (1-2 minutes each)
- What customizations did you make?
- What are you most proud of?
- What would you improve?

**Reflection & Future Pathways (15 minutes)**

- Discussion questions:
  - Which discipline interested you most? Why?
  - What was the most challenging part?
  - What did you learn about how engineers work together?
  - How does this project compare to what you thought engineering was?
- Education pathways:
  - High school: Math, physics, computer science classes
  - College: Engineering programs, what to expect
  - Alternatives: Bootcamps, trade schools, self-learning
  - Industry certifications
- Resources for continued learning
- Optional: Q&A with guest engineers (if available)

### Materials Needed

- 3D printed enclosures
- Completed devices from previous weeks
- Any final assembly tools needed
- Backup components for troubleshooting
- Career/education resource handouts
- Certificates of completion (optional)

### Pre-Session Preparation

- Complete all 3D prints
- Test fit one complete assembly
- Prepare education/career resources
- Arrange guest speakers if possible
- Create any certificates or completion documentation

### Follow-Up

- Provide resource list for continued learning
- Encourage students to provide feedback
- Keep in touch with interested students about future opportunities

---

## Materials & Budget Summary

### Per Student Kit

- ESP32 development board: $8-12
- DHT22 or BME280 sensor: $5-10
- WS2812B LED strip (8-12 LEDs): $3-5
- Breadboard: $3-5
- Jumper wires set: $3-5
- USB cable: $3-5
- 3D printed enclosure: $2-5 (filament cost)
- **Total per student: ~$27-47**

### Shared Resources

- Computers with Arduino IDE
- 3D printer access
- Backup components
- Tools (wire strippers, calipers, etc.)

### Software (All Free)

- Arduino IDE
- Tinkercad
- Required Arduino libraries (FastLED, DHT or Adafruit BME280)

---

## Instructor Preparation Checklist

### Before Week 1

- [ ] Order all components with extras for backup
- [ ] Build and test one complete example device
- [ ] Prepare requirements analysis discussion materials

### Before Week 2

- [ ] Test all components
- [ ] Pre-solder headers to ESP32 boards (if needed)
- [ ] Install Arduino IDE on all computers
- [ ] Install ESP32 board support and libraries
- [ ] Create and test wiring diagrams
- [ ] Write and test verification code
- [ ] Prepare troubleshooting guide

### Before Week 3

- [ ] Write base code with clear modification points
- [ ] Test all modification examples
- [ ] Create modification guide document
- [ ] Prepare RGB color reference sheet
- [ ] Load base code on backup ESP32 boards

### Before Week 4

- [ ] Create and test Tinkercad starter template
- [ ] Set up Tinkercad class accounts
- [ ] Prepare component measurement reference
- [ ] Test print starter design
- [ ] Plan printing schedule
- [ ] Ensure 3D printer is calibrated and ready

### Before Week 5

- [ ] Complete all 3D prints
- [ ] Test fit assembly
- [ ] Prepare career/education resources
- [ ] Arrange guest speakers (if applicable)
- [ ] Create certificates or completion documentation

---

## Tips for Success

### Time Management

- Build in buffer time for troubleshooting
- Have backup activities if students finish early
- Be prepared to adjust pacing based on class progress

### Differentiation

- Advanced students: Suggest additional features or customizations
- Struggling students: Provide extra support, use buddy system
- Have extension activities ready

### Safety

- Emphasize proper handling of electronics
- USB power only (safe low voltage)
- Supervise 3D printer operation
- Hot glue gun safety if used for final assembly

### Engagement

- Encourage questions and experimentation
- Celebrate failures as learning opportunities
- Make connections to real-world applications
- Share stories of engineering careers and innovations

### Documentation

- Take photos of student work for portfolios
- Document issues and solutions for future iterations
- Collect student feedback for course improvement

---

## Possible Extensions

If students are interested in continuing beyond the 5 weeks:

- Add a display screen (OLED) to show numerical readings
- Implement WiFi connectivity to log data online
- Add more sensors (light, air quality, etc.)
- Create a mobile app to monitor the device
- Design a more complex multi-part enclosure
- Implement battery power for portability
- Add user controls (buttons to change modes)

---

## Assessment Ideas (Optional)

- Participation and engagement
- Successful completion of weekly activities
- Creativity in customizations
- Ability to troubleshoot and problem-solve
- Quality of final presentation
- Reflection on learning and interests

---

## Resources for Students

### Online Learning

- Arduino Project Hub: https://create.arduino.cc/projecthub
- Tinkercad Tutorials: https://www.tinkercad.com/learn
- Khan Academy: Computer Programming and Physics

### Communities

- Local maker spaces
- Robotics clubs
- Online forums (Arduino, maker communities)

### Books

- "Make: Electronics" by Charles Platt
- "Python Crash Course" by Eric Matthes
- "The Way Things Work Now" by David Macaulay

---

## Notes for Future Iterations

_Use this section to document what worked well, what needs improvement, and ideas for future versions of the course._