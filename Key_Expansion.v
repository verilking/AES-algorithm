module key_expansion (in,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10);
input [127:0] in;
output [127:0] key1,key2,key3,key4,key5,key6,key7,key8,key9,key10;

parameter [3:0] round1 = 'b0001, round2 = 'b0010, round3 = 'b0011, round4 = 'b0100, round5 = 'b0101, round6 = 'b0110,
                round7 = 'b0111,  round8 = 'b1000, round9 = 'b1001, round10 = 'b1010;

Key_Expansion_round R1(in, round1, key1);
Key_Expansion_round R2(key1, round2, key2);
Key_Expansion_round R3(key2, round3, key3);
Key_Expansion_round R4(key3, round4, key4);
Key_Expansion_round R5(key4, round5, key5);
Key_Expansion_round R6(key5, round6, key6);
Key_Expansion_round R7(key6, round7, key7);
Key_Expansion_round R8(key7, round8, key8);
Key_Expansion_round R9(key8, round9, key9);
Key_Expansion_round R10(key9, round10, key10);

endmodule


module Key_Expansion_round(current, round, next);

    input [127:0] current;
    input [3:0] round;
    output [127:0] next;
    
    wire [31:0]rot_temp, sub_temp, rcon_temp;
    wire [31:0]xor_temp1, xor_temp2, xor_temp3, xor_temp4;

    Rotword rot1(current, rot_temp);
    subword K2(rot_temp, sub_temp);
    rcon K3(sub_temp, round, rcon_temp);

    KeyXOR1 K4(rcon_temp, current, xor_temp1);
    KeyXOR2 K5(xor_temp1, current, xor_temp2);
    KeyXOR3 K6(xor_temp2, current, xor_temp3);
    KeyXOR4 K7(xor_temp3, current, xor_temp4);

    assign next[127:120] = xor_temp1[31:24];
    assign next[95:88] = xor_temp1[23:16];
    assign next[63:56] = xor_temp1[15:8];
    assign next[31:24] = xor_temp1[7:0];
    
    assign next[119:112] = xor_temp2[31:24];
    assign next[87:80] = xor_temp2[23:16];
    assign next[55:48] = xor_temp2[15:8];
    assign next[23:16] = xor_temp2[7:0];
    
    assign next[111:104] = xor_temp3[31:24];
    assign next[79:72] = xor_temp3[23:16];
    assign next[47:40] = xor_temp3[15:8];
    assign next[15:8] = xor_temp3[7:0];
    
    assign next[103:96] = xor_temp4[31:24];
    assign next[71:64] = xor_temp4[23:16];
    assign next[39:32] = xor_temp4[15:8];
    assign next[7:0] = xor_temp4[7:0];
    
endmodule