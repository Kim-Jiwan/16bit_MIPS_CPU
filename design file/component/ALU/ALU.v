module ALU #(
    parameter inst_SIZE = 16
) (
    input   wire    [2:0]               ALU_ctrl,
    input   wire    [inst_SIZE-1:0]     in0,
    input   wire    [inst_SIZE-1:0]     in1,

    output  reg                         zero,
    output  reg     [inst_SIZE-1:0]     ALU_output
);

    wire    [inst_SIZE-1:0]     add_output;
    wire    [inst_SIZE-1:0]     sub_output;
    wire    [inst_SIZE-1:0]     and_output;
    wire    [inst_SIZE-1:0]     or_output;
    wire    [inst_SIZE-1:0]     slt_output;
    wire    [inst_SIZE-1:0]     mul_output;

    adder           adder0(             .in0        (in0),
                                        .in1        (in1),
                                        .out        (add_output)        );

    substractor     substrator0(        .in0        (in0),
                                        .in1        (in1),
                                        .out        (sub_output)        );

    multiplier      multiplier0(        .in0        (in0),
                                        .in1        (in1),
                                        .out        (mul_output)        );

    always @(in0 or in1) begin
        if ((in0 - in1) == 0)
            zero = 1;
        else
            zero = 0;
    end

    assign and_output   =   in0 & in1;
    assign or_output    =   in0 | in1;
    
    always @(in0 or in1 or ALU_ctrl) begin
        case(ALU_ctrl)
            // add operation
            3'b000 : begin
                ALU_output = add_output;
            end
            // sub operation
            3'b001 : begin
                ALU_output = sub_output;
            end
            // and operation
            3'b010 : begin
                ALU_output = and_output;
            end
            // or operation
            3'b011 : begin
                ALU_output = or_output;
            end
            // slt operation
            3'b100 : begin
                ALU_output = slt_output; 
            end
            // mul operation
            3'b100 : begin
                ALU_output = mul_output;
            end
        endcase
    end
endmodule