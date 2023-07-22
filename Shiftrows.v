module shiftrows (
    input [127:0] in,
    output [127:0] out
);

    // First Row is maintained
    assign out[127:96] = in[127:96];

    // Second ROw is shifted one block
    assign out[95:88] = in[71:64];
    assign out[87:80] = in[95:88];
    assign out[79:72] = in[87:80];
    assign out[71:64] = in[79:72];

    // Third Row is shifted two block
    assign out[63:56] = in[47:40];
    assign out[55:48] = in[39:32];
    assign out[47:40] = in[63:56];
    assign out[39:32] = in[55:48];

    // Fourth Row is shifted three block.
    assign out[31:24] = in[23:16];
    assign out[23:16] = in[15:8];
    assign out[15:8] = in[7:0];
    assign out[7:0] = in[31:24];

endmodule