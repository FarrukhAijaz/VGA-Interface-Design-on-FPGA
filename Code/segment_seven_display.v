module segment_seven_display(BCD_num,disp_hex,clk);

	input clk;
	input BCD_num;
	output reg [6:0]disp_hex;
	
	
	always @ (posedge clk)
	
	begin
	
		case(BCD_num)
		
		4'd0 : disp_hex=7'b1000000;
		4'd1 : disp_hex=7'b1111001;
		
		default: disp_hex=7'b1000000;
		
		endcase
		
	end
endmodule
