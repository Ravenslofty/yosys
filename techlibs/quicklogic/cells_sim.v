(* abc9_lut=1, lib_whitebox *)
module LUT4(
   output O, 
   input I0,
   input I1,
   input I2,
   input I3
);
   parameter [15:0] INIT = 0;
   //assign O = INIT[{I3, I2, I1, I0}];
   wire [7:0] s3 = I3 ? INIT[15:8] : INIT[7:0];
	wire [3:0] s2 = I2 ?       s3[ 7:4] :       s3[3:0];
	wire [1:0] s1 = I1 ?       s2[ 3:2] :       s2[1:0];
	assign O = I0 ? s1[1] : s1[0];
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

