//                FZ        FS
module LUT1(output O, input I0);
    parameter [1:0] INIT = 0;
    assign O = I0 ? INIT[1] : INIT[0];
endmodule

//               TZ        TSL TAB
module LUT2(output O, input I0, I1);
    parameter [3:0] INIT = 0;
    assign O = INIT[{I1, I0}];
endmodule

// O:  TZ
// I0: TA1 TA2 TB1 TB2
// I1: TSL
// I2: TAB
module LUT3(output O, input I0, I1, I2);
    parameter [7:0] INIT = 0;
    assign O = INIT[{I2, I1, I0}];
endmodule

// O:  CZ
// I0: TA1 TA2 TB1 TB2 BA1 BA2 BB1 BB2
// I1: TSL BSL
// I2: TAB BAB
// I3: TBS
module LUT4(output O, input I0, I1, I2, I3);
    parameter [15:0] INIT = 0;
    assign O = INIT[{I3, I2, I1, I0}];
endmodule

//               FZ       FS
module inv(output Q, input A);
    assign Q = A ? 0 : 1;
endmodule

module buff(output Q, input A);
    assign Q = A;
endmodule

module dff(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input CLK
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK)
        Q <= D;
endmodule

module dffc(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input CLK,
    (* clkbuf_sink *)
    input CLR
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK)
        if (~CLR)
            Q <= D;
    always @(CLR)
        if (CLR)
            Q <= 1'b0;
endmodule

module dffp(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input CLK,
    (* clkbuf_sink *)
    input PRE
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK)
        if (~PRE)
            Q <= D;
    always @(PRE)
        if (PRE)
            Q <= 1'b1;
endmodule

module dffpc(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input CLK,
    (* clkbuf_sink *)
    input CLR,
    (* clkbuf_sink *)
    input PRE
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK)
        if ((~PRE) && (~CLR))
            Q <= D;
    always @(CLR or PRE)
        if (CLR)
            Q <= 1'b0;
        else if (PRE)
            Q <= 1'b1;
endmodule

module dffe(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input CLK,
    input EN
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK)
        if (EN)
            Q <= D;
endmodule

module dffec(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input CLK,
    input EN,
    (* clkbuf_sink *)
    input CLR
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK)
        if (~CLR)
            if (EN)
                Q <= D;
    always @(CLR)
        if (CLR)
            Q <= 1'b0;
endmodule

module dffepc(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input CLK,
    input EN,
    (* clkbuf_sink *)
    input CLR,
    (* clkbuf_sink *)
    input PRE
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge CLK)
        if (~CLR && ~PRE)
            if (EN)
                Q <= D;
    always @(CLR or PRE)
        if (CLR)
            Q <= 1'b0;
        else if (PRE)
            Q <= 1'b1;
endmodule

//                  FZ       FS F2 (F1 TO 0)
module AND2I0(output Q, input A, B);
    assign Q = A ? B : 0;
endmodule

//                  FZ       FS F1 F2
module mux2x0(output Q, input S, A, B);
    assign Q = S ? B : A;
endmodule

//                  FZ       FS F1 F2
module mux2x1(output Q, input S, A, B);
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

module bipad(input A, input EN, output Q, inout P);
    assign Q = P;
    assign P = EN ? A : 1'bz;
endmodule

module logic_0(output a);
    assign a = 0;
endmodule

module logic_1(output a);
    assign a = 1;
endmodule

module logic_cell_macro(
    input BA1,
    input BA2,
    input BAB,
    input BAS1,
    input BAS2,
    input BB1,
    input BB2,
    input BBS1,
    input BBS2,
    input BSL,
    input F1,
    input F2,
    input FS,
    input QCK,
    input QCKS,
    input QDI,
    input QDS,
    input QEN,
    input QRT,
    input QST,
    input TA1,
    input TA2,
    input TAB,
    input TAS1,
    input TAS2,
    input TB1,
    input TB2,
    input TBS,
    input TBS1,
    input TBS2,
    input TSL,
    output CZ,
    output FZ,
    output QZ,
    output TZ
);

    wire TAP1,TAP2,TBP1,TBP2,BAP1,BAP2,BBP1,BBP2,QCKP,TAI,TBI,BAI,BBI,TZI,BZI,CZI,QZI;
    reg QZ;

    assign TAP1 = TAS1 ? ~TA1 : TA1; 
    assign TAP2 = TAS2 ? ~TA2 : TA2; 
    assign TBP1 = TBS1 ? ~TB1 : TB1; 
    assign TBP2 = TBS2 ? ~TB2 : TB2;
    assign BAP1 = BAS1 ? ~BA1 : BA1;
    assign BAP2 = BAS2 ? ~BA2 : BA2;
    assign BBP1 = BBS1 ? ~BB1 : BB1;
    assign BBP2 = BBS2 ? ~BB2 : BB2;

    assign TAI = TSL ? TAP2 : TAP1;
    assign TBI = TSL ? TBP2 : TBP1;
    assign BAI = BSL ? BAP2 : BAP1;
    assign BBI = BSL ? BBP2 : BBP1;
    assign TZI = TAB ? TBI : TAI;
    assign BZI = BAB ? BBI : BAI;
    assign CZI = TBS ? BZI : TZI;
    assign QZI = QDS ? QDI : CZI ;
    assign FZ = FS ? F2 : F1;
    assign TZ = TZI;
    assign CZ = CZI;
    assign QCKP = QCKS ? QCK : ~QCK;

    always @(posedge QCKP or posedge QRT or posedge QST)
        if (QRT)
            QZ <= 1'b0;
        else if (QST)
            QZ <= 1'b1;
        else
            QZ <= QZI;

endmodule

// BLACK BOXES

(* blackbox *)
(* keep *)
module qlal4s3b_cell_macro(
    input	WB_CLK,
    input	WBs_ACK,
    input	[31:0]WBs_RD_DAT,
    output	[3:0]WBs_BYTE_STB,
    output	WBs_CYC,
    output	WBs_WE,
    output	WBs_RD,
    output	WBs_STB,
    output	[16:0]WBs_ADR,
    input	[3:0]SDMA_Req,
    input	[3:0]SDMA_Sreq,
    output	[3:0]SDMA_Done,
    output	[3:0]SDMA_Active,
    input	[3:0]FB_msg_out,
    input	[7:0]FB_Int_Clr,
    output	FB_Start,
    input	FB_Busy,
    output	WB_RST,
    output	Sys_PKfb_Rst,
    output	Sys_Clk0,
    output	Sys_Clk0_Rst,
    output	Sys_Clk1,
    output	Sys_Clk1_Rst,
    output	Sys_Pclk,
    output	Sys_Pclk_Rst,
    input	Sys_PKfb_Clk,
    input	[31:0]FB_PKfbData,
    output	[31:0]WBs_WR_DAT,
    input	[3:0]FB_PKfbPush,
    input	FB_PKfbSOF,
    input	FB_PKfbEOF,
    output	[7:0]Sensor_Int,
    output	FB_PKfbOverflow,
    output	[23:0]TimeStamp,
    input	Sys_PSel,
    input	[15:0]SPIm_Paddr,
    input	SPIm_PEnable,
    input	SPIm_PWrite,
    input	[31:0]SPIm_PWdata,
    output	SPIm_PReady,
    output	SPIm_PSlvErr,
    output	[31:0]SPIm_Prdata,
    input	[15:0]Device_ID,
    input	[13:0]FBIO_In_En,
    input	[13:0]FBIO_Out,
    input	[13:0]FBIO_Out_En,
    output	[13:0]FBIO_In,
    inout 	[13:0]SFBIO,
    input   Device_ID_6S,
    input   Device_ID_4S,
    input   SPIm_PWdata_26S,
    input   SPIm_PWdata_24S,
    input   SPIm_PWdata_14S,
    input   SPIm_PWdata_11S,
    input   SPIm_PWdata_0S,
    input   SPIm_Paddr_8S,
    input   SPIm_Paddr_6S,
    input   FB_PKfbPush_1S,
    input   FB_PKfbData_31S,
    input   FB_PKfbData_21S,
    input   FB_PKfbData_19S,
    input   FB_PKfbData_9S,
    input   FB_PKfbData_6S,
    input   Sys_PKfb_ClkS,
    input   FB_BusyS,
    input   WB_CLKS);

endmodule /* qlal4s3b_cell_macro */

(* blackbox *)
module gclkbuff (input A, output Z);

endmodule

(* blackbox *)
module ram8k_2x1_cell_macro (
    input [10:0] A1_0,
    input [10:0] A1_1,
    input [10:0] A2_0,
    input [10:0] A2_1,
    (* clkbuf_sink *)
    input CLK1_0,
    (* clkbuf_sink *)
    input CLK1_1,
    (* clkbuf_sink *)
    input CLK2_0,
    (* clkbuf_sink *)
    input CLK2_1,
    output Almost_Empty_0, Almost_Empty_1, Almost_Full_0, Almost_Full_1,
    input ASYNC_FLUSH_0, ASYNC_FLUSH_1, ASYNC_FLUSH_S0, ASYNC_FLUSH_S1, CLK1EN_0, CLK1EN_1, CLK1S_0, CLK1S_1,CLK2EN_0,CLK2EN_1, CLK2S_0, CLK2S_1, CONCAT_EN_0, CONCAT_EN_1, CS1_0, CS1_1,CS2_0, CS2_1, DIR_0, DIR_1, FIFO_EN_0, FIFO_EN_1, P1_0, P1_1, P2_0,P2_1, PIPELINE_RD_0, PIPELINE_RD_1,
    output [3:0] POP_FLAG_0,
    output [3:0] POP_FLAG_1,
    output [3:0] PUSH_FLAG_0,
    output [3:0] PUSH_FLAG_1,
    output [17:0] RD_0,
    output [17:0] RD_1,
    input  SYNC_FIFO_0, SYNC_FIFO_1,
    input [17:0] WD_0,
    input [17:0] WD_1,
    input [1:0] WEN1_0,
    input [1:0] WEN1_1,
    input [1:0] WIDTH_SELECT1_0,
    input [1:0] WIDTH_SELECT1_1,
    input [1:0] WIDTH_SELECT2_0,
    input [1:0] WIDTH_SELECT2_1,
    input SD,DS,LS,SD_RB1,LS_RB1,DS_RB1,RMEA,RMEB,TEST1A,TEST1B,
    input [3:0] RMA,
    input [3:0] RMB);

endmodule /* ram8k_2x1_cell_macro */

(* blackbox *)
module gpio_cell_macro (
    input DS, ESEL, FIXHOLD, IE, INEN, IQC, IQCS, IQE, IQR, OQE, OQI, OSEL, WPD,
    inout IP,
    output IQZ);
endmodule /*  gpio_cell_macro */

(* blackbox *)
module qlal4s3_mult_32x32_cell (
    input [31:0] Amult,
    input [31:0] Bmult,
    input [1:0] Valid_mult,
    output [63:0] Cmult);

endmodule /* qlal4s3_32x32_mult_cell */

(* blackbox *)
module qlal4s3_mult_16x16_cell (
    input [15:0] Amult,
    input [15:0] Bmult,
    input [1:0] Valid_mult,
    output [31:0] Cmult);

endmodule /* qlal4s3_16x16_mult_cell */

(* blackbox *)
module qlal4s3_mult_cell_macro(
    input [31:0] Amult,
    input [31:0] Bmult,
    input [1:0] Valid_mult,
    input sel_mul_32x32,
    output [63:0] Cmult);

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
