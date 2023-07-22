module tb_inv_subbytes ();
reg [127:0] in;
wire [127:0] out;

    inv_subbytes u1(in, out);

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb_inv_subbytes);

        in = 128'hC918B1BC_C918B1BC_C918B1BC_C918B1BC;
        #10
        in = 128'hC918B1BC_C918B1BC_C918B1BC_C918B1BC;
    end
endmodule