module frequency_1Hz(clk,freq_hz);


	input clk;
	output reg freq_hz;
	
	reg [25:0] count;
	
	always @ (posedge clk)
	begin
	
		if (count>=25000000 && count<50000000)
			begin
			freq_hz<=1;
			count<=0;
			end
			
		else if (count<25000000)
			begin
			freq_hz<=0;
			count<=count+1'b1;
			end
	
	end
	
endmodule




	
