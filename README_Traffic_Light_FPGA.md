
# FPGA-Based Traffic Light System (Verilog) – DE10-Lite

This project implements a simple traffic light controller using an FPGA development board (Intel Altera DE10-Lite). The system cycles through red, green, and yellow lights with standard durations using Verilog HDL.

---

## ⚙️ Principle

The traffic light controller uses a finite state machine (FSM) to control the three states: RED, GREEN, and YELLOW. Each state lasts for a predetermined duration, and transitions are managed by a 1 Hz clock tick derived from the onboard 50 MHz clock. The FSM resets to RED on system reset.

---

## 🧾 Components Used

- **DE10-Lite FPGA board (Intel/Altera)**
- **Verilog HDL**
- **Onboard LEDs (LEDR[0], LEDR[1], LEDR[2])**
- **Clock (50 MHz)**
- **Quartus Prime Lite Software**
- **USB-Blaster (for programming)**

---

## 🔌 LED Connections

| LED Color | FPGA Pin | Description  |
|-----------|----------|--------------|
| Red       | PIN_Y23  | Stop signal  |
| Yellow    | PIN_AK22 | Warning signal |
| Green     | PIN_AG22 | Go signal    |

*(Please verify actual pin mappings based on your DE10-Lite board's user manual or pin planner.)*

---

## 💡 Applications

- Educational demonstrations of FSM design
- Traffic control simulations
- Entry-level Verilog and FPGA projects
- Prototype for smart traffic systems
- Timing logic training tools

---

## ✅ Advantages

- Simple and effective for learning digital design
- No external components needed (uses onboard LEDs)
- Easy to modify for different durations or patterns
- Demonstrates clock division and FSM clearly

---

## ⚠️ Limitations

- Basic functionality; no sensors or real-time inputs
- Only three static durations (not adaptive)
- Not scalable without significant redesign
- Uses onboard LEDs; real-world interface (e.g., lights/signals) not included

---

## 🚀 Getting Started

1. Open the project in **Quartus Prime Lite**.
2. Add the `traffic_light.v` file.
3. Assign pins using the **Pin Planner** or `.qsf`.
4. Compile the project.
5. Use the **USB-Blaster** to program the DE10-Lite.
6. Reset the board and observe the LED cycle.

---

## 📜 Conclusion

This traffic light system is a great introductory project for students and enthusiasts learning Verilog and FPGA design. It provides a real-world application of FSMs, clock dividers, and LED control, all within a compact and low-cost environment.
