module Renderer(
	input pixelClock,
	input visibleArea,
	input [10:0] screenX,
	input [10:0] screenY,
	input [3:0] data_trans,
	input [3:0] data_recev,
	input [15:0] received1,
	input [15:0] received2,
	input [15:0] received3,
	input [15:0] received4,
	input [15:0] transmitted1,
	input [15:0] transmitted2,
	input [15:0] transmitted3,
	input [15:0] transmitted4,
	input [10:0] drop1,
	input [10:0] drop2,
	input [10:0] drop3,
	input [10:0] drop4,
	input [2:0] count1,
	input [2:0] count2,
	input [2:0] count3,
	input [2:0] count4,
	input [11:0] buffer1,
	input [11:0] buffer2,
	input [11:0] buffer3,
	input [11:0] buffer4,
	output reg [23:0] screenPixel
);

// Colors
localparam

	black = 24'h000000,
	blue = 24'h0000FF,
	green = 24'h00FF00,
	red = 24'hFF0000,
	yellow = 24'hFFFF00,
	white = 24'hFFFFFF;

// Character graphics for digits 9-0.
localparam [799:0] digits = {	
	80'b01111100110001101100011011001110110111101111011011100110110001101100011001111100,
	80'b00011000001110000111100000011000000110000001100000011000000110000001100001111110,
	80'b01111100110001100000011000001100000110000011000001100000110000001100011011111110,
	80'b01111100110001100000011000000110001111000000011000000110000001101100011001111100,
	80'b00001100000111000011110001101100110011001111111000001100000011000000110000011110,
	80'b11111110110000001100000011000000111111000000011000000110000001101100011001111100,
	80'b00111000011000001100000011000000111111001100011011000110110001101100011001111100,
	80'b11111110110001100000011000000110000011000001100000110000001100000011000000110000,
	80'b01111100110001101100011011000110011111001100011011000110110001101100011001111100,
	80'b01111100110001101100011011000110011111100000011000000110000001100000110001111000
};


localparam
	v_box_start=129,
	v_box_end=249,
	h_box_start=53,
	h_box_end=75,
	box_distance=42,
	h_num=8,
	v_num=10;


reg [15:0] transmitted_data; 
reg [15:0] received_data;
reg [15:0] drop_data;
reg [23:0] box_pixel;
reg [23:0] box_pixel1;
reg [23:0] box_pixel2;
reg [23:0] box_pixel3;
reg [23:0] box_pixel4;
reg [23:0] color_box_pixel_1;
reg [23:0] color_box_pixel_2;
reg [23:0] color_box_pixel_3;
reg [23:0] color_box_pixel_4;
reg [23:0] color_box_pixel;
reg [23:0] input_num_pixel_1;
reg [23:0] input_num_pixel_2;
reg [23:0] input_num_pixel_3;
reg [23:0] input_num_pixel_4;
reg [23:0] input_num_pixel;
reg [23:0] output_num_pixel_1;
reg [23:0] output_num_pixel_2;
reg [23:0] output_num_pixel_3;
reg [23:0] output_num_pixel_4;
reg [23:0] output_num_pixel;
reg [23:0] tnum_pixel_1;
reg [23:0] tnum_pixel_2;
reg [23:0] tnum_pixel_3;
reg [23:0] tnum_pixel_4;
reg [23:0] tnum_pixel_5;
reg [23:0] tnum_pixel;
reg [23:0] rnum_pixel_1;
reg [23:0] rnum_pixel_2;
reg [23:0] rnum_pixel_3;
reg [23:0] rnum_pixel_4;
reg [23:0] rnum_pixel_5;
reg [23:0] rnum_pixel;
reg [23:0] num_pixel_1;
reg [23:0] num_pixel_2;
reg [23:0] num_pixel_3;
reg [23:0] num_pixel_4;
reg [23:0] num_pixel_5;
reg [23:0] num_pixel;
reg [23:0] computedPixel;


always @(posedge pixelClock)
begin
	if (visibleArea)
	begin
		if ((((screenX >= h_box_start & screenX < h_box_start+1)|(screenX >= h_box_end-1 & screenX < h_box_end))
			& screenY >= v_box_start
			& screenY < v_box_end)
			|(screenX>=h_box_start & screenX<h_box_end 
			&((screenY>=v_box_start & screenY<v_box_start+1)|(screenY>=v_box_end-1 & screenY<v_box_end))))
			box_pixel1 <= black;
		else
			box_pixel1 <= white;
		
		if ((((screenX >= h_box_start+box_distance & screenX < h_box_start+box_distance+1)|(screenX >= h_box_end+box_distance-1 & screenX < h_box_end+box_distance))
			& screenY >= v_box_start
			& screenY <v_box_end)
			|(screenX>=h_box_start+box_distance & screenX<h_box_end+box_distance
			&((screenY>=v_box_start & screenY<v_box_start+1)|(screenY>=v_box_end-1 & screenY<v_box_end))))
			box_pixel2 <= black;
		else
			box_pixel2 <= white;
			
		if ((((screenX >= h_box_start+2*box_distance & screenX < h_box_start+2*box_distance+1)|(screenX >= h_box_end+2*box_distance-1 & screenX < h_box_end+2*box_distance))
			& screenY >= v_box_start
			& screenY < v_box_end)
			|(screenX>=h_box_start+2*box_distance & screenX<h_box_end+2*box_distance
			&((screenY>=v_box_start & screenY<v_box_start+1)|(screenY>=v_box_end-1 & screenY<v_box_end))))
			box_pixel3 <= black;
		else
			box_pixel3 <= white;
		
		if ((((screenX >= h_box_start+3*box_distance & screenX < h_box_start+3*box_distance+1)|(screenX >= h_box_end+3*box_distance-1 & screenX < h_box_end+3*box_distance))
			& screenY >= v_box_start
			& screenY < v_box_end)
			|(screenX>=h_box_start+3*box_distance & screenX<h_box_end+3*box_distance
			&((screenY>=v_box_start & screenY<v_box_start+1)|(screenY>=v_box_end-1 & screenY<v_box_end))))
			box_pixel4 <= black;
		else
			box_pixel4 <= white;
		
		box_pixel<=box_pixel1&box_pixel2&box_pixel3&box_pixel4;
		
		
		if (screenX>=h_box_start+7 & screenX<h_box_end-7 & screenY>=v_box_end-v_num-6 & screenY<v_box_end-6 & count1>=1 & digits[799-(screenY-v_box_end+v_num+6+1)*(screenX-h_box_start-7+1)-1-80*buffer1[11:10]])
			color_box_pixel_1<=black;
		else if (screenX>=h_box_start+1 & screenX<h_box_end-1 & screenY>=v_box_end-21 & screenY<v_box_end-1 & count1>=1)
			color_box_pixel_1<=red;
		
		else if (screenX>=h_box_start+7 & screenX<h_box_end-7 & screenY>=v_box_end-v_num-6-21 & screenY<v_box_end-6-21 & count1>=2 &  digits[799-(screenY-v_box_end+v_num+6+21+1)*(screenX-h_box_start-7+1)-1-80*buffer1[9:8]])
			color_box_pixel_1<=black;
		else if (screenX>=h_box_start+1 & screenX<h_box_end-1 & screenY>=v_box_end-21-21 & screenY<v_box_end-1-21 & count1>=2)
			color_box_pixel_1<=red;
		
		else if (screenX>=h_box_start+7 & screenX<h_box_end-7 & screenY>=v_box_end-v_num-6-2*21 & screenY<v_box_end-6-2*21 & count1>=3 &  digits[799-(screenY-v_box_end+v_num+6+2*21+1)*(screenX-h_box_start-7+1)-1-80*buffer1[7:6]])
			color_box_pixel_1<=black;
		else if (screenX>=h_box_start+1 & screenX<h_box_end-1 & screenY>=v_box_end-21-2*21 & screenY<v_box_end-1-2*21 & count1>=3)
			color_box_pixel_1<=red;
		
		else if (screenX>=h_box_start+7 & screenX<h_box_end-7 & screenY>=v_box_end-v_num-6-3*21 & screenY<v_box_end-6-3*21 & count1>=4 &  digits[799-(screenY-v_box_end+v_num+6+3*21+1)*(screenX-h_box_start-7+1)-1-80*buffer1[5:4]])
			color_box_pixel_1<=black;
		else if (screenX>=h_box_start+1 & screenX<h_box_end-1 & screenY>=v_box_end-21-3*21 & screenY<v_box_end-1-3*21 & count1>=4)
			color_box_pixel_1<=red;
		
		else if (screenX>=h_box_start+7 & screenX<h_box_end-7 & screenY>=v_box_end-v_num-6-4*21 & screenY<v_box_end-6-4*21 & count1>=5 &  digits[799-(screenY-v_box_end+v_num+6+4*21+1)*(screenX-h_box_start-7+1)-1-80*buffer1[3:2]])
			color_box_pixel_1<=black;
		else if (screenX>=h_box_start+1 & screenX<h_box_end-1 & screenY>=v_box_end-21-4*21 & screenY<v_box_end-1-4*21 & count1>=5)
			color_box_pixel_1<=red;
		
		else if (screenX>=h_box_start+7 & screenX<h_box_end-7 & screenY>=v_box_end-v_num-6-5*21 & screenY<v_box_end-6-5*21 & count1==6 &  digits[799-(screenY-v_box_end+v_num+6+5*21+1)*(screenX-h_box_start-7+1)-1-80*buffer1[1:0]])
			color_box_pixel_1<=black;
		else if (screenX>=h_box_start+1 & screenX<h_box_end-1 & screenY>=v_box_end-21-5*21 & screenY<v_box_end-1-5*21 & count1==6)
			color_box_pixel_1<=red;
		
		else color_box_pixel_1<=white;
		
		
		
		if (screenX>=h_box_start+7+box_distance & screenX<h_box_end-7+box_distance & screenY>=v_box_end-v_num-6 & screenY<v_box_end-6 & count2>=1 & digits[799-(screenY-v_box_end+v_num+6+1)*(screenX-h_box_start-7-box_distance+1)-1-80*buffer2[11:10]])
			color_box_pixel_2<=black;
		else if (screenX>=h_box_start+1+box_distance & screenX<h_box_end-1+box_distance & screenY>=v_box_end-21 & screenY<v_box_end-1 & count2>=1)
			color_box_pixel_2<=blue;
		
		else if (screenX>=h_box_start+7+box_distance & screenX<h_box_end-7+box_distance & screenY>=v_box_end-v_num-6-21 & screenY<v_box_end-6-21 & count2>=2 &  digits[799-(screenY-v_box_end+v_num+21+6+1)*(screenX-h_box_start-7-box_distance+1)-1-80*buffer2[9:8]])
			color_box_pixel_2<=black;
		else if (screenX>=h_box_start+1+box_distance & screenX<h_box_end-1+box_distance & screenY>=v_box_end-21-21 & screenY<v_box_end-1-21 & count2>=2)
			color_box_pixel_2<=blue;
		
		else if (screenX>=h_box_start+7+box_distance & screenX<h_box_end-7+box_distance & screenY>=v_box_end-v_num-6-2*21 & screenY<v_box_end-6-2*21 & count2>=3 &  digits[799-(screenY-v_box_end+v_num+2*21+6+1)*(screenX-h_box_start-7-box_distance+1)-1-80*buffer2[7:6]])
			color_box_pixel_2<=black;
		else if (screenX>=h_box_start+1+box_distance & screenX<h_box_end-1+box_distance & screenY>=v_box_end-21-2*21 & screenY<v_box_end-1-2*21 & count2>=3)
			color_box_pixel_2<=blue;
	
		else if (screenX>=h_box_start+7+box_distance & screenX<h_box_end-7+box_distance & screenY>=v_box_end-v_num-6-3*21 & screenY<v_box_end-6-3*21 & count2>=4 &  digits[799-(screenY-v_box_end+v_num+3*21+6+1)*(screenX-h_box_start-7-box_distance+1)-1-80*buffer2[5:4]])
			color_box_pixel_2<=black;
		else if (screenX>=h_box_start+1+box_distance & screenX<h_box_end-1+box_distance & screenY>=v_box_end-21-3*21 & screenY<v_box_end-1-3*21 & count2>=4)
			color_box_pixel_2<=blue;
		
		else if (screenX>=h_box_start+7+box_distance & screenX<h_box_end-7+box_distance & screenY>=v_box_end-v_num-6-4*21 & screenY<v_box_end-6-4*21 & count2>=5 &  digits[799-(screenY-v_box_end+v_num+4*21+6+1)*(screenX-h_box_start-7-box_distance+1)-1-80*buffer2[3:2]])
			color_box_pixel_2<=black;
		else if (screenX>=h_box_start+1+box_distance & screenX<h_box_end-1+box_distance & screenY>=v_box_end-21-4*21 & screenY<v_box_end-1-4*21 & count2>=5)
			color_box_pixel_2<=blue;
		
		else if (screenX>=h_box_start+7+box_distance & screenX<h_box_end-7+box_distance & screenY>=v_box_end-v_num-6-5*21 & screenY<v_box_end-6-5*21 & count2==6 & digits[799-(screenY-v_box_end+v_num+5*21+6+1)*(screenX-h_box_start-7-box_distance+1)-1-80*buffer2[1:0]])
			color_box_pixel_2<=black;
		else if (screenX>=h_box_start+1+box_distance & screenX<h_box_end-1+box_distance & screenY>=v_box_end-21-5*21 & screenY<v_box_end-1-5*21 & count2==6)
			color_box_pixel_2<=blue;
		else color_box_pixel_2<=white;
		
		
		if (screenX>=h_box_start+7+2*box_distance & screenX<h_box_end-7+2*box_distance & screenY>=v_box_end-v_num-6 & screenY<v_box_end-6 & count3>=1 & digits[799-(screenY-v_box_end+v_num+6+1)*(screenX-h_box_start-7-2*box_distance+1)-1-80*buffer3[11:10]])
			color_box_pixel_3<=black;
		else if (screenX>=h_box_start+1+2*box_distance & screenX<h_box_end-1+2*box_distance & screenY>=v_box_end-21 & screenY<v_box_end-1 & count3>=1)
			color_box_pixel_3<=yellow;
		
		else if (screenX>=h_box_start+7+2*box_distance & screenX<h_box_end-7+2*box_distance & screenY>=v_box_end-v_num-6-21 & screenY<v_box_end-6-21 & count3>=2 & digits[799-(screenY-v_box_end+v_num+21+6+1)*(screenX-h_box_start-7-2*box_distance+1)-1-80*buffer3[9:8]])
			color_box_pixel_3<=black;
		else if (screenX>=h_box_start+1+2*box_distance & screenX<h_box_end-1+2*box_distance & screenY>=v_box_end-21-21 & screenY<v_box_end-1-21 & count3>=2)
			color_box_pixel_3<=yellow;
		
		else if (screenX>=h_box_start+7+2*box_distance & screenX<h_box_end-7+2*box_distance & screenY>=v_box_end-v_num-6-2*21 & screenY<v_box_end-6-2*21 & count3>=3 &  digits[799-(screenY-v_box_end+v_num+2*21+6+1)*(screenX-h_box_start-7-2*box_distance+1)-1-80*buffer3[7:6]])
			color_box_pixel_3<=black;
		else if (screenX>=h_box_start+1+2*box_distance & screenX<h_box_end-1+2*box_distance & screenY>=v_box_end-21-2*21 & screenY<v_box_end-1-2*21 & count3>=3)
			color_box_pixel_3<=yellow;
		
		else if (screenX>=h_box_start+7+2*box_distance & screenX<h_box_end-7+2*box_distance & screenY>=v_box_end-v_num-6-3*21 & screenY<v_box_end-6-3*21 & count3>=4 &  digits[799-(screenY-v_box_end+v_num+3*21+6+1)*(screenX-h_box_start-7-2*box_distance+1)-1-80*buffer3[5:4]])
			color_box_pixel_3<=black;
		else if (screenX>=h_box_start+1+2*box_distance & screenX<h_box_end-1+2*box_distance & screenY>=v_box_end-21-2*21 & screenY<v_box_end-1-2*21 & count3>=4)
			color_box_pixel_3<=yellow;
		
		else if (screenX>=h_box_start+7+2*box_distance & screenX<h_box_end-7+2*box_distance & screenY>=v_box_end-v_num-6-4*21 & screenY<v_box_end-6-4*21 & count3>=5 &  digits[799-(screenY-v_box_end+v_num+4*21+6+1)*(screenX-h_box_start-7-2*box_distance+1)-1-80*buffer3[3:2]])
			color_box_pixel_3<=black;
		else if (screenX>=h_box_start+1+2*box_distance & screenX<h_box_end-1+2*box_distance & screenY>=v_box_end-21-4*21 & screenY<v_box_end-1-4*21 & count3>=5)
			color_box_pixel_3<=yellow;
		
		else if (screenX>=h_box_start+7+2*box_distance & screenX<h_box_end-7+2*box_distance & screenY>=v_box_end-v_num-6-5*21 & screenY<v_box_end-6-5*21 & count3==6 & digits[799-(screenY-v_box_end+v_num+5*21+6+1)*(screenX-h_box_start-7-2*box_distance+1)-1-80*buffer3[1:0]])
			color_box_pixel_3<=black;
		else if (screenX>=h_box_start+1+2*box_distance & screenX<h_box_end-1+2*box_distance & screenY>=v_box_end-21-5*21 & screenY<v_box_end-1-5*21 & count3==6)
			color_box_pixel_3<=yellow;
		else color_box_pixel_3<=white;
		
		
		if (screenX>=h_box_start+7+3*box_distance & screenX<h_box_end-7+3*box_distance & screenY>=v_box_end-v_num-6 & screenY<v_box_end-6 & count4>=1 & digits[799-(screenY-v_box_end+v_num+6+1)*(screenX-h_box_start-7-3*box_distance+1)-1-80*buffer4[11:10]])
			color_box_pixel_4<=black;
		else if (screenX>=h_box_start+1+3*box_distance & screenX<h_box_end-1+3*box_distance & screenY>=v_box_end-21 & screenY<v_box_end-1 & count4>=1)
			color_box_pixel_4<=green;
		
		else if (screenX>=h_box_start+7+3*box_distance & screenX<h_box_end-7+3*box_distance & screenY>=v_box_end-v_num-6-21 & screenY<v_box_end-6-21 & count4>=2 &  digits[799-(screenY-v_box_end+v_num+21+6+1)*(screenX-h_box_start-7-3*box_distance+1)-1-80*buffer4[9:8]])
			color_box_pixel_4<=black;
		else if (screenX>=h_box_start+1+3*box_distance & screenX<h_box_end-1+3*box_distance & screenY>=v_box_end-21-21 & screenY<v_box_end-1-21 & count4>=2)
			color_box_pixel_4<=green;
		
		else if (screenX>=h_box_start+7+3*box_distance & screenX<h_box_end-7+3*box_distance & screenY>=v_box_end-v_num-6-2*21 & screenY<v_box_end-6-2*21 & count4>=3 &  digits[799-(screenY-v_box_end+v_num+2*21+6+1)*(screenX-h_box_start-7-3*box_distance+1)-1-80*buffer4[7:6]])
			color_box_pixel_4<=black;
		else if (screenX>=h_box_start+1+3*box_distance & screenX<h_box_end-1+3*box_distance & screenY>=v_box_end-21-2*21 & screenY<v_box_end-1-2*21 & count4>=3)
			color_box_pixel_4<=green;
		
		else if (screenX>=h_box_start+7+3*box_distance & screenX<h_box_end-7+3*box_distance & screenY>=v_box_end-v_num-6-3*21 & screenY<v_box_end-6-3*21 & count4>=4 &  digits[799-(screenY-v_box_end+v_num+3*21+6+1)*(screenX-h_box_start-7-3*box_distance+1)-1-80*buffer4[5:4]])
			color_box_pixel_4<=black;
		else if (screenX>=h_box_start+1+3*box_distance & screenX<h_box_end-1+3*box_distance & screenY>=v_box_end-21-3*21 & screenY<v_box_end-1-3*21 & count4>=4)
			color_box_pixel_4<=green;
		
		else if (screenX>=h_box_start+7+3*box_distance & screenX<h_box_end-7+3*box_distance & screenY>=v_box_end-v_num-6-4*21 & screenY<v_box_end-6-4*21 & count4>=5 &  digits[799-(screenY-v_box_end+v_num+4*21+6+1)*(screenX-h_box_start-7-3*box_distance+1)-1-80*buffer4[3:2]])
			color_box_pixel_4<=black;
		else if (screenX>=h_box_start+1+3*box_distance & screenX<h_box_end-1+3*box_distance & screenY>=v_box_end-21-4*21 & screenY<v_box_end-1-4*21 & count4>=5)
			color_box_pixel_4<=green;
		
		else if (screenX>=h_box_start+7+3*box_distance & screenX<h_box_end-7+3*box_distance & screenY>=v_box_end-v_num-6-5*21 & screenY<v_box_end-6-5*21 & count4==6 &  digits[799-(screenY-v_box_end+v_num+5*21+6+1)*(screenX-h_box_start-7-3*box_distance+1)-1-80*buffer4[1:0]])
			color_box_pixel_4<=black;
		else if (screenX>=h_box_start+1+3*box_distance & screenX<h_box_end-1+3*box_distance & screenY>=v_box_end-21-5*21 & screenY<v_box_end-1-5*21 & count4==6)
			color_box_pixel_4<=green;
		else color_box_pixel_4<=white;
		color_box_pixel<=color_box_pixel_4&color_box_pixel_3&color_box_pixel_2&color_box_pixel_1;
		
		
		if (screenX>=106 & screenX<114 & screenY>=389 & screenY<399 & digits[799-(screenX-106)-80*data_trans[3]])
			input_num_pixel_4<=black;
		else
			input_num_pixel_4<=white;
			
		if (screenX>=114 & screenX<122 & screenY>=389 & screenY<399 & digits[799-(screenX-114)-80*data_trans[2]])
			input_num_pixel_3<=black;
		else
			input_num_pixel_3<=white;
			
		if (screenX>=122 & screenX<130 & screenY>=389 & screenY<399 & digits[799-(screenX-122)-80*data_trans[1]])
			input_num_pixel_2<=black;
		else
			input_num_pixel_2<=white;
			
		if (screenX>=130 & screenX<138 & screenY>=389 & screenY<399 & digits[799-(screenX-130)-80*data_trans[0]])
			input_num_pixel_1<=black;
		else
			input_num_pixel_1<=white;
			
			
		if (screenX>=106 & screenX<114 & screenY>=99 & screenY<109 & digits[799-(screenX-106)-80*data_recev[3]])
			output_num_pixel_4<=black;
		else
			output_num_pixel_4<=white;
			
		if (screenX>=114 & screenX<122 & screenY>=99 & screenY<109 & digits[799-(screenX-114)-80*data_recev[2]])
			output_num_pixel_3<=black;
		else
			output_num_pixel_3<=white;
			
		if (screenX>=122 & screenX<130 & screenY>=99 & screenY<109 & digits[799-(screenX-122)-80*data_recev[1]])
			output_num_pixel_2<=black;
		else
			output_num_pixel_2<=white;
			
		if (screenX>=130 & screenX<138 & screenY>=99 & screenY<109 & digits[799-(screenX-130)-80*data_recev[0]])
			output_num_pixel_1<=black;
		else
			output_num_pixel_1<=white;
			
		
		input_num_pixel<=input_num_pixel_1&input_num_pixel_2&input_num_pixel_3&input_num_pixel_4;
		output_num_pixel<=output_num_pixel_1&output_num_pixel_2&output_num_pixel_3&output_num_pixel_4;
		
		if (screenX>=281 & screenX<289 & screenY>=139 & screenY<149 & transmitted1<10 & digits[799-(screenX-281+1)*(screenY-139+1)-1-80*transmitted1])
			tnum_pixel_1<=black;
		else if ((screenX>=281 & screenX<289 & screenY>=139 & screenY<149  & digits[799-(screenX-281+1)*(screenY-139+1)-1-80*(transmitted1%10)])
		| (screenX>=273 & screenX<281 & screenY>=139 & screenY<149  & digits[799-(screenX-273+1)*(screenY-139+1)-1-80*((transmitted1-(transmitted1%10))/10)])
		& transmitted1<100)
			tnum_pixel_1<=black;
		else if ((screenX>=281 & screenX<289 & screenY>=139 & screenY<149  & digits[799-(screenX-281+1)*(screenY-139+1)-1-80*(transmitted1%10)])
		| (screenX>=273 & screenX<281 & screenY>=139 & screenY<149  & digits[799-(screenX-273+1)*(screenY-139+1)-1-80*(((transmitted1-(transmitted1%10))/10)%10)])
		| (screenX>=265 & screenX<273 & screenY>=139 & screenY<149  & digits[799-(screenX-265+1)*(screenY-139+1)-1-80*((((transmitted1-(transmitted1%10))/10)-((transmitted1-(transmitted1%10))/10)%10)/10)])
		& transmitted1<1000)
			tnum_pixel_1<=black;
		else 
			tnum_pixel_1<=white;
		
		
		if (screenX>=361 & screenX<369 & screenY>=139 & screenY<149 & transmitted2<10 & digits[799-(screenX-361+1)*(screenY-139+1)-1-80*transmitted2])
			tnum_pixel_2<=black;
		else if ((screenX>=361 & screenX<369 & screenY>=139 & screenY<149  & digits[799-(screenX-361+1)*(screenY-139+1)-1-80*(transmitted2%10)])
		| (screenX>=353 & screenX<361 & screenY>=139 & screenY<149  & digits[799-(screenX-353+1)*(screenY-139+1)-1-80*((transmitted2-(transmitted2%10))/10)])
		& transmitted2<100)
			tnum_pixel_2<=black;
		else if ((screenX>=361 & screenX<369 & screenY>=139 & screenY<149  & digits[799-(screenX-361+1)*(screenY-139+1)-1-80*(transmitted2%10)])
		| (screenX>=353 & screenX<361 & screenY>=139 & screenY<149  & digits[799-(screenX-353+1)*(screenY-139+1)-1-80*(((transmitted2-(transmitted2%10))/10)%10)])
		| (screenX>=345 & screenX<353 & screenY>=139 & screenY<149  & digits[799-(screenX-345+1)*(screenY-139+1)-1-80*((((transmitted2-(transmitted2%10))/10)-((transmitted2-(transmitted2%10))/10)%10)/10)])
		& transmitted2<1000)
			tnum_pixel_2<=black;
		else 
			tnum_pixel_2<=white;
			
			
		if (screenX>=441 & screenX<449 & screenY>=139 & screenY<149 & transmitted3<10 & digits[799-(screenX-441+1)*(screenY-139+1)-1-80*transmitted3])
			tnum_pixel_3<=black;
		else if ((screenX>=441 & screenX<449 & screenY>=139 & screenY<149  & digits[799-(screenX-441+1)*(screenY-139+1)-1-80*(transmitted3%10)])
		| (screenX>=433 & screenX<441 & screenY>=139 & screenY<149  & digits[799-(screenX-433+1)*(screenY-139+1)-1-80*((transmitted3-(transmitted3%10))/10)])
		& transmitted3<100)
			tnum_pixel_3<=black;
		else if ((screenX>=441 & screenX<449 & screenY>=139 & screenY<149  & digits[799-(screenX-441+1)*(screenY-139+1)-1-80*(transmitted3%10)])
		| (screenX>=433 & screenX<441 & screenY>=139 & screenY<149  & digits[799-(screenX-433+1)*(screenY-139+1)-1-80*(((transmitted3-(transmitted3%10))/10)%10)])
		| (screenX>=425 & screenX<433 & screenY>=139 & screenY<149  & digits[799-(screenX-425+1)*(screenY-139+1)-1-80*((((transmitted3-(transmitted3%10))/10)-((transmitted3-(transmitted3%10))/10)%10)/10)])
		& transmitted3<1000)
			tnum_pixel_3<=black;
		else 
			tnum_pixel_3<=white;
			
			
		if (screenX>=521 & screenX<529 & screenY>=139 & screenY<149 & transmitted4<10 & digits[799-(screenX-521+1)*(screenY-139+1)-1-80*transmitted4])
			tnum_pixel_4<=black;
		else if ((screenX>=521 & screenX<529 & screenY>=139 & screenY<149  & digits[799-(screenX-521+1)*(screenY-139+1)-1-80*(transmitted4%10)])
		| (screenX>=513 & screenX<521 & screenY>=139 & screenY<149  & digits[799-(screenX-513+1)*(screenY-139+1)-1-80*((transmitted4-(transmitted4%10))/10)])
		& transmitted4<100)
			tnum_pixel_4<=black;
		else if ((screenX>=521 & screenX<529 & screenY>=139 & screenY<149  & digits[799-(screenX-521+1)*(screenY-139+1)-1-80*(transmitted4%10)])
		| (screenX>=513 & screenX<521 & screenY>=139 & screenY<149  & digits[799-(screenX-513+1)*(screenY-139+1)-1-80*(((transmitted4-(transmitted4%10))/10)%10)])
		| (screenX>=505 & screenX<513 & screenY>=139 & screenY<149  & digits[799-(screenX-505+1)*(screenY-139+1)-1-80*((((transmitted4-(transmitted4%10))/10)-((transmitted4-(transmitted4%10))/10)%10)/10)])
		& transmitted4<1000)
			tnum_pixel_4<=black;
		else 
			tnum_pixel_4<=white;
			
		
		transmitted_data<=transmitted1+transmitted2+transmitted3+transmitted4;
		
		if (screenX>=566 & screenX<574 & screenY>=139 & screenY<149 & transmitted_data<10 & digits[799-(screenX-566+1)*(screenY-139+1)-1-80*transmitted_data])
			tnum_pixel_5<=black;
		else if ((screenX>=566 & screenX<574 & screenY>=139 & screenY<149  & digits[799-(screenX-566+1)*(screenY-139+1)-1-80*(transmitted_data%10)])
		| (screenX>=558 & screenX<566 & screenY>=139 & screenY<149  & digits[799-(screenX-558+1)*(screenY-139+1)-1-80*((transmitted_data-(transmitted_data%10))/10)])
		& transmitted_data<100)
			tnum_pixel_5<=black;
		else if ((screenX>=566 & screenX<574 & screenY>=139 & screenY<149  & digits[799-(screenX-566+1)*(screenY-139+1)-1-80*(transmitted_data%10)])
		| (screenX>=558 & screenX<566 & screenY>=139 & screenY<149  & digits[799-(screenX-558+1)*(screenY-139+1)-1-80*(((transmitted_data-(transmitted_data%10))/10)%10)])
		| (screenX>=550 & screenX<558 & screenY>=139 & screenY<149  & digits[799-(screenX-550+1)*(screenY-139+1)-1-80*((((transmitted_data-(transmitted_data%10))/10)-((transmitted_data-(transmitted_data%10))/10)%10)/10)])
		& transmitted_data<1000)
			tnum_pixel_5<=black;
		else 
			tnum_pixel_5<=white;
			
		
		
		if (screenX>=281 & screenX<289 & screenY>=239 & screenY<249 & received1<10 & digits[799-(screenX-281+1)*(screenY-239+1)-1-80*received1])
			rnum_pixel_1<=black;
		else if ((screenX>=281 & screenX<289 & screenY>=239 & screenY<249  & digits[799-(screenX-281+1)*(screenY-239+1)-1-80*(received1%10)])
		| (screenX>=273 & screenX<281 & screenY>=239 & screenY<249  & digits[799-(screenX-273+1)*(screenY-239+1)-1-80*((received1-(received1%10))/10)])
		& received1<100)
			rnum_pixel_1<=black;
		else if ((screenX>=281 & screenX<289 & screenY>=239 & screenY<249  & digits[799-(screenX-281+1)*(screenY-239+1)-1-80*(received1%10)])
		| (screenX>=273 & screenX<281 & screenY>=239 & screenY<249  & digits[799-(screenX-273+1)*(screenY-239+1)-1-80*(((received1-(received1%10))/10)%10)])
		| (screenX>=265 & screenX<273 & screenY>=239 & screenY<249  & digits[799-(screenX-265+1)*(screenY-239+1)-1-80*((((received1-(received1%10))/10)-((received1-(received1%10))/10)%10)/10)])
		& received1<1000)
			rnum_pixel_1<=black;
		else 
			rnum_pixel_1<=white;
		
		
		if (screenX>=361 & screenX<369 & screenY>=239 & screenY<249 & received2<10 & digits[799-(screenX-361+1)*(screenY-239+1)-1-80*received2])
			rnum_pixel_2<=black;
		else if ((screenX>=361 & screenX<369 & screenY>=239 & screenY<249  & digits[799-(screenX-361+1)*(screenY-239+1)-1-80*(received2%10)])
		| (screenX>=353 & screenX<361 & screenY>=139 & screenY<249  & digits[799-(screenX-353+1)*(screenY-239+1)-1-80*((received2-(received2%10))/10)])
		& received2<100)
			rnum_pixel_2<=black;
		else if ((screenX>=361 & screenX<369 & screenY>=239 & screenY<249  & digits[799-(screenX-361+1)*(screenY-239+1)-1-80*(received2%10)])
		| (screenX>=353 & screenX<361 & screenY>=239 & screenY<249  & digits[799-(screenX-353+1)*(screenY-239+1)-1-80*(((received2-(received2%10))/10)%10)])
		| (screenX>=345 & screenX<353 & screenY>=239 & screenY<249  & digits[799-(screenX-345+1)*(screenY-239+1)-1-80*((((received2-(received2%10))/10)-((received2-(received2%10))/10)%10)/10)])
		& received2<1000)
			rnum_pixel_2<=black;
		else 
			rnum_pixel_2<=white;
			
			
		if (screenX>=441 & screenX<449 & screenY>=239 & screenY<249 & received3<10 & digits[799-(screenX-441+1)*(screenY-239+1)-1-80*received3])
			rnum_pixel_3<=black;
		else if ((screenX>=441 & screenX<449 & screenY>=239 & screenY<249  & digits[799-(screenX-441+1)*(screenY-239+1)-1-80*(received3%10)])
		| (screenX>=433 & screenX<441 & screenY>=239 & screenY<249  & digits[799-(screenX-433+1)*(screenY-239+1)-1-80*((received3-(received3%10))/10)])
		& received3<100)
			rnum_pixel_3<=black;
		else if ((screenX>=441 & screenX<449 & screenY>=239 & screenY<249  & digits[799-(screenX-441+1)*(screenY-239+1)-1-80*(received3%10)])
		| (screenX>=433 & screenX<441 & screenY>=239 & screenY<249  & digits[799-(screenX-433+1)*(screenY-239+1)-1-80*(((received3-(received3%10))/10)%10)])
		| (screenX>=425 & screenX<433 & screenY>=239 & screenY<249  & digits[799-(screenX-425+1)*(screenY-239+1)-1-80*((((received3-(received3%10))/10)-((received3-(received3%10))/10)%10)/10)])
		& received3<1000)
			rnum_pixel_3<=black;
		else 
			rnum_pixel_3<=white;
			
			
		if (screenX>=521 & screenX<529 & screenY>=239 & screenY<249 & received4<10 & digits[799-(screenX-521+1)*(screenY-239+1)-1-80*received4])
			rnum_pixel_4<=black;
		else if ((screenX>=521 & screenX<529 & screenY>=239 & screenY<249  & digits[799-(screenX-521+1)*(screenY-239+1)-1-80*(received4%10)])
		| (screenX>=513 & screenX<521 & screenY>=239 & screenY<249  & digits[799-(screenX-513+1)*(screenY-239+1)-1-80*((received4-(received4%10))/10)])
		& received4<100)
			rnum_pixel_4<=black;
		else if ((screenX>=521 & screenX<529 & screenY>=239 & screenY<249  & digits[799-(screenX-521+1)*(screenY-239+1)-1-80*(received4%10)])
		| (screenX>=513 & screenX<521 & screenY>=239 & screenY<249  & digits[799-(screenX-513+1)*(screenY-239+1)-1-80*(((received4-(received4%10))/10)%10)])
		| (screenX>=505 & screenX<513 & screenY>=239 & screenY<249  & digits[799-(screenX-505+1)*(screenY-239+1)-1-80*((((received4-(received4%10))/10)-((received4-(received4%10))/10)%10)/10)])
		& received4<1000)
			rnum_pixel_4<=black;
		else 
			rnum_pixel_4<=white;
			
		
		received_data<=received1+received2+received3+received4;
		
		if (screenX>=566 & screenX<574 & screenY>=239 & screenY<249 & received_data<10 & digits[799-(screenX-566+1)*(screenY-239+1)-1-80*received_data])
			rnum_pixel_5<=black;
		else if ((screenX>=566 & screenX<574 & screenY>=239 & screenY<249  & digits[799-(screenX-566+1)*(screenY-239+1)-1-80*(received_data%10)])
		| (screenX>=558 & screenX<566 & screenY>=239 & screenY<249  & digits[799-(screenX-558+1)*(screenY-239+1)-1-80*((received_data-(received_data%10))/10)])
		& received_data<100)
			rnum_pixel_5<=black;
		else if ((screenX>=566 & screenX<574 & screenY>=239 & screenY<249  & digits[799-(screenX-566+1)*(screenY-239+1)-1-80*(received_data%10)])
		| (screenX>=558 & screenX<566 & screenY>=239 & screenY<249  & digits[799-(screenX-558+1)*(screenY-239+1)-1-80*(((received_data-(received_data%10))/10)%10)])
		| (screenX>=550 & screenX<558 & screenY>=239 & screenY<249  & digits[799-(screenX-550+1)*(screenY-239+1)-1-80*((((received_data-(received_data%10))/10)-((received_data-(received_data%10))/10)%10)/10)])
		& received_data<1000)
			rnum_pixel_5<=black;
		else 
			rnum_pixel_5<=white;
		
		
		
		if (screenX>=281 & screenX<289 & screenY>=329 & screenY<339 & drop1<10 & digits[799-(screenX-281+1)*(screenY-329+1)-1-80*drop1])
			num_pixel_1<=black;
		else if ((screenX>=281 & screenX<289 & screenY>=329 & screenY<339  & digits[799-(screenX-281+1)*(screenY-329+1)-1-80*(drop1%10)])
		| (screenX>=273 & screenX<281 & screenY>=329 & screenY<339  & digits[799-(screenX-273+1)*(screenY-329+1)-1-80*((drop1-(drop1%10))/10)])
		& drop1<100)
			num_pixel_1<=black;
		else if ((screenX>=281 & screenX<289 & screenY>=329 & screenY<339  & digits[799-(screenX-281+1)*(screenY-329+1)-1-80*(drop1%10)])
		| (screenX>=273 & screenX<281 & screenY>=329 & screenY<339  & digits[799-(screenX-273+1)*(screenY-329+1)-1-80*(((drop1-(drop1%10))/10)%10)])
		| (screenX>=265 & screenX<273 & screenY>=329 & screenY<339  & digits[799-(screenX-265+1)*(screenY-329+1)-1-80*((((drop1-(drop1%10))/10)-((drop1-(drop1%10))/10)%10)/10)])
		& drop1<1000)
			num_pixel_1<=black;
		else 
			num_pixel_1<=white;
		
		
		if (screenX>=361 & screenX<369 & screenY>=329 & screenY<339 & drop2<10 & digits[799-(screenX-361+1)*(screenY-329+1)-1-80*drop2])
			num_pixel_2<=black;
		else if ((screenX>=361 & screenX<369 & screenY>=329 & screenY<339  & digits[799-(screenX-361+1)*(screenY-329+1)-1-80*(drop2%10)])
		| (screenX>=353 & screenX<361 & screenY>=329 & screenY<339  & digits[799-(screenX-353+1)*(screenY-329+1)-1-80*((drop2-(drop2%10))/10)])
		& drop2<100)
			num_pixel_2<=black;
		else if ((screenX>=361 & screenX<369 & screenY>=329 & screenY<339  & digits[799-(screenX-361+1)*(screenY-329+1)-1-80*(drop2%10)])
		| (screenX>=353 & screenX<361 & screenY>=329 & screenY<339  & digits[799-(screenX-353+1)*(screenY-329+1)-1-80*(((drop2-(drop2%10))/10)%10)])
		| (screenX>=345 & screenX<353 & screenY>=329 & screenY<339  & digits[799-(screenX-345+1)*(screenY-329+1)-1-80*((((drop2-(drop2%10))/10)-((drop2-(drop2%10))/10)%10)/10)])
		& drop2<1000)
			num_pixel_2<=black;
		else 
			num_pixel_2<=white;
			
			
		if (screenX>=441 & screenX<449 & screenY>=329 & screenY<339 & drop3<10 & digits[799-(screenX-441+1)*(screenY-329+1)-1-80*drop3])
			num_pixel_3<=black;
		else if ((screenX>=441 & screenX<449 & screenY>=329 & screenY<339  & digits[799-(screenX-441+1)*(screenY-329+1)-1-80*(drop3%10)])
		| (screenX>=433 & screenX<441 & screenY>=329 & screenY<339  & digits[799-(screenX-433+1)*(screenY-329+1)-1-80*((drop3-(drop3%10))/10)])
		& drop3<100)
			num_pixel_3<=black;
		else if ((screenX>=441 & screenX<449 & screenY>=329 & screenY<339  & digits[799-(screenX-441+1)*(screenY-329+1)-1-80*(drop3%10)])
		| (screenX>=433 & screenX<441 & screenY>=329 & screenY<339  & digits[799-(screenX-433+1)*(screenY-329+1)-1-80*(((drop3-(drop3%10))/10)%10)])
		| (screenX>=425 & screenX<433 & screenY>=329 & screenY<339  & digits[799-(screenX-425+1)*(screenY-329+1)-1-80*((((drop3-(drop3%10))/10)-((drop3-(drop3%10))/10)%10)/10)])
		& drop3<1000)
			num_pixel_3<=black;
		else 
			num_pixel_3<=white;
			
			
		if (screenX>=521 & screenX<529 & screenY>=329 & screenY<339 & drop4<10 & digits[799-(screenX-521+1)*(screenY-329+1)-1-80*drop4])
			num_pixel_4<=black;
		else if ((screenX>=521 & screenX<529 & screenY>=329 & screenY<339  & digits[799-(screenX-521+1)*(screenY-329+1)-1-80*(drop4%10)])
		| (screenX>=513 & screenX<521 & screenY>=329 & screenY<339  & digits[799-(screenX-513+1)*(screenY-329+1)-1-80*((drop4-(drop4%10))/10)])
		& drop4<100)
			num_pixel_4<=black;
		else if ((screenX>=521 & screenX<529 & screenY>=329 & screenY<339  & digits[799-(screenX-521+1)*(screenY-329+1)-1-80*(drop4%10)])
		| (screenX>=513 & screenX<521 & screenY>=329 & screenY<339  & digits[799-(screenX-513+1)*(screenY-329+1)-1-80*(((drop4-(drop4%10))/10)%10)])
		| (screenX>=505 & screenX<513 & screenY>=329 & screenY<339  & digits[799-(screenX-505+1)*(screenY-329+1)-1-80*((((drop4-(drop4%10))/10)-((drop4-(drop4%10))/10)%10)/10)])
		& drop4<1000)
			num_pixel_4<=black;
		else 
			num_pixel_4<=white;
			
		
		drop_data<=drop1+drop2+drop3+drop4;
		
		if (screenX>=566 & screenX<574 & screenY>=329 & screenY<339 & drop_data<10 & digits[799-(screenX-566+1)*(screenY-329+1)-1-80*drop_data])
			num_pixel_5<=black;
		else if ((screenX>=566 & screenX<574 & screenY>=329 & screenY<339  & digits[799-(screenX-566+1)*(screenY-329+1)-1-80*(drop_data%10)])
		| (screenX>=558 & screenX<566 & screenY>=329 & screenY<339  & digits[799-(screenX-558+1)*(screenY-329+1)-1-80*((drop_data-(drop_data%10))/10)])
		& drop_data>=100)
			num_pixel_5<=black;
		else if ((screenX>=566 & screenX<574 & screenY>=329 & screenY<339  & digits[799-(screenX-566+1)*(screenY-329+1)-1-80*(drop_data%10)])
		| (screenX>=558 & screenX<566 & screenY>=329 & screenY<339  & digits[799-(screenX-558+1)*(screenY-329+1)-1-80*(((drop_data-(drop_data%10))/10)%10)])
		| (screenX>=550 & screenX<558 & screenY>=329 & screenY<339  & digits[799-(screenX-550+1)*(screenY-329+1)-1-80*((((drop_data-(drop_data%10))/10)-((drop_data-(drop_data%10))/10)%10)/10)])
		& drop_data<1000)
			num_pixel_5<=black;
		else 
			num_pixel_5<=white;
		
		num_pixel<=num_pixel_1&num_pixel_2&num_pixel_3&num_pixel_4&num_pixel_5;
		tnum_pixel<=tnum_pixel_1&tnum_pixel_2&tnum_pixel_3&tnum_pixel_4&tnum_pixel_5;
		rnum_pixel<=rnum_pixel_1&rnum_pixel_2&rnum_pixel_3&rnum_pixel_4&rnum_pixel_5;

		computedPixel <= box_pixel & color_box_pixel & input_num_pixel&num_pixel&output_num_pixel&tnum_pixel&rnum_pixel;
		
		//if (computedPixel==black1)
			//screenPixel<=white;
		//else
		screenPixel <= computedPixel;
		//screenPixel<=white;
	end
end

endmodule
