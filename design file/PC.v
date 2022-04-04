module PC #(
    parameter PC_SIZE = 13
) (
    input   	                       clk,
    input   	                       rst,
    input  		    [PC_SIZE-1:0]      PC_next,

    output  reg     [PC_SIZE-1:0]      PC_current
);

    always @(posedge clk) begin
        if (!rst)
            PC_current <= 13'b0;
            
        else
            PC_current <= PC_next;
    end
    
endmodule