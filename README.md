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

