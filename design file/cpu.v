module cpu #(
    parameter inst_SIZE = 16
) (
    input   wire    clk,
    input   wire    rst,

    output          current_instr
);
    reg     [inst_SIZE-1:0]     PC_current;
    
    wire    [inst_SIZE-1:0]     instr;
    wire    [2:0]               opcode;
    wire    [2:0]               rs;
    wire    [2:0]               rt;
    wire    [2:0]               rd;
    wire    [6:0]               imm_val;
    wire    [3:0]               funct;
    wire    [12:0]              address;

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

    wire    [inst_SIZE-1:0]     extended_imm_val;
    wire    [inst_SIZE-1:0]     read_data_1;
    wire    [inst_SIZE-1:0]     read_data_2;
    wire    [inst_SIZE-1:0]     rt_imm_mux_result;
    wire    [2:0]               ALU_ctrl;

    inst_mem            inst_mem0(      .PC                 (PC),
                                        .instr              (instr)             );
    
    field_generator     field_gen0(     .instr              (instr),
                                        
                                        .opcode             (opcode),
                                        .rs                 (rs),
                                        .rt                 (rt),
                                        .rd                 (rd),
                                        .imm_val            (imm_val),
                                        .funct              (funct),
                                        .address            (address)           );

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
                                        .reg_write          (reg_write)         );

    registers           reg0(           

                                                                                );

    sign_extension      sign_exts(      .imm_val            (imm_val),
                                        .extended_imm_val   ()                  );

    MUX_2_to_1          mux0(           .sel                (ALU_src),
                                        .in0                (extended_imm_val),
                                        .in1                (rt),
                                        .out                (rt_imm_mux_result) );

    ALU_ctrl_unit       ALU_ctrl0(      .funct              (funct),
                                        .ALU_op             (ALU_op),

                                        .ALU_ctrl           (ALU_ctrl)          );

    ALU                 ALU0();

    
endmodule