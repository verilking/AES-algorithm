module AddRoundKey(in, master_key, out);
input [127:0] in, master_key;
output [127:0] out;

xor(out, in, master_key);
endmodule