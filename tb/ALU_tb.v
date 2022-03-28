module ALU_tb #(
    parameter inst_SIZE = 16
) (
    
);
    reg     [2:0]               ALU_ctrl;
    reg     [inst_SIZE-1:0]     in0, in1;

    wire                        zero;
    wire    [inst_SIZE-1:0]     out;

    ALU  alu0(  .ALU_ctrl       (ALU_ctrl),
                .in0            (in0),
                .in1            (in1),
                
                .zero           (zero),
                .ALU_output     (out)           );

    initial begin
        ALU_ctrl        =   3'b000;
        in0             =   16'b0000_0000_0000_0001;
        in1             =   16'b0000_0000_1111_0010; 
    end

    begin
        #5 ALU_ctrl     =   3'b001;
        #5 ALU_ctrl     =   3'b010;
        #5 ALU_ctrl     =   3'b011;
        #5 ALU_ctrl     =   3'b100;
    end

    always begin
        #5 in1 = in1 + 16'b1;
    end
endmodule