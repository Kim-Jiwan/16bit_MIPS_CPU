module sign_extension (
    input   wire            sign_or_zero,
    input   wire    [6:0]   imm_val,

    output  wire    [13:0]  extended_imm_val
);

    assign 

    always @(*) begin
        if (imm_val[7]) begin
            assign extended_imm_val = {7{imm_val}
        end
    end
    
endmodule