

module \$__QUICKLOGIC_RAMB16BWER_TDP (CLK2, CLK3, A1ADDR, A1DATA, A1EN, B1ADDR, B1DATA, B1EN);
	parameter CFG_ABITS = 9;
	parameter CFG_DBITS = 36;
	parameter CFG_ENABLE_B = 4;

	parameter CLKPOL2 = 1;
	parameter CLKPOL3 = 1;
	parameter [18431:0] INIT = 18432'bx;

	input CLK2;
	input CLK3;

	input [CFG_ABITS-1:0] A1ADDR;
	output [CFG_DBITS-1:0] A1DATA;
	input A1EN;

	input [CFG_ABITS-1:0] B1ADDR;
	input [CFG_DBITS-1:0] B1DATA;
	input [CFG_ENABLE_B-1:0] B1EN;
	
	assign VCC = 1'b1;
	assign GND = 1'b0;


	wire [3:0] B1EN_4 = {4{B1EN}};

	wire [3:0] DIP, DOP;
	wire [31:0] DI, DO;

	wire [31:0] DOB;
	wire [3:0] DOPB;

	wire[1:0] WS1_0;
	wire[1:0] WS1_1;
	wire[1:0] WS2_0;
	wire[1:0] WS2_1;

	
	assign A1DATA = { DOP[3], DO[31:24], DOP[2], DO[23:16], DOP[1], DO[15: 8], DOP[0], DO[ 7: 0] };
	assign { DIP[3], DI[31:24], DIP[2], DI[23:16], DIP[1], DI[15: 8], DIP[0], DI[ 7: 0] } = B1DATA;

    if(CFG_DBITS <=9)
	begin
             assign WS1_0 = 2'b00;
             assign WS2_0 = 2'b00;
	end
    else if(CFG_DBITS >9 && CFG_DBITS <=18)
	begin
             assign WS1_0 = 2'b01;
             assign WS2_0 = 2'b01;
	end
    else if(CFG_DBITS > 18)
	begin
             assign WS1_0 = 2'b10;
             assign WS2_0 = 2'b10;
	end

//	generate begin
       	ram8k_2x1_cell_macro #(
			`include "brams_init_18.vh"
		) _TECHMAP_REPLACE_ (			
			.A1_0(B1ADDR) ,
			.A1_1(GND),
			.A2_0(A1ADDR),
		   .A2_1(GND),
		   .ASYNC_FLUSH_0(GND), //chk
		   .ASYNC_FLUSH_1(GND), //chk
		   .ASYNC_FLUSH_S0(GND),
		   .ASYNC_FLUSH_S1(GND),
			.CLK1_0(CLK2),
		   .CLK1_1(GND),
			.CLK1S_0(!CLKPOL2),
			.CLK1S_1(GND),
			.CLK1EN_0(VCC),
			.CLK1EN_1(GND),
		   .CLK2_0(CLK3),
		   .CLK2_1(GND),
		   .CLK2S_0(!CLKPOL3),
			.CLK2S_1(GND),
		   .CLK2EN_0(A1EN),
		   .CLK2EN_1(GND),
		   .CONCAT_EN_0(GND),
		   .CONCAT_EN_1(GND),
		   .CS1_0(VCC),
		   .CS1_1(GND),
		   .CS2_0(VCC),
		   .CS2_1(GND),
		   .DIR_0(GND),
		   .DIR_1(GND),
		   .FIFO_EN_0(GND),
		   .FIFO_EN_1(GND),
		   .P1_0(GND), //P1_0
		   .P1_1(GND), //P1_1
		   .P2_0(GND), //
		   .P2_1(GND), //
		   .PIPELINE_RD_0(GND),
		   .PIPELINE_RD_1(GND),
		   .SYNC_FIFO_0(GND),
		   .SYNC_FIFO_1(GND),
		   .WD_1(GND),
		   .WD_0(B1DATA),
		   .WIDTH_SELECT1_0(WS1_0),
		   .WIDTH_SELECT1_1(GND),
		   .WIDTH_SELECT2_0(WS2_0),
		   .WIDTH_SELECT2_1(GND),
			.WEN1_0(B1EN_4[1:0]),
			.WEN1_1(B1EN_4[3:2]),
		   .Almost_Empty_0(),
		   .Almost_Empty_1(),
		   .Almost_Full_0(),
		   .Almost_Full_1(),
		   .POP_FLAG_0(),
		   .POP_FLAG_1(),
		   .PUSH_FLAG_0(),
		   .PUSH_FLAG_1(),
		   .RD_0(A1DATA),
		   .RD_1(),
		   .TEST1A(GND),
		   .TEST1B(GND),
		   .RMA(4'd0),
		   .RMB(4'd0),
		   .RMEA(GND),
		   .RMEB(GND)
		   );

	//end endgenerate
endmodule

// ------------------------------------------------------------------------

module \$__QUICKLOGIC_RAMB8BWER_TDP (CLK2, CLK3, A1ADDR, A1DATA, A1EN, B1ADDR, B1DATA, B1EN);
	parameter CFG_ABITS = 9;
	parameter CFG_DBITS = 18;
	parameter CFG_ENABLE_B = 2;

	parameter CLKPOL2 = 1;
	parameter CLKPOL3 = 1;
	parameter [9215:0] INIT = 9216'bx;

	input CLK2;
	input CLK3;

	input [CFG_ABITS-1:0] A1ADDR;
	output [CFG_DBITS-1:0] A1DATA;
	input A1EN;

	input [CFG_ABITS-1:0] B1ADDR;
	input [CFG_DBITS-1:0] B1DATA;
	input [CFG_ENABLE_B-1:0] B1EN;

	wire [10:0] A1ADDR_11;
	wire [10:0] B1ADDR_11;
	wire [1:0] B1EN_2 = {2{B1EN}};

	wire [1:0] DIP, DOP;
	wire [15:0] DI, DO;

	wire [15:0] DOBDO;
	wire [1:0] DOPBDOP;
	
	wire[1:0] WS1_0;
	wire[1:0] WS1_1;
	wire[1:0] WS2_0;
	wire[1:0] WS2_1;


	assign GND = 1'b0;
	assign VCC = 1'b1;

	assign A1DATA = { DOP[1], DO[15: 8], DOP[0], DO[ 7: 0] };
	assign { DIP[1], DI[15: 8], DIP[0], DI[ 7: 0] } = B1DATA;

    if(CFG_ABITS == 11)
        	begin
        		assign A1ADDR_11[CFG_ABITS-1:0]=A1ADDR;
        		assign B1ADDR_11[CFG_ABITS-1:0]=B1ADDR;
        	end
	else
        	begin
				assign A1ADDR_11[10:CFG_ABITS]=0;
        		assign A1ADDR_11[CFG_ABITS-1:0]=A1ADDR;
				assign B1ADDR_11[10:CFG_ABITS]=0;
        		assign B1ADDR_11[CFG_ABITS-1:0]=B1ADDR;
        	end

    if(CFG_DBITS <=9)
		begin
             assign WS1_0 = 2'b00;
             assign WS2_0 = 2'b00;
		end
    else if(CFG_DBITS >9 && CFG_DBITS <=18)
		begin
             assign WS1_0 = 2'b01;
             assign WS2_0 = 2'b01;
		end
    else if(CFG_DBITS > 18)
		begin
             assign WS1_0 = 2'b10;
             assign WS2_0 = 2'b10;
		end

	//generate begin
       	ram8k_2x1_cell_macro #(
            `include "brams_init_9.vh"
        ) _TECHMAP_REPLACE_ (			
			.A1_0(B1ADDR_11) ,
			.A1_1(GND),
			.A2_0(A1ADDR_11),
			.A2_1(GND),
			.ASYNC_FLUSH_0(GND), //chk
			.ASYNC_FLUSH_1(GND), //chk
			.ASYNC_FLUSH_S0(GND),
			.ASYNC_FLUSH_S1(GND),
			.CLK1_0(WClk0),
			.CLK1_1(GND),
			.CLK1S_0(!CLKPOL2),
			.CLK1S_1(GND),
			.CLK1EN_0(VCC),
			.CLK1EN_1(VCC),
			.CLK2_0(CLK3),
			.CLK2_1(GND),
			.CLK2S_0(!CLKPOL3),
			.CLK2S_1(GND),
		   .CLK2EN_0(A1EN),
		   .CLK2EN_1(GND),
		   .CONCAT_EN_0(GND),
		   .CONCAT_EN_1(GND),
		   .CS1_0(VCC),
		   .CS1_1(GND),
		   .CS2_0(VCC),
		   .CS2_1(GND),
		   .DIR_0(GND),
		   .DIR_1(GND),
		   .FIFO_EN_0(GND),
		   .FIFO_EN_1(GND),
		   .P1_0(GND), //P1_0
		   .P1_1(GND), //P1_1
		   .P2_0(GND), //
		   .P2_1(GND), //
		   .PIPELINE_RD_0(GND),
		   .PIPELINE_RD_1(GND),
		   .SYNC_FIFO_0(GND),
		   .SYNC_FIFO_1(GND),
		   .WD_1(GND),
		   .WD_0(B1DATA),
		   .WIDTH_SELECT1_0(WS1_0),
		   .WIDTH_SELECT1_1(GND),
		   .WIDTH_SELECT2_0(WS2_0),
		   .WIDTH_SELECT2_1(GND),
		   .WEN1_0(B1EN_2),
		   .WEN1_1(GND),
		   .Almost_Empty_0(),
		   .Almost_Empty_1(),
		   .Almost_Full_0(),
		   .Almost_Full_1(),
		   .POP_FLAG_0(),
		   .POP_FLAG_1(),
		   .PUSH_FLAG_0(),
		   .PUSH_FLAG_1(),
		   .RD_0(A1DATA),
		   .RD_1(),
		   .TEST1A(GND),
		   .TEST1B(GND),
		   .RMA(4'd0),
		   .RMB(4'd0),
		   .RMEA(GND),
		   .RMEB(GND)
		   );

	//end endgenerate
endmodule
