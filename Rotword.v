module Rotword(key, R_key);

    input [127:0] key;
    output [31:0] R_key;
    
    assign R_key[7:0] = key[103:96]; // 1 to last
    assign R_key[15:8] = key[7:0]; 
    assign R_key[23:16] = key[39:32];
    assign R_key[31:24] = key[71:64];
    
endmodule
