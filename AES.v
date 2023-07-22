//////////////////////////////////////////////
////        4register pipeline AES        ////
////     Throughput : 512bits/40clocks    ////
//////////////////////////////////////////////
module AES (plaintext, CLK, RST, cypertext, done); 
input CLK, RST; //clock signal, reset signal
input [511:0]plaintext; //512-bit
output reg [127:0]cypertext; //128-bit
output reg done; //done signal

//module wire
wire [127:0] out_addroundkey, out_mux2, in_subbytes;
wire [127:0] initial_key, temp_subbytes, temp_shift, temp_mixcolumn;
wire [127:0] key1, key2, key3, key4, key5, key6, key7, key8, key9, key10;

reg [3:0] state, nextstate, counter;
reg [127:0] roundkey;
wire [127:0] masterkey; 

//register wire
wire [127:0] Q_subbytes, Q_shift1, Q_shift2, Q_mix, Q_out_addroundkey;
wire [127:0] Q_key1, Q_key2, Q_key3, Q_key4;
wire [3:0] Q_round1, Q_round2, Q_round3, Q_round4;

assign masterkey = 128'h1;
// first round
key_expansion key_Ex(masterkey, key1, key2, key3, key4, key5, key6, key7, key8, key9, key10); //generate all round key
AddRoundKey AddRoundKey1(plaintext, masterkey, initial_key);

// State value
parameter [3:0] S_INIT = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011,
                    S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, 
                    S8 = 4'b1000, S9 = 4'b1001, S10 = 4'b1010;

    //FSM controller
    always @(posedge CLK) begin  //Operate in posedge CLOCK, Synchronous RESET
        counter <= counter + 1;
        if (RST) begin //Active High RESET
            state <= S_INIT; counter <= 0;// initial value
        end 
        else if(counter == 'd3) begin 
            state <= nextstate; counter <= 0;//state machine with CLOCK
        end
    end

    //FSM
    always @ (*) begin 
        case (state)
            S_INIT : begin nextstate <= S1; roundkey <= key1; 
                    case(counter) //pipeline controller
                        0 : plaintext = plaintext[511:384];
                        1 : plaintext = plaintext[383:256];
                        2 : plaintext = plaintext[255:128];
                        3 : plaintext = plaintext[127:0];
                    endcase 
                    end
            S1 : begin nextstate <= S2; roundkey <= key2; end
            S2 : begin nextstate <= S3; roundkey <= key3; end
            S3 : begin nextstate <= S4; roundkey <= key4; end
            S4 : begin nextstate <= S5; roundkey <= key5; end
            S5 : begin nextstate <= S6; roundkey <= key6; end
            S6 : begin nextstate <= S7; roundkey <= key7; end
            S7 : begin nextstate <= S8; roundkey <= key8; end
            S8 : begin nextstate <= S9; roundkey <= key9; end
            S9 : begin nextstate <= S10; roundkey <= key10; end
            S10 : begin nextstate <= S_INIT; cypertext <= Q_out_addrounkey; done = 1; end
        endcase
    end
    
// round 1~9
MUX1 multiplexer1(.in1(initial_key), .in2(Q_out_addroundkey), .sel(state), .out(in_subbytes));
subbytes subbytes(.in(in_subbytes), .out(temp_subbytes));

Resgister1 R1(roundkey, temp_subbytes, state, CLK, RST, Q_key1, Q_subbytes, Q_round1); 

shiftrows shiftrows(.in(Q_subbytes), .out(temp_shift));
Resgister1 R2(Q_key1, temp_shift, Q_round1, CLK, RST, Q_key2, Q_shift1, Q_round2); 

mixcolumn mixcolumn(.in(Q_shift1), .out(temp_mixcolumn));
Resgister2 R3(Q_key2, Q_shift1, temp_mixcolumn, Q_round2, CLK, RST, Q_key3, Q_shift2, Q_mix, Q_round3);

MUX2 multiplexer2(.in1(Q_mix), .in2(Q_shift2), .sel(Q_round3), .out(out_mux2));
AddRoundKey addroudnkey(.in1(out_mux2), .in2(Q_key3), .out(out_addroundkey));
Register3 R4(out_addroundkey, CLK, RST, Q_out_addroundkey); 

endmodule

module MUX1 (in1, in2, sel, out); // mux's output == subbytes input
input [127:0] in1, in2; //in1 == initial value //in2 == feedback value 
input [3:0] sel; //select signal(state)
output reg [127:0] out; //multiplexer's output

always @ (in1, in2, sel) begin 
    case (sel) 
        4'b0000 : out = in1; //init state: output <= in1
        default : out = in2; //other state: output <= in2 
    endcase
end
endmodule 

module MUX2 (in1, in2, sel, out); // MUX's output == 2nd addroundkey's input
input [127:0] in1, in2; //in1 == mixcolumn's output //in2 == shift row's output
input [3:0] sel; //select signal(state)
output reg [127:0] out;

always @ (in1, in2, sel) begin
    case (sel) 
        4'b1001 : out = in2; //state1001: output <= in2
        default : out = in1; //other state: output <= in1
    endcase
end
endmodule 

module Resgister1(D_key, D, D_round, CLK, RST, Q_key, Q, Q_round); //260bits register
input CLK, RST;
input [127:0] D_key, D;
input [3:0] D_round;
output reg [127:0] Q_key, Q;
output reg [3:0] Q_round;

always @ (posedge CLK or posedge RST) begin //DFF x260
    if (RST) begin Q <= 128'b0; Q_key <= 128'b0; Q_round <= 4'b0; end //reset
    else begin Q <= D; Q_key <= D_key; Q_round <= D_round; end
end
endmodule

module Resgister2(D_key, D1, D2, D_round, CLK, RST, Q_key, Q1, Q2, Q_round); //388bits register
input CLK, RST;
input [127:0] D_key, D1, D2;
input [3:0] D_round;
output reg [127:0] Q_key, Q1, Q2;
output reg [3:0] Q_round;

always @ (posedge CLK or posedge RST) begin //DFF x388
    if (RST) begin Q1 <= 128'b0; Q2 <= 128'b0; Q_key <= 128'b0; Q_round <= 4'b0; end //reset
    else begin Q1 <= D1; Q2 <= D2; Q_key <= D_key; Q_round <= D_round; end
end
endmodule

module Register3(D, CLK, RST, Q); //128bits register
input [127:0] D;
input CLK, RST;
output reg [127:0] Q;

always @(posedge CLK) begin //DFF x128
    if(RST) Q <= 128'b0; //reset
    else Q <= D;
end
endmodule

