module data_mem (
    input   wire    [15:0]  datamem_data,
    input   wire    [15:0]  datamem_addr,
    input   wire            clk, rst, we, re,
    output  wire    [15:0]  datamem_strm
);
    integer i;
    reg [15:0] internal_mem [127:0];

    always @(posedge clk) begin
        if (~rst) begin
            for (i = 0; i < 128; i = i + 1)
                internal_mem[i] <= 16'b0; 
        end

        else if (we) begin
            internal_mem[datamem_addr] <= datamem_data;
        end
    end

    assign datamem_strm = (re) ? internal_mem[datamem_addr] : 16'b0;

endmodule