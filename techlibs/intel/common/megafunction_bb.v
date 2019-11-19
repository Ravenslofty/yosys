// Intel megafunction declarations, to avoid Yosys complaining.

(* blackbox *)
module altera_std_synchronizer(clk, din, dout, reset_n);

parameter depth = 2;

input clk;
input reset_n;
input din;
output dout;

endmodule

(* blackbox *)
module altiobuf_in(datain, dataout);

parameter enable_bus_hold = "FALSE";
parameter use_differential_mode = "FALSE";
parameter number_of_channels = 1;

input [number_of_channels-1:0] datain;
output [number_of_channels-1:0] dataout;

endmodule

(* blackbox *)
module altiobuf_out(datain, dataout);

parameter enable_bus_hold = "FALSE";
parameter use_differential_mode = "FALSE";
parameter use_oe = "FALSE";
parameter number_of_channels = 1;

input [number_of_channels-1:0] datain;
output [number_of_channels-1:0] dataout;

endmodule