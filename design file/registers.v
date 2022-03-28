module registers #(
    parameter inst_SIZE =   16,
    parameter PC_SIZE   =   13
) (
    input   wire    [2:0]               rs,
    input   wire    [2:0]               rt,
    input   wire    [2:0]               rd,
    input   wire    [inst_SIZE-1:0]     reg_write_data,
    input   wire                        reg_write,

    output  wire    [inst_SIZE-1:0]     read_data_1,
    output  wire    [inst_SIZE-1:0]     read_data_2
);
    // rs와 rt의 주소를 받아서 data를 출력하는 module...


endmodule