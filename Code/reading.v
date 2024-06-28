module reading(data1,data2,data3,data4,clk,ins1,ins2,ins3,ins4,reading,data_out,
transmitted1, transmitted2,transmitted3,transmitted4);



	input [11:0]data1,data2,data3,data4;
	input clk;
	input [2:0]ins1,ins2,ins3,ins4;
	
	output reg [3:0]reading;
	output reg [3:0] data_out;
	output reg [15:0] transmitted1, transmitted2,transmitted3,transmitted4;
	
	reg[1:0] count;
	
	initial begin
	
	count<=0;
	reading<=4'd0;
	
	end
	
	
	always@(posedge clk) begin
	
		
		if (count>=25000000*3 & count<50000000*3) begin 
		
			if (ins1==0 && ins2==0 && ins3==0 && ins4==0)
			
				reading<=4'd0;
				
			else begin
			
				
				
				if (ins1>0 & ins2<3 & ins3<4 & ins4<4)begin
		
					data_out[3:2]<=2'b00;
					data_out[1:0]<=data1[11:10];
					reading<=4'b0001;
					transmitted1<=transmitted1+1;
				
				end
			
				else if  (ins2>ins1 & ins2>=3 & ins3<4 & ins4<4)begin
				
					data_out[3:2]<=2'b01;
					data_out[1:0]<=data2[11:10];
					reading<=4'b0010;
					transmitted2<=transmitted2+1;
					
				end
			
				else if (ins2>0 & ins3<4 & ins4<4)begin
				
					data_out[3:2]<=2'b01;
					data_out[1:0]<=data2[11:10];
					reading<=4'b0010;
					transmitted2<=transmitted2+1;
					
				
				end
			
				else if (ins3>ins2 & ins3>=4 & ins4<4)begin
				
					data_out[3:2]<=2'b10;
					data_out[1:0]<=data3[11:10];
					reading<=4'b0100;
					transmitted3<=transmitted3+1;
				
				end
				
				else if (ins3>0 & ins4<4)begin
			
					data_out[3:2]<=2'b10;
					data_out[1:0]<=data3[11:10];
					reading<=4'b0100;
					transmitted3<=transmitted3+1;
				
				end
				
				else if (ins4>=4)begin
				
					data_out[3:2]<=2'b11;
					data_out[1:0]<=data4[11:10];
					reading<=4'b1000;
					transmitted4<=transmitted4+1;
					
				end
					
				else if (ins4>0)begin
				
					data_out[3:2]<=2'b11;
					data_out[1:0]<=data4[11:10];
					reading<=4'b1000;
					transmitted4<=transmitted4+1;

				end
				
				
			end
			
			count<=count+1;
		end
		
		else if (count==50000000) count<=0;
		
		else count<=count+1;
	
	
	end
	
endmodule
