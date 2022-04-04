// To remove trash data, we have to initialize data before get datafile

module register_file #(
    parameter inst_SIZE =   16
) (
	input								clk, rst,
	
    input   	    [2:0]               rs,
    input   	    [2:0]               rt,
    input   	    [2:0]               rd,
    input   	    [inst_SIZE-1:0]     reg_write_data,
    input   	                        reg_write,

    output  	    [inst_SIZE-1:0]     read_data_1,
    output  	    [inst_SIZE-1:0]     read_data_2
);
    // rs와 rt의 주소를 받아서 data를 출력하는 module...
	// register 8개
	
	integer i;
	reg	[inst_SIZE-1:0] internal_mem [7:0];

	always @(posedge clk) begin
		if (~rst) begin
			for (i = 0; i < 8; i = i + 1)
				internal_mem[i] <= 16'b0;
		end
		
		else if (reg_write) begin
			internal_mem[rd] <= reg_write_data;
		end
		
	end
	
	assign read_data_1 = internal_mem[rs];
	assign read_data_2 = internal_mem[rt];
	
endmodule