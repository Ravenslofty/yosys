module \$_MUX_ (
   input A,
   input B,
   input S,
   output Y
);
    QLOGIC_MUX _TECHMAP_REPLACE_ (.A(A), .B(B), .S(S), .Y(Y));
endmodule

module \$_DFF_N_ (
   input D,
   input C,
   output Q
);
    wire nC = ~ C;
    QLOGIC_DFFE _TECHMAP_REPLACE_ (.S(1'b0), .D(D), .E(1'b1), .QCK(nC), .R(1'b0), .QZ(Q));
endmodule

module \$_DFF_P_ (
   input D,
   input C,
   output Q
);
    QLOGIC_DFFE _TECHMAP_REPLACE_ (.S(1'b0), .D(D), .E(1'b1), .QCK(C), .R(1'b0), .QZ(Q));
endmodule

module \$_DFF_PN0_ (
   input D,
   input C,
   input R,
   output Q
);
    wire nR = ~ R;
    QLOGIC_DFFE _TECHMAP_REPLACE_ (.S(1'b0), .D(D), .E(1'b1), .QCK(C), .R(nR), .QZ(Q));
endmodule

module \$_DFF_PP0_ (
   input D,
   input C,
   input R,
   output Q
);
    QLOGIC_DFFE _TECHMAP_REPLACE_ (.S(1'b0), .D(D), .E(1'b1), .QCK(C), .R(R), .QZ(Q));
endmodule

module \$__DFFE_PP0_ (
   input D,
   input C,
   input E,
   input R,
   output Q
);
    wire nE = ~ E;
    QLOGIC_DFFE _TECHMAP_REPLACE_ (.S(1'b0), .D(D), .E(nE), .QCK(C), .R(R), .QZ(Q));
endmodule

module \$_NOT_ (
   input A,
   output Y
);
    QLOGIC_NOT _TECHMAP_REPLACE_ (.A(A), .Y(Y));
endmodule

