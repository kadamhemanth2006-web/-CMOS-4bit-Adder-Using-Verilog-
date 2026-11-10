`timescale 1ns/1ps

module tb_four_bit_adder;
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] Sum;
    wire       Cout;

    integer a, b, ci;
    integer expected;
    integer tests;
    integer errors;

    four_bit_adder dut (
        .A(A), .B(B), .Cin(Cin),
        .Sum(Sum), .Cout(Cout)
    );

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, tb_four_bit_adder);

        tests = 0;
        errors = 0;

        // Exhaustively test all 16 x 16 x 2 input combinations.
        for (a = 0; a < 16; a = a + 1) begin
            for (b = 0; b < 16; b = b + 1) begin
                for (ci = 0; ci < 2; ci = ci + 1) begin
                    A = a;
                    B = b;
                    Cin = ci;
                    #1;

                    expected = a + b + ci;
                    tests = tests + 1;

                    if ({Cout, Sum} !== expected[4:0]) begin
                        $display("FAIL A=%b B=%b Cin=%b | got Cout=%b Sum=%b | expected=%b",
                                 A, B, Cin, Cout, Sum, expected[4:0]);
                        errors = errors + 1;
                    end
                end
            end
        end

        if (errors == 0)
            $display("PASS: All %0d input combinations verified.", tests);
        else
            $display("FAIL: %0d errors out of %0d tests.", errors, tests);

        $finish;
    end
endmodule
