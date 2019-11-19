`default_nettype none

module MISTRAL_ALM6(input A, B, C, D, E, F, output Q);

parameter [63:0] LUT = 64'h0000_0000_0000_0000;

wire [31:0] s5 = F ? LUT[63:32] : LUT[31:0];
wire [15:0] s4 = E ? s5[31:16]  : s5[15:0];
wire  [7:0] s3 = D ? s4[15:8]   : s4[7:0];
wire  [3:0] s2 = C ? s3[7:4]    : s3[3:0];
wire  [1:0] s1 = B ? s2[3:2]    : s2[1:0];
assign       Q = A ? s1[1]      : s1[0];

endmodule


module MISTRAL_ALM5(input A, B, C, D, E, output Q);

parameter [31:0] LUT = 32'h0000_0000;

wire [15:0] s4 = E ? LUT[31:16] : LUT[15:0];
wire  [7:0] s3 = D ? s4[15:8]   : s4[7:0];
wire  [3:0] s2 = C ? s3[7:4]    : s3[3:0];
wire  [1:0] s1 = B ? s2[3:2]    : s2[1:0];
assign       Q = A ? s1[1]      : s1[0];

endmodule


module MISTRAL_ALM4(input A, B, C, D, output Q);

parameter [15:0] LUT = 16'h0000;

wire [7:0] s3 = D ? LUT[15:8]   : LUT[7:0];
wire [3:0] s2 = C ? s3[7:4]     : s3[3:0];
wire [1:0] s1 = B ? s2[3:2]     : s2[1:0];
assign      Q = A ? s1[1]       : s1[0];

endmodule


module MISTRAL_ALM3(input A, B, C, output Q);

parameter [7:0] LUT = 8'h0000;

wire [3:0] s2 = C ? LUT[7:4]    : LUT[3:0];
wire [1:0] s1 = B ? s2[3:2]     : s2[1:0];
assign      Q = A ? s1[1]       : s1[0];

endmodule