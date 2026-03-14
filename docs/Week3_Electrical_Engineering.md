# Week 3: Electrical Engineering - Making Connections

## Topics

- What do electrical engineers do?
- Basic electrical concepts: circuits, voltage, current, signals, ohms law
- Logic concepts (boolean/binary, AND, OR, NOT)
- Reading wiring diagrams
- Component interfaces (I2C, digital pins)
- Troubleshooting electrical connections
- Introduction to test equipment (DVM, oscilloscope, logic analyzer, etc.)

## Activities

*There are only six wires to be connected for this design. As a result, the hands-on time requirements are minimal. This can be advantageous if the students need more time with Tinkercad to finish their enclosure designs from Week 2. The instructor can adjust the activities this week to provide time for completing the mechanical design.*

### Conceptual Introduction (20 minutes)

- Basic concepts explained through analogy:
  - Voltage = pressure in a water pipe
  - Current = flow of water
  - Circuit = complete loop
  - Ohms Law
- Digital Logic
  - Microcontrollers: Introduction to the ESP32
  - Boolean/binary values, AND, OR, NOT
  - GPIO usage
  - Serial buses (I2C, SPI, WS2812B, and One-Wire)
- Sensing and Controlling
  - Sensors (voltage, current, temperature, pressure, humidity, position, strain, distance, etc.)
  - Controlling (motors, resistive loads, optocouplers, voltage translators, etc.)
- Overview of hardware architecture:
  - ESP32 dev board schematic, pinout, etc.
  - WS2812B (neopixel) schematic and description. How does it work and communicate?
  - DHT11 description. How does it work and communicate?

### Guided Wiring Activity (40 minutes)

- Provide clear, color-coded wiring diagram
- Step-by-step connection process:
  1. Connect temperature/humidity sensor (3 wires)
  2. Connect LED strip (3 wires: power, ground, data)
- Checkpoints: Verify each connection before proceeding
- Plug in USB cable **Gently!**
- Verify test results by executing test procedure

**Connections Table**

| ESP32 Board Pin   | Device Pin  | Wire Color  | Purpose           |
|---:|:---|:---|:---|
| **LED Strip**     |             |             |                   |
| VIN               | LED +5V     | Orange      | +5V to LED Strip  |
| GND               | LED GND     | Green       | LED Strip Ground  |
| D13               | LED Din     | Yellow      | LED Strip Data    |
| **DHT11 Sensor**  |             |             |                   |
| 3V3               | +           | Red         | DHT11 3.3V Supply |
| GND               | -           | Brown       | DHT11 Ground      |
| D18               | out         | Orange      | DHT11 Data        |


### Troubleshooting (5 minutes)

- Common issues and solutions
- How to systematically check connections
- Using the serial monitor to see sensor data

### Career Discussion (20 minutes)

- What electrical engineers do: design and test power systems, circuit design, electronics, telecommunications

Electrical or computer engineers should be in the class for some of this discussion. Choose folks who have experience designing and testing mirocontroller based electronic devices. Here are some questions that we could ask of them:
- What made you select Electrical/Computer Engineering for an education and career?
- What kind of education is require?
- Did you enjoy university? What were your favorite and least favorite parts?
- Where are you employed?
- What is your job like (day in the life...)?
- What are your favorite and least favorite parts of the job?
- What has surprised you most about the job (vs. your expectations before your job)
- Do you have any recommendations for someone considering a job as an engineer?

## Materials Needed

- ESP32 development boards with pre-soldered headers
- DHT11 breakout board
- WS2812B LED strips (10 LED segments)
- USB cables
- Pre-written test code
- Clear wiring diagrams (printed or on screen)
- Materials for general electrical circuit discussion
- Materials for microcontroller interfacing discussion
  - GPIO to drive LEDs, relays, etc.
  - Binary
  - Serial bus operation (oscilloscope and/or logic analyzer to show communication protocol)
- Materials for ESP32 discussion
- Test Plan/Procedure!

## Pre-Session Preparation

- ESP32 pinout and feature slides prepared.
- Example ESP32 applications
- Hardware architecture and wiring diagram slides prepared.
- WS2812B introduction: https://www.elecfreaks.com/blog/post/get-to-know-ws2812b.html
- Test all components beforehand
- Create test plan
- Prepare backup components

## Homework/Preparation

- Keep device safe for next week
- Optional: Observe what happens when you change temperature (breathe on sensor, use ice pack)
