// This is a purely-synchronous flop, that ABC9 can use for sequential synthesis.
(* abc9_flop, lib_whitebox *)
module $__MISTRAL_FF_SYNCONLY (
    input DATAIN, CLK, ENA, SCLR, SLOAD, SDATA,
    output reg Q
);

MISTRAL_FF ff (.DATAIN(DATAIN), .CLK(CLK), .ENA(ENA), .ACLR(1'b1), .SCLR(SCLR), .SLOAD(SLOAD), .SDATA(SDATA), .Q(Q));

endmodule

(* abc9_box *)
module $__MISTRAL_MUL27X27U (input [26:0] A, input [26:0] B, output [53:0] Y);

specify
    (A *> Y) = 3732;
    (B *> Y) = 3928;
endspecify

assign Y = $unsigned(A) * $unsigned(B);

endmodule

(* abc9_box *)
module $__MISTRAL_MUL27X27S (input [26:0] A, input [26:0] B, output [53:0] Y);

specify
    (A *> Y) = 3732;
    (B *> Y) = 3928;
endspecify

assign Y = $signed(A) * $signed(B);

endmodule

(* abc9_box *)
module $__MISTRAL_MUL18X18U (input [17:0] A, input [17:0] B, output [35:0] Y);

specify
    (A *> Y) = 3180;
    (B *> Y) = 3982;
endspecify

assign Y = $unsigned(A) * $unsigned(B);

endmodule

(* abc9_box *)
module $__MISTRAL_MUL18X18S (input [17:0] A, input [17:0] B, output [35:0] Y);

specify
    (A *> Y) = 3180;
    (B *> Y) = 3982;
endspecify

assign Y = $signed(A) * $signed(B);

endmodule

(* abc9_box *)
module $__MISTRAL_MUL9X9U (input [8:0] A, input [8:0] B, output [17:0] Y);

specify
    (A *> Y) = 2818;
    (B *> Y) = 3051;
endspecify

assign Y = $unsigned(A) * $unsigned(B);

endmodule

(* abc9_box *)
module $__MISTRAL_MUL9X9S (input [8:0] A, input [8:0] B, output [17:0] Y);

specify
    (A *> Y) = 2818;
    (B *> Y) = 3051;
endspecify

assign Y = $signed(A) * $signed(B);

endmodule
