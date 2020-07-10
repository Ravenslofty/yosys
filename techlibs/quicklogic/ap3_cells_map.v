
module \$_DFF_ (D, CQZ, QCK, QEN, QRT, QST);
    input D;
    input QCK;
    input QEN;
    input QRT;
    input QST;
    output CQZ;
    ff _TECHMAP_REPLACE_ (.CQZ(CQZ), .D(D), .QCK(QCK), .QEN(QEN), .QRT(QRT), .QST(QST));
endmodule

module \$_DFF_N_ (D, Q, C);
    input D;
    input C;
    output Q;
    wire C_INV;
    inv clkinv (.Q(C_INV), .A(C));
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C_INV), .QEN(1'b1), .QRT(1'b0), .QST(1'b0));
endmodule

module \$_DFF_P_ (D, Q, C);
    input D;
    input C;
    output Q;
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C), .QEN(1'b1), .QRT(1'b0), .QST(1'b0));
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
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C_INV), .QEN(1'b1), .QRT(R_INV), .QST(1'b0));
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
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C_INV), .QEN(1'b1), .QRT(1'b0), .QST(R_INV));
endmodule

module \$_DFF_NP0_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire C_INV;
    inv clkinv (.Q(C_INV), .A(C));
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C_INV), .QEN(1'b1), .QRT(R), .QST(1'b0));
endmodule

module \$_DFF_NP1_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire C_INV;
    inv clkinv (.Q(C_INV), .A(C));
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C_INV), .QEN(1'b1), .QRT(1'b0), .QST(R));
endmodule

module \$_DFF_PN0_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire R_INV;
    inv preinv (.Q(R_INV), .A(R));
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C), .QEN(1'b1), .QRT(R_INV), .QST(1'b0));
endmodule

module \$_DFF_PN1_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    wire R_INV;
    inv preinv (.Q(R_INV), .A(R));
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C), .QEN(1'b1), .QRT(1'b0), .QST(R_INV));
endmodule

module \$_DFF_PP0_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C), .QEN(1'b1), .QRT(R), .QST(1'b0));
endmodule

module \$_DFF_PP1_ (D, Q, C, R);
    input D;
    input C;
    input R;
    output Q;
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C), .QEN(1'b1), .QRT(1'b0), .QST(R));
endmodule

module \$_DFFSR_NPP_ (D, Q, C, R, S);
    input D;
    input C;
    input R;
    input S;
    output Q;
    wire C_INV;
    inv clkinv (.Q(C_INV), .A(C));
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C_INV), .QEN(1'b1), .QRT(R), .QST(S));
endmodule

module \$_DFFSR_PPP_ (D, Q, C, R, S);
    input D;
    input C;
    input R;
    input S;
    output Q;
    ff _TECHMAP_REPLACE_ (.CQZ(Q), .D(D), .QCK(C), .QEN(1'b1), .QRT(R), .QST(S));
endmodule