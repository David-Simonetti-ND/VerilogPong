`timescale 1ns/1ns
module sprite_manager_tb();
	reg          clk = 1'b0;
   reg    [7:0] x_ball = 8'd0;
   reg    [6:0] y_ball = 7'd0;
	reg    [7:0] x_paddle = 8'd0;
   reg    [6:0] y_paddle = 7'd0;
	reg    [7:0] x_ai = 8'd0;
   reg    [6:0] y_ai = 7'd0;
   reg    [7:0] xvga = 8'd0;
   reg    [6:0] yvga = 7'd0;
	reg    [4:0] player_score = 4'd0;
	reg    [4:0] ai_score = 4'd0;
   wire   [2:0] color;
	
	sprite_manager uut(
		.VGA_CLK(clk),
		.xvga(xvga),
		.yvga(yvga),
		.x_ball(x_ball),
		.y_ball(y_ball),
		.x_paddle(x_paddle),
		.y_paddle(y_paddle),
		.x_ai(x_ai),
		.y_ai(y_ai),
		.player_score(player_score),
		.ai_score(ai_score),
		.color(color)
	);
		
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
			x_ball = 8'd80; y_ball = 7'd60;
			x_paddle = 8'd10; y_paddle = 7'd5;
			x_ai = 8'd150; y_ai = 7'd5;
			player_score = 4'd0; ai_score = 4'd0;
		for (k = 0; k < 5; k = k + 1)
		begin
			x_ball = x_ball + 5; y_ball = y_ball + 5;
			y_paddle = y_paddle + 5; y_ai = y_ai + 5;
			player_score = player_score + 1; ai_score = ai_score + 1;
			#768000; // wait for one vga cycle
		end
	end
	
endmodule