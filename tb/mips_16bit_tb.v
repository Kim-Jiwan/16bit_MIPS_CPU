`timescale 1ns / 10ps

module mips_16bit_tb (

);
	reg						clk;
	reg						rst;
	
	wire	[15:0]			current_instr;
	wire	[12:0]			PC_current;
	wire	[12:0]			PCnext;
	
	assign PCnext =	 PC.PC_next;
	
	mips_16bit mips(		.clk			(clk),
							.rst			(rst),
							
							.current_instr	(current_instr),
							.PC_current		(PC_current)		);
	
	initial begin
		clk = 0;
		rst = 0;
		#2 rst = 1;
	end
	
	always begin
		#0.5 clk = ~clk;
	end
	
	always #1 begin
		if (current_instr !== 16'hxxxx) begin
			$timeformat(-12, 0," ps"); // -9 -> 10^-9 that is nano sec
			$display("ID:0292, at time%t, PC=%d, RF[0, 1, 2, 3, 4, 7] is: %d, %d, %d, %d, %d, %d", $time, PC_current, 
																									register_file.internal_mem[0],
																									register_file.internal_mem[1],
																									register_file.internal_mem[2],
																									register_file.internal_mem[3],
																									register_file.internal_mem[4],
																									register_file.internal_mem[7]		);
		end
		else begin
			$display("The final result of C in memory is : %d", data_mem.internal_mem[3]);
			$finish;
		end
	end
endmodule