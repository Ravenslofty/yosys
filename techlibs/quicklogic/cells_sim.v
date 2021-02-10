//                FZ        FS
module LUT1(output O, input I0);
    parameter [1:0] INIT = 0;
    parameter EQN = "(I0)";
    assign O = I0 ? INIT[1] : INIT[0];
endmodule

//               TZ        TSL TAB
module LUT2(output O, input I0, I1);
    parameter [3:0] INIT = 4'h0;
	parameter EQN = "(I0)";
    assign O = INIT[{I1, I0}];
endmodule

// O:  TZ
// I0: TA1 TA2 TB1 TB2
// I1: TSL
// I2: TAB
module LUT3(output O, input I0, I1, I2);
    parameter [7:0] INIT = 8'h0;
	parameter EQN = "(I0)";
    assign O = INIT[{I2, I1, I0}];
endmodule

// O:  CZ
// I0: TA1 TA2 TB1 TB2 BA1 BA2 BB1 BB2
// I1: TSL BSL
// I2: TAB BAB
// I3: TBS
module LUT4(output O, input I0, I1, I2, I3);
    parameter [15:0] INIT = 16'h0;
    parameter EQN = "(I0)";
    assign O = INIT[{I3, I2, I1, I0}];
endmodule

module LUT5(output O, input I0, I1, I2, I3, I4);
    parameter [31:0] INIT = 32'h0;
    parameter EQN = "(I0)";
    assign O = INIT[{I4, I3, I2, I1, I0}];
endmodule

module inv(output Q, input A);
    assign Q = A ? 0 : 1;
endmodule

module buff(output Q, input A);
    assign Q = A;
endmodule

module logic_0(output a);
    assign a = 0;
endmodule

module logic_1(output a);
    assign a = 1;
endmodule

(* blackbox *)
module gclkbuff (input A, output Z);

assign Z = A;

endmodule

