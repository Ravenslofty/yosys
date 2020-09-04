module \$__out_buff (Q, A);
	output Q;
    input A;

    parameter _TECHMAP_CONSTMSK_A_ = 0;
    parameter _TECHMAP_CONSTVAL_A_ = 0;

    if(_TECHMAP_CONSTMSK_A_ == 1) begin
        d_buff _TECHMAP_REPLACE_ (.OUT_DBUF(Q), .IN_DBUF(_TECHMAP_CONSTVAL_A_));
    end
    else begin
        out_buff _TECHMAP_REPLACE_ (.Q(Q), .A(A));
    end
endmodule

module \$__in_buff (Q, A);
	output Q;
    input A;

    in_buff _TECHMAP_REPLACE_ (.Q(Q), .A(A));

endmodule