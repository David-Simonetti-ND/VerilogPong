`timescale 1ns/1ns
module displayscoreboard_tb();
	reg          clk = 1'b0;
   reg    [7:0] xvga = 8'd0;
   reg    [6:0] yvga = 7'd0;
	reg    [3:0] player_score;
	reg    [3:0] ai_score;
	wire         display_player;
	wire         display_ai;
	wire   [2:0] player_color;
	wire   [2:0] ai_color;
	
	displayscoreboard uut(
		.VGA_CLK(clk),
		.xvga(xvga),
		.yvga(yvga),
		.player_score(player_score),
		.ai_score(ai_score),
		.display_player(display_player),
		.display_ai(display_ai),
		.player_color(player_color),
		.ai_color(ai_color)
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
		for (k = 0; k < 10; k = k + 1)
		begin
			player_score = k;
			ai_score = k;
			#768000; // wait for one vga cycle
			end
	end
	
endmodule