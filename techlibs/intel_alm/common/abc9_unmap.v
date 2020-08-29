// After performing sequential synthesis, map the synchronous flops back to
// standard MISTRAL_FF flops.

module $__MISTRAL_FF_SYNCONLY (
    input DATAIN, CLK, ENA, SCLR, SLOAD, SDATA,
    output reg Q
);

MISTRAL_FF _TECHMAP_REPLACE_ (.DATAIN(DATAIN), .CLK(CLK), .ACLR(1'b1), .ENA(ENA), .SCLR(SCLR), .SLOAD(SLOAD), .SDATA(SDATA), .Q(Q));

endmodule

module $__MISTRAL_MUL27X27U (input [26:0] A, input [26:0] B, output [53:0] Y);

MISTRAL_MUL27X27 #(.A_SIGNED(0), .B_SIGNED(0)) _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));

endmodule

(* abc9_box *)
module $__MISTRAL_MUL27X27S (input [26:0] A, input [26:0] B, output [53:0] Y);

MISTRAL_MUL27X27 #(.A_SIGNED(1), .B_SIGNED(1)) _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));

endmodule

(* abc9_box *)
module $__MISTRAL_MUL18X18U (input [17:0] A, input [17:0] B, output [35:0] Y);

MISTRAL_MUL18X18 #(.A_SIGNED(0), .B_SIGNED(0)) _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));

endmodule

(* abc9_box *)
module $__MISTRAL_MUL18X18S (input [17:0] A, input [17:0] B, output [35:0] Y);

MISTRAL_MUL18X18 #(.A_SIGNED(1), .B_SIGNED(1)) _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));

endmodule

(* abc9_box *)
module $__MISTRAL_MUL9X9U (input [8:0] A, input [8:0] B, output [17:0] Y);

MISTRAL_MUL9X9 #(.A_SIGNED(0), .B_SIGNED(0)) _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));

endmodule

(* abc9_box *)
module $__MISTRAL_MUL9X9S (input [8:0] A, input [8:0] B, output [17:0] Y);

MISTRAL_MUL9X9 #(.A_SIGNED(1), .B_SIGNED(1)) _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));

endmodule
