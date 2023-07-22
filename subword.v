module subword(in, out);
input [31:0] in;
output [31:0] out;

Sbox sw1(in[31:24], out[31:24]);
Sbox sw2(in[23:16], out[23:16]);
Sbox sw3(in[15:8], out[15:8]);
Sbox sw4(in[7:0], out[7:0]);

endmodule