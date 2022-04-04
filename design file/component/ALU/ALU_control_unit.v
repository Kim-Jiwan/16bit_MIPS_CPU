module ALU_ctrl_unit (
    input   	    [3:0]   funct,
    input   	    [1:0]   ALU_op,

    output  reg     [2:0]   ALU_ctrl
);
    always @(funct or ALU_op) begin
        case(ALU_op)
            2'b00 : begin
				case (funct)
					4'b0000 : ALU_ctrl = 3'b000; // add
					4'b0001 : ALU_ctrl = 3'b001; // sub
					4'b0010 : ALU_ctrl = 3'b010; // and
					4'b0011 : ALU_ctrl = 3'b011; // or
					4'b0100 : ALU_ctrl = 3'b100; // slt shift left
					4'b0101 : ALU_ctrl = 3'b101; // mul
					default : ALU_ctrl = 3'bxxx; // default
				endcase
            end
            2'b01 : ALU_ctrl = 3'b001; // sub -> for zero check
            2'b10 : ALU_ctrl = 3'b100; // slt shift left for slti
            2'b11 : ALU_ctrl = 3'b000; // add for addi, lw, sw
        endcase
    end
endmodule