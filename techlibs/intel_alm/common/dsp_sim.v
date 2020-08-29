// The DSP slices in the Cyclone V/10 GX are highly flexible, supporting a wide
// range of multiplication operand sizes, pre-adders, and a 64-bit accumulator
// that can be chained through multiple slices.
//
// Operand sizes
// -------------
// A DSP slice can implement:
// - M27X27: one 27x27-bit multiplier, with a 26-bit signed pre-adder, and 64-bit
//   post-adder.
// - M18X18_FULL: two independent 18x18-bit multipliers, each with an 18-bit
//   signed pre-adder and 37-bit post-adder.
// - M18X18_SUMOF2: two independent 18x18-bit multipliers added together to
//   produce a 38-bit result.
// - M18X18_PLUS36: one 18x18-bit multiplier added to a 36-bit input value.
// - M18X18_SYSTOLIC: two independent 18x18-bit multipliers, added together, then
//   added to a 44-bit chain input.
// - M9X9: three independent 9x9-bit multipliers, each with 18-bit post-adder
//   (not available in Cyclone 10 GX).
//
// Note that all operands must be signed, so zero bits must be added to the most
// significant bits of unsigned values to get the right result.
//
// M27X27
// ------
// 27x27 mode is aimed at floating-point multiplication, since one 27x27 covers
// the mantissa of an IEEE754 single-precision float (24 bits), and a double-
// precision float has a 54-bit mantissa that can be broken up into 27x27 chunks
// easily. It can of course be used for integer multiplication, but since humans
// prefer power-of-two width integers, those generally use M18X18 mode instead.
//
// M27X27 mode is represented with a MISTRAL_MUL27X27 cell, although pre-adders
// and post-adders are not presently implemented due to needing a new Yosys pass
// to merge them into the cells.
//
// M18X18_FULL
// -----------
// 18x18 mode is aimed at integer multiplication, since a 16-bit integer fits
// neatly inside, and humans like power-of-two integers. Fixed-point multiplication
// will probably also use this mode.
//
// M18X18_FULL mode is represented with a MISTRAL_MUL18X18 cell. The caveat about
// Yosys not supporting pre/post adders in M27x27 applies here too.
//
// M18X18_SUMOF2
// -------------
// (18x18)+(18x18) mode is aimed at complex math. The documentation gives:
// (a + bi) x (c + di) = ((a x c) - (b x d)) + ((a x d) + (b x c))i
// which can be implemented in terms of two M18X18_SUMOF2 DSP slices.
//
// M18X18_SUMOF2 mode is not currently implemented in Yosys. The merge pass
// mentioned earlier could recognise the pattern of two M18X18_FULL cells added
// together and merge them into this mode.
//
// M18X18_PLUS36
// -------------
// (18x18)+36 mode implements fused multiply-adds, using the internal adder in
// the DSP block instead of a slower external carry chain.
//
// M18X18_PLUS36 mode is not currently implemented in Yosys. This seems like
// an important mode to recognise, but would require the merge pass mentioned above.
//
// M18X18_SYSTOLIC
// ---------------
// 18x18 systolic mode is aimed at systolic arrays of multipliers chained together.
// Finite impulse response filters are given as an example in the documentation.
//
// M18X18_SYSTOLIC mode is not currently implemented in Yosys, and it doesn't seem
// very easy to infer, but maybe I can figure a way or have IP blocks instantiate it.
//
// M9X9
// ----
// 9x9 mode is aimed at multiplying bytes, and so is the fastest and uses the
// least area of the mode.
//
// 9x9 mode was removed in the 10 series (Cyclone 10GX, Arria 10, Stratix 10),
// but reappears in the Agilex chip with AI applications in mind. (That's some
// way off support in Yosys, though.)
//
// M9X9 mode is represented with a MISTRAL_M9X9 cell. The caveat about Yosys not
// supporting pre/post adders in M27x27 applies here too.

(* abc9_box *)
module MISTRAL_MUL27X27(input [26:0] A, input [26:0] B, output [53:0] Y);

parameter A_SIGNED = 1;
parameter B_SIGNED = 1;

// TODO: Cyclone 10 GX timings; the below are for Cyclone V
specify
    (A *> Y) = 3732;
    (B *> Y) = 3928;
endspecify

wire [53:0] A_, B_;

if (A_SIGNED)
    assign A_ = $signed(A);
else
    assign A_ = $unsigned(A);

if (B_SIGNED)
    assign B_ = $signed(B);
else
    assign B_ = $unsigned(B);

assign Y = A_ * B_;

endmodule

(* abc9_box *)
module MISTRAL_MUL18X18(input [17:0] A, input [17:0] B, output [35:0] Y);

parameter A_SIGNED = 1;
parameter B_SIGNED = 1;

// TODO: Cyclone 10 GX timings; the below are for Cyclone V
specify
    (A *> Y) = 3180;
    (B *> Y) = 3982;
endspecify

wire [35:0] A_, B_;

if (A_SIGNED)
    assign A_ = $signed(A);
else
    assign A_ = $unsigned(A);

if (B_SIGNED)
    assign B_ = $signed(B);
else
    assign B_ = $unsigned(B);

assign Y = A_ * B_;

endmodule

(* abc9_box *)
module MISTRAL_MUL9X9(input [8:0] A, input [8:0] B, output [17:0] Y);

parameter A_SIGNED = 1;
parameter B_SIGNED = 1;

// TODO: Cyclone 10 GX timings; the below are for Cyclone V
specify
    (A *> Y) = 2818;
    (B *> Y) = 3051;
endspecify

wire [17:0] A_, B_;

if (A_SIGNED)
    assign A_ = $signed(A);
else
    assign A_ = $unsigned(A);

if (B_SIGNED)
    assign B_ = $signed(B);
else
    assign B_ = $unsigned(B);

assign Y = A_ * B_;

endmodule
