module program_counter #(
    parameter inst_SIZE =   16,
    parameter PC_SIZE   =   13
) (
    input   wire                       clk,
    input   wire                       rst,
    input   wire    [PC_SIZE-1:0]      PC_next,

    output  reg     [PC_SIZE-1:0]      PC_current
);

    always @(posedge clk or negedge rst) begin
        if (!rst)
            PC_current <= 13'b0_0000_0000;
            
        else
            PC_current <= PC_next;
    end
    
endmodule