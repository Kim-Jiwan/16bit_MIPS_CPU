// 1word == 16bits

module data_mem (
    input   	    [15:0]  data_mem_data,
    input   	    [15:0]  data_mem_addr,
    input   	            clk, rst,
	input					mem_write, mem_read,
	// clk -> obvious
	// we : write enable
	// if we == 1, then whatever input is going to be saved inside memory
	// re : read enable
	// we, re is controling the memory
    
    output  	    [15:0]  data_mem_strm
);
    integer i; // for reset
    reg [15:0] internal_mem [23:0]; 	// 128 numbers of 16bits memory
										// memory space that considering 16bit as 1word
										
	initial #2 begin
		$readmemb("datafile.txt", internal_mem);
	end
	
	// can I make a memory initializaion module??
    always @(posedge clk) begin
        if (~rst) begin
            for (i = 0; i < 24; i = i + 1)
                internal_mem[i] <= 16'b0;	// looks like loop! but it acts like initialize everything as 16'b0 
											// in this case we can use for loop in RTL.
        end

        else if (mem_write) begin // if we is high, bring data from datamem_data
            internal_mem[data_mem_addr] <= data_mem_data; // flip flop
			// where comes from the datamem_addr ???
			// we have to distinguish from address !
        end
    end

    assign data_mem_strm = (mem_read) ? internal_mem[data_mem_addr] : 16'b0;
	// if re is high, let out internal_mem that matching datamem_addr

endmodule