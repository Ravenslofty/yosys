`ifndef NO_LUT
    module \$lut (A, Y);
    parameter WIDTH = 0;
    parameter LUT = 0;

    input [WIDTH-1:0] A;
    output Y;

    generate
        if (WIDTH == 1) 
        begin
            LUT4 #(.EQN(""),.INIT(LUT)) _TECHMAP_REPLACE_ (.O(Y), .I0(1'b0), .I1(1'b0), .I2(1'b0), .I3(A[0]));
        end 
        else if (WIDTH == 2) 
        begin
            LUT4 #(.EQN(""),.INIT(LUT)) _TECHMAP_REPLACE_ (.O(Y), .I0(1'b0), .I1(1'b0), .I2(A[1]), .I3(A[0]));
        end 
        else if (WIDTH == 3) 
        begin
            LUT4 #(.EQN(""),.INIT(LUT)) _TECHMAP_REPLACE_ (.O(Y), .I0(1'b0), .I1(A[2]), .I2(A[1]), .I3(A[0]));
        end else if (WIDTH == 4) 
        begin
            LUT4 #(.EQN(""),.INIT(LUT)) _TECHMAP_REPLACE_ (.O(Y),.I0(A[0]), .I1(A[1]), .I2(A[2]), .I3(A[3]));
        end else
        begin
            wire _TECHMAP_FAIL_ = 1;
        end
    endgenerate
    endmodule
`endif
