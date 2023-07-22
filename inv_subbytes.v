module inv_subbytes(in, out);
input [127:0] in;
output [127:0] out;

invSbox S1(in[127:120], out[127:120]);
invSbox S2(in[119:112], out[119:112]);
invSbox S3(in[111:104], out[111:104]);
invSbox S4(in[103:96], out[103:96]);
invSbox S5(in[95:88], out[95:88]);
invSbox S6(in[87:80], out[87:80]);
invSbox S7(in[79:72], out[79:72]);
invSbox S8(in[71:64], out[71:64]);
invSbox S9(in[63:56], out[63:56]);
invSbox S10(in[55:48], out[55:48]);
invSbox S11(in[47:40], out[47:40]);
invSbox S12(in[39:32], out[39:32]);
invSbox S13(in[31:24], out[31:24]);
invSbox S14(in[23:16], out[23:16]);
invSbox S15(in[15:8], out[15:8]);
invSbox S16(in[7:0], out[7:0]);

endmodule