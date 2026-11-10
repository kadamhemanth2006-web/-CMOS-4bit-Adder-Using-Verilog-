* Generic educational CMOS 1-bit full adder
* NAND2 = 4 MOSFETs; XOR2 = 4 NAND2 gates.
* Carry = NAND(NAND(A,B), NAND(P,Cin)), P=A XOR B.
* Generic Level-1 models only; NOT a Sky130 sign-off model.

.model NM NMOS (LEVEL=1 VTO=0.7 KP=120u LAMBDA=0.02)
.model PM PMOS (LEVEL=1 VTO=-0.7 KP=50u LAMBDA=0.02)

.subckt inv A Y VDD VSS
Mp Y A VDD VDD PM W=2u L=0.18u
Mn Y A VSS VSS NM W=1u L=0.18u
.ends inv

.subckt nand2 A B Y VDD VSS
Mp1 Y A VDD VDD PM W=2u L=0.18u
Mp2 Y B VDD VDD PM W=2u L=0.18u
Mn1 Y A nmid VSS NM W=1u L=0.18u
Mn2 nmid B VSS VSS NM W=1u L=0.18u
.ends nand2

.subckt xor2 A B Y VDD VSS
Xn1 A B n1 VDD VSS nand2
Xn2 A n1 n2 VDD VSS nand2
Xn3 B n1 n3 VDD VSS nand2
Xn4 n2 n3 Y VDD VSS nand2
.ends xor2

.subckt full_adder A B CI S CO VDD VSS
Xp A B p VDD VSS xor2
Xs p CI S VDD VSS xor2
Xc1 A B n_ab VDD VSS nand2
Xc2 p CI n_pc VDD VSS nand2
Xc3 n_ab n_pc CO VDD VSS nand2
.ends full_adder

VDD vdd 0 1.8
VA a 0 PULSE(0 1.8 1n 100p 100p 4n 8n)
VB b 0 PULSE(0 1.8 2n 100p 100p 8n 16n)
VC ci 0 PULSE(0 1.8 3n 100p 100p 16n 32n)

XFA a b ci sum cout vdd 0 full_adder

.tran 50p 32n
.control
run
wrdata full_adder_cmos_waveform.txt v(a) v(b) v(ci) v(sum) v(cout)
.endc
.end
