module MISTRAL_MAC18X19(A, B, Y);

parameter A_SIGNED = 0;
parameter B_SIGNED = 0;
parameter A_WIDTH = 18;
parameter B_WIDTH = 19;
parameter Y_WIDTH = 37;

input [A_WIDTH-1:0] A;
input [B_WIDTH-1:0] B;
input [Y_WIDTH-1:0] Y;

if (B_SIGNED !== 1) begin
    $error("input B must be signed");
end

assign Y = $signed(A) * $signed(B);

endmodule
