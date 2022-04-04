module MUX_3_1_3bit (
    input   	    [1:0]       sel,
    input   	    [2:0]     	in0,
    input   	    [2:0]     	in1,
    input   	    [2:0]     	in2,

    output  reg     [2:0]     	out
);

    always @(sel or in0 or in1 or in2) begin
        case(sel)
            2'b00 : out = in0;
            2'b01 : out = in1;
            2'b10 : out = in2;
            2'b11 : out = 3'b0;
        endcase
    end
    
endmodule