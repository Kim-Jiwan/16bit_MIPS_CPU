module inst_mem #(
    parameter inst_SIZE =   16,
    parameter PC_SIZE   =   13
) (
	input								clk, rst,
    input   	    [PC_SIZE-1:0]       instr_mem_addr,

    output  	    [inst_SIZE-1:0]     instr
);

    integer i;
    reg [15:0] internal_mem [23:0];
	
	initial #2 begin
		$readmemb("instructionfile.txt", internal_mem);
	end
	
	// how to match initialize timing with rst????
	
	// inst_memd is sucsess!
	
    always @(posedge clk) begin
        if (~rst) begin
            for (i = 0; i < 24; i = i + 1)
                internal_mem[i] <= 16'b0; // rst -> all of memory is 16'h0000
				
        end
    end
	
	assign instr = internal_mem[instr_mem_addr];
    
endmodule

