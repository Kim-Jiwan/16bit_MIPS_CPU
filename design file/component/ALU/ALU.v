module ALU #(
    parameter inst_SIZE = 16
) (
    input   	    [2:0]               ALU_ctrl,
    input   	    [inst_SIZE-1:0]     in0, // rd
    input   	    [inst_SIZE-1:0]     in1, // rs

    output  reg                         zero,
    output  reg     [inst_SIZE-1:0]     ALU_output
);

    wire    [inst_SIZE-1:0]     add_output;
    wire    [inst_SIZE-1:0]     sub_output;
    wire    [inst_SIZE-1:0]     and_output;
    wire    [inst_SIZE-1:0]     or_output;
    wire    [inst_SIZE-1:0]     slt_output;
    wire    [inst_SIZE-1:0]     mul_output;

    assign  add_output  =   in0 + in1;
    assign  sub_output  =   in0 - in1;
    assign  and_output  =   in0 & in1;
    assign  or_output   =   in0 | in1;
    //assign  slt_output  =   in0 << in1;
    assign  slt_output  =   in0 < in1 ? 1 : 0;
    assign  mul_output  =   in0 * in1;
	/*
    always @(in0 or in1 or ALU_ctrl) begin
		if (ALU_ctrl == 3'b001)
			if (sub_output == 0)
				zero = 1;
			else
				zero = 0;
				
		else
			zero = 0;
    end
    */
    always @(in0 or in1 or ALU_ctrl) begin // latch!!
        case(ALU_ctrl)
            // add operation
            3'b000 : begin
				ALU_output = add_output;
				zero = 0;
			end
            // sub operation
            3'b001 : begin 
				ALU_output = sub_output;
				
				if (sub_output == 16'b0)
					zero = 1;
				else
					zero = 0;
			end
            // and operation
            3'b010 : begin
				ALU_output = and_output;
				zero = 0;
			end
            // or operation
            3'b011 : begin
				ALU_output = or_output;
				zero = 0;
			end
			// slt operation
            // set on less than
            3'b100 : begin
				ALU_output = slt_output;
				zero = 0;
			end
            // mul operation
            3'b101 : begin
				ALU_output = mul_output;
				zero = 0;
			end
			default : begin
				ALU_output = 0;
				zero = 0;
			end
        endcase
    end
endmodule
