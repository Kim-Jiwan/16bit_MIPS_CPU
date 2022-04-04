module field_generator #(
    parameter inst_SIZE = 16
) (
    input   	    [inst_SIZE-1:0]     instr,

    output          [2:0]               opcode,
    output          [2:0]               rs,
    output          [2:0]               rt,
    output          [2:0]               rd,
    output          [3:0]               funct,
	output          [6:0]               imm_val
);

	assign PC_instr	=	instr[12:0];
	
    assign opcode   =   instr[15:13];
    assign rs       =   instr[12:10]; 	// read register 1
    assign rt       =   instr[9:7];		// read register 2
    assign rd       =   instr[6:4];		// write register
    assign funct    =   instr[3:0];
    assign imm_val  =   instr[6:0];
	
endmodule