module KeyXOR1(rcon, current, next);

    input [31:0] rcon;
    input [127:0] current;
    output [31:0] next;
    
    assign next[31:24] = rcon[31:24] ^ current[127:120];
    assign next[23:16] = rcon[23:16] ^ current[95:88];
    assign next[15:8] = rcon[15:8] ^ current[63:56];
    assign next[7:0] = rcon[7:0] ^ current[31:24];

endmodule

module KeyXOR2(word, current, next);

    input [31:0] word;
    input [127:0] current;
    output [31:0] next;
    
    assign next[31:24] = word[31:24] ^ current[119:112];
    assign next[23:16] = word[23:16] ^ current[87:80];
    assign next[15:8] = word[15:8] ^ current[55:48];
    assign next[7:0] = word[7:0] ^ current[23:16];

endmodule

module KeyXOR3(word, current, next);

    input [31:0] word;
    input [127:0] current;
    output [31:0] next;
    
    assign next[31:24] = word[31:24] ^ current[111:104];
    assign next[23:16] = word[23:16] ^ current[79:72];
    assign next[15:8] = word[15:8] ^ current[47:40];
    assign next[7:0] = word[7:0] ^ current[15:8];

endmodule

module KeyXOR4(word, current, next);

    input [31:0] word;
    input [127:0] current;
    output [31:0] next;
    
    assign next[31:24] = word[31:24] ^ current[103:96];
    assign next[23:16] = word[23:16] ^ current[71:64];
    assign next[15:8] = word[15:8] ^ current[39:32];
    assign next[7:0] = word[7:0] ^ current[7:0];

endmodule