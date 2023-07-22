module mixcolumn_optimize(in, out);
input [127:0] in;
output [127:0] out;

wire [127:0] in_matrix, out_matrix; //transpose matrix
wire [127:0] multi2, multi3; //x2 & x3

//transpose matrix 
assign in_matrix[127:96] = {in[127:120], in[95:88], in[63:56], in[31:24]};
assign in_matrix[95:64] = {in[119:112], in[87:80], in[55:48], in[23:16]};
assign in_matrix[63:32] = {in[111:104], in[79:72], in[47:40], in[15:8]};
assign in_matrix[31:0] = {in[103:96], in[71:64], in[39:32], in[7:0]};


// 맨위 행(1번 행) 계산
GF_multi2 A11(in_matrix[127:120], multi2[127:120]);
GF_multi2 A12(in_matrix[119:112], multi2[119:112]);
GF_multi2 A13(in_matrix[111:104], multi2[111:104]);
GF_multi2 A14(in_matrix[103:96], multi2[103:96]);

GF_multi3 B11(in_matrix[127:120], multi3[127:120]);
GF_multi3 B12(in_matrix[119:112], multi3[119:112]);
GF_multi3 B13(in_matrix[111:104], multi3[111:104]);
GF_multi3 B14(in_matrix[103:96], multi3[103:96]);

GF_ADD ADD11(multi2[127:120], multi3[119:112], in_matrix[111:104], in_matrix[103:96], out_matrix[127:120]); 
GF_ADD ADD12(in_matrix[127:120], multi2[119:112], multi3[111:104], in_matrix[103:96], out_matrix[119:112]); 
GF_ADD ADD13(in_matrix[127:120], in_matrix[119:112], multi2[111:104], multi3[103:96], out_matrix[111:104]); 
GF_ADD ADD14(multi3[127:120], in_matrix[119:112], in_matrix[111:104], multi2[103:96], out_matrix[103:96]); 

// 2번 행 계산
GF_multi2 A21(in_matrix[95:88], multi2[95:88]);
GF_multi2 A22(in_matrix[87:80], multi2[87:80]);
GF_multi2 A23(in_matrix[79:72], multi2[79:72]);
GF_multi2 A24(in_matrix[71:64], multi2[71:64]);

GF_multi3 B21(in_matrix[95:88], multi3[95:88]);
GF_multi3 B22(in_matrix[87:80], multi3[87:80]);
GF_multi3 B23(in_matrix[79:72], multi3[79:72]);
GF_multi3 B24(in_matrix[71:64], multi3[71:64]);

GF_ADD ADD21(multi2[95:88], multi3[87:80], in_matrix[79:72], in_matrix[71:64], out_matrix[95:88]);
GF_ADD ADD22(in_matrix[95:88], multi2[87:80], multi3[79:72], in_matrix[71:64], out_matrix[87:80]);
GF_ADD ADD23(in_matrix[95:88], in_matrix[87:80], multi2[79:72], multi3[71:64], out_matrix[79:72]);
GF_ADD ADD24(multi3[95:88], in_matrix[87:80], in_matrix[79:72], multi2[71:64], out_matrix[71:64]);

// 3번 행 계산
GF_multi2 A31(in_matrix[63:56], multi2[63:56]);
GF_multi2 A32(in_matrix[55:48], multi2[55:48]);
GF_multi2 A33(in_matrix[47:40], multi2[47:40]);
GF_multi2 A34(in_matrix[39:32], multi2[39:32]);

GF_multi3 B31(in_matrix[63:56], multi3[63:56]);
GF_multi3 B32(in_matrix[55:48], multi3[55:48]);
GF_multi3 B33(in_matrix[47:40], multi3[47:40]);
GF_multi3 B34(in_matrix[39:32], multi3[39:32]);

GF_ADD ADD31(multi2[63:56], multi3[55:48], in_matrix[47:40], in_matrix[39:32], out_matrix[63:56]);
GF_ADD ADD32(in_matrix[63:56], multi2[55:48], multi3[47:40], in_matrix[39:32], out_matrix[55:48]);
GF_ADD ADD33(in_matrix[63:56], in_matrix[55:48], multi2[47:40], multi3[39:32], out_matrix[47:40]);
GF_ADD ADD34(multi3[63:56], in_matrix[55:48], in_matrix[47:40], multi2[39:32], out_matrix[39:32]);

// 4번 행 계산
GF_multi2 A41(in_matrix[31:24], multi2[31:24]);
GF_multi2 A42(in_matrix[23:16], multi2[23:16]);
GF_multi2 A43(in_matrix[15:8], multi2[15:8]);
GF_multi2 A44(in_matrix[7:0], multi2[7:0]);

GF_multi3 B41(in_matrix[31:24], multi3[31:24]);
GF_multi3 B42(in_matrix[23:16], multi3[23:16]);
GF_multi3 B43(in_matrix[15:8], multi3[15:8]);
GF_multi3 B44(in_matrix[7:0], multi3[7:0]);

GF_ADD ADD41(multi2[31:24], multi3[23:16], in_matrix[15:8], in_matrix[7:0], out_matrix[31:24]);
GF_ADD ADD42(in_matrix[31:24], multi2[23:16], multi2[15:8], in_matrix[7:0], out_matrix[23:16]);
GF_ADD ADD43(in_matrix[31:24], in_matrix[23:16], multi2[15:8], multi3[7:0], out_matrix[15:8]);
GF_ADD ADD44(multi3[31:24], in_matrix[23:16], in_matrix[15:8], multi2[7:0], out_matrix[7:0]);

// matrix 재배열
assign out[127:96] = {out_matrix[127:120], out_matrix[95:88], out_matrix[63:56], out_matrix[31:24]};
assign out[95:64] = {out_matrix[119:112], out_matrix[87:80], out_matrix[55:48], out_matrix[23:16]};
assign out[63:32] = {out_matrix[111:104], out_matrix[79:72], out_matrix[47:40], out_matrix[15:8]};
assign out[31:0] = {out_matrix[103:96], out_matrix[71:64], out_matrix[39:32], out_matrix[7:0]};
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