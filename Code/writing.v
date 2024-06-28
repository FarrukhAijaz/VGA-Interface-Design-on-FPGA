module writing(data,reading,count1,count2,count3,count4,drop1,drop2,drop3,drop4,buffer1,buffer2,buffer3,buffer4,clk);
	
	input clk;
	input [3:0] data;
	input [3:0]reading;
	
	output reg [2:0]count1,count2,count3,count4;
	output reg [15:0] drop1,drop2,drop3,drop4;
	output reg [11:0] buffer1,buffer2,buffer3,buffer4;
	
	
	always@(posedge clk) begin

		// When there is no data coming, it does not decrease the count while reading.?
		// We can use case for reading.
		// Also, sensitivity list for always block is not determined.
		// There are two of them:data and reading.?
		
		case(data[3:2])
		
			2'd0:begin 
			if (count1<6 && reading[0]==0)begin
				buffer1[count1]<=data[0];
				buffer1[count1+1]<=data[1];
				count1<=count1+1;
				end
			else if (count1<6 && reading[0]==1)begin
				buffer1[count1]<=data[0];
				buffer1[count1+1]<=data[1];
				count1<=count1;
				buffer1<=buffer1<<2;
				end
			else if (count1==6 && reading[0]==0)begin
				count1<=3'd6;
				drop1<=drop1+1;
				buffer1<=buffer1<<2;
				buffer1[10]<=data[0];
				buffer1[11]<=data[1];
				end
			else if (count1==6 && reading[0]==1) begin
				count1<=3'd6;
				drop1<=drop1;
				buffer1<=buffer1<<2;
				buffer1[10]<=data[0];
				buffer1[11]<=data[1];
				end
			end
			
			2'd1:begin
			if (count2<6 && reading[1]==0)begin
				buffer2[count2]<=data[0];
				buffer2[count2+1]<=data[1];
				count2<=count2+1;
				end
			else if (count2<6 && reading[1]==1)begin
				buffer2[count2]<=data[0];
				buffer2[count2+1]<=data[1];
				count2<=count2;
				buffer2<=buffer2<<2;
				end
			else if (count2==6 && reading[1]==0)begin
				count2<=3'd6;
				drop2<=drop2+1;
				buffer2<=buffer2<<2;
				buffer2[10]<=data[0];
				buffer2[11]<=data[1];
				end
			else if (count1==6 && reading[1]==1) begin
				count2<=3'd6;
				drop2<=drop2;
				buffer2<=buffer2<<2;
				buffer2[10]<=data[0];
				buffer2[11]<=data[1];
				end
			end
			
			2'd2:begin
			if (count3<6 && reading[2]==0)begin
				buffer3[count3]<=data[0];
				buffer3[count3+1]<=data[1];
				count3<=count3+1;
				end
			else if (count3<6 && reading[2]==1)begin
				buffer3[count3]<=data[0];
				buffer3[count3+1]<=data[1];
				count3<=count3;
				buffer3<=buffer3<<2;
				end
			else if (count3==6 && reading[2]==0)begin
				count3<=3'd6;
				drop3<=drop3+1;
				buffer3<=buffer3<<2;
				buffer3[10]<=data[0];
				buffer3[11]<=data[1];
				end
			else if (count3==6 && reading[2]==1) begin
				count3<=3'd6;
				drop3<=drop3;
				buffer3<=buffer3<<2;
				buffer3[10]<=data[0];
				buffer3[11]<=data[1];
				end
			end
			
			2'd3:begin
			if (count4<6 && reading[3]==0)begin
				buffer4[count4]<=data[0];
				buffer4[count4+1]<=data[1];
				count4<=count4+1;
				end
			else if (count4<6 && reading[3]==1)begin
				buffer4[count4]<=data[0];
				buffer4[count4+1]<=data[1];
				count4<=count4;
				buffer4<=buffer4<<2;
				end
			else if (count4==6 && reading[3]==0)begin
				count4<=3'd6;
				drop4<=drop4+1;
				buffer4<=buffer4<<2;
				buffer4[10]<=data[0];
				buffer4[11]<=data[1];
				end
			else if (count4==6 && reading[3]==1) begin
				count4<=3'd6;
				drop4<=drop4;
				buffer4<=buffer4<<2;
				buffer4[10]<=data[0];
				buffer4[11]<=data[1];
				end
			end
		
	endcase
	
	end
	
endmodule
