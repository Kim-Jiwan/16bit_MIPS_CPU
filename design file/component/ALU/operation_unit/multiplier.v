module multiplier #(
    parameter dataSIZE = 16
) (
    input   wire    [dataSIZE-1:0]  in0,
    input   wire    [dataSIZE-1:0]  in1,

    output  wire    [dataSIZE-1:0]  out
);

    assign out = in0 * in1;
    
endmodule