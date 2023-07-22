module InvAES (CLK, RST, led);
input CLK, RST;
output [3:0] led;
wire[127:0]plaintext;
wire [127:0]cypertext;

wire [127:0] out_addroundkey, out_mux2, in_shift;
wire [127:0] initial_key, temp_subbytes, temp_shift, temp_mixcolumn, temp_AR, out_mux2;
wire [127:0] key1, key2, key3, key4, key5, key6, key7, key8, key9, key10;
wire [127:0] Q_AR, Q_mix;
reg [3:0] state, nextstate, counter;
reg [127:0] roundkey;
wire [127:0] masterkey; 
wire [127:0] Q_subbytes, Q_shift, Q_mix, Q_AR1, Q_AR2, Q_mux2;
wire [127:0] Q_key1, Q_key2, Q_key3, Q_key4;
wire [3:0] Q_round1, Q_round2, Q_round3, Q_round4;

integer i = 0, j = 0;
wire clk;
ClockDivider u1(.clk_in(CLK), .clk_out(clk));
assign masterkey = 128'h1;
assign cypertext = 128'h936e8722476107bc0420fec84c77478a;
// first round
key_expansion key_Ex(masterkey, key1, key2, key3, key4, key5, key6, key7, key8, key9, key10); //generate all round key
AddRoundKey AddRoundKey1(cypertext, key10, initial_key);

// State value
parameter [3:0] S_INIT = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011,
                    S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, 
                    S8 = 4'b1000, S9 = 4'b1001, S10 = 4'b1010;


    always @(posedge CLK) begin  //Operate in posedge CLOCK, posedge RESET
        counter <= counter + 1;
        if (i == 0) begin state <= S_INIT; i = i + 1; counter <= 0; end
        else if (RST) begin //Active High RESET
            state <= S_INIT; counter <= 0;// initial value
        end 
        else if(counter == 'd3) begin 
            state <= nextstate; counter <= 0; //state maching with CLOCK
        end
    end

    always @ (*) begin 
        case (state)
            S_INIT : begin nextstate <= S1; roundkey <= key9; end
            S1 : begin nextstate <= S2; roundkey <= key8; end
            S2 : begin nextstate <= S3; roundkey <= key7; end
            S3 : begin nextstate <= S4; roundkey <= key6; end
            S4 : begin nextstate <= S5; roundkey <= key5; end
            S5 : begin nextstate <= S6; roundkey <= key4; end
            S6 : begin nextstate <= S7; roundkey <= key3; end
            S7 : begin nextstate <= S8; roundkey <= key2; end
            S8 : begin nextstate <= S9; roundkey <= key1; end
            S9 : begin nextstate <= S10; roundkey <= masterkey; end
            S10 : begin nextstate <= S_INIT; end
        endcase
    end

always @ (*) begin
    reg_addroundkey = out_addroundkey;
    if ((reg_addroundkey ==  128'h1) && (state == 4'd10) && (j == 1)) begin cypertext = out_addroundkey; j = j + 1; end
    if (RST) begin //Active High RESET
            j=1; // initial value
            cypertext = 128'b0;
        end
end
// round 1~9
INVMUX1 IMX1(.in1(initial_key), .in2(Q_mux2), .sel(state), .out(in_shift));

Inv_shiftrows inv_shiftrows(.in(in_shift), .out(temp_shift));
Resgister1 R1(roundkey, temp_shift, state, CLK, RST, Q_key1, Q_shift, Q_round1);

Inv_subbytes inv_subbytes(.in(Q_shift), .out(temp_subbytes));
AddRoundKey addroudnkey(.in1(temp_subbytes), .in2(Q_key1), .out(temp_AR));
Register2 R2(temp_AR, Q_round1, CLK, RST, Q_AR1, Q_round2);

Inv_mixcolumn inv_mixcolumn(.in(temp_AR), .out(temp_mixcolumn));
Resgister1 R3(Q_AR1, temp_mixcolumn, Q_round2, CLK, RST, Q_AR2, Q_mix, Q_round3);

INVMUX2 IMX2(.in1(Q_mix), .in2(Q_AR2), .sel(Q_round3), .out(out_mux2));
Register3 R4(out_mux2, CLK, RST, Q_mux2);
assign plaintext = out_mux2;

endmodule

module INVMUX1 (in1, in2, sel, out); // subbytes에 들어갈 입력 정하는 MUX
input [127:0] in1, in2; //in1 == initial value, in2 == 라운드 돌고온 입력 
input [3:0] sel;
output reg [127:0] out;

always @ (in1, in2, sel) begin
    case (sel) 
        4'b0000 : out = in1;
        default : out = in2;
    endcase
end
endmodule 

module INVMUX2 (in1, in2, sel, out); // 마지막 add roundkey에 들어갈 MUX
input [127:0] in1, in2; //in2 == shift rows에서 나온 출력
input [3:0] sel;
output reg [127:0] out;

always @ (in1, in2, sel) begin
    case (sel) 
        4'b1010 : out = in2; 
        default : out = in1;
    endcase
end
endmodule 


module Resgister1(D_key, D, D_round, CLK, RST, Q_key, Q, Q_round); //260bit register
input CLK, RST;
input [127:0] D_key, D;
input [3:0] D_round;
output reg [127:0] Q_key, Q;
output reg [3:0] Q_round;

always @ (posedge CLK) begin
    if (RST) begin Q <= 128'b0; Q_key <= 128'b0; Q_round <= 4'b0; end
    else begin Q <= D; Q_key <= D_key; Q_round <= D_round; end
end
endmodule

module Register2(D, D_round, CLK, RST, Q, Q_round); //132bit reg
input [127:0] D, D_round;
input CLK, RST;
output reg [127:0] Q, Q_round;

always @(posedge CLK) begin
    if(RST) begin Q <= 128'b0; Q_round <= 4'b0; end
    else begin Q <= D; Q_round <= D_round; end
end
endmodule


module Register3(D, CLK, RST, Q); //128bit reg
input [127:0] D;
input CLK, RST;
output reg [127:0] Q;

always @(posedge CLK) begin
    if(RST) begin Q <= 128'b0; end
    else begin Q <= D; end
end
endmodule