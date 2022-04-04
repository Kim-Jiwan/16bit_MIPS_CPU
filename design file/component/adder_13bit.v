module adder_13bit #(
    parameter PC_SIZE = 13
) (
    // input   wire            sign_or_zero,
    input   	    [PC_SIZE-1:0]	in0,
	input			[PC_SIZE-1:0]	in1,

    output  	    [PC_SIZE-1:0]	out
);

	assign out = in0 + in1;

endmodule