module MUX_2_1_16bit #(
    parameter inst_SIZE = 16
) (
    input   	                    	sel,
    input   	    [inst_SIZE-1:0] 	in0,
    input   	    [inst_SIZE-1:0] 	in1,

    output  	    [inst_SIZE-1:0] 	out
);

    assign out = sel ? in1 : in0;
    
endmodule