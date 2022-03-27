module ALU_control_unit #(
    parameter inst_SIZE = 16
) (
    input   wire    [3:0]   funct,
    input   wire    [1:0]   alu_op,

    output  reg     [2:0]   alu_ctrl
);
    always @(*) begin
        case(alu_op)
            2'b00 : begin
                        case (funct)
                            4'b0000 : assign alu_ctrl = 3'b000; // add
                            4'b0001 : assign alu_ctrl = 3'b001; // sub
                            4'b0010 : assign alu_ctrl = 3'b010; // and
                            4'b0011 : assign alu_ctrl = 3'b011; // or
                            4'b0100 : assign alu_ctrl = 3'b100; // slt shift left
                            4'b0101 : assign alu_ctrl = 3'b101; // mul
                            default : assign alu_ctrl = 3'bxxx; // default
                        endcase
            end
            2'b01 : assign alu_ctrl = 3'b001; // sub -> for zero check
            2'b10 : assign alu_ctrl = 3'b100; // slt shift left for slti
            2'b11 : assign alu_ctrl = 3'b000; // add for addi, lw, sw
        endcase
    end
endmodule