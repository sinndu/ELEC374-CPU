# Phase 1 Checklist:

## 1. Register File & Storage Modules

- [X] **Generic 32-bit Register**: Module with `D`, `Q`, `clk`, `clr`, and `Rin` (enable).
- [ ] **General Purpose Registers**: Instantiate R0 through R15.
- [ ] **PC (Program Counter)**: 32-bit register with increment logic.
- [ ] **IR (Instruction Register)**: 32-bit register to hold fetched instructions.
- [ ] **Y Register**: 32-bit temporary buffer for ALU operand A.
- [ ] **Z Register**: 64-bit register (Z-High and Z-Low) to store ALU results.
- [ ] **MAR (Memory Address Register)**: 32-bit register for memory interfacing.
- [ ] **HI & LO Registers**: 32-bit registers for specific multiply/divide outputs.

## 2. Bus & Interconnects

- [X] **32-to-5 Encoder**: Logic to convert "out" signals (R0out, PCout, etc.) into a selection index.
- [X] **32:1 Bus Multiplexer**: The central hub connecting all register outputs to the common 32-bit bus.
- [X] **MDR (Memory Data Register)**:
  - [X] Implement `MDMux` (Selects between BusMuxOut and Mdatain).
  - [X] Implement 32-bit register for MDR.

## 3. Arithmetic Logic Unit (ALU)

- [X] **Logical Ops**: `AND`, `OR`, `NOT`.
- [X] **Basic Arithmetic**: `Add`, `Sub` (using Carry-Lookahead or Ripple-Carry logic).
- [X] **Shift/Rotate Ops**: `SHR`, `SHRA`, `SHL`, `ROR`, `ROL`.
- [X] **Complex Ops**:
  - [X] `MUL`: 32x32 Booth's Algorithm or Carry-Save.
  - [X] `DIV`: 32-bit Non-restoring or Restoring Division.
  - [X] `NEG`: Two's complement negation logic.

## 4. System Integration (Top-Level Datapath)

- [ ] **Instantiation**: Connect all sub-modules into a single `datapath.v` entity.
- [ ] **Clock Distribution**: Ensure a global clock and reset signal are routed.
- [ ] **Pin Mapping**: Verify all "in" and "out" control signals are accessible for simulation.

## 5. Verification & Simulation (ModelSim)

- [ ] **Testbench Setup**: Create a `datapath_tb.v` to drive control signals.
- [ ] **Instruction Simulations**:
  - [ ] `Add/Sub` (T0-T5 sequence)
  - [ ] `Mul/Div` (T0-T? sequence)
  - [ ] `Shr/Shra/Shl/Ror/Rol`
  - [ ] `And/Or/Not/Neg`
- [ ] **Waveform Analysis**: Verify data moves correctly from Bus → Register → ALU → Z-Reg → Bus.
