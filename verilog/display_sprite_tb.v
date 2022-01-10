`timescale 1ns/1ns
module display_sprite_tb();
	reg          	 clk = 1'b0;
   reg    	 [7:0] xvga = 8'd0;
   reg    	 [6:0] yvga = 7'd0;
	reg    	 [7:0] x = 8'd0;
	reg    	 [6:0] y = 7'd0;
	parameter [3:0] width = 4'd4;
	parameter [3:0] height = 4'd4;
	wire	          to_display;
	wire   	 [2:0] sprite_color;
	
	display_sprite uut(
		.VGA_CLK(clk),
		.xvga(xvga),
		.yvga(yvga),
		.x(x),
		.y(y),
		.width(width),
		.height(height),
		.to_display(to_display),
		.sprite_color(sprite_color)
	);
	
	defparam uut.IMAGE_FILE = "Sprites/ball.mem";
	
	integer i;
	integer j;
	integer k;
	
	always #20 clk = ~clk; // 20 nanoseocnd 50mHz clock
	
	// 40 nanosecond wait to get a 25mHz VGA clock, this simulates the xvga and yvga signals system would recieve
	always 
	begin
		for (i = 0; i < 120; i = i + 1)
		begin
			yvga = i;
			for (j = 0; j < 160; j = j + 1)
			begin
				#40 xvga = j;
			end
		end
	end
	
	initial 
	begin
			x = 8'd80; y = 7'd60;
		for (k = 0; k < 5; k = k + 1)
		begin
			x = x + 5; y = y + 5;
			#768000; // wait for one vga cycle
		end
	end
	
endmodule