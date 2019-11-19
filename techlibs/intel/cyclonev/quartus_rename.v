module MISTRAL_ALM6(input A, B, C, D, E, F, output Q);
parameter LUT = 64'h0000_0000_0000_0000;

cyclonev_lcell_comb #(.lut_mask(LUT)) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .datac(C), .datad(D), .datae(E), .dataf(F), .combout(Q));

endmodule


module MISTRAL_ALM5(input A, B, C, D, E, output Q);
parameter LUT = 32'h0000_0000;

cyclonev_lcell_comb #(.lut_mask({2{LUT}})) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .datac(C), .datad(D), .datae(E), .combout(Q));

endmodule


module MISTRAL_ALM4(input A, B, C, D, output Q);
parameter LUT = 16'h0000;

cyclonev_lcell_comb #(.lut_mask({4{LUT}})) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .datac(C), .datad(D), .combout(Q));

endmodule


module MISTRAL_ALM3(input A, B, C, output Q);
parameter LUT = 8'h00;

cyclonev_lcell_comb #(.lut_mask({8{LUT}})) _TECHMAP_REPLACE_ (.dataa(A), .datab(B), .datac(C), .combout(Q));

endmodule


module MISTRAL_NOT(input A, output Q);

assign Q = ~A;
//cyclonev_lcell_comb #(.lut_mask(64'hFF00_FF00_FF00_FF00)) _TECHMAP_REPLACE_ (.dataa(A), .combout(Q));

endmodule
