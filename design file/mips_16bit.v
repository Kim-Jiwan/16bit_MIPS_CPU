module mips_16bit #(
    parameter inst_SIZE =   16,
    parameter PC_SIZE   =   13 // PC is 13bit or 16bit? what is different?
) (
    input   	    				clk,
    input   				    	rst,

    output		[inst_SIZE-1:0]		current_instr,
	output		[PC_SIZE-1:0]		PC_current
);
	
    wire    [PC_SIZE-1:0]       PC_next;
    wire    [PC_SIZE-1:0]       PC_p2;

    wire    [PC_SIZE-1:0]       addr;
    wire    [2:0]               opcode;
    wire    [2:0]               rs; // source register
    wire    [2:0]               rt; // target register
    wire    [2:0]               rd; // destination register
    wire    [6:0]               imm_val;
    wire    [3:0]               funct; // function code
    wire    [2:0]               reg_write_addr; // output of MUX3_to_1 before registers
    // control signal
    wire    [1:0]               reg_DST;
    wire    [1:0]               ALU_op;
    wire    [1:0]               mem_to_reg;
    wire                        jump;
    wire                        branch;
    wire                        mem_read;
    wire                        mem_write;
    wire                        ALU_src;
    wire                        reg_write;
    wire                        sign_or_zero;
	
	wire						jr_ctrl;

    // excution port
    wire    [inst_SIZE-1:0]		extended_imm_val;
    wire    [inst_SIZE-1:0]     read_data_1;
    wire    [inst_SIZE-1:0]     read_data_2;
    wire    [inst_SIZE-1:0]     rd2_imm_mux_output;
    wire    [2:0]               ALU_ctrl;

    wire                        zero;
    wire    [inst_SIZE-1:0]     ALU_result;

    wire    [PC_SIZE-1:0]       add_PC_p2_imm_output;

    wire                        zero_and_branch;
    wire    [PC_SIZE-1:0]	    PC_mux1_output;
    wire    [PC_SIZE-1:0]     	PC_mux2_output;

    // memory port
    wire    [inst_SIZE-1:0]     mem_read_data;
    wire    [inst_SIZE-1:0]     mem_to_reg_output;
    wire    [inst_SIZE-1:0]     reg_write_data;

    // fetch
    PC				    PC0(            .clk                (clk),
                                        .rst                (rst),
                                        .PC_next            (PC_next),
                                        
                                        .PC_current         (PC_current)      	        );

	// PC + 1 function module !!
    adder_13bit         adder0(         .in0                (PC_current),
                                        .in1                (13'b1),
                                        .out                (PC_p2)                     );

    inst_mem            inst_mem0(      .clk				(clk),
										.rst				(rst),
										.instr_mem_addr     (PC_current),
										
                                        .instr              (current_instr)             );
    
    field_generator     field_gen0(     .instr              (current_instr),
                                        
                                        .opcode             (opcode),
                                        .rs                 (rs),
                                        .rt                 (rt),
                                        .rd                 (rd),
                                        .funct            	(funct),
                                        .imm_val            (imm_val)                   );

    ctrl_sig_unit       ctrl_sig0(      .opcode             (opcode),
                                        
                                        .reg_DST            (reg_DST),
                                        .jump               (jump),
                                        .branch             (branch),
                                        .mem_read           (mem_read),
                                        .mem_to_reg         (mem_to_reg),
                                        .ALU_op             (ALU_op),
                                        .mem_write          (mem_write),
                                        .ALU_src            (ALU_src),
                                        .reg_write          (reg_write)                 );
										
	jr_ctrl_unit		jr_ctrl0(		.ALU_op				(ALU_op),
										.funct				(funct),
										
										.jr					(jr_ctrl)					);
										
////////////////////not done
    MUX_3_1_3bit        mux3_1_0(       .sel                (reg_DST),
                                        .in0                (rt),
                                        .in1                (rd),
                                        .in2                (3'b111),
                                        
                                        .out                (reg_write_addr)            );

    register_file       reg0(           .clk				(clk),
										.rst				(rst),
										
										.rs					(rs),
										.rt					(rt),
										.rd					(reg_write_addr),
										.reg_write_data 	(reg_write_data),						
										.reg_write			(reg_write),
										
										.read_data_1		(read_data_1),
										.read_data_2		(read_data_2)				);
////////////////////////////

    // excution & memory
    sign_extension      sign_exts(      .imm_val            (imm_val),
	
                                        .extended_imm_val   (extended_imm_val)          );

    MUX_2_1_16bit       mux0(           .sel                (ALU_src),
                                        .in0                (read_data_2),
                                        .in1                (extended_imm_val),
										
                                        .out                (rd2_imm_mux_output)        );

    ALU_ctrl_unit       ALU_ctrl0(      .funct              (funct),
                                        .ALU_op             (ALU_op),

                                        .ALU_ctrl           (ALU_ctrl)                  );
										

    ALU                 ALU0(           .ALU_ctrl           (ALU_ctrl),
                                        .in0                (read_data_1),
                                        .in1                (rd2_imm_mux_output),
                                        
                                        .zero               (zero),
                                        .ALU_output         (ALU_result)                );

    data_mem            datamem(        .data_mem_data      (read_data_2),
                                        .data_mem_addr      (ALU_result),
                                        .clk                (clk),
                                        .rst                (rst),
                                        .mem_read           (mem_read),
                                        .mem_write          (mem_write),
                                        
                                        .data_mem_strm      (mem_read_data)             );

    MUX_3_1_16bit       mux3_1_1(       .sel                (mem_to_reg),
                                        .in0                (ALU_result),
                                        .in1                (mem_read_data),
                                        .in2                ({3'b000, PC_p2}),
                                        
                                        .out                (mem_to_reg_output)         );

	////////////////////////// what is selection signal of this MUX?//////////////////////
    MUX_2_1_16bit	    mux4(           .sel                (jr_ctrl),
                                        .in0                (mem_to_reg_output),
                                        .in1                (16'b0),
                                        
                                        .out                (reg_write_data)            );
    // branch & PC decision
    and (zero_and_branch, branch, zero);

    adder_13bit         adder1(         .in0                (PC_p2),
                                        .in1                (extended_imm_val[12:0]),
                                        
                                        .out                (add_PC_p2_imm_output)      );

    MUX_2_1_13bit       mux1(           .sel                (zero_and_branch),
                                        .in0                (PC_p2),
                                        .in1                (add_PC_p2_imm_output),
                                        
                                        .out                (PC_mux1_output)            );

    MUX_2_1_13bit       mux2(           .sel                (jump),
                                        .in0                (PC_mux1_output),
                                        .in1                (current_instr[12:0]),
                                        
                                        .out                (PC_mux2_output)            );

    MUX_2_1_13bit       mux3(           .sel                (jr_ctrl),
                                        .in0                (PC_mux2_output),
                                        .in1                (read_data_1[12:0]),

                                        .out                (PC_next)                   );
    
endmodule