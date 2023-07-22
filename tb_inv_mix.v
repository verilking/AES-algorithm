module tb ();
reg [127:0] in;
wire [127:0] out;

    inv_mixcolumns A1(in, out);

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb);

        in = 127'h00000001_00000001_00000003_00000002;
        #10
        in = 127'h11111111_11111111_33333333_22222222;
        #10
        in = 127'h6a2cb027_6a6dd99c_5c335d21_4551615c;
        #10
        in = 127'h6a2cb027_6a6dd99c_5c335d21_4551615c;
    end
endmodule
