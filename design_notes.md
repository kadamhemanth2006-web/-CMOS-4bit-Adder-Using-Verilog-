# Design notes

## Architecture

The design is a 4-bit ripple-carry adder. Four full-adder stages are connected in series. The least-significant stage receives the external carry input. Each stage's carry output drives the next stage's carry input.

```text
 A0 B0       A1 B1       A2 B2       A3 B3
  | |         | |         | |         | |
+-------+   +-------+   +-------+   +-------+
|  FA0  |-->|  FA1  |-->|  FA2  |-->|  FA3  |
|       |   |       |   |       |   |       |
+-------+   +-------+   +-------+   +-------+
  |             |           |           |
 Sum[0]       Sum[1]      Sum[2]      Sum[3]
   Cin                                     Cout
```

## Full-adder truth table

| A | B | Cin | Sum | Cout |
|---:|---:|---:|---:|---:|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 1 | 1 |

## Verification approach

The self-checking testbench enumerates all 512 combinations of A, B, and Cin. For each combination, it compares the concatenated output `{Cout, Sum}` with the 5-bit integer result of `A + B + Cin`.

## Important correction to the supplied brief

The supplied brief's test case `A=0101`, `B=0110`, `Cin=1` gives a stated expected output of `Sum=1000`, `Cout=1`. However, 5 + 6 + 1 = 12, whose 5-bit representation is `01100`. Therefore the correct outputs are `Cout=0`, `Sum=1100`.

The supplied brief also labels `1111 + 1111` as decimal 30, which is correct, and its lower four bits are `1110` with carry-out 1.
