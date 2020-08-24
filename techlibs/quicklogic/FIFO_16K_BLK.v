module FIFO_16K_BLK(DIN0,Fifo_Push_Flush0,Fifo_Pop_Flush0,PUSH0,POP0,Push_Clk0,Pop_Clk0,Push_Clk0_En,Pop_Clk0_En,Fifo0_Dir,Async_Flush0,Almost_Full0,Almost_Empty0,PUSH_FLAG0,POP_FLAG0,DOUT0,
					DIN1,Fifo_Push_Flush1,Fifo_Pop_Flush1,PUSH1,POP1,Push_Clk1,Pop_Clk1,Push_Clk1_En,Pop_Clk1_En,Fifo1_Dir,Async_Flush1,Almost_Full1,Almost_Empty1,PUSH_FLAG1,POP_FLAG1,DOUT1
					);
					
parameter 	Concatenation_En = 0,

			data_depth_int0 = 512,
			data_width_int0 = 36,
			reg_rd_int0    	= 0,
			sync_fifo_int0 	= 0,
			
			data_depth_int1 = 512,
			data_width_int1 = 18,
			reg_rd_int1     = 0,
			sync_fifo_int1  = 0;

input Fifo_Push_Flush0,Fifo_Pop_Flush0;
input Push_Clk0,Pop_Clk0;
input PUSH0,POP0;
input [data_width_int0-1:0] DIN0;
input Push_Clk0_En,Pop_Clk0_En,Fifo0_Dir,Async_Flush0;
output [data_width_int0-1:0] DOUT0;
output [3:0] PUSH_FLAG0,POP_FLAG0;
output Almost_Full0,Almost_Empty0;

input Fifo_Push_Flush1,Fifo_Pop_Flush1;
input Push_Clk1,Pop_Clk1;
input PUSH1,POP1;
input [data_width_int1-1:0] DIN1;
input Push_Clk1_En,Pop_Clk1_En,Fifo1_Dir,Async_Flush1;
output [data_width_int1-1:0] DOUT1;
output [3:0] PUSH_FLAG1,POP_FLAG1;
output Almost_Full1,Almost_Empty1;

wire LS,DS,SD,LS_RB1,DS_RB1,SD_RB1;

wire [10:0] addr_wr,addr_rd;
wire clk1_sig0, clk2_sig0, clk1_sig_en0, clk2_sig_en0, fifo_clk1_flush_sig0, fifo_clk2_flush_sig0, p1_sig0, p2_sig0,clk1_sig_sel0,clk2_sig_sel0;
wire reg_rd0,sync_fifo0; 
wire [35:0] in_reg0;
wire [35:0] out_reg0;
wire [1:0] WS1_0;
wire [1:0] WS2_0;
wire Push_Clk0_Sel,Pop_Clk0_Sel;
wire Async_Flush_Sel0;

wire clk1_sig1, clk2_sig1, clk1_sig_en1, clk2_sig_en1, fifo_clk1_flush_sig1, fifo_clk2_flush_sig1, p1_sig1, p2_sig1,clk1_sig_sel1,clk2_sig_sel1;
wire reg_rd1,sync_fifo1;
wire [35:0] in_reg1;
wire [35:0] out_reg1;
wire [1:0] WS1_1;
wire [1:0] WS2_1;
wire Push_Clk1_Sel,Pop_Clk1_Sel;
wire Async_Flush_Sel1;

wire [3:0] out_par0;
wire [1:0] out_par1;

assign LS = 1'b0;
assign DS = 1'b0;
assign SD = 1'b0;
assign LS_RB1 = 1'b0;
assign DS_RB1 = 1'b0;
assign SD_RB1 = 1'b0;

assign VCC = 1'b1;
assign GND = 1'b0;

assign Push_Clk0_Sel  	= 1'b0;
assign Pop_Clk0_Sel   	= 1'b0;
assign Async_Flush_Sel0 = 1'b0;

assign reg_rd0 = reg_rd_int0;
assign sync_fifo0 = sync_fifo_int0;

generate
begin
	assign addr_wr=11'b00000000000;
	assign addr_rd=11'b00000000000;
end
endgenerate

assign clk1_sig0 = Fifo0_Dir ? Pop_Clk0 : Push_Clk0;
assign clk2_sig0 = Fifo0_Dir ? Push_Clk0 : Pop_Clk0 ;
assign clk1_sig_en0 = Fifo0_Dir ? Pop_Clk0_En : Push_Clk0_En;
assign clk2_sig_en0 = Fifo0_Dir ? Push_Clk0_En : Pop_Clk0_En ;
assign clk1_sig_sel0 =  Push_Clk0_Sel;
assign clk2_sig_sel0 =  Pop_Clk0_Sel ;
assign fifo_clk1_flush_sig0 = Fifo0_Dir ? Fifo_Pop_Flush0 : Fifo_Push_Flush0;
assign fifo_clk2_flush_sig0 = Fifo0_Dir ? Fifo_Push_Flush0 : Fifo_Pop_Flush0 ;
assign p1_sig0 = Fifo0_Dir ? POP0 : PUSH0;
assign p2_sig0 = Fifo0_Dir ? PUSH0 : POP0 ;

generate 
//Generating data
	if (Concatenation_En == 1'b0) begin
		assign clk1_sig1 = Fifo1_Dir ? Pop_Clk1 : Push_Clk1;
		assign clk2_sig1 = Fifo1_Dir ? Push_Clk1 : Pop_Clk1 ;
		assign clk1_sig_en1 = Fifo1_Dir ? Pop_Clk1_En : Push_Clk1_En;
		assign clk2_sig_en1 = Fifo1_Dir ? Push_Clk1_En : Pop_Clk1_En ;
		assign clk1_sig_sel1 =  Push_Clk1_Sel;
		assign clk2_sig_sel1 =  Pop_Clk1_Sel ;
		assign fifo_clk1_flush_sig1 = Fifo1_Dir ? Fifo_Pop_Flush1 : Fifo_Push_Flush1;
		assign fifo_clk2_flush_sig1 = Fifo1_Dir ? Fifo_Push_Flush1 : Fifo_Pop_Flush1 ;
		assign p1_sig1 = Fifo1_Dir ? POP1 : PUSH1;
		assign p2_sig1 = Fifo1_Dir ? PUSH1 : POP1 ;
		assign reg_rd1 = reg_rd_int1;
		assign sync_fifo1 = sync_fifo_int1;
		assign Push_Clk1_Sel  	= 1'b0;
		assign Pop_Clk1_Sel   	= 1'b0;
		assign Async_Flush_Sel1 = 1'b0;
	end

	if (data_width_int0 == 36) 
	begin
        assign in_reg0[data_width_int0-1:0] =DIN0[data_width_int0-1:0]; 
    end  
    else if (data_width_int0 > 9 && data_width_int0 < 36)
    begin
		assign in_reg0[35:data_width_int0] =0;
        assign in_reg0[data_width_int0-1:0] =DIN0[data_width_int0-1:0]; 
    end
    else if (data_width_int0 <= 9) 
	begin
		assign in_reg0[35:data_width_int0] =0;
        assign in_reg0[data_width_int0-1:0] =DIN0[data_width_int0-1:0]; 
    end

    if (Concatenation_En == 0) begin
		if (data_width_int1 == 36) 
		begin
			assign in_reg1[data_width_int1-1:0] =DIN1[data_width_int1-1:0]; 
		end  
		else if (data_width_int1 > 9 && data_width_int1 < 36)
		begin
			assign in_reg1[35:data_width_int1] =0;
			assign in_reg1[data_width_int1-1:0] =DIN1[data_width_int1-1:0]; 
		end
		else if (data_width_int1 <= 9) 
		begin
			assign in_reg1[35:data_width_int1] =0;
			assign in_reg1[data_width_int1-1:0] =DIN1[data_width_int1-1:0]; 
		end
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

    if (Concatenation_En == 0) begin
		if(data_width_int1 <=9)
		begin
			assign WS1_1 = 2'b00;
			assign WS2_1 = 2'b00;
		end
		else if(data_width_int1 >9 && data_width_int1 <=18)
		begin
			assign WS1_1 = 2'b01;
			assign WS2_1 = 2'b01;
		end
		else if(data_width_int1 > 18)
		begin
			assign WS1_1 = 2'b10;
			assign WS2_1 = 2'b10;
		end
    end

  if (Concatenation_En == 1'b0)	

	ram8k_2x1_cell_macro U1 (.A1_0(addr_wr) , 
							.A1_1(addr_wr), 
							.A2_0(addr_rd), 
							.A2_1(addr_rd), 
							.ASYNC_FLUSH_0(Async_Flush0), 
							.ASYNC_FLUSH_1(Async_Flush1),
							.ASYNC_FLUSH_S0(Async_Flush_Sel0), 
							.ASYNC_FLUSH_S1(Async_Flush_Sel1), 
							.CLK1_0(clk1_sig0), 
							.CLK1_1(clk1_sig1), 
							.CLK1EN_0(clk1_sig_en0), 
							.CLK1EN_1(clk1_sig_en1), 
							.CLK2_0(clk2_sig0),
							.CLK2_1(clk2_sig1), 
							.CLK1S_0(clk1_sig_sel0), 
							.CLK1S_1(clk1_sig_sel1), 
							.CLK2S_0(clk2_sig_sel0),
							.CLK2S_1(clk2_sig_sel1),
							.CLK2EN_0(clk2_sig_en0), 
							.CLK2EN_1(clk2_sig_en1), 
							.CONCAT_EN_0(GND),
							.CONCAT_EN_1(GND), 
							.CS1_0(fifo_clk1_flush_sig0), 
							.CS1_1(fifo_clk1_flush_sig1), 
							.CS2_0(fifo_clk2_flush_sig0), 
							.CS2_1(fifo_clk2_flush_sig1), 
							.DIR_0(Fifo0_Dir),
							.DIR_1(Fifo1_Dir), 
							.FIFO_EN_0(VCC), 
							.FIFO_EN_1(VCC), 
							.P1_0(p1_sig0), 
							.P1_1(p1_sig1), 
							.P2_0(p2_sig0),
							.P2_1(p2_sig1), 
							.PIPELINE_RD_0(reg_rd0), 
							.PIPELINE_RD_1(reg_rd1), 
							.SYNC_FIFO_0(sync_fifo0),
							.SYNC_FIFO_1(sync_fifo1), 
							.WD_1({1'b0,in_reg1[15:8],1'b0,in_reg1[7:0]}), 
							.WD_0({1'b0,in_reg0[15:8],1'b0,in_reg0[7:0]}), 
							.WIDTH_SELECT1_0(WS1_0), 
							.WIDTH_SELECT1_1(WS1_1), 
							.WIDTH_SELECT2_0(WS2_0),
							.WIDTH_SELECT2_1(WS2_1), 
							// PP-II doesn't use this signal
							.WEN1_0({GND,GND}), 
							.WEN1_1({GND,GND}), 
							.Almost_Empty_0(Almost_Empty0),
							.Almost_Empty_1(Almost_Empty1), 
							.Almost_Full_0(Almost_Full0), 
							.Almost_Full_1(Almost_Full1),
							.POP_FLAG_0(POP_FLAG0), 
							.POP_FLAG_1(POP_FLAG1), 
							.PUSH_FLAG_0(PUSH_FLAG0), 
							.PUSH_FLAG_1(PUSH_FLAG1),
							.RD_0({out_par0[1],out_reg0[15:8],out_par0[0],out_reg0[7:0]}), 
							.RD_1({out_par1[1],out_reg1[15:8],out_par1[0],out_reg1[7:0]}),
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

if (Concatenation_En == 1'b1)
	
	ram8k_2x1_cell_macro U2 (.A1_0(addr_wr) , 
							.A1_1(addr_wr), 
							.A2_0(addr_rd), 
							.A2_1(addr_rd), 
							.ASYNC_FLUSH_0(Async_Flush0), 
							.ASYNC_FLUSH_1(GND),
							.ASYNC_FLUSH_S0(Async_Flush_Sel0), 
							.ASYNC_FLUSH_S1(Async_Flush_Sel0),
							.CLK1_0(clk1_sig0), 
							.CLK1_1(clk1_sig0), 
							.CLK1EN_0(clk1_sig_en0), 
							.CLK1EN_1(clk1_sig_en0), 
							.CLK2_0(clk2_sig0),
							.CLK2_1(clk2_sig0), 
							.CLK1S_0(clk1_sig_sel0), 
							.CLK1S_1(clk1_sig_sel0), 
							.CLK2S_0(clk2_sig_sel0),
							.CLK2S_1(clk2_sig_sel0),
							.CLK2EN_0(clk2_sig_en0), 
							.CLK2EN_1(clk2_sig_en0), 
							.CONCAT_EN_0(VCC),
							.CONCAT_EN_1(GND), 
							.CS1_0(fifo_clk1_flush_sig0), 
							.CS1_1(GND), 
							.CS2_0(fifo_clk2_flush_sig0), 
							.CS2_1(GND), 
							.DIR_0(Fifo0_Dir),
							.DIR_1(GND), 
							.FIFO_EN_0(VCC), 
							.FIFO_EN_1(GND), 
							.P1_0(p1_sig0), 
							.P1_1(GND), 
							.P2_0(p2_sig0),
							.P2_1(GND), 
							.PIPELINE_RD_0(reg_rd0), 
							.PIPELINE_RD_1(GND), 
							.SYNC_FIFO_0(sync_fifo0),
							.SYNC_FIFO_1(GND), 
							.WD_1({1'b0,in_reg0[31:24],1'b0,in_reg0[23:16]}), 
							.WD_0({1'b0,in_reg0[15:8],1'b0,in_reg0[7:0]}), 
							.WIDTH_SELECT1_0(WS1_0), 
							.WIDTH_SELECT1_1({GND,GND}), 
							.WIDTH_SELECT2_0(WS2_0),
							.WIDTH_SELECT2_1({GND,GND}), 
							.WEN1_0({GND,GND}), 
							.WEN1_1({GND,GND}), 
							.Almost_Empty_0(Almost_Empty0),
							.Almost_Empty_1(), 
							.Almost_Full_0(Almost_Full0), 
							.Almost_Full_1(),
							.POP_FLAG_0(POP_FLAG0), 
							.POP_FLAG_1(), 
							.PUSH_FLAG_0(PUSH_FLAG0), 
							.PUSH_FLAG_1(),
							.RD_0({out_par0[1],out_reg0[15:8],out_par0[0],out_reg0[7:0]}), 
							.RD_1({out_par0[3],out_reg0[31:24],out_par0[2],out_reg0[23:16]}),
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

endgenerate
						
generate

    assign DOUT0[data_width_int0-1 :0]= out_reg0[data_width_int0-1 :0];

	if (Concatenation_En == 0) begin
		assign DOUT1[data_width_int1-1 :0]= out_reg1[data_width_int1-1 :0];
    end

endgenerate	

endmodule
