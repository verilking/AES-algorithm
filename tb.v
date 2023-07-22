module tb ();
reg [127:0] plaintext;
wire [127:0] cypertext;
reg CLK, RST;

    AES_pipe AES(plaintext, CLK, RST, cypertext);


    always #1 begin CLK = ~CLK; end //CLK generate

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb);
        
        CLK = 1; RST = 1; 
        #1 RST = 0;
        #1 plaintext=128'h1;
        #2 plaintext=128'h2;
        #2 plaintext=128'h3;
        #2 plaintext=128'h4;
        #100 $finish;
    end

endmodule