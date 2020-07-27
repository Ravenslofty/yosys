(* techmap_celltype = "$fa" *)
module fa (
    output S,
	output CO,
	input A,
	input B,
	input CI
);
    
    carry_out #() carry(.CO(CO), .A(A), .B(B), .CI(CI));

    // hex code for adder infer is 0xE896
    LUT4 #(.INIT(16'b 1110_1000_1001_0110)) lut(.O(S), .I0(A), .I1(B), .I2(CI), .I3(1'b0));
    
endmodule
