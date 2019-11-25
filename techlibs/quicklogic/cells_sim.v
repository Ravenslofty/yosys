module QLOGIC_MUX(
    input A,
    input B,
    input S,
    output Y
);
    assign Y = S ? A : B;
endmodule

module QLOGIC_DFFE(input S, input D, input E, input QCK, input R, output reg QZ);
    parameter [0:0] INIT = 1'b0;
    initial QZ = INIT;
    always @(posedge QCK) begin
        if (S)
           QZ <= 1'b1;
        else if (E)
           QZ <= D;
        else if (R)
           QZ <= 0;
    end
endmodule

module QLOGIC_NOT(input A, output Y);
    assign Y = ~A;
endmodule
