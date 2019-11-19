module \$lut (A, Y);

parameter WIDTH = 1;
parameter LUT = 0;

input [WIDTH-1:0] A;
output Y;

generate
    if (WIDTH == 1) begin
        MISTRAL_NOT _TECHMAP_REPLACE_(
            .A(A[0]), .Q(Y)
        );
    end else
    if (WIDTH == 2) begin
        localparam LUT8 = {{4{LUT[1]}}, {4{LUT[0]}}};
        MISTRAL_ALM3 #(.LUT(LUT8)) _TECHMAP_REPLACE_(
            .A(A[1]), .B(A[0]), .C(1'b1), .Q(Y)
        );
    end else
    if (WIDTH == 3) begin
        MISTRAL_ALM3 #(.LUT(LUT)) _TECHMAP_REPLACE_(
            .A(A[2]), .B(A[1]), .C(A[0]), .Q(Y)
        );
    end else
    if (WIDTH == 4) begin
        MISTRAL_ALM4 #(.LUT(LUT)) _TECHMAP_REPLACE_(
            .A(A[3]), .B(A[2]), .C(A[1]), .D(A[0]), .Q(Y)
        );
    end else
    if (WIDTH == 5) begin
        MISTRAL_ALM5 #(.LUT(LUT)) _TECHMAP_REPLACE_ (
            .A(A[4]), .B(A[3]), .C(A[2]), .D(A[1]), .E(A[0]), .Q(Y)
        );
    end else
    if (WIDTH == 6) begin
        MISTRAL_ALM6 #(.LUT(LUT)) _TECHMAP_REPLACE_ (
            .A(A[5]), .B(A[4]), .C(A[3]), .D(A[2]), .E(A[1]), .F(A[0]), .Q(Y)
        );
    end else begin
        wire _TECHMAP_FAIL_ = 1'b1;
    end
endgenerate
endmodule
