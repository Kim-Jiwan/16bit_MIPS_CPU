module jr_ctrl_unit (
	input			[1:0]		ALU_op,
    input   	    [3:0]       funct,

    output  reg	    			jr
);
	// funct == 1000 -> jr instr
	// opcode == 000 -> ALUop == 00
	always @(ALU_op or funct) begin
		if ({funct, ALU_op} == 6'b100000)
			jr = 1'b1;
		else
			jr = 1'b0;
	end

endmodule