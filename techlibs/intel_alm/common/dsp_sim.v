(* abc9_box, lib_whitebox *)
module MISTRAL_MUL27x27(A, B, Y);

parameter A_SIGNED = 0;
parameter B_SIGNED = 1;
parameter A_WIDTH = 27;
parameter B_WIDTH = 27;
parameter Y_WIDTH = 54;

input [A_WIDTH-1:0] A;
input [B_WIDTH-1:0] B;
output [Y_WIDTH-1:0] Y;

specify
    (A *> Y) = 4057;
    (B *> Y) = 4057;
endspecify

if (B_SIGNED !== 1) begin
    $error("input B must be signed");
end

if (A_WIDTH > 27) begin
    $error("input A is wider than 27 bits");
end

if (B_WIDTH > 27) begin
    $error("input B is wider than 27 bits");
end

assign Y = $signed(A) * $signed(B);

endmodule

(* abc9_box, lib_whitebox *)
module MISTRAL_MUL18X18(A, B, Y);

parameter A_SIGNED = 0;
parameter B_SIGNED = 1;
parameter A_WIDTH = 18;
parameter B_WIDTH = 18;
parameter Y_WIDTH = 37;

input [A_WIDTH-1:0] A;
input [B_WIDTH-1:0] B;
output [Y_WIDTH-1:0] Y;

localparam A_EXTEND = Y_WIDTH - A_WIDTH;
localparam B_EXTEND = Y_WIDTH - B_WIDTH;

specify
    (A *> Y) = 4057;
    (B *> Y) = 4057;
endspecify

if (B_SIGNED !== 1) begin
    $error("input B must be signed");
end

if (A_WIDTH > 18) begin
    $error("input A is wider than 18 bits");
end

if (B_WIDTH > 18) begin
    $error("input B is wider than 18 bits");
end

assign Y = $signed(A) * $signed(B);

endmodule

(* abc9_box, lib_whitebox *)
module MISTRAL_MUL9X9(A, B, Y);

parameter A_SIGNED = 0;
parameter B_SIGNED = 1;
parameter A_WIDTH = 9;
parameter B_WIDTH = 9;
parameter Y_WIDTH = 18;

input [A_WIDTH-1:0] A;
input [B_WIDTH-1:0] B;
output [Y_WIDTH-1:0] Y;

specify
    (A *> Y) = 4057;
    (B *> Y) = 4057;
endspecify

if (B_SIGNED !== 1) begin
    $error("input B must be signed");
end

if (A_WIDTH > 9) begin
    $error("input A is wider than 9 bits");
end

if (B_WIDTH > 9) begin
    $error("input B is wider than 9 bits");
end

assign Y = $signed(A) * $signed(B);

endmodule
