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
    wire    [1:0]               reg_dst;
    wire    [1:0]               alu_op;
    wire    [1:0]               mem_to_reg;
    wire                        jump;
    wire                        branch;
    wire                        mem_read;
    wire                        mem_write;
    wire                        alu_src;
    wire                        reg_write;
    wire                        sign_or_zero;

    inst_mem            inst_mem0(      .PC                 (PC),
                                        .instr              (instr)         );
    
    field_generator     field_gen0(     .instr              (instr),
                                        
                                        .opcode             (opcode),
                                        .rs                 (rs),
                                        .rt                 (rt),
                                        .rd                 (rd),
                                        .imm_val            (imm_val),
                                        .funct              (funct),
                                        .address            (address)       );

    ctrl_sig_unit       ctrl_sig0(      .opcode             (opcode),
                                        .rst                (rst),
                                        
                                        .reg_dst            (reg_dst),
                                        .jump               (jump),
                                        .branch             (branch),
                                        .mem_read           (mem_read),
                                        .mem_to_reg         (mem_to_reg),
                                        .alu_op             (alu_op),
                                        .mem_write          (mem_write),
                                        .alu_src            (alu_src),
                                        .reg_write          (reg_write)     );

    sign_extension      sign_exts(      .imm_val            (imm_val),
                                        .extended_imm_val   ())

    
endmodule