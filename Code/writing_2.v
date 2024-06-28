module writing_2(data,reading,count1,count2,count3,count4,drop1,drop2,drop3,drop4,buffer1,buffer2,buffer3,buffer4,clk,
received1,received2,received3,received4,count);
	
	input clk;
	input [3:0] data;
	input [3:0]reading;
	input [2:0]count;
	
	output reg [2:0]count1,count2,count3,count4;
	output reg [10:0] drop1,drop2,drop3,drop4;
	output reg [11:0] buffer1,buffer2,buffer3,buffer4;
	output reg [15:0] received1,received2,received3,received4;
	
	initial begin
	
	count1<=0;
	count2<=0;
	count3<=0;
	count4<=0;
	buffer1<=12'd0;
	buffer2<=12'd0;
	buffer3<=12'd0;
	buffer4<=12'd0;
	
	end
	
	
	always@(posedge clk) begin

		
		
		case(reading)
		
		4'd0:case(data[3:2])
		
			2'd0:begin 
			if (count1<6 && count==4)begin
				buffer1[10-2*count1]<=data[0];
				buffer1[11-2*count1]<=data[1];
				count1<=count1+1;
				received1<=received1+1;
				end
			
			else if (count1==6&& count==4)begin
				count1<=3'd6;
				drop1<=drop1+1;
				buffer1<=buffer1<<2;
				buffer1[1]<=data[1];
				buffer1[0]<=data[0];
				received1<=received1+1;
				end
			
			end
			
			2'd1:begin
			if (count2<6 && count==4)begin
				buffer2[10-2*count2]<=data[0];
				buffer2[11-2*count2]<=data[1];
				count2<=count2+1;
				received2<=received2+1;
				end
			
			else if (count2==6&& count==4)begin
				count2<=3'd6;
				drop2<=drop2+1;
				buffer2<=buffer2<<2;
				buffer2[1]<=data[1];
				buffer2[0]<=data[0];
				received2<=received2+1;
				end
			
			end
			
			2'd2:begin
			if (count3<6&& count==4)begin
				buffer3[10-2*count3]<=data[0];
				buffer3[11-2*count3]<=data[1];
				count3<=count3+1;
				received3<=received3+1;
				end
			
			else if (count3==6&& count==4)begin
				count3<=3'd6;
				drop3<=drop3+1;
				buffer3<=buffer3<<2;
				buffer3[1]<=data[1];
				buffer3[0]<=data[0];
				received3<=received3+1;
				end
			
			end
			
			2'd3:begin
			if (count4<6&& count==4)begin
				buffer4[10-2*count4]<=data[0];
				buffer4[11-2*count4]<=data[1];
				count4<=count4+1;
				received4<=received4+1;
				end
			
			else if (count4==6&& count==4)begin
				count4<=3'd6;
				drop4<=drop4+1;
				buffer4<=buffer4<<2;
				buffer4[1]<=data[1];
				buffer4[0]<=data[0];
				received4<=received4+1;
				end
			
			end
		
	endcase
	
		4'd1:case(data[3:2])
		
			2'd0:begin 
			
			if (count1<6&& count==4)begin
				buffer1[10-2*count1]<=data[0];
				buffer1[11-2*count1]<=data[1];
				count1<=count1;
				buffer1<=buffer1<<2;
				received1<=received1+1;
				end
			
			else if (count1==6&& count==4) begin
				count1<=3'd6;
				drop1<=drop1;
				buffer1<=buffer1<<2;
				buffer1[1]<=data[1];
				buffer1[0]<=data[0];
				received1<=received1+1;
				end
			end
			
			2'd1:begin
			if (count2<6&& count==4)begin
				buffer2[10-2*count2]<=data[0];
				buffer2[11-2*count2]<=data[1];
				count2<=count2+1;
				count1<=count1-1;
				buffer1<=buffer1<<2;
				received2<=received2+1;
				end
			
			else if (count2==6&& count==4)begin
				count2<=3'd6;
				drop2<=drop2+1;
				buffer2<=buffer2<<2;
				buffer2[1]<=data[1];
				buffer2[0]<=data[0];
				count1<=count1-1;
				buffer1<=buffer1<<2;
				received2<=received2+1;
				end
			
			end
			
			2'd2:begin
			if (count3<6&& count==4)begin
				buffer3[10-2*count3]<=data[0];
				buffer3[11-2*count3]<=data[1];
				count3<=count3+1;
				count1<=count1-1;
				buffer1<=buffer1<<2;
				received3<=received3+1;
				end
			
			else if (count3==6&& count==4)begin
				count3<=3'd6;
				drop3<=drop3+1;
				buffer3<=buffer3<<2;
				buffer3[1]<=data[1];
				buffer3[0]<=data[0];
				count1<=count1-1;
				buffer1<=buffer1<<2;
				received3<=received3+1;
				end
			
			end
			
			2'd3:begin
			if (count4<6&& count==4)begin
				buffer4[10-2*count4]<=data[0];
				buffer4[11-2*count4]<=data[1];
				count4<=count4+1;
				count1<=count1-1;
				buffer1<=buffer1<<2;
				received4<=received4+1;
				end
			
			else if (count4==6&& count==4)begin
				count4<=3'd6;
				drop4<=drop4+1;
				buffer4<=buffer4<<2;
				buffer4[1]<=data[1];
				buffer4[0]<=data[0];
				count1<=count1-1;
				buffer1<=buffer1<<2;
				received4<=received4+1;
				end
			
			end
		
	endcase
		
		4'd2:case(data[3:2])
		
			2'd0:begin 
			if (count1<6&& count==4)begin
				buffer1[10-2*count1]<=data[0];
				buffer1[11-2*count1]<=data[1];
				count1<=count1+1;
				count2<=count2-1;
				buffer2<=buffer2<<2;
				received1<=received1+1;
				end
			
			else if (count1==6&& count==4)begin
				count1<=3'd6;
				drop1<=drop1+1;
				buffer1<=buffer1<<2;
				buffer1[1]<=data[1];
				buffer1[0]<=data[0];
				count2<=count2-1;
				buffer2<=buffer2<<2;
				received1<=received1+1;
				end
			
			end
			
			2'd1:begin
			
			if (count2<6&& count==4)begin
				buffer2[10-2*count2]<=data[0];
				buffer2[11-2*count2]<=data[1];
				count2<=count2;
				buffer2<=buffer2<<2;
				received2<=received2+1;
				end
			
			else if (count1==6&& count==4) begin
				count2<=3'd6;
				drop2<=drop2;
				buffer2<=buffer2<<2;
				buffer2[1]<=data[1];
				buffer2[0]<=data[0];
				received2<=received2+1;
				end
			end
			
			2'd2:begin
			if (count3<6&& count==4)begin
				buffer3[10-2*count3]<=data[0];
				buffer3[11-2*count3]<=data[1];
				count3<=count3+1;
				count2<=count2-1;
				buffer2<=buffer2<<2;
				received3<=received3+1;
				end
			
			else if (count3==6&& count==4)begin
				count3<=3'd6;
				drop3<=drop3+1;
				buffer3<=buffer3<<2;
				buffer3[1]<=data[1];
				buffer3[0]<=data[0];
				count2<=count2-1;
				buffer2<=buffer2<<2;
				received3<=received3+1;
				end
			
			end
			
			2'd3:begin
			if (count4<6&& count==4)begin
				buffer4[10-2*count4]<=data[0];
				buffer4[11-2*count4]<=data[1];
				count4<=count4+1;
				count2<=count2-1;
				buffer2<=buffer2<<2;
				received4<=received4+1;
				end
			
			else if (count4==6&& count==4)begin
				count4<=3'd6;
				drop4<=drop4+1;
				buffer4<=buffer4<<2;
				buffer4[1]<=data[1];
				buffer4[0]<=data[0];
				count2<=count2-1;
				buffer2<=buffer2<<2;
				received4<=received4+1;
				end
			
			end
		
	endcase
		
		4'd4:case(data[3:2])
		
			2'd0:begin 
			if (count1<6&& count==4)begin
				buffer1[10-2*count1]<=data[0];
				buffer1[11-2*count1]<=data[1];
				count1<=count1+1;
				count3<=count3-1;
				buffer3<=buffer3<<2;
				received1<=received1+1;
				end
			
			else if (count1==6&& count==4)begin
				count1<=3'd6;
				drop1<=drop1+1;
				buffer1<=buffer1<<2;
				buffer1[1]<=data[1];
				buffer1[0]<=data[0];
				count3<=count3-1;
				buffer3<=buffer3<<2;
				received1<=received1+1;
				end
			
			end
			
			2'd1:begin
			if (count2<6&& count==4)begin
				buffer2[10-2*count2]<=data[0];
				buffer2[11-2*count2]<=data[1];
				count2<=count2+1;
				count3<=count3-1;
				buffer3<=buffer3<<2;
				received2<=received2+1;
				end
			
			else if (count2==6&& count==4)begin
				count2<=3'd6;
				drop2<=drop2+1;
				buffer2<=buffer2<<2;
				buffer2[1]<=data[1];
				buffer2[0]<=data[0];
				count3<=count3-1;
				buffer3<=buffer3<<2;
				received2<=received2+1;
				end
			
			end
			
			2'd2:begin
			
			if (count3<6&& count==4)begin
				buffer3[10-2*count3]<=data[0];
				buffer3[11-2*count3]<=data[1];
				count3<=count3;
				buffer3<=buffer3<<2;
				received3<=received3+1;
				end
			
			else if (count3==6&& count==4) begin
				count3<=3'd6;
				drop3<=drop3;
				buffer3<=buffer3<<2;
				buffer3[1]<=data[1];
				buffer3[0]<=data[0];
				received3<=received3+1;
				end
			end
			
			2'd3:begin
			if (count4<6&& count==4)begin
				buffer4[10-2*count4]<=data[0];
				buffer4[11-2*count4]<=data[1];
				count4<=count4+1;
				count3<=count3-1;
				buffer3<=buffer3<<2;
				received4<=received4+1;
				end
			
			else if (count4==6&& count==4)begin
				count4<=3'd6;
				drop4<=drop4+1;
				buffer4<=buffer4<<2;
				buffer4[1]<=data[1];
				buffer4[0]<=data[0];
				count3<=count3-1;
				buffer3<=buffer3<<2;
				received4<=received4+1;
				end
			
			end
		
	endcase
		
		4'd8:case(data[3:2])
		
			2'd0:begin 
			if (count1<6&& count==4)begin
				buffer1[10-2*count1]<=data[0];
				buffer1[11-2*count1]<=data[1];
				count1<=count1+1;
				count4<=count4-1;
				buffer4<=buffer4<<2;
				received1<=received1+1;
				end
			
			else if (count1==6&& count==4)begin
				count1<=3'd6;
				drop1<=drop1+1;
				buffer1<=buffer1<<2;
				buffer1[1]<=data[1];
				buffer1[0]<=data[0];
				count4<=count4-1;
				buffer4<=buffer4<<2;
				received1<=received1+1;
				end
			
			end
			
			2'd1:begin
			if (count2<6&& count==4)begin
				buffer2[10-2*count2]<=data[0];
				buffer2[11-2*count2]<=data[1];
				count2<=count2+1;
				count4<=count4-1;
				buffer4<=buffer4<<2;
				received2<=received2+1;
				end
			
			else if (count2==6&& count==4)begin
				count2<=3'd6;
				drop2<=drop2+1;
				buffer2<=buffer2<<2;
				buffer2[1]<=data[1];
				buffer2[0]<=data[0];
				count4<=count4-1;
				buffer4<=buffer4<<2;
				received2<=received2+1;
				end
			
			end
			
			2'd2:begin
			if (count3<6&& count==4)begin
				buffer3[10-2*count3]<=data[0];
				buffer3[11-2*count3]<=data[1];
				count3<=count3+1;
				count4<=count4-1;
				buffer4<=buffer4<<2;
				received3<=received3+1;
				end
			
			else if (count3==6&& count==4)begin
				count3<=3'd6;
				drop3<=drop3+1;
				buffer3<=buffer3<<2;
				buffer3[1]<=data[1];
				buffer3[0]<=data[0];
				count4<=count4-1;
				buffer4<=buffer4<<2;
				received3<=received3+1;
				end
			
			end
			
			2'd3:begin
			
			if (count4<6&& count==4)begin
				buffer4[10-2*count4]<=data[0];
				buffer4[11-2*count4]<=data[1];
				count4<=count4;
				buffer4<=buffer4<<2;
				received4<=received4+1;
				end
			
			else if (count4==6&& count==4) begin
				count4<=3'd6;
				drop4<=drop4;
				buffer4<=buffer4<<2;
				buffer4[1]<=data[1];
				buffer4[0]<=data[0];
				received4<=received4+1;
				end
			end
		
		endcase
		
		
		endcase
	
	end
	
endmodule
