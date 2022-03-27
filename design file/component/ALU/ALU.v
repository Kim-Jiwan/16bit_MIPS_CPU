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

    adder           u0(     .in0        (read_data_1),
                            .in1        (read_data_2),
                            .out        (add_output)        );

    substractor     u1(     .in0        (read_data_1),
                            .in1        (read_data_2),
                            .out        (sub_output)        );
    
    always @(read_data_1 or read_data_2 or ALU_ctrl) begin
        case(ALU_ctrl)
            // add operation
            /*3'b000 : begin
                ALU_result = read_data_1 + read_data_2;
                
                if (ALU_result == 0)
                    assign zero = 1;
                else
                    assign zero = 0;
            end
            // sub operation
            3'b001 : begin
                ALU_result = read_data_1 - read_data_2;
                
                if (ALU_result == 0)
                    assign zero = 1;
                else
                    assign zero = 0;
            end
            // and operation
            3'b010 : begin
                ALU_result = 
            end
            3'b011 : 
            3'b100 : 
            3'b111 :*/
        endcase
    end

    
    
endmodule