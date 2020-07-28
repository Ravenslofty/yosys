module LUT4(
   output O, 
   input I0,
   input I1,
   input I2,
   input I3
);
   parameter [15:0] INIT = 0;
   assign O = INIT[{I3, I2, I1, I0}];
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

