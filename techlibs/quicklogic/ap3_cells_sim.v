module ff(
    output reg CQZ,
    input D,
    (* clkbuf_sink *)
    input QCK,
    input QEN,
    (* clkbuf_sink *)
    input QRT,
    (* clkbuf_sink *)
    input QST
);
    parameter [0:0] INIT = 1'b0;
    initial CQZ = INIT;

    always @(posedge CLK or posedge QRT or posedge QST)
        if (QRT)
            CQZ <= 1'b0;
        else if (QST)
            CQZ <= 1'b1;
        else if (QEN)
            CQZ <= D;
endmodule

(* blackbox *)
module RAM (RADDR,RRLSEL,REN,RMODE,
	    WADDR,WDATA,WEN,WMODE,
	    FMODE,FFLUSH,RCLK,WCLK,RDATA,
	    FFLAGS,FIFO_DEPTH,ENDIAN,POWERDN,PROTECT,
	    UPAE,UPAF,SBOG);

   input [10:0] RADDR,WADDR;
   input [1:0] 	RRLSEL,RMODE,WMODE;
   input 	REN,WEN,FFLUSH,RCLK,WCLK;
   input [31:0] WDATA;
   input [1:0] 	SBOG, ENDIAN, UPAF, UPAE;
   output [31:0] RDATA;
   output [3:0]  FFLAGS;
   input [2:0] 	 FIFO_DEPTH;
   input 	 FMODE, POWERDN, PROTECT;
   

     DPRAM_FIFO U1(
		 .RCLK(RCLK), .REN(REN), .WCLK(WCLK), .WEN(WEN),
		 .WADDR(WADDR),.WDATA(WDATA),.RADDR(RADDR), .RDATA(RDATA),
		 .RMODE(RMODE), .WMODE(WMODE),
		 .TLD(), .TRD(),          // SideBand bus outputs
		 .FRD(32'h0), .FLD(32'h0),  // SideBand bus inputs
		 .FFLAGS(FFLAGS), // unused FIFO flags
		 .FMODE(FMODE), .FFLUSH(FFLUSH),.RRLSEL(RRLSEL),
		 .PROTECT(PROTECT),
		 .PL_INIT(1'b0), .PL_ENA(1'b0), .PL_CLK(1'b0),
		 .PL_REN(1'b0), .PL_WEN(1'b0),
		 .PL_ADDR(20'h0), .PL_DATA_IN(32'h0), .PL_DATA_OUT(),
		 .ENDIAN(ENDIAN), .FIFO_DEPTH(FIFO_DEPTH), .RAM_ID(8'h00),
		 .POWERDN(POWERDN), .SBOG(SBOG),
		 .UPAE(UPAE), .UPAF(UPAF),
		 .DFT_SCAN_CLK_DAISYIN(1'b0), .DFT_SCAN_RST_DAISYIN(1'b0),
		 .DFT_SCAN_MODE_DAISYIN(1'b0), .DFT_SCAN_EN_DAISYIN(1'b0),
		 .DFT_SCAN_IN_DAISYIN(1'b0), .dft_FFB_scan_out()
		 );
endmodule 

(* blackbox *)
module DSP (MODE_SEL,COEF_DATA,OPER_DATA,OUT_SEL,ENABLE,CLR,RND,SAT,CLOCK,MAC_OUT,CSEL,OSEL,SBOG);

input [1:0] MODE_SEL,OUT_SEL;
input [1:0] CSEL;
input [1:0] OSEL;
input [31:0] COEF_DATA,OPER_DATA;
input ENABLE,CLR,RND,SAT,CLOCK;
input [1:0]SBOG;
output [63:0] MAC_OUT;


dsp_top U1 (
	       .oper(OPER_DATA), .coef(COEF_DATA),
	       .outsel(OUT_SEL),
	       .mode(MODE),
	       .clk(CLOCK), .clr(CLR), .ena(ENABLE),
	       .fld(32'h0), .frd(32'h0), .sbog(SBOG),
	       .rnd(RND), .sat(SAT),
	       .o_sel(OSEL), .c_sel(CSEL),
	       .mac_out(MAC_OUT),
	       .tld(), .trd(),
	       .DFT_SCAN_CLK_DAISYIN(1'b0),
	       .DFT_SCAN_RST_DAISYIN(1'b0),
	       .DFT_SCAN_MODE_DAISYIN(1'b0),
	       .DFT_SCAN_EN_DAISYIN(1'b0),
	       .DFT_SCAN_IN_DAISYIN(1'b0),
	       .dft_FFB_scan_out()
	       );
endmodule 