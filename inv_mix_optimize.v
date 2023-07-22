module inv_mixcolumns(in, out);
input [127:0] in;
output [127:0] out;

wire [127:0] in_matrix, out_matrix; //transpose matrix
wire [127:0] multi2, multi3, multi9, multiE, multiB, multiD; 

//transpose matrix 
assign in_matrix[127:96] = {in[127:120], in[95:88], in[63:56], in[31:24]};
assign in_matrix[95:64] = {in[119:112], in[87:80], in[55:48], in[23:16]};
assign in_matrix[63:32] = {in[111:104], in[79:72], in[47:40], in[15:8]};
assign in_matrix[31:0] = {in[103:96], in[71:64], in[39:32], in[7:0]};

// 맨위 행(1번 행) 계산
GF_multiB B11(in_matrix[127:120], multiB[127:120]);
GF_multiB B12(in_matrix[119:112], multiB[119:112]);
GF_multiB B13(in_matrix[111:104], multiB[111:104]);
GF_multiB B14(in_matrix[103:96], multiB[103:96]);

GF_multi9 N11(in_matrix[127:120], multi9[127:120]);
GF_multi9 N12(in_matrix[119:112], multi9[119:112]);
GF_multi9 N13(in_matrix[111:104], multi9[111:104]);
GF_multi9 N14(in_matrix[103:96], multi9[103:96]);

GF_multiE E11(in_matrix[127:120], multiE[127:120]);
GF_multiE E12(in_matrix[119:112], multiE[119:112]);
GF_multiE E13(in_matrix[111:104], multiE[111:104]);
GF_multiE E14(in_matrix[103:96], multiE[103:96]);

GF_multiD D11(in_matrix[127:120], multiD[127:120]);
GF_multiD D12(in_matrix[119:112], multiD[119:112]);
GF_multiD D13(in_matrix[111:104], multiD[111:104]);
GF_multiD D14(in_matrix[103:96], multiD[103:96]);

GF_ADD ADD11(multiE[127:120], multiB[119:112], multiD[111:104], multi9[103:96], out_matrix[127:120]); 
GF_ADD ADD12(multi9[127:120], multiE[119:112], multiB[111:104], multiD[103:96], out_matrix[119:112]); 
GF_ADD ADD13(multiD[127:120], multi9[119:112], multiE[111:104], multiB[103:96], out_matrix[111:104]); 
GF_ADD ADD14(multiB[127:120], multiD[119:112], multi9[111:104], multiE[103:96], out_matrix[103:96]); 

// 2번 행 계산
GF_multiB B21(in_matrix[95:88], multiB[95:88]);
GF_multiB B22(in_matrix[87:80], multiB[87:80]);
GF_multiB B23(in_matrix[79:72], multiB[79:72]);
GF_multiB B24(in_matrix[71:64], multiB[71:64]);

GF_multi9 N21(in_matrix[95:88], multi9[95:88]);
GF_multi9 N22(in_matrix[87:80], multi9[87:80]);
GF_multi9 N23(in_matrix[79:72], multi9[79:72]);
GF_multi9 N24(in_matrix[71:64], multi9[71:64]);

GF_multiE E21(in_matrix[95:88], multiE[95:88]);
GF_multiE E22(in_matrix[87:80], multiE[87:80]);
GF_multiE E23(in_matrix[79:72], multiE[79:72]);
GF_multiE E24(in_matrix[71:64], multiE[71:64]);

GF_multiD D21(in_matrix[95:88], multiD[95:88]);
GF_multiD D22(in_matrix[87:80], multiD[87:80]);
GF_multiD D23(in_matrix[79:72], multiD[79:72]);
GF_multiD D24(in_matrix[71:64], multiD[71:64]);

GF_ADD ADD21(multiE[95:88], multiB[87:80], multiD[79:72], multi9[71:64], out_matrix[95:88]); 
GF_ADD ADD22(multi9[95:88], multiE[87:80], multiB[79:72], multiD[71:64], out_matrix[87:80]); 
GF_ADD ADD23(multiD[95:88], multi9[87:80], multiE[79:72], multiB[71:64], out_matrix[79:72]); 
GF_ADD ADD24(multiB[95:88], multiD[87:80], multi9[79:72], multiE[71:64], out_matrix[71:64]); 

// 3번 행 계산
GF_multiB B31(in_matrix[63:56], multiB[63:56]);
GF_multiB B32(in_matrix[55:48], multiB[55:48]);
GF_multiB B33(in_matrix[47:40], multiB[47:40]);
GF_multiB B34(in_matrix[39:32], multiB[39:32]);

GF_multi9 N31(in_matrix[63:56], multi9[63:56]);
GF_multi9 N32(in_matrix[55:48], multi9[55:48]);
GF_multi9 N33(in_matrix[47:40], multi9[47:40]);
GF_multi9 N34(in_matrix[39:32], multi9[39:32]);

GF_multiE E31(in_matrix[63:56], multiE[63:56]);
GF_multiE E32(in_matrix[55:48], multiE[55:48]);
GF_multiE E33(in_matrix[47:40], multiE[47:40]);
GF_multiE E34(in_matrix[39:32], multiE[39:32]);

GF_multiD D31(in_matrix[63:56], multiD[63:56]);
GF_multiD D32(in_matrix[55:48], multiD[55:48]);
GF_multiD D33(in_matrix[47:40], multiD[47:40]);
GF_multiD D34(in_matrix[39:32], multiD[39:32]);

GF_ADD ADD31(multiE[63:56], multiB[55:48], multiD[47:40], multi9[39:32], out_matrix[63:56]);
GF_ADD ADD32(multi9[63:56], multiE[55:48], multiB[47:40], multiD[39:32], out_matrix[55:48]);
GF_ADD ADD33(multiD[63:56], multi9[55:48], multiE[47:40], multiB[39:32], out_matrix[47:40]);
GF_ADD ADD34(multiB[63:56], multiD[55:48], multi9[47:40], multiE[39:32], out_matrix[39:32]);
// 4번 행 계산
GF_multiB B41(in_matrix[31:24], multiB[31:24]);
GF_multiB B42(in_matrix[23:16], multiB[23:16]);
GF_multiB B43(in_matrix[15:8], multiB[15:8]);
GF_multiB B44(in_matrix[7:0], multiB[7:0]);

GF_multi9 N41(in_matrix[31:24], multi9[31:24]);
GF_multi9 N42(in_matrix[23:16], multi9[23:16]);
GF_multi9 N43(in_matrix[15:8], multi9[15:8]);
GF_multi9 N44(in_matrix[7:0], multi9[7:0]);

GF_multiE E41(in_matrix[31:24], multiE[31:24]);
GF_multiE E42(in_matrix[23:16], multiE[23:16]);
GF_multiE E43(in_matrix[15:8], multiE[15:8]);
GF_multiE E44(in_matrix[7:0], multiE[7:0]);

GF_multiD D41(in_matrix[31:24], multiD[31:24]);
GF_multiD D42(in_matrix[23:16], multiD[23:16]);
GF_multiD D43(in_matrix[15:8], multiD[15:8]);
GF_multiD D44(in_matrix[7:0], multiD[7:0]);

GF_ADD ADD41(multiE[31:24], multiB[23:16], multiD[15:8], multi9[7:0], out_matrix[31:24]);
GF_ADD ADD42(multi9[31:24], multiE[23:16], multiB[15:8], multiD[7:0], out_matrix[23:16]);
GF_ADD ADD43(multiD[31:24], multi9[23:16], multiE[15:8], multiB[7:0], out_matrix[15:8]);
GF_ADD ADD44(multiB[31:24], multiD[23:16], multi9[15:8], multiE[7:0], out_matrix[7:0]);

// matrix 재배열
assign out[127:96] = {out_matrix[127:120], out_matrix[95:88], out_matrix[63:56], out_matrix[31:24]};
assign out[95:64] = {out_matrix[119:112], out_matrix[87:80], out_matrix[55:48], out_matrix[23:16]};
assign out[63:32] = {out_matrix[111:104], out_matrix[79:72], out_matrix[47:40], out_matrix[15:8]};
assign out[31:0] = {out_matrix[103:96], out_matrix[71:64], out_matrix[39:32], out_matrix[7:0]};
endmodule

module MUX (in1, in2, sel, out);
input [7:0] in1, in2;
input sel;
output reg [7:0]out;

always @ (in1, in2, sel) begin
    case(sel)
        1'b0 : out = in1;
        1'b1 : out = in2;
    endcase
end
endmodule

module GF_ADD(in1, in2, in3, in4, out_ADD);
input [7:0] in1, in2, in3, in4;
output [7:0] out_ADD;

assign out_ADD = in1 ^ in2 ^ in3 ^ in4;
endmodule

module GF_multi2 (in, out2);
input [7:0]in;
output [7:0]out2;
wire [7:0] temp1, temp2;
parameter [7:0] overflow = 8'b0001_1011;
assign temp1 = in<<1;
assign temp2 = (in<<1) ^ overflow;

MUX MUX_2in(temp1, temp2, in[7], out2);
endmodule

module GF_multi3 (in, out3);
input [7:0]in;
output [7:0]out3;

wire [7:0]temp;

GF_multi2 multi2 (in, temp);
assign out3 = temp^in; //multi2 + self
endmodule

module GF_multi9 (in, out9);
input [7:0] in;
output [7:0] out9;

wire [7:0] temp1, temp2, temp3;

GF_multi2 multi2 (in, temp1);
GF_multi2 multi2_1 (temp1, temp2); // temp2 = in * 2 * 2
GF_multi2 multi2_2 (temp2, temp3); // out9 = (in * 2 * 2) * 2 XOR in

assign out9 = temp3 ^ in;
endmodule

module GF_multiB (in, outB);
input [7:0] in;
output [7:0] outB;

wire [7:0] temp1, temp2, temp3, temp4;

GF_multi2 multi2 (in, temp1); // temp1 = in * 2
GF_multi2 multi2_1 (temp1, temp2); // temp2 = in * 2 * 2
assign temp3 = temp2 ^ in; // temp3 = (in * 2 * 2) XOR in
GF_multi2 multi2_2 (temp3, temp4); // outB = ((in * 2 * 2) XOR in) * 2 XOR in
assign outB = temp4 ^ in;
endmodule

module GF_multiD (in, outD);
input [7:0] in;
output [7:0] outD;

wire [7:0] temp1, temp2, temp3, temp4;

GF_multi2 multi2 (in, temp1); // temp1 = in * 2
assign temp2 = temp1 ^ in; // temp2 = (in * 2) XOR in
GF_multi2 multi2_1 (temp2, temp3); // temp3 = ((in * 2) XOR in) * 2
GF_multi2 multi2_2 (temp3, temp4); // outD = (((in * 2) XOR in) * 2) * 2 XOR in
assign outD = temp4 ^ in;
endmodule

module GF_multiE (in, outE);
input [7:0] in;
output [7:0] outE;

wire [7:0] temp1, temp2, temp3, temp4, temp5;

GF_multi2 multi2 (in, temp1); // temp1 = in * 2
GF_multi2 multi2_1 (temp1, temp2); // temp2 = (in * 2) * 2
GF_multi3 multi3 (in, temp3); // temp3 = in * 3

assign temp4 = temp2 ^ temp3; // temp4 = (in * 4) XOR (in * 3)
GF_multi2 multi2_2(temp4, outE); // temp5 = ((in * 4) XOR (in * 3)) * 2


endmodule
