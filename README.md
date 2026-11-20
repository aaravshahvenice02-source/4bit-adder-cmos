# 4-bit Adder Using CMOS Logic

## Objective
Design and simulate a 4-bit ripple carry adder in Verilog.

## Tools Used
- Icarus Verilog (functional simulation)
- GTKWave (waveform viewer)

## Design
- `full_adder.v` - 1-bit full adder: Sum = A ^ B ^ Cin, Cout = majority(A, B, Cin)
- `four_bit_adder.v` - 4-bit ripple carry adder: four full adders chained, Cout of each stage feeds Cin of the next

## Files
- full_adder.v - 1-bit full adder
- four_bit_adder.v - 4-bit ripple carry adder
- tb_four_bit_adder.v - self-checking testbench (6 directed tests plus all 512 input combinations)
- Waveform.png - simulation waveform
- Simulation_Output.png - terminal output

## How to Run
iverilog -o adder.out full_adder.v four_bit_adder.v tb_four_bit_adder.v
vvp adder.out
gtkwave adder.vcd

## Results
All 6 directed tests pass, and the exhaustive test of all 512 combinations of A, B and Cin completes with 0 errors.

Test cases include: 1 + 3 = 4; 5 + 6 + Cin(1) = 12 (Cout = 0); 15 + 15 = 30 (Sum = 14, Cout = 1); 0 + 0 = 0; 15 + 1 = 16 (Sum = 0, Cout = 1).
