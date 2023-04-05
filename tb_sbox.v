module tb_sbox ();
reg [7:0] in_sbox;
wire [7:0] out_sbox;

    Sbox sbox(in_sbox, out_sbox);

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb_sbox);

        in_sbox = 8'b00000000;
        #10
        in_sbox = 8'b10000001; // h81 --> 
        #10
        in_sbox = 8'b11110000;  
        
    end
endmodule