# Design of a 4-bit Adder Using CMOS Logic

A 4-bit ripple-carry adder built from four cascaded 1-bit full adders. This repository contains synthesizable Verilog RTL, an exhaustive self-checking testbench, and an educational transistor-level SPICE starting point.

## Project objective

Design and verify a 4-bit adder with two 4-bit operands and a carry input. The design produces a 4-bit sum and a carry output.

## Repository contents

```text
.
├── rtl/
│   ├── full_adder.v
│   └── four_bit_adder.v
├── testbench/
│   └── tb_four_bit_adder.v
├── spice/
│   ├── full_adder_cmos.sp
│   └── README.md
├── docs/
│   └── design_notes.md
├── .gitignore
└── README.md
```

## Logic equations

For each 1-bit stage:

- `P = A XOR B`
- `Sum = P XOR Cin`
- `Cout = (A AND B) OR (P AND Cin)`

The carry output of each stage is connected to the carry input of the next stage. This is a ripple-carry architecture.

## Verify the Verilog design

Install Icarus Verilog and GTKWave. On Ubuntu:

```bash
sudo apt update
sudo apt install iverilog gtkwave
```

From the repository root:

```bash
iverilog -g2012 -Wall -o adder_sim rtl/full_adder.v rtl/four_bit_adder.v testbench/tb_four_bit_adder.v
vvp adder_sim
gtkwave adder.vcd
```

The testbench checks all `16 × 16 × 2 = 512` possible input combinations and prints a PASS message if every result matches the reference addition.

Expected final message:

```text
PASS: All 512 input combinations verified.
```

## Example test vectors

| A | B | Cin | Sum | Cout |
|---|---|---:|---|---:|
| 0001 | 0011 | 0 | 0100 | 0 |
| 0101 | 0110 | 1 | 1100 | 0 |
| 1111 | 0001 | 0 | 0000 | 1 |
| 0000 | 0000 | 0 | 0000 | 0 |
| 1111 | 1111 | 1 | 1111 | 1 |

**Note:** The second row is `5 + 6 + 1 = 12`, so the correct 4-bit result is `1100` with carry-out `0`. The uploaded project brief lists `1000` with carry-out `1` for this vector, which is arithmetically incorrect. The implementation and testbench use the correct result.

## CMOS / physical-design status

The `spice/` directory contains a generic MOSFET-level educational netlist for a 1-bit full adder and instructions for running it with ngspice. It is not a Sky130-qualified cell or a sign-off layout.

The Xschem schematic capture, Sky130 PDK setup, Magic layout, DRC, and Netgen LVS stages described in the project brief are not represented as completed results in this repository. Those stages require the corresponding tools/PDK and must be run and verified before claiming a completed physical CMOS layout.

## Tools

- Verilog HDL
- Icarus Verilog (RTL simulation)
- GTKWave (waveform viewing)
- ngspice (optional transistor-level educational simulation)
- Xschem, Magic, Netgen, and Sky130 Open_PDKs (physical-design extension)

## Author

Add your name, college, department, and company/internship details here before submission.
