module rcon(key, round, rkey);
    
    input [31:0] key;
    input [3:0] round;
    output [31:0] rkey;
    
    wire [31:0] temp;
    reg [31:0] rcon;
    reg [31:0] r_rkey;
    
    Decoder R1(round, temp);
    always @(*) begin
        rcon = temp;
        r_rkey = key ^ rcon;
    end
    
    assign rkey = r_rkey;

endmodule

module Decoder(round , rcon);

    input [3:0] round;
    output [31:0] rcon;
    
    reg [31:0] result;
    
    parameter fist_round = {8'h01, 24'h0};
    parameter second_round = {8'h02, 24'h0};
    parameter third_round = {8'h04, 24'h0};
    parameter fourth_round = {8'h08, 24'h0};
    parameter fifth_round = {8'h10, 24'h0};
    parameter sixth_round = {8'h20, 24'h0};
    parameter seventh_round = {8'h40, 24'h0};
    parameter eighth_round = {8'h80, 24'h0};
    parameter ninth_round = {8'h1b, 24'h0};
    parameter tenth_round = {8'h36, 24'h0};
    
    always @(*) begin
        case(round)
            4'b0001: result = fist_round;
            4'b0010: result = second_round;
            4'b0011: result = third_round;
            4'b0100: result = fourth_round;
            4'b0101: result = fifth_round;
            4'b0110: result = sixth_round;
            4'b0111: result = seventh_round;
            4'b1000: result = eighth_round;
            4'b1001: result = ninth_round;
            4'b1010: result = tenth_round;
        endcase
    end
    
    assign rcon = result;
endmodule
