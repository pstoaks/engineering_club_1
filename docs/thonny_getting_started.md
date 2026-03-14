# Getting Started with Thonny & CircuitPython
*Introduction to Engineering Course — Week 4: Software Engineering*

---

## What Is Thonny?

Thonny is a free Python editor designed for beginners. For this course it serves as your complete development environment for writing, saving, and running CircuitPython code on your ESP32 board — all over a single USB cable. No WiFi needed.

| | |
|---|---|
| **Write** | code in the top editor pane |
| **Save** | the file to your board with Ctrl+S |
| **Watch** | your board restart and run the new code automatically |
| **Debug** | using the REPL shell at the bottom — `print()` output appears here |

---

## Before Class: Install Thonny

### Install Thonny

1. Go to **https://thonny.org** and download the appropriate installer for your computer.
2. Run the installer with all default options.
3. Launch Thonny. On first run it may ask your experience level — choose **"Standard"**.

### Configure Thonny for CircuitPython

1. Plug your ESP32 board into the laptop via USB.
2. In Thonny, go to **Tools → Options** and click the **Interpreter** tab.
3. From the first dropdown, select **"CircuitPython (generic)"**.
4. From the port dropdown, choose the COM port you noted in Step 1 (e.g., COM3).
5. Click **OK**.

> ✅ **Success:** The bottom pane of Thonny will show a `>>>` prompt. This is the REPL — your live connection to the board. Type `print("hello")` and press Enter to confirm it works.

---

## The Thonny Interface

| Area | What it does |
|---|---|
| **Top editor pane** | Where you write and edit your code. |
| **Bottom shell / REPL** | Live connection to the board. Shows `print()` output and errors. You can type Python here interactively. *REPL stands for Read-Eval-Print-Loop. It is an interactive computer programming environment that takes single user inputs (read), executes them (evaluate), returns the result to the screen (print), and repeats this process in a loop.*|
| **File browser** | View → Files — shows files on both your laptop AND the board. Open your code files directly from the board here. |
| **Status bar** | Bottom-right corner shows the connected board and COM port. |

---

## Your Daily Coding Workflow

### Step 1 — Open code.py from the Board

1. Go to **View → Files** to show the file browser panel.
2. In the lower half of the panel ("MicroPython device"), find **code.py** and double-click it.
3. It opens in the editor pane, ready to edit.

Note that when Thonny connects to the board initially, it stops any program running on it.
To start the currently loaded program, type **Ctrl+D** in the REPL.

Note that if the program loaded on the board is running, you'll need to press the Stop button in the toolbar (or type **Ctrl+C** in the REPL) before editing and saving code.

**NOTE:** In CircuitPython, the board can either be running the REPL (allowing files to be opened and saved), or it can be running the program. Not both at the same time. If you attempt to save an open file when the program is running, you'll see a nasty error alert pop up. This won't cause any problems, but it will remind you to stop the program before attempting to save.

### Step 2 — Edit the Code

- Make your changes in the editor pane.

### Step 3 — Save and Run

- **Ctrl+S** saves the file back to the board.
- You'll need to type **Ctrl+D** in the REPL to restart the program running.
- Watch the REPL shell — your `print()` statements appear here as the code runs, as well as any errors that your code produces.

### Step 4 — Use the REPL to Explore

- Press the Stop button in the toolbar or type **Ctrl+C** in the REPL to interrupt running code and get the `>>>` prompt.
- Type Python commands directly to test ideas without saving a file:
  - `import board` — then...
  - `dir(board)` — lists all available pin names for your board
- Press **Ctrl+D** to soft-reset the board and resume running code.py.

---

## Key Shortcuts to Know

| Shortcut | What it does |
|---|---|
| **Ctrl+S** | Save file to board (triggers auto-restart) |
| **Ctrl+C** | Interrupt running code → get `>>>` prompt |
| **Ctrl+D** | Soft reset → resume running code.py |
| **Ctrl+Z** | Undo last edit |
| **Ctrl+F** | Find text in the editor |

---

## Troubleshooting

| Problem | Fix |
|---|---|
| **No `>>>` in the REPL shell** | Check the COM port in Tools → Options → Interpreter. Try unplugging and re-plugging the USB cable. |
| **"Port not found" error** | The board isn't recognized. Check Device Manager to verify that the board is recognized as a COM port or try a different USB cable — some cables are power-only. |
| **Sensor read errors in the REPL** | DHT11 errors are normal occasionally — the code handles them. Persistent errors suggest a loose wire on the sensor data pin. |
| **Board not visible in file browser** | Make sure Thonny is connected (`>>>` in REPL). Click View → Files if the panel isn't showing. |
| **Can't save edited file** | Stop the running program by pressing the Stop button in the toolbar or **Ctrl+C** in the REPL and try again. |

---

## REPL Cheat Sheet — Useful Examples

Type these directly at the `>>>` prompt to explore your board:

```python
import board                          # load the board module
dir(board)                            # list all pin names on your board
```

```python
import board
import neopixel                       # load libraries
leds = neopixel.NeoPixel(board.IO13, 10) # Create a NeoPixel object to control the LED strip
leds.fill((255, 0, 0))                # turn all LEDs red
leds.fill((0, 0, 0))                  # turn LEDs off
leds[4] =((0, 0, 255))                # Make LED #4 (fifth LED) blue
pixels.show()                         # needed if auto_write=False
```

---

## Further Reading

- **Adafruit "Welcome to CircuitPython" guide:** https://learn.adafruit.com/welcome-to-circuitpython
- **CircuitPython library docs:** https://docs.circuitpython.org
- **Thonny home page:** https://thonny.org
- **CircuitPython library bundle (download libraries here):** https://circuitpython.org/libraries

---

*Introduction to Engineering Course — Keep this sheet, you'll refer to it every week.*
