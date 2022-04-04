module MUX_2_1_13bit #(
    parameter PC_SIZE = 13
) (
    input   	                    sel,
    input   	    [PC_SIZE-1:0] 	in0,
    input   	    [PC_SIZE-1:0] 	in1,

    output  	    [PC_SIZE-1:0] 	out
);

    assign out = sel ? in1 : in0;
    
endmodule