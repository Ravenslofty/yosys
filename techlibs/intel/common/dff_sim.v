module MISTRAL_FF(input D, CLK, ACn, EN, output reg Q);

parameter [0:0] INIT = 1'b0;

initial Q = INIT;

always @(posedge CLK or negedge ACn) begin
    if (!ACn) begin
        Q <= 0;
    end
    else begin
        if (EN) Q <= D;
    end
end

endmodule
