module display_sprite(
	input          VGA_CLK,
   input    [7:0] xvga,
   input    [6:0] yvga,
	input    [7:0] x,
   input    [6:0] y,
	input    [3:0] width,
	input    [3:0] height,
	output reg     to_display,
	output   [2:0] sprite_color
	);
	
	wire [7:0] xs = xvga - x;
   wire [6:0] ys = yvga - y;
	
	wire in_sprite = (xvga >= x) & (xvga < (x + width)) & (yvga >= y) & (yvga < (y + height));
	
	always @(posedge VGA_CLK) to_display <= in_sprite;
	
	parameter IMAGE_FILE = "Sprites/sprite.mem";
	
	sprite_rom sprite ( 
      .clk  (VGA_CLK),    			
      .x    (xs[1:0]),
      .y    (ys[1:0]),  
		.dout (sprite_color)
   );
	
	defparam sprite.IMAGE_FILE = IMAGE_FILE;
	
endmodule