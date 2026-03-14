# Week 1: Introduction & Requirements Analysis

## Topics

- Class overview: What are we going to be doing? (Syllabus)
- What is engineering? Problem-solving and design.
- Overview of electrical, mechanical, and software engineering disciplines
- Introduction to the engineering design process
- Requirements analysis and specification

## Activities

### Introduction (15 minutes)

- Instructor introduction: Short (5 min) overview of education and experience.
- Class overview using the syllabus.
- Introductions around the room. What's your handle?

### What is Engineering? (20 minutes)
- What is engineering? 
  * Discussion of engineering as disciplined creative problem-solving. What makes it different from "hacking"?
  * Requirements -> Design -> Implement -> Test.
  * Draw a diagram showing how the design progresses through the process and how the engineer incorporates science
    and technology to create the design.
  * Discuss the engineering disciplines and how they fit in. Each discipline has its own processes for Design->Implement->Test.
  * Test what you fly, fly what you test. What do you think this means?
- Show completed IoT environmental monitor example
- Explain how all three disciplines work together to create this device

### Requirements Analysis (40 minutes)

- Introduce the concept: "Before building anything, engineers must understand what they're building and why"
- Guided exercise: Define requirements for our device. One or more huddles to discuss these.
  - **The Need**: 
    - We need a product that is attractive and suitable for inclusion in a child's room that is capable of displaying temperature and humidity visually (at a glance) and via WiFI. The incorporation of a game would be "cool".
    - Instructor poses as "Product Engineer" who can describe the desired product, but not detailed engineering requirements. 
    - Throughout the exercise, the students should ask the Product Engineer questions to verify their understanding of the requirements. 
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

### Specification and Preliminary Design (20 minutes)
  - Summarize the requirements in each area
  - How are we going to meet each requirement?
  - What components will we need?
  - What will need to do (tasks) to implement, test, and manufacture our design?

### Component Exploration (10 minutes)
- Unbox and examine components
**STATIC ELECTRICITY KILLS ELECTRONICS**
**Be Gentle, please!**
   * ESP32: The "brain" (electrical engineering, software engineering)
   * DHT11 sensor: The "senses" (electrical engineering)
   * LED strip: The "display" (electrical engineering)
   * Enclosure: The "body" (mechanical engineering)
   * Software: Invisible stuff inside. Infinitely malleable.
   * Identify how each component addresses our requirements

### Discipline Breakdown (10 minutes)
- Map each identified task to the engineering discipline(s) that execute it
- Preview what we'll learn each week (mechanical, electrical, software)

### Time Filler (if needed)
- Introduce and demonstrate Tinkercad.

## Materials Needed

- Completed example device
- Component kits for each student
- Whiteboard/screen for requirements discussion
- Any slides? Or are we better off drawing the diagrams as needed in order
  to keep it more interactive?
- Extra of everything (dev boards, dupont wires, DHT11s, etc.)

## Homework/Preparation

- Think about: What questions do you have about the project?
- Think about: What do you want your device to look like? (The shape of the base and any decoration.)
- Optional: Research what ESP32 boards are used for in real products
- Optional: Lookup Python and CircuitPython on the web
- Optional: Play with Tinkercad at home.
