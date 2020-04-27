`ifdef cyclonev
`define LCELL cyclonev_lcell_comb
`define MAC cyclonev_mac
`endif
`ifdef cyclone10gx
`define LCELL cyclone10gx_lcell_comb
`define MAC cyclone10gx_mac
`endif

module __MISTRAL_VCC(output Q);

MISTRAL_ALUT2 #(.LUT(4'b1111)) _TECHMAP_REPLACE_ (.A(1'b1), .B(1'b1), .Q(Q));

endmodule


module __MISTRAL_GND(output Q);

MISTRAL_ALUT2 #(.LUT(4'b0000)) _TECHMAP_REPLACE_ (.A(1'b1), .B(1'b1), .Q(Q));

endmodule


module MISTRAL_FF(input DATAIN, CLK, ACLR, ENA, SCLR, SLOAD, SDATA, output reg Q);

dffeas #(.power_up("low"), .is_wysiwyg("true")) _TECHMAP_REPLACE_ (.d(DATAIN), .clk(CLK), .clrn(ACLR), .ena(ENA), .sclr(SCLR), .sload(SLOAD), .asdata(SDATA), .q(Q));

endmodule


module MISTRAL_ALUT6(input A, B, C, D, E, F, output Q);
parameter [63:0] LUT = 64'h0000_0000_0000_0000;

`LCELL #(.lut_mask(LUT)) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .datac(C), .datad(D), .datae(E), .dataf(F), .combout(Q));

endmodule


module MISTRAL_ALUT5(input A, B, C, D, E, output Q);
parameter [31:0] LUT = 32'h0000_0000;

`LCELL #(.lut_mask({2{LUT}})) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .datac(C), .datad(D), .datae(E), .combout(Q));

endmodule


module MISTRAL_ALUT4(input A, B, C, D, output Q);
parameter [15:0] LUT = 16'h0000;

`LCELL #(.lut_mask({4{LUT}})) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .datac(C), .datad(D), .combout(Q));

endmodule


module MISTRAL_ALUT3(input A, B, C, output Q);
parameter [7:0] LUT = 8'h00;

`LCELL #(.lut_mask({8{LUT}})) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .datac(C), .combout(Q));

endmodule


module MISTRAL_ALUT2(input A, B, output Q);
parameter [3:0] LUT = 4'h0;

`LCELL #(.lut_mask({16{LUT}})) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .combout(Q));

endmodule


module MISTRAL_NOT(input A, output Q);

NOT _TECHMAP_REPLACE_ (.IN(A), .OUT(Q));

endmodule


module MISTRAL_ALUT_ARITH(input A, B, C, D0, D1, CI, output SO, CO);
parameter LUT0 = 16'h0000;
parameter LUT1 = 16'h0000;

`LCELL #(.lut_mask({16'h0, LUT1, 16'h0, LUT0})) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .datac(C), .datad(D0), .dataf(D1), .cin(CI), .sumout(SO), .cout(CO));

endmodule


module MISTRAL_MUL27X27(A, B, Y);

parameter A_SIGNED = 0;
parameter B_SIGNED = 1;
parameter A_WIDTH = 27;
parameter B_WIDTH = 27;
parameter Y_WIDTH = 54;

input [A_WIDTH-1:0] A;
input [B_WIDTH-1:0] B;
output [Y_WIDTH-1:0] Y;

`MAC #(.ax_width(A_WIDTH), .ay_scan_in_width(B_WIDTH), .result_a_width(Y_WIDTH), .operation_mode("M27x27")) _TECHMAP_REPLACE_ (.ax(A), .ay(B), .resulta(Y));

endmodule


module MISTRAL_MUL18X18(A, B, Y);

parameter A_SIGNED = 0;
parameter B_SIGNED = 1;
parameter A_WIDTH = 18;
parameter B_WIDTH = 19;
parameter Y_WIDTH = 37;

input [A_WIDTH-1:0] A;
input [B_WIDTH-1:0] B;
output [Y_WIDTH-1:0] Y;

`MAC #(.ax_width(B_WIDTH), .ay_scan_in_width(A_WIDTH), .result_a_width(Y_WIDTH), .operation_mode("M18x18_FULL")) _TECHMAP_REPLACE_ (.ax(B), .ay(A), .resulta(Y));

endmodule


module MISTRAL_MUL9X9(A, B, Y);

parameter A_SIGNED = 0;
parameter B_SIGNED = 1;
parameter A_WIDTH = 9;
parameter B_WIDTH = 9;
parameter Y_WIDTH = 18;

input [A_WIDTH-1:0] A;
input [B_WIDTH-1:0] B;
output [Y_WIDTH-1:0] Y;

`MAC #(.ax_width(A_WIDTH), .ay_scan_in_width(B_WIDTH), .result_a_width(Y_WIDTH), .operation_mode("M9x9")) _TECHMAP_REPLACE_ (.ax(A), .ay(B), .resulta(Y));

endmodule
