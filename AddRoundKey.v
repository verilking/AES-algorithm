module AddRoundKey(in1, in2, out);
input [127:0] in1, in2;
output [127:0] out;

assign out = in1 ^ in2;
endmodule