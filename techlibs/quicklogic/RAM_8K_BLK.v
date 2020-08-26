module RAM_8K_BLK ( WA,RA,WD,WClk,RClk,WClk_En,RClk_En,WEN,RD
    			   );

parameter 	addr_int0 	= 9,
	  		data_depth_int0 = 512,
	  		data_width_int0 = 18,
            wr_enable_int0 	= 2,
	  		reg_rd_int0 	= 0;
			
parameter [9215:0] INIT = 9216'b0;
parameter init_ram1="init1.mem";	
			
input [addr_int0-1:0] WA;
input [addr_int0-1:0] RA;
input WClk,RClk;
input WClk_En,RClk_En;
input [wr_enable_int0-1:0] WEN;
input [data_width_int0-1:0] WD;
output [data_width_int0-1:0] RD;

assign VCC = 1'b1;
assign GND = 1'b0;

wire WClk_Sel,RClk_Sel;

wire 		reg_rd0;
wire 		reg_rd1;
wire [10:0] addr_wr0,addr_rd0,addr_wr1,addr_rd1;

wire [17:0] in_reg0;

wire [2:0] wen_reg0;

wire [15:0] out_reg0;

wire [1:0] out_par0;

wire [1:0] WS1_0,WS2_0; 
wire [1:0] WS_GND;

wire LS,DS,SD,LS_RB1,DS_RB1,SD_RB1;

wire WD0_SEL,RD0_SEL;
wire WD1_SEL,RD1_SEL;

assign WD0_SEL = 1'b1;
assign RD0_SEL = 1'b1;
assign WD1_SEL = 1'b0;
assign RD1_SEL = 1'b0;

assign WClk0_Sel = 1'b0;
assign RClk0_Sel = 1'b0;

assign WClk1_Sel = 1'b0;
assign RClk1_Sel = 1'b0;

assign LS = 1'b0;
assign DS = 1'b0;
assign SD = 1'b0;
assign LS_RB1 = 1'b0;
assign DS_RB1 = 1'b0;
assign SD_RB1 = 1'b0;

assign reg_rd0 =reg_rd_int0;
assign WS_GND = 2'b00;

assign reg_rd1 =1'b0;

assign wen_reg0[2:wr_enable_int0]=0;
assign wen_reg0[wr_enable_int0-1:0]=WEN;

assign addr_wr1=11'b0000000000;
assign addr_rd1=11'b0000000000;


generate

	if(addr_int0 == 11)
	begin
		assign addr_wr0[10:0]=WA;
		assign addr_rd0[10:0]=RA;
	end
	else
	begin
		assign addr_wr0[10:addr_int0]=0;
		assign addr_wr0[addr_int0-1:0]=WA;
		assign addr_rd0[10:addr_int0]=0;
		assign addr_rd0[addr_int0-1:0]=RA;
	end

    if (data_width_int0 == 18) 
	begin
        assign in_reg0[data_width_int0-1:0] =WD[data_width_int0-1:0]; 
    end  
    else if (data_width_int0 > 9 && data_width_int0 < 18)
    begin
		assign in_reg0[17:data_width_int0] =0;
        assign in_reg0[data_width_int0-1:0] =WD[data_width_int0-1:0]; 
    end
    else if (data_width_int0 <= 9) 
	begin
		assign in_reg0[17:data_width_int0] =0;
        assign in_reg0[data_width_int0-1:0] =WD[data_width_int0-1:0]; 
    end

	if(data_width_int0 <=9)
    begin
		assign WS1_0 = 2'b00;
		assign WS2_0 = 2'b00;
    end
	else if(data_width_int0 >9 && data_width_int0 <=18)
    begin
		assign WS1_0 = 2'b01;
		assign WS2_0 = 2'b01;
    end
	else if(data_width_int0 > 18)
    begin
		assign WS1_0 = 2'b10;
		assign WS2_0 = 2'b10;
    end

endgenerate

	ram8k_2x1_cell_macro # (.INIT(INIT),
						    .init_ram1(init_ram1),
							.init_ram2(0),
							.data_width_int0(data_width_int0), 
							.data_depth_int0(data_depth_int0),
							.data_width_int1(0), 
							.data_depth_int1(0),
							.init_ad(1)
                           )
                        U1 (.A1_0(addr_wr0) , 
							.A1_1(addr_wr1), 
							.A2_0(addr_rd0), 
							.A2_1(addr_rd1), 
							.ASYNC_FLUSH_0(GND), //chk
							.ASYNC_FLUSH_1(GND), //chk
							.ASYNC_FLUSH_S0(GND),
							.ASYNC_FLUSH_S1(GND),
							.CLK1_0(WClk), 
							.CLK1_1(GND), 
							.CLK1S_0(WClk0_Sel), 
							.CLK1S_1(WClk1_Sel),
							.CLK1EN_0(WClk_En), 
							.CLK1EN_1(GND), 
							.CLK2_0(RClk),
							.CLK2_1(GND), 
							.CLK2S_0(RClk0_Sel),
							.CLK2S_1(RClk1_Sel), 
							.CLK2EN_0(RClk_En), 
							.CLK2EN_1(GND), 
							.CONCAT_EN_0(GND),
							.CONCAT_EN_1(GND), 
							.CS1_0(WD0_SEL), 
							.CS1_1(WD1_SEL), 
							.CS2_0(RD0_SEL), 
							.CS2_1(RD1_SEL), 
							.DIR_0(GND),
							.DIR_1(GND), 
							.FIFO_EN_0(GND), 
							.FIFO_EN_1(GND), 
							.P1_0(GND), //P1_0
							.P1_1(GND), //P1_1
							.P2_0(GND), //
							.P2_1(GND), //
							.PIPELINE_RD_0(reg_rd0), 
							.PIPELINE_RD_1(reg_rd1), 
							.SYNC_FIFO_0(GND),
							.SYNC_FIFO_1(GND), 
							.WD_1({18{GND}}), 
							.WD_0({1'b0,in_reg0[15:8],1'b0,in_reg0[7:0]}), 
							.WIDTH_SELECT1_0(WS1_0), 
							.WIDTH_SELECT1_1(WS_GND), 
							.WIDTH_SELECT2_0(WS2_0),
							.WIDTH_SELECT2_1(WS_GND), 
							.WEN1_0(wen_reg0[1:0]), 
							.WEN1_1({2{GND}}), 
							.Almost_Empty_0(),
							.Almost_Empty_1(), 
							.Almost_Full_0(), 
							.Almost_Full_1(),
							.POP_FLAG_0(), 
							.POP_FLAG_1(), 
							.PUSH_FLAG_0(), 
							.PUSH_FLAG_1(),
							.RD_0({out_par0[1],out_reg0[15:8],out_par0[0],out_reg0[7:0]}), 
							.RD_1(),
							.SD(SD),
							.SD_RB1(SD_RB1),
							.LS(LS),
							.LS_RB1(LS_RB1),
							.DS(DS),
							.DS_RB1(DS_RB1),
							.TEST1A(GND),
							.TEST1B(GND),
							.RMA(4'd0),
							.RMB(4'd0),
							.RMEA(GND),
							.RMEB(GND)
							);
						
    assign RD[data_width_int0-1 :0]= out_reg0[data_width_int0-1 :0];
					

endmodule

