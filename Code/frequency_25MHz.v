module frequency_25MHz(clk,freq_25mhz);


	input clk;
	output reg freq_25mhz;
	
	
	
	always @ (posedge clk)
	begin
	
		freq_25mhz<=~freq_25mhz;
	
	end
	
endmodule
