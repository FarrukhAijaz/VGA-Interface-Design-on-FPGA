module serial_to_parallel(button0,button1,start,data,clk,count_12);


	input button0,button1,clk;
	input start;
	
	output reg [3:0]data;
	output reg [2:0] count_12;
	reg start_button;
	reg [3:0] data_temp;
	reg [2:0] count;
	
	initial begin 
		
		start_button<=0;
		count<=0;
		data_temp<=4'd0;
		data<=4'd0;
		
	end
	
	always@(negedge clk) begin 
		count_12<=0;
		case(start_button)
		
		1'd0:begin
		
			if (start==0) start_button<=1;
			else start_button<=0;
			
			end
		
		1'd1:if (count<4)begin 
			
				if(button0==1 && button1==0) begin
				
					data_temp<=data_temp<<1;
					data_temp[0]<=1;
					count<=count+1;
					
				end
				
				else if(button0==0 && button1==1) begin
				
					data_temp<=data_temp<<1;
					data_temp[0]<=0;
					count<=count+1;
					
				end
				
				else if (button0==0 && button1==0) begin
				
					count<=count;
					data_temp<=data_temp;
				
				end
				
				else if (button0==1 && button1==1) begin
				
					count<=count;
					data_temp<=data_temp;
				
				end
				
			end
			
			else begin 
			
				count<=0;
				data<=data_temp;
				count_12<=4;
				
			end
		
		endcase
	end
	
endmodule

		
		
		