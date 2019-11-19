module MISTRAL_FF(input D, CLK, ACn, EN, output reg Q);

parameter [0:0] INIT = 1'b0;

localparam INIT_STR = (INIT == 1'b0) ? "low" : "high";

dffeas #(.power_up(INIT_STR), .is_wysiwyg("true")) _TECHMAP_REPLACE_ (.d(D), .clk(CLK), .clrn(ACn), .ena(EN), .q(Q));

endmodule
