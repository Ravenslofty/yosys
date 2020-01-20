//                FZ        FS
module LUT1(output O, input I0);
    parameter [1:0] INIT = 0;
    assign O = I0 ? INIT[1] : INIT[0];
endmodule

//               TZ        TSL TAB
module LUT2(output O, input I0, I1);
    parameter [3:0] INIT = 0;
    wire [1:0] s1 = I0 ? INIT[3:2] : INIT[1:0];
    assign O = I1 ? s1[1] : s1[0];
endmodule

// O: TZ
// I0: TA1 TA2 TB1 TB2
// I1: TSL
// I2: TAB
module LUT3(output O, input I0, I1, I2);
    parameter [7:0] INIT = 0;
    wire [3:0] s2 = I0 ? INIT[7:4] : INIT[3:0];
    wire [1:0] s1 = I1 ? s2[3:2] : s2[1:0];
    assign O = I2 ? s1[1] : s1[0];
    // TODO: This is not a valid in-sight implementation for QL - to be
    // discussed with the client
endmodule

// O: CZ
// I0: TA1 TA2 TB1 TB2 BA1 BA2 BB1 BB2
// I1: TSL BSL
// I2: TAB BAB
// I3: TBS
module LUT4(output O, input I0, I1, I2, I3);
    parameter [15:0] INIT = 0;
    wire [7:0] s3 = I0 ? INIT[15:8] : INIT[7:0];
    wire [3:0] s2 = I1 ? s3[7:4] : s3[3:0];
    wire [1:0] s1 = I2 ? s2[3:2] : s2[1:0];
    assign O = I3 ? s1[1] : s1[0];
    // TODO: This is not a valid in-sight implementation for QL - to be
    // discussed with the client
endmodule

//               FZ       FS
module inv(output Q, input A);
    assign Q = A ? 0 : 1;
endmodule

//               QZ      QDI  QCK
module dff(output reg Q, input D, CLK);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK) begin
        Q <= D;
    end
endmodule

//                QZ      QDI  QCK  QRT
module dffc(output reg Q, input D, CLK, CLR);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK, posedge CLR) begin
        if (CLR)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule

//                QZ      QDI  QCK  QST
module dffp(output reg Q, input D, CLK, PRE);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK, posedge PRE) begin
        if (PRE)
            Q <= 1'b1;
        else
            Q <= D;
    end
endmodule

//                 QZ      QDI  QCK  QRT  QST
module dffpc(output reg Q, input D, CLK, CLR, PRE);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK, posedge CLR, posedge PRE) begin
        if (CLR)
            Q <= 1'b0;
        else if (PRE)
            Q <= 1'b1;
        else
            Q <= D;
    end
endmodule

//                QZ      QDI  QCK QEN
module dffe(output reg Q, input D, CLK, EN);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK) begin
        if (EN)
            Q <= D;
    end
endmodule

//                 QZ      QDI  QCK QEN  QRT
module dffec(output reg Q, input D, CLK, EN, CLR);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK, posedge CLR) begin
        if (CLR)
            Q <= 1'b0;
        else if (EN)
            Q <= D;
    end
endmodule

//                  QZ      QDI  QCK QEN  QRT  QST
module dffepc(output reg Q, input D, CLK, EN, CLR, PRE);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK, posedge CLR, posedge PRE) begin
        if (CLR)
            Q <= 1'b0;
        else if (PRE)
            Q <= 1'b1;
        else if (EN)
            Q <= D;
    end
endmodule

//                  FZ       FS F2 (F1 TO 0)
module AND2I0(output Q, input A, B);
    assign Q = A ? B : 0;
endmodule

//                  FZ       FS F1 F2
module mux2x0(output Q, input S, A, B);
    assign Q = S ? B : A;
endmodule

//                  TZ       TSL TABTA1TA2TB1TB2 
module mux4x0(output Q, input S0, S1, A, B, C, D);
    assign Q = S1 ? (S0 ? D : C) : (S0 ? B : A);
endmodule

// S0 BSL TSL
// S1 BAB TAB
// S2 TBS
// A TA1
// B TA2
// C TB1
// D TB2
// E BA1
// F BA2
// G BB1
// H BB2
// Q CZ
module mux8x0(output Q, input S0, S1, S2, A, B, C, D, E, F, G, H);
    assign Q = S2 ? (S1 ? (S0 ? H : G) : (S0 ? F : E)) : (S1 ? (S0 ? D : C) : (S0 ? B : A));
endmodule

module inpad(output Q, input P);
    assign Q = P;
endmodule

module outpad(output P, input A);
    assign P = A;
endmodule

module ckpad(output Q, input P);
    assign Q = P;
endmodule

// module DFFSEC(output Q, input D, CLR, EN, CLK, N_11);
//     parameter [0:0] INIT = 1'b0;
//     // TODO implement
// endmodule
// 
// module DFFSEP(output Q, input D, CLR, EN, CLK, N_11);
//     parameter [0:0] INIT = 1'b0;
//     // TODO implement
// endmodule
// 
// module DFFSLE_APC(output Q, input D, CLR, EN, CLK, N_11);
//     parameter [0:0] INIT = 1'b0;
//     // TODO implement
// endmodule
// 
// module DFFSEC_APC(output Q, input D, CLR, EN, CLK, N_11);
//     parameter [0:0] INIT = 1'b0;
//     // TODO implement
// endmodule
