`timescale 1ns/1ps

module tb_four_bit_adder;
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] Sum;
    wire       Cout;

    reg  [4:0] expected;
    integer    errors = 0;
    integer    i, j, k;

    four_bit_adder uut (.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));

    task test;
        input [3:0] a;
        input [3:0] b;
        input       c;
        begin
            A = a; B = b; Cin = c;
            #10;
            expected = a + b + c;
            $display("A=%2d B=%2d Cin=%b -> Sum=%2d Cout=%b  (expected %2d)  %s",
                     A, B, Cin, Sum, Cout, expected,
                     ({Cout, Sum} === expected) ? "PASS" : "FAIL");
            if ({Cout, Sum} !== expected) errors = errors + 1;
        end
    endtask

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, tb_four_bit_adder);

        $display("---- Directed tests ----");
        test(4'd1,  4'd3,  1'b0);   // basic, no carry in
        test(4'd5,  4'd6,  1'b1);   // with carry in: 12, Cout 0
        test(4'd15, 4'd15, 1'b0);   // overflow: 30 = Cout 1, Sum 14
        test(4'd0,  4'd0,  1'b0);   // zero
        test(4'd4,  4'd3,  1'b0);
        test(4'd15, 4'd1,  1'b0);   // full carry propagation

        $display("---- Exhaustive test (all 512 combinations) ----");
        for (i = 0; i < 16; i = i + 1)
            for (j = 0; j < 16; j = j + 1)
                for (k = 0; k < 2; k = k + 1) begin
                    A = i; B = j; Cin = k;
                    #1;
                    expected = i + j + k;
                    if ({Cout, Sum} !== expected) begin
                        errors = errors + 1;
                        $display("FAIL: A=%0d B=%0d Cin=%0d", i, j, k);
                    end
                end

        $display("---- Done: %0d errors ----", errors);
        $finish;
    end
endmodule
