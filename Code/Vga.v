/*

West,A (2019) fpga-pong [Source code].
https://github.com/andy-west/fpga-pong.


*/


module Vga(
	input pixelClock,
	input [23:0] activePixel,
	output reg [7:0]RED,
	output reg [7:0]GREEN,
	output reg [7:0]BLUE,
	output reg HSYNC,
	output reg VSYNC,
	output reg visibleArea,
	output reg [10:0] screenX,
	output reg [10:0] screenY
);

reg [15:0] hPos = 0;
reg [15:0] vPos = 0;

parameter [15:0] hVisiblePixels = 640;
localparam [7:0] hBackPorchPixels = 48;
localparam [7:0] hSyncPixels = 96;
localparam [7:0] hFrontPorchPixels = 16;
localparam [15:0] hTotalPixels = hVisiblePixels + hFrontPorchPixels + hSyncPixels + hBackPorchPixels;

parameter [15:0] vVisibleLines = 480;
localparam [7:0] vBackPorchLines = 33;
localparam [7:0] vSyncLines = 2;
localparam [7:0] vFrontPorchLines = 10;
localparam [15:0] vTotalLines = vVisibleLines + vFrontPorchLines + vSyncLines + vBackPorchLines;

// horizontal timings
    parameter HA_END = 639;           // end of active pixels
    parameter HS_STA = HA_END + 16;   // sync starts after front porch
    parameter HS_END = HS_STA + 96;   // sync ends
    parameter LINE   = 799;           // last pixel on line (after back porch)

    // vertical timings
    parameter VA_END = 479;           // end of active pixels
    parameter VS_STA = VA_END + 10;   // sync starts after front porch
    parameter VS_END = VS_STA + 2;    // sync ends
    parameter SCREEN = 524;           // last line on screen (after back porch)




always @(posedge pixelClock)
begin
	hPos <= hPos + 1'b1;

	if (hPos >= hTotalPixels)
	begin
		hPos <= 0;
		vPos <= vPos + 1'b1;

		if (vPos >= vTotalLines)
			vPos <= 0;
	end

	if ((vPos >= vBackPorchLines)
		& (vPos < vBackPorchLines + vVisibleLines)
		& (hPos >= hBackPorchPixels)
		& (hPos < hBackPorchPixels + hVisiblePixels))
		begin
			visibleArea <= 1;

			RED <= activePixel[23:16];
			GREEN <= activePixel[15:8];
			BLUE <= activePixel[7:0];
		end
	else
		begin
			visibleArea <= 0;

			RED <= 8'h00;
			GREEN <= 8'h00;
			BLUE <= 8'h00;
		end

	/*if (hPos >hVisiblePixels + hFrontPorchPixels && hPos < hVisiblePixels + hFrontPorchPixels+hSyncPixels)
		HSYNC <= 0;
	else
		HSYNC <= 1;

	if (vPos > vVisibleLines+vFrontPorchLines && vPos< vVisibleLines+vFrontPorchLines+vSyncLines)
		VSYNC <= 0;
	else
		VSYNC <= 1;	
	*/
	
	HSYNC = ~(hPos >= HS_STA && hPos < HS_END);  // invert: negative polarity
	VSYNC = ~(vPos >= VS_STA && vPos < VS_END);
	
	
	if(hPos<hBackPorchPixels) screenX<=0;
	else screenX <= hPos - hBackPorchPixels;
	if (vPos<vBackPorchLines) screenY<=0;
	else screenY <= vPos - vBackPorchLines;
end

endmodule




/*module testbench;

	reg pixelClock;
	reg [23:0] activePixel;
	wire [7:0]RED;
	wire [7:0]GREEN;
	wire [7:0]BLUE;
	wire HSYNC;
	wire VSYNC;
	wire visibleArea;
	wire [10:0] screenX;
	wire [10:0] screenY;
	
	
	Vga vg(.pixelClock(pixelClock),.activePixel(activePixel),.RED(RED),.GREEN(GREEN),
	.BLUE(BLUE),.HSYNC(HSYNC),.VSYNC(VSYNC),.visibleArea(visibleArea),.screenX(screenX),.screenY(screenY));
	
	always begin
	
	#10 pixelClock<=1;
	#10 pixelClock<=0;
	
	
	end
	
	always begin
	
	#100 activePixel<=24'hff00ff;
	#100 activePixel<=24'hff0000;
	
	
	end
	
endmodule

*/
