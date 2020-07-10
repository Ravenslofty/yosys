module ff(
    output reg CQZ,
    input D,
    (* clkbuf_sink *)
    input QCK,
    input QEN,
    (* clkbuf_sink *)
    input QRT,
    (* clkbuf_sink *)
    input QST
);
    parameter [0:0] INIT = 1'b0;
    initial CQZ = INIT;

    always @(posedge CLK or posedge QRT or posedge QST)
        if (QRT)
            CQZ <= 1'b0;
        else if (QST)
            CQZ <= 1'b1;
        else if (QEN)
            CQZ <= D;
endmodule
