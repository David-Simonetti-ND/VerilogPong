module sprite_manager (
   input          VGA_CLK,
   input    [7:0] x_ball,
   input    [6:0] y_ball,
	input    [7:0] x_paddle,
   input    [6:0] y_paddle,
	input    [7:0] x_ai,
   input    [6:0] y_ai,
   input    [7:0] xvga,
   input    [6:0] yvga,
	input    [4:0] player_score,
	input    [4:0] ai_score,
   output reg   [2:0] color
   );
   
   wire [2:0] sprite_color_ball, sprite_color_paddle, sprite_color_ai, player_score_color, ai_score_color, background_color;
	wire in_ball, in_paddle, in_ai, in_p_score, in_ai_score;
	
	display_sprite ball(
		.VGA_CLK(VGA_CLK),
		.xvga(xvga),
		.yvga(yvga),
		.x(x_ball),
		.y(y_ball),
		.width(4'h4),
		.height(4'h4),
		.to_display(in_ball),
		.sprite_color(sprite_color_ball)
	);
	
	display_sprite paddle(
		.VGA_CLK(VGA_CLK),
		.xvga(xvga),
		.yvga(yvga),
		.x(x_paddle),
		.y(y_paddle),
		.width(4'h2),
		.height(4'hf),
		.to_display(in_paddle),
		.sprite_color(sprite_color_paddle)
	);
	
	display_sprite ai(
		.VGA_CLK(VGA_CLK),
		.xvga(xvga),
		.yvga(yvga),
		.x(x_ai),
		.y(y_ai),
		.width(4'h2),
		.height(4'hf),
		.to_display(in_ai),
		.sprite_color(sprite_color_ai)
	);
	
	defparam ball.IMAGE_FILE = "Sprites/ball.mem";
	defparam paddle.IMAGE_FILE = "Sprites/paddle.mem";
	defparam ai.IMAGE_FILE = "Sprites/paddle.mem";
	
	displayscoreboard scoreboard(
		.VGA_CLK(VGA_CLK),
		.xvga(xvga),
		.yvga(yvga),
		.player_score(player_score),
		.ai_score(ai_score),
		.display_player(in_p_score),
		.display_ai(in_ai_score),
		.player_color(player_score_color),
		.ai_color(ai_score_color)
	);
	
   background_rom background_rom ( 
      .clk  (VGA_CLK),    			
      .x    (xvga),
      .y    (yvga),  
      .dout (background_color)
   );
   
	always @(posedge VGA_CLK)
	begin
		if (in_ball) color = sprite_color_ball;
		else if (in_paddle) color = sprite_color_paddle;
		else if (in_ai) color = sprite_color_ai;
		else if (in_p_score) color = player_score_color;
		else if (in_ai_score) color = ai_score_color;
		else color = background_color;
	end
   
endmodule
