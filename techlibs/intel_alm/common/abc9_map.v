// Map purely-synchronous flops to ABC9 flops, while 
// mapping flops with asynchronous-clear as boxes, this is because ABC9 
// doesn't support asynchronous-clear flops in sequential synthesis.
module MISTRAL_FF(
    input DATAIN, CLK, ACLR, ENA, SCLR, SLOAD, SDATA,
    output reg Q
);

parameter _TECHMAP_CONSTMSK_ACLR_ = 1'b0;

// If the async-clear is constant, we assume it's disabled.
if (_TECHMAP_CONSTMSK_ACLR_ != 1'b0)
    $__MISTRAL_FF_SYNCONLY _TECHMAP_REPLACE_ (.DATAIN(DATAIN), .CLK(CLK), .ENA(ENA), .SCLR(SCLR), .SLOAD(SLOAD), .SDATA(SDATA), .Q(Q));
else
    wire _TECHMAP_FAIL_ = 1;

endmodule

// Map parametrically-signed multipliers to fixed signed/unsigned multipliers.
module MISTRAL_MUL27X27(input [26:0] A, input [26:0] B, output [53:0] Y);

parameter A_SIGNED = 1;
parameter B_SIGNED = 1;

if (A_SIGNED || B_SIGNED)
    $__MISTRAL_MUL27X27S _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));
else
    $__MISTRAL_MUL27X27U _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));

endmodule

module MISTRAL_MUL18X18(input [17:0] A, input [17:0] B, output [35:0] Y);

parameter A_SIGNED = 1;
parameter B_SIGNED = 1;

if (A_SIGNED || B_SIGNED)
    $__MISTRAL_MUL18X18S _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));
else
    $__MISTRAL_MUL18X18U _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));

endmodule

module MISTRAL_MUL9X9(input [8:0] A, input [8:0] B, output [17:0] Y);

parameter A_SIGNED = 1;
parameter B_SIGNED = 1;

if (A_SIGNED || B_SIGNED)
    $__MISTRAL_MUL9X9S _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));
else
    $__MISTRAL_MUL9X9U _TECHMAP_REPLACE_ (.A(A), .B(B), .Y(Y));

endmodule
