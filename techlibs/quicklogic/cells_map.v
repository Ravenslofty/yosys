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
            LUT2 #(.INIT(INIT_address_inverse(LUT))) _TECHMAP_REPLACE_ (.O(Y), .I0(A[0]), .I1(A[1]));
        end
        else if (WIDTH == 3)
        begin
            LUT3 #(.INIT(INIT_address_inverse(LUT))) _TECHMAP_REPLACE_ (.O(Y), .I0(A[0]), .I1(A[1]), .I2(A[2]));
        end
        else if (WIDTH == 4)
        begin
            LUT4 #(.INIT(INIT_address_inverse(LUT))) _TECHMAP_REPLACE_ (.O(Y), .I0(A[0]), .I1(A[1]), .I2(A[2]), .I3(A[3]));
        end
        else
        begin
            wire _TECHMAP_FAIL_ = 1;
        end
    endgenerate
endmodule

module \$_MUX_ (A, B, S, Y);

    parameter WIDTH = 0;

    input [WIDTH-1:0] A, B;
    input S;
    output reg [WIDTH-1:0] Y;

    generate
        if (WIDTH == 1)
        begin
            mux2x0 _TECHMAP_REPLACE_ (.Q(Y[0]), .S(S), .A(A[0]), .B(B[0]));
        end
        else
        begin
            wire _TECHMAP_FAIL_ = 1;
        end
    endgenerate
endmodule

module \$_NOT_ (A, Y);
    input A;
    output Y;
    inv _TECHMAP_REPLACE_ (.Q(Y), .A(A));
endmodule

module \$_AND_ (A, B, Y);
    input A;
    input B;
    output Y;
    AND2I0 _TECHMAP_REPLACE_ (.Q(Q), .A(A), .B(B));
endmodule

module \$_DFF_N_ (D, Q, C);
    input D;
    input C;
    output Q;
    wire C_INV;
    inv clkinv (.Q(C_INV), .A(C));
    dff tmpdff (.Q(Q), .D(D), .CLK(C_INV));
endmodule

module \$_DFF_P_ (D, Q, C);
    input D;
    input C;
    output Q;
    dff _TECHMAP_REPLACE_ (.Q(Q), .D(D), .CLK(C));
endmodule

module \$_DFF_NN0_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire C_INV;
    inv clkinv (.Q(C_INV), .A(C));
    wire R_INV;
    inv clrinv (.Q(R_INV), .A(R));
    dffc tmpdffc (.Q(Q), .D(D), .CLK(C_INV), .CLR(R_INV));
endmodule

module \$_DFF_NN1_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire C_INV;
    inv clkinv (.Q(C_INV), .A(C));
    wire R_INV;
    inv preinv (.Q(R_INV), .A(R));
    dffp tmpdffp (.Q(Q), .D(D), .CLK(C_INV), .PRE(R_INV));
endmodule

module \$_DFF_NP0_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire C_INV;
    inv clkinv (.Q(C_INV), .A(C));
    dffc tmpdffc (.Q(Q), .D(D), .CLK(C_INV), .CLR(R));
endmodule

module \$_DFF_NP1_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire C_INV;
    inv clkinv (.Q(C_INV), .A(C));
    dffp tmpdffp (.Q(Q), .D(D), .CLK(C_INV), .PRE(R));
endmodule

module \$_DFF_PN0_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire R_INV;
    inv preinv (.Q(R_INV), .A(R));
    dffc tmpdffc (.Q(Q), .D(D), .CLK(C), .CLR(R_INV));
endmodule

module \$_DFF_PN1_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire R_INV;
    inv preinv (.Q(R_INV), .A(R));
    dffp tmpdffp (.Q(Q), .D(D), .CLK(C), .PRE(R_INV));
endmodule

module \$_DFF_PP0_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    dffc _TECHMAP_REPLACE_ (.Q(Q), .D(D), .CLK(C), .CLR(R));
endmodule

module \$_DFF_PP1_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    dffp _TECHMAP_REPLACE_ (.Q(Q), .D(D), .CLK(C), .PRE(R));
endmodule
