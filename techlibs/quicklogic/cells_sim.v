// O:  CZ
// I0: TA1 TA2 TB1 TB2 BA1 BA2 BB1 BB2
// I1: TSL BSL
// I2: TAB BAB
// I3: TBS
module LUT4(output O, input I0, I1, I2, I3);
    parameter [15:0] INIT = 0;
    assign O = INIT[{I3, I2, I1, I0}];
endmodule

module inv(output Q, input A);
    assign Q = A ? 0 : 1;
endmodule

module buff(output Q, input A);
    assign Q = A;
endmodule

module inpad(
    output Q,
    (* iopad_external_pin *)
    input P
);
    assign Q = P;
endmodule

module outpad(
    (* iopad_external_pin *)
    output P,
    input A
);
    assign P = A;
endmodule

module ckpad(
    output Q,
    (* iopad_external_pin *)
    input P
);
    assign Q = P;
endmodule

module bipad(
    input A,
    input EN,
    output Q,
    (* iopad_external_pin *)
    inout P
);
    assign Q = P;
    assign P = EN ? A : 1'bz;
endmodule

module logic_0(output a);
    assign a = 0;
endmodule

module logic_1(output a);
    assign a = 1;
endmodule

