module MUX_3_1_16bit #(
    parameter inst_SIZE =   16
) (
    input   	    [1:0]               sel,
    input   	    [inst_SIZE-1:0]     in0,
    input   	    [inst_SIZE-1:0]     in1,
    input   	    [inst_SIZE-1:0]     in2,

    output  reg     [inst_SIZE-1:0]     out
);

    always @(sel or in0 or in1 or in2) begin
        case(sel)
            2'b00 : out = in0;
            2'b01 : out = in1;
            2'b10 : out = in2;
            default : out = 16'b0;
        endcase
    end
    
endmodule