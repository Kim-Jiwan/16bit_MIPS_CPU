module MUX_2_to_1 #(
    parameter inst_SIZE = 16
) (
    input   wire                    sel,
    input   wire    [inst_SIZE-1:0] in0,
    input   wire    [inst_SIZE-1:0] in1,

    output  wire    [inst_SIZE-1:0] out
);

    assign out = sel ? in0 : in1;
    
endmodule