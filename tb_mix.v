module tb ();
reg [127:0] in;
wire [127:0] out1, out2;

    mixcolumn mixcolumn(in, out1);
    

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb);

        in = 128'h00000000_00000000_00000000_00000001;
        #10
        in = 128'h00000000_00000000_00000000_11111111;
        #10
        in = 128'h63f230fe6b01d77c67ab776f767bc52b;
        #10
        in = 128'h63f230fe6b01d77c67ab776f767bc52b;
    end
endmodule
