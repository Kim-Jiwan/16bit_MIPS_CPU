module sign_extension #(
    parameter inst_SIZE = 16
) (
    // input   wire            sign_or_zero,
    input   wire    [6:0]   imm_val,

    output  wire    [inst_SIZE-1:0]  extended_imm_val
);
    wire    [8:0]   MSB;

    assign MSB = {9{imm_val[6]}};
    assign extended_imm_val = {MSB, imm_val};
endmodule