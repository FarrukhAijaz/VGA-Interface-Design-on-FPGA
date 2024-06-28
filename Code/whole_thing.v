module whole_thing(but0,but1,start,clk,RED,GREEN,BLUE,HSYNC,VSYNC,hex_disp1,hex_disp2,hex_disp3,hex_disp4,clk25,button_clk);

	input but0,but1,start;
	input clk;
	input button_clk;
	output [7:0] RED;
	output [7:0] GREEN;
	output [7:0] BLUE;
	output HSYNC;
	output VSYNC;
	output [6:0] hex_disp1;
	output [6:0] hex_disp2;
	output [6:0] hex_disp3;
	output [6:0] hex_disp4;
	output clk25;
	
	wire [11:0]b1,b2,b3,b4;
	wire [3:0]c1,c2,c3,c4;
	wire r;
	wire freq_25;
	wire [3:0]data;
	wire [2:0] serial_count;
	wire [3:0]d;
	
	wire [10:0]screenx;
	wire [10:0]screeny;
	wire [15:0] trans1;
	wire [15:0] trans2;
	wire [15:0] trans3;
	wire [15:0] trans4;
	wire [15:0] recev1;
	wire [15:0] recev2;
	wire [15:0]	recev3;
	wire [15:0] recev4;
	wire [10:0] drop1;
	wire [10:0] drop2;
	wire [10:0] drop3;
	wire [10:0] drop4;
	wire visible;
	wire [23:0] pixel;
	wire [2:0] count;
	
	frequency_25MHz freq2(.clk(clk),.freq_25mhz(clk25));
	
	frequency_25MHz freq(.clk(clk),.freq_25mhz(freq_25));
	
	Renderer rend(.pixelClock(freq_25),.visibleArea(visible),.screenX(screenx),.screenY(screeny),.data_trans(data),.data_recev(d),
	.received1(recev1),.received2(recev2),.received3(recev3),.received4(recev4),
	.transmitted1(trans1),.transmitted2(trans2),.transmitted3(trans3),.transmitted4(trans4),
	.drop1(drop1),.drop2(drop2),.drop3(drop3),.drop4(drop4),
	.count1(c1),.count2(c2),.count3(c3),.count4(c4),
	.buffer1(b1),.buffer2(b2),.buffer3(b3),.buffer4(b4),
	.screenPixel(pixel));
	
	Vga vg(.pixelClock(freq_25),.activePixel(pixel),
	.RED(RED),.GREEN(GREEN),.BLUE(BLUE),.HSYNC(HSYNC),.VSYNC(VSYNC),.visibleArea(visible),.screenX(screenx),.screenY(screeny));
	
	serial_to_parallel uC1(.button0(but0),.button1(but1),.start(start),.data(data),.clk(button_clk),.count_12(count));
	
	
	writing_2 uA1(.clk(button_clk),.data(data),.reading(r),.count1(c1),.count2(c2),.count3(c3),.count4(c4),.buffer1(b1),.buffer2(b2),.buffer3(b3),.buffer4(b4),
	.drop1(drop1),.drop2(drop2),.drop3(drop3),.drop4(drop4),.received1(recev1),.received2(recev2),.received3(recev3),.received4(recev4),.count(count));
	
	
	reading uB1(.data1(b1),.data2(b2),.data3(b3),.data4(b4),.clk(clk),.ins1(c1),.ins2(c2),.ins3(c3),.ins4(c4),.reading(r),.data_out(d),
	.transmitted1(trans1), .transmitted2(trans2),.transmitted3(trans3),.transmitted4(trans4));
	
	segment_seven_display disp1(.clk(clk),.BCD_num(data[0]),.disp_hex(hex_disp1));
	
	segment_seven_display disp2(.clk(clk),.BCD_num(data[1]),.disp_hex(hex_disp2));
	
	segment_seven_display disp3(.clk(clk),.BCD_num(data[2]),.disp_hex(hex_disp3));
	
	segment_seven_display disp4(.clk(clk),.BCD_num(data[3]),.disp_hex(hex_disp4));
	

	
endmodule



