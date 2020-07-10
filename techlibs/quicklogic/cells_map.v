module \$lut (A, Y);
    parameter WIDTH = 0;
    parameter LUT = 0;

    input [WIDTH-1:0] A;
    output Y;

    function [WIDTH ** 2 - 1:0] INIT_address_inverse;
        input [WIDTH ** 2 - 1: 0] arr;
        integer i;
        integer n;
        reg [WIDTH - 1:0] tmp;
        reg [WIDTH - 1:0] tmp2;
        tmp = 0;
        tmp2 = 0;
        for (i = 0; i < WIDTH ** 2; i++) begin
            INIT_address_inverse[tmp2] = arr[tmp];
            tmp = tmp + 1;
            for (n = 0; n < WIDTH; n++) begin
                tmp2[WIDTH - 1 - n] = tmp[n];
            end
        end
    endfunction

    generate
        if (WIDTH == 1)
        begin
            LUT1 #(.INIT(INIT_address_inverse(LUT))) _TECHMAP_REPLACE_ (.O(Y), .I0(A[0]));
        end
        else if (WIDTH == 2)
        begin
            LUT2 #(.INIT(INIT_address_inverse(LUT))) _TECHMAP_REPLACE_ (.O(Y), .I0(A[1]), .I1(A[0]));
        end
        else if (WIDTH == 3)
        begin
            LUT3 #(.INIT(INIT_address_inverse(LUT))) _TECHMAP_REPLACE_ (.O(Y), .I0(A[2]), .I1(A[1]), .I2(A[0]));
        end
        else if (WIDTH == 4)
        begin
            LUT4 #(.INIT(INIT_address_inverse(LUT))) _TECHMAP_REPLACE_ (.O(Y), .I0(A[3]), .I1(A[2]), .I2(A[1]), .I3(A[0]));
        end
        else
        begin
            wire _TECHMAP_FAIL_ = 1;
        end
    endgenerate
endmodule

module \$_DLATCH_P_ (E, D, Q);
    input E;
    input D;
    output reg Q;
    LUT3 #(.INIT(8'b11100010)) latchimpl (.O(Q), .I2(D), .I1(E), .I0(Q));
endmodule

module \$_DLATCH_N_ (E, D, Q);
    input E;
    input D;
    output reg Q;
    LUT3 #(.INIT(8'b10111000)) latchimpl (.O(Q), .I2(D), .I1(E), .I0(Q));
endmodule

module \$_DLATCHSR_NNN_ (E, S, R, D, Q);
    input E;
    input S;
    input R;
    input D;
    output Q;
    wire SEDQ;
    LUT4 #(.INIT(16'b101011001111111)) sedqlut (.O(SEDQ), .I3(S), .I2(E), .I1(D), .I0(Q));
    LUT2 #(.INIT(4'b1000)) sedr (.O(Q), .I1(R), .I0(SEDQ));
endmodule

module \$_DLATCHSR_NNP_ (E, S, R, D, Q);
    input E;
    input S;
    input R;
    input D;
    output Q;
    wire SEDQ;
    LUT4 #(.INIT(16'b101011001111111)) sedqlut (.O(SEDQ), .I3(S), .I2(E), .I1(D), .I0(Q));
    LUT2 #(.INIT(4'b0010)) sedr (.O(Q), .I1(R), .I0(SEDQ));
endmodule

module \$_DLATCHSR_NPN_ (E, S, R, D, Q);
    input E;
    input S;
    input R;
    input D;
    output Q;
    wire SEDQ;
    LUT4 #(.INIT(16'b111111111010110)) sedqlut (.O(SEDQ), .I3(S), .I2(E), .I1(D), .I0(Q));
    LUT2 #(.INIT(4'b1000)) sedr (.O(Q), .I1(R), .I0(SEDQ));
endmodule

module \$_DLATCHSR_NPP_ (E, S, R, D, Q);
    input E;
    input S;
    input R;
    input D;
    output Q;
    wire SEDQ;
    LUT4 #(.INIT(16'b111111111010110)) sedqlut (.O(SEDQ), .I3(S), .I2(E), .I1(D), .I0(Q));
    LUT2 #(.INIT(4'b0010)) sedr (.O(Q), .I1(R), .I0(SEDQ));
endmodule

module \$_DLATCHSR_PNN_ (E, S, R, D, Q);
    input E;
    input S;
    input R;
    input D;
    output Q;
    wire SEDQ;
    LUT4 #(.INIT(16'b110010101111111)) sedqlut (.O(SEDQ), .I3(S), .I2(E), .I1(D), .I0(Q));
    LUT2 #(.INIT(4'b1000)) sedr (.O(Q), .I1(R), .I0(SEDQ));
endmodule

module \$_DLATCHSR_PNP_ (E, S, R, D, Q);
    input E;
    input S;
    input R;
    input D;
    output Q;
    wire SEDQ;
    LUT4 #(.INIT(16'b110010101111111)) sedqlut (.O(SEDQ), .I3(S), .I2(E), .I1(D), .I0(Q));
    LUT2 #(.INIT(4'b0010)) sedr (.O(Q), .I1(R), .I0(SEDQ));
endmodule

module \$_DLATCHSR_PPN_ (E, S, R, D, Q);
    input E;
    input S;
    input R;
    input D;
    output Q;
    wire SEDQ;
    LUT4 #(.INIT(16'b111111111100101)) sedqlut (.O(SEDQ), .I3(S), .I2(E), .I1(D), .I0(Q));
    LUT2 #(.INIT(4'b1000)) sedr (.O(Q), .I1(R), .I0(SEDQ));
endmodule

module \$_DLATCHSR_PPP_ (E, S, R, D, Q);
    input E;
    input S;
    input R;
    input D;
    output Q;
    wire SEDQ;
    LUT4 #(.INIT(16'b11111111110010)) sedqlut (.O(SEDQ), .I3(S), .I2(E), .I1(D), .I0(Q));
    LUT2 #(.INIT(4'b0010)) sedr (.O(Q), .I1(R), .I0(SEDQ));
endmodule

