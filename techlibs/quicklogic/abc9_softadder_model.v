(* abc9_box, lib_whitebox *)
module soft_adder (
	output cout,
	output sumout,
	input a, b,
	(* abc9_carry *)
	input cin
);
    parameter LUT = 0;

    wire [1:0] lut2_out;

    frac_lut4 #(
        .LUT(16'h0)
    ) lut_inst (
        .in({1'b0, cin, b, a}),
        .lut2_out(lut2_out),
        .lut4_out(sumout)
    );

    carry_follower carry_inst(
        .a(lut2_out[1]),
        .b(cin),
        .cin(lut2_out[0]),
        .cout(cout)
    );

    /*parameter I2_IS_CI = 0;

    // Effective LUT input
    wire [3:0] li = (I2_IS_CI) ? {I3, cin, b, a} : {I3, I2, b, a};

    // Output function
    wire [7:0] s1 = li[0] ?
        {LUT[15], LUT[13], LUT[11], LUT[9], LUT[7], LUT[5], LUT[3], LUT[1]} :
        {LUT[14], LUT[12], LUT[10], LUT[8], LUT[6], LUT[4], LUT[2], LUT[0]};

    wire [3:0] s2 = li[1] ? {s1[7], s1[5], s1[3], s1[1]} :
                            {s1[6], s1[4], s1[2], s1[0]};

    wire [1:0] s3 = li[2] ? {s2[3], s2[1]} : {s2[2], s2[0]};

    assign      sumout = li[3] ? s3[1] : s3[0];

    // Carry out function
    assign cout = (s2[2]) ? cin : s2[3];*/

endmodule
