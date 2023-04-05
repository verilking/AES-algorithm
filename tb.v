module tb ();
reg [127:0] in_mix;
wire [127:0] out_mix;

    mixcolumn mix1(in_mix, out_mix);

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb);

        in_mix = 128'h01010101010101010101010101010101;
        #10
        in_mix = 128'h01010101020202020101010101010101;
        #10
        in_mix = 128'h01010101010101010101010101010101;
         
        
    end

endmodule