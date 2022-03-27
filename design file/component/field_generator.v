module field_generator #(
    parameter inst_SIZE = 16
) (
    input   wire    [inst_SIZE-1:0]     instr,

    //output  wire    [12:0]              PC_inst, // ?? 이건 뭔지 모르겠다.

    output  wire    [2:0]               opcode,
    output  wire    [2:0]               rs,
    output  wire    [2:0]               rt,
    output  wire    [2:0]               rd,
    output  wire    [6:0]               imm_val,
    output  wire    [3:0]               funct,
    output  wire    [12:0]              address
);
    assign opcode   =   instr[15:13];
    assign rs       =   instr[12:10];
    assign rt       =   instr[9:7];
    assign rd       =   instr[6:4];
    assign funct    =   instr[3:0];

    assign imm_val  =   instr[6:0];
    // assign 


endmodule