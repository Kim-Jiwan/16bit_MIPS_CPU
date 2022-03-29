module mips_16bit #(
    parameter inst_SIZE =   16,
    parameter PC_SIZE   =   13
) (
    input   wire    clk,
    input   wire    rst,

    output          current_instr
);
    reg     [PC_SIZE-1:0]       PC_current;
    wire    [PC_SIZE-1:0]       PC_next;
    wire    [PC_SIZE-1:0]       PC_p2;

    wire    [inst_SIZE-1:0]     instr;
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

    // excution port
    wire    [inst_SIZE-1:0]     extended_imm_val;
    wire    [inst_SIZE-1:0]     read_data_1;
    wire    [inst_SIZE-1:0]     read_data_2;
    wire    [inst_SIZE-1:0]     rt_imm_mux_output;
    wire    [2:0]               ALU_ctrl;

    wire                        zero;
    wire    [inst_SIZE-1:0]     ALU_result;

    wire    [PC_SIZE-1:0]       add_PC_p2_imm_output;

    wire                        zero_and_branch;
    wire    [inst_SIZE-1:0]     PC_mux1_output;
    wire    [inst_SIZE-1:0]     PC_mux2_output;

    // memory port
    wire    [inst_SIZE-1:0]     mem_read_data;
    wire    [inst_SIZE-1:0]     mem_to_reg_output;
    wire    [inst_SIZE-1:0]     reg_write_data;

    // fetch
    program_counter     PC0(            .clk                (clk),
                                        .rst                (rst),
                                        .PC_next            (PC_next),
                                        
                                        .PC_current         (PC_current)                );

    adder               adder0(         .in0                (PC_current),
                                        .in1                (13'b1),
                                        .out                (PC_p2)                     );

    inst_mem            inst_mem0(      .PC                 (PC_current),
                                        .instr              (instr)                     );
    
    field_generator     field_gen0(     .instr              (instr),
                                        
                                        .opcode             (opcode),
                                        .rs                 (rs),
                                        .rt                 (rt),
                                        .rd                 (rd),
                                        .imm_val            (imm_val),
                                        .funct              (funct),
                                        .address            (address)                   );

    ctrl_sig_unit       ctrl_sig0(      .opcode             (opcode),
                                        .rst                (rst),
                                        
                                        .reg_DST            (reg_DST),
                                        .jump               (jump),
                                        .branch             (branch),
                                        .mem_read           (mem_read),
                                        .mem_to_reg         (mem_to_reg),
                                        .ALU_op             (ALU_op),
                                        .mem_write          (mem_write),
                                        .ALU_src            (ALU_src),
                                        .reg_write          (reg_write)                 );
////////////////////not done
    MUX_3_to_1          mux3_1_0(       .sel                (reg_DST),
                                        .in0                (rt),
                                        .in1                (rd),
                                        .in2                (3'b111),
                                        
                                        .out                (reg_write_addr)            );

    registers           reg0(           

                                                                                        );
////////////////////////////

    // excution & memory
    sign_extension      sign_exts(      .imm_val            (imm_val),
                                        .extended_imm_val   (extended_imm_val)          );

    MUX_2_to_1          mux0(           .sel                (ALU_src),
                                        .in0                (extended_imm_val),
                                        .in1                (read_data_2),
                                        .out                (rd2_imm_mux_output)        );

    ALU_ctrl_unit       ALU_ctrl0(      .funct              (funct),
                                        .ALU_op             (ALU_op),

                                        .ALU_ctrl           (ALU_ctrl)                  );

    ALU                 ALU0(           .ALU_ctrl           (ALU_ctrl),
                                        .in0                (read_data_1),
                                        .in1                (rt_imm_mux_output),
                                        
                                        .zero               (zero),
                                        .ALU_output         (ALU_result)                );

    data_mem            datamem(        .datamem_data       (read_data_2),
                                        .datamem_addr       (ALU_result),
                                        .clk                (clk),
                                        .rst                (rst),
                                        .we                 (mem_read),
                                        .re                 (mem_write),
                                        
                                        .datamem_strm       (mem_read_data)             );

    MUX_3_to_1          mux3_1_1(       .sel                (mem_to_reg),
                                        .in0                (ALU_result),
                                        .in1                (mem_read_data),
                                        .in2                (PC_p2),
                                        
                                        .out                (mem_to_reg_output)         );

    MUX_2_to_1          mux4(           .sel                (),
                                        .in0                (1'b0),
                                        .in1                (mem_to_reg_output),
                                        
                                        .out                (reg_write_data)            );
    // branch & PC decision
    and (zero, branch, zero_and_branch);

    adder               adder1(         .in0                (PC_p2),
                                        .in1                (extended_imm_val),
                                        
                                        .out                (add_PC_p2_imm_output)      );

    MUX_2_to_1          mux1(           .sel                (zero_and_branch),
                                        .in0                (add_PC_p2_imm_output),
                                        .in1                (PC_p2),
                                        
                                        .out                (PC_mux1_output)            );

    MUX_2_to_1          mux2(           .sel                (jump),
                                        .in0                (PC_current),
                                        .in1                (PC_mux1_output),
                                        
                                        .out                (PC_mux2_output)            );

    MUX_2_to_1          mux3(           .sel                (jr_ctrl),
                                        .in0                (read_data_1),
                                        .in1                (PC_mux2_output),

                                        .out                (PC_next)                   );
    
endmodule