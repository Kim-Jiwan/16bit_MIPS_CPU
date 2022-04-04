module ctrl_sig_unit (
    input   	    [2:0]   opcode,

    output  reg     [1:0]   reg_DST,
    output  reg             jump,
    output  reg             branch,
    output  reg             mem_read,
    output  reg     [1:0]   mem_to_reg,
    output  reg     [1:0]   ALU_op,
    output  reg             mem_write,
    output  reg             ALU_src,
    output  reg             reg_write
);

	always @(opcode) begin
		case(opcode)
                3'b000 : begin // R format
                    reg_DST     <= 2'b01;
                    jump        <= 1'b0;
                    branch      <= 1'b0;
                    mem_read    <= 1'b0;
                    mem_to_reg  <= 2'b00;
                    ALU_op      <= 2'b00;
                    mem_write   <= 1'b0;
                    ALU_src     <= 1'b0;
                    reg_write   <= 1'b1;
                end
                3'b100 : begin // I format lw instruction
                    reg_DST     <= 2'b00;
                    jump        <= 1'b0;
                    branch      <= 1'b0;
                    mem_read    <= 1'b1;
                    mem_to_reg  <= 2'b01;
                    ALU_op      <= 2'b11;
                    mem_write   <= 1'b0;
                    ALU_src     <= 1'b1;
                    reg_write   <= 1'b1;
                end
                3'b101 : begin // I format sw instruction
                    reg_DST     <= 2'b00;
                    jump        <= 1'b0;
                    branch      <= 1'b0;
                    mem_read    <= 1'b0;
                    mem_to_reg  <= 1'b0;
                    ALU_op      <= 2'b11;
                    mem_write   <= 1'b1;
                    ALU_src     <= 1'b1;
                    reg_write   <= 1'b0;
                end
                3'b110 : begin // I format beq instruction
                    reg_DST     <= 2'b00;
                    jump        <= 1'b0;
                    branch      <= 1'b1;
                    mem_read    <= 1'b0;
                    mem_to_reg  <= 2'b00;
                    ALU_op      <= 2'b01;
                    mem_write   <= 1'b0;
                    ALU_src     <= 1'b0;
                    reg_write   <= 1'b0;
                end
                3'b111 : begin // I format addi instruction
                    reg_DST     <= 2'b00;
                    jump        <= 1'b0;
                    branch      <= 1'b0;
                    mem_read    <= 1'b0;
                    mem_to_reg  <= 2'b00;
                    ALU_op      <= 2'b11;
                    mem_write   <= 1'b0;
                    ALU_src     <= 1'b1;
                    reg_write   <= 1'b1;
                end
                3'b001 : begin // I format slti instruction
                    reg_DST     <= 2'b00;
                    jump        <= 1'b0;
                    branch      <= 1'b0;
                    mem_read    <= 1'b0;
                    mem_to_reg  <= 2'b00;
                    ALU_op      <= 2'b10;
                    mem_write   <= 1'b0;
                    ALU_src     <= 1'b1;
                    reg_write   <= 1'b1;
                end
                3'b010 : begin // J format j instruction
                    reg_DST     <= 2'b00;
                    jump        <= 1'b1;
                    branch      <= 1'b0;
                    mem_read    <= 1'b0;
                    mem_to_reg  <= 2'b00;
                    ALU_op      <= 2'b00;
                    mem_write   <= 1'b0;
                    ALU_src     <= 1'bx;
                    reg_write   <= 1'b0;
                end
                3'b011 : begin // J format jal instruction
                    reg_DST     <= 2'b10;
                    jump        <= 1'b1;
                    branch      <= 1'b0;
                    mem_read    <= 1'b0;
                    mem_to_reg  <= 2'b10;
                    ALU_op      <= 2'b00;
                    mem_write   <= 1'b0;
                    ALU_src     <= 1'bx;
                    reg_write   <= 1'b1;
                end
				default : begin
					reg_DST     <= 2'b00;
					jump        <= 1'b0;
					branch      <= 1'b0;
					mem_read    <= 1'b0;
					mem_to_reg  <= 2'b00;
					ALU_op      <= 2'b00;
					mem_write   <= 1'b0;
					ALU_src     <= 1'b0;
					reg_write   <= 1'b0;
				end
		endcase
	end
endmodule