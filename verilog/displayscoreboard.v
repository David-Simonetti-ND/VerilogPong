module displayscoreboard(
	input          VGA_CLK,
   input    [7:0] xvga,
   input    [6:0] yvga,
	input    [3:0] player_score,
	input    [3:0] ai_score,
	output reg     display_player,
	output reg     display_ai,
	output   [2:0] player_color,
	output   [2:0] ai_color
	);
	
	wire [7:0] xs_p = xvga - 8'h40;
   wire [6:0] ys_p = yvga - 8'h04;
	
	wire [7:0] xs_ai = xvga - 8'h60;
   wire [6:0] ys_ai = yvga - 8'h04;
	
	always @(posedge VGA_CLK)
	begin
		display_player <= (xvga >= 8'h40) & (xvga < (8'h40 + 8'h4)) & (yvga >= 8'h04) & (yvga < (8'h04 + 8'h7));
		display_ai <= (xvga >= 8'h60) & (xvga < (8'h60 + 8'h4)) & (yvga >= 8'h04) & (yvga < (8'h04 + 8'h7));
	end
	
	scoreboard player(
		.clk(VGA_CLK),
		.score(player_score),
		.x(xs_p[2:0]),
      .y(ys_p[2:0]),
		.dout(player_color)
	);
	
	scoreboard ai(
		.clk(VGA_CLK),
		.score(ai_score),
		.x(xs_ai[2:0]),
      .y(ys_ai[2:0]),
		.dout(ai_color)
	);
endmodule