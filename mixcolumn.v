module mixcolumn(in, out);
input [127:0] in;
output [127:0] out;

wire [127:0] in_matrix, out_matrix; //transpose matrix
wire [127:0] multi2, multi3; 

//temporary variable
wire [31:0]temp11, temp12, temp13, temp14, temp21, temp22, temp23, temp24, 
temp31, temp32, temp33, temp34, temp41, temp42, temp43, temp44;

//transpose matrix 
assign in_matrix[127:96] = {in[127:120], in[95:88], in[63:56], in[31:24]};
assign in_matrix[95:64] = {in[119:112], in[87:80], in[55:48], in[23:16]};
assign in_matrix[63:32] = {in[111:104], in[79:72], in[47:40], in[15:8]};
assign in_matrix[31:0] = {in[103:96], in[71:64], in[39:32], in[7:0]};

// specific constant matrix
parameter [7:0] const1 = 8'b10110101; //2311 
parameter [7:0] const2 = 8'b01101101; //1231
parameter [7:0] const3 = 8'b01011011; //1123
parameter [7:0] const4 = 8'b11010110; //3112


// 맨위 행(1번 행) 계산
GF_multi2 A11(in_matrix[127:120], multi2[127:120]);
GF_multi2 A12(in_matrix[119:112], multi2[119:112]);
GF_multi2 A13(in_matrix[111:104], multi2[111:104]);
GF_multi2 A14(in_matrix[103:96], multi2[103:96]);

GF_multi3 B11(in_matrix[127:120], multi3[127:120]);
GF_multi3 B12(in_matrix[119:112], multi3[119:112]);
GF_multi3 B13(in_matrix[111:104], multi3[111:104]);
GF_multi3 B14(in_matrix[103:96], multi3[103:96]);

MUX M111(in_matrix[127:120], multi2[127:120], multi3[127:120], const1[7:6], temp11[31:24]);
MUX M112(in_matrix[119:112], multi2[119:112], multi3[119:112], const1[5:4], temp11[23:16]);
MUX M113(in_matrix[111:104], multi2[111:104], multi3[111:104], const1[3:2], temp11[15:8]);
MUX M114(in_matrix[103:96], multi2[103:96], multi3[103:96], const1[1:0], temp11[7:0]);
GF_ADD ADD11(temp11[31:24], temp11[23:16], temp11[15:8], temp11[7:0], out_matrix[127:120]); 

MUX M121(in_matrix[127:120], multi2[127:120], multi3[127:120], const2[7:6], temp12[31:24]);
MUX M122(in_matrix[119:112], multi2[119:112], multi3[119:112], const2[5:4], temp12[23:16]);
MUX M123(in_matrix[111:104], multi2[111:104], multi3[111:104], const2[3:2], temp12[15:8]);
MUX M124(in_matrix[103:96], multi2[103:96], multi3[103:96], const2[1:0], temp12[7:0]);
GF_ADD ADD12(temp12[31:24], temp12[23:16], temp12[15:8], temp12[7:0], out_matrix[119:112]); 

MUX M131(in_matrix[127:120], multi2[127:120], multi3[127:120], const3[7:6], temp13[31:24]);
MUX M132(in_matrix[119:112], multi2[119:112], multi3[119:112], const3[5:4], temp13[23:16]);
MUX M133(in_matrix[111:104], multi2[111:104], multi3[111:104], const3[3:2], temp13[15:8]);
MUX M134(in_matrix[103:96], multi2[103:96], multi3[103:96], const3[1:0], temp13[7:0]);
GF_ADD ADD13(temp13[31:24], temp13[23:16], temp13[15:8], temp13[7:0], out_matrix[111:104]); 

MUX M141(in_matrix[127:120], multi2[127:120], multi3[127:120], const4[7:6], temp14[31:24]);
MUX M142(in_matrix[119:112], multi2[119:112], multi3[119:112], const4[5:4], temp14[23:16]);
MUX M143(in_matrix[111:104], multi2[111:104], multi3[111:104], const4[3:2], temp14[15:8]);
MUX M144(in_matrix[103:96], multi2[103:96], multi3[103:96], const4[1:0], temp14[7:0]);
GF_ADD ADD14(temp14[31:24], temp14[23:16], temp14[15:8], temp14[7:0], out_matrix[103:96]); 

// 2번 행 계산
GF_multi2 A21(in_matrix[95:88], multi2[95:88]);
GF_multi2 A22(in_matrix[87:80], multi2[87:80]);
GF_multi2 A23(in_matrix[79:72], multi2[79:72]);
GF_multi2 A24(in_matrix[71:64], multi2[71:64]);

GF_multi3 B21(in_matrix[95:88], multi3[95:88]);
GF_multi3 B22(in_matrix[87:80], multi3[87:80]);
GF_multi3 B23(in_matrix[79:72], multi3[79:72]);
GF_multi3 B24(in_matrix[71:64], multi3[71:64]);

MUX M211(in_matrix[95:88], multi2[95:88], multi3[95:88], const1[7:6], temp21[31:24]);
MUX M212(in_matrix[87:80], multi2[87:80], multi3[87:80], const1[5:4], temp21[23:16]);
MUX M213(in_matrix[79:72], multi2[79:72], multi3[79:72], const1[3:2], temp21[15:8]);
MUX M214(in_matrix[71:64], multi2[71:64], multi3[71:64], const1[1:0], temp21[7:0]);
GF_ADD ADD21(temp21[31:24], temp21[23:16], temp21[15:8], temp21[7:0], out_matrix[95:88]);

MUX M221(in_matrix[95:88], multi2[95:88], multi3[95:88], const2[7:6], temp22[31:24]);
MUX M222(in_matrix[87:80], multi2[87:80], multi3[87:80], const2[5:4], temp22[23:16]);
MUX M223(in_matrix[79:72], multi2[79:72], multi3[79:72], const2[3:2], temp22[15:8]);
MUX M224(in_matrix[71:64], multi2[71:64], multi3[71:64], const2[1:0], temp22[7:0]);
GF_ADD ADD22(temp22[31:24], temp22[23:16], temp22[15:8], temp22[7:0], out_matrix[87:80]);

MUX M231(in_matrix[95:88], multi2[95:88], multi3[95:88], const3[7:6], temp23[31:24]);
MUX M232(in_matrix[87:80], multi2[87:80], multi3[87:80], const3[5:4], temp23[23:16]);
MUX M233(in_matrix[79:72], multi2[79:72], multi3[79:72], const3[3:2], temp23[15:8]);
MUX M234(in_matrix[71:64], multi2[71:64], multi3[71:64], const3[1:0], temp23[7:0]);
GF_ADD ADD23(temp23[31:24], temp23[23:16], temp23[15:8], temp23[7:0], out_matrix[79:72]);

MUX M241(in_matrix[95:88], multi2[95:88], multi3[95:88], const4[7:6], temp24[31:24]);
MUX M242(in_matrix[87:80], multi2[87:80], multi3[87:80], const4[5:4], temp24[23:16]);
MUX M243(in_matrix[79:72], multi2[79:72], multi3[79:72], const4[3:2], temp24[15:8]);
MUX M244(in_matrix[71:64], multi2[71:64], multi3[71:64], const4[1:0], temp24[7:0]);
GF_ADD ADD24(temp24[31:24], temp24[23:16], temp24[15:8], temp24[7:0], out_matrix[71:64]);

// 3번 행 계산
GF_multi2 A31(in_matrix[63:56], multi2[63:56]);
GF_multi2 A32(in_matrix[55:48], multi2[55:48]);
GF_multi2 A33(in_matrix[47:40], multi2[47:40]);
GF_multi2 A34(in_matrix[39:32], multi2[39:32]);

GF_multi3 B31(in_matrix[63:56], multi3[63:56]);
GF_multi3 B32(in_matrix[55:48], multi3[55:48]);
GF_multi3 B33(in_matrix[47:40], multi3[47:40]);
GF_multi3 B34(in_matrix[39:32], multi3[39:32]);

MUX M311(in_matrix[63:56], multi2[63:56], multi3[63:56], const1[7:6], temp31[31:24]);
MUX M312(in_matrix[55:48], multi2[55:48], multi3[55:48], const1[5:4], temp31[23:16]);
MUX M313(in_matrix[47:40], multi2[47:40], multi3[47:40], const1[3:2], temp31[15:8]);
MUX M314(in_matrix[39:32], multi2[39:32], multi3[39:32], const1[1:0], temp31[7:0]);
GF_ADD ADD31(temp31[31:24], temp31[23:16], temp31[15:8], temp31[7:0], out_matrix[63:56]);

MUX M321(in_matrix[63:56], multi2[63:56], multi3[63:56], const2[7:6], temp32[31:24]);
MUX M322(in_matrix[55:48], multi2[55:48], multi3[55:48], const2[5:4], temp32[23:16]);
MUX M323(in_matrix[47:40], multi2[47:40], multi3[47:40], const2[3:2], temp32[15:8]);
MUX M324(in_matrix[39:32], multi2[39:32], multi3[39:32], const2[1:0], temp32[7:0]);
GF_ADD ADD32(temp32[31:24], temp32[23:16], temp32[15:8], temp32[7:0], out_matrix[55:48]);

MUX M331(in_matrix[63:56], multi2[63:56], multi3[63:56], const3[7:6], temp33[31:24]);
MUX M332(in_matrix[55:48], multi2[55:48], multi3[55:48], const3[5:4], temp33[23:16]);
MUX M333(in_matrix[47:40], multi2[47:40], multi3[47:40], const3[3:2], temp33[15:8]);
MUX M334(in_matrix[39:32], multi2[39:32], multi3[39:32], const3[1:0], temp33[7:0]);
GF_ADD ADD33(temp33[31:24], temp33[23:16], temp33[15:8], temp33[7:0], out_matrix[47:40]);

MUX M341(in_matrix[63:56], multi2[63:56], multi3[63:56], const4[7:6], temp34[31:24]);
MUX M342(in_matrix[55:48], multi2[55:48], multi3[55:48], const4[5:4], temp34[23:16]);
MUX M343(in_matrix[47:40], multi2[47:40], multi3[47:40], const4[3:2], temp34[15:8]);
MUX M344(in_matrix[39:32], multi2[39:32], multi3[39:32], const4[1:0], temp34[7:0]);
GF_ADD ADD34(temp34[31:24], temp34[23:16], temp34[15:8], temp34[7:0], out_matrix[39:32]);
// 4번 행 계산
GF_multi2 A41(in_matrix[31:24], multi2[31:24]);
GF_multi2 A42(in_matrix[23:16], multi2[23:16]);
GF_multi2 A43(in_matrix[15:8], multi2[15:8]);
GF_multi2 A44(in_matrix[7:0], multi2[7:0]);

GF_multi3 B41(in_matrix[31:24], multi3[31:24]);
GF_multi3 B42(in_matrix[23:16], multi3[23:16]);
GF_multi3 B43(in_matrix[15:8], multi3[15:8]);
GF_multi3 B44(in_matrix[7:0], multi3[7:0]);

MUX M411(in_matrix[31:24], multi2[31:24], multi3[31:24], const1[7:6], temp41[31:24]);
MUX M412(in_matrix[23:16], multi2[23:16], multi3[23:16], const1[5:4], temp41[23:16]);
MUX M413(in_matrix[15:8], multi2[15:8], multi3[15:8], const1[3:2], temp41[15:8]);
MUX M414(in_matrix[7:0], multi2[7:0], multi3[7:0], const1[1:0], temp41[7:0]);
GF_ADD ADD41(temp41[31:24], temp41[23:16], temp41[15:8], temp41[7:0], out_matrix[31:24]);

MUX M421(in_matrix[31:24], multi2[31:24], multi3[31:24], const2[7:6], temp42[31:24]);
MUX M422(in_matrix[23:16], multi2[23:16], multi3[23:16], const2[5:4], temp42[23:16]);
MUX M423(in_matrix[15:8], multi2[15:8], multi3[15:8], const2[3:2], temp42[15:8]);
MUX M424(in_matrix[7:0], multi2[7:0], multi3[7:0], const2[1:0], temp42[7:0]);
GF_ADD ADD42(temp42[31:24], temp42[23:16], temp42[15:8], temp42[7:0], out_matrix[23:16]);

MUX M431(in_matrix[31:24], multi2[31:24], multi3[31:24], const3[7:6], temp43[31:24]);
MUX M432(in_matrix[23:16], multi2[23:16], multi3[23:16], const3[5:4], temp43[23:16]);
MUX M433(in_matrix[15:8], multi2[15:8], multi3[15:8], const3[3:2], temp43[15:8]);
MUX M434(in_matrix[7:0], multi2[7:0], multi3[7:0], const3[1:0], temp43[7:0]);
GF_ADD ADD43(temp43[31:24], temp43[23:16], temp43[15:8], temp43[7:0], out_matrix[15:8]);

MUX M441(in_matrix[31:24], multi2[31:24], multi3[31:24], const4[7:6], temp44[31:24]);
MUX M442(in_matrix[23:16], multi2[23:16], multi3[23:16], const4[5:4], temp44[23:16]);
MUX M443(in_matrix[15:8], multi2[15:8], multi3[15:8], const4[3:2], temp44[15:8]);
MUX M444(in_matrix[7:0], multi2[7:0], multi3[7:0], const4[1:0], temp44[7:0]);
GF_ADD ADD44(temp44[31:24], temp44[23:16], temp44[15:8], temp44[7:0], out_matrix[7:0]);

// matrix 재배열
assign out[127:96] = {out_matrix[127:120], out_matrix[95:88], out_matrix[63:56], out_matrix[31:24]};
assign out[95:64] = {out_matrix[119:112], out_matrix[87:80], out_matrix[55:48], out_matrix[23:16]};
assign out[63:32] = {out_matrix[111:104], out_matrix[79:72], out_matrix[47:40], out_matrix[15:8]};
assign out[31:0] = {out_matrix[103:96], out_matrix[71:64], out_matrix[39:32], out_matrix[7:0]};
endmodule

module MUX(in1, in2, in3, sel, out_MUX);
input [7:0] in1, in2, in3;
input [1:0] sel;
output [7:0] out_MUX;
reg [7:0] temp_mux;

always @ (sel, in1, in2, in3) begin
  case(sel) 
    2'b00 : temp_mux = 7'bx;
    2'b01 : temp_mux = in1;
    2'b10 : temp_mux = in2;
    2'b11 : temp_mux = in3;
  endcase 
end
assign out_MUX = temp_mux;
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

MUX2input MUX_2in(temp1, temp2, in[7], out2);

endmodule

module GF_multi3 (in, out3);
input [7:0]in;
output [7:0]out3;

wire [7:0]temp;

GF_multi2 multi2 (in, temp);
assign out3 = temp^in; //multi2 + self
endmodule

module MUX2input (in1, in2, sel, out);
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