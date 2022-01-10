module system(
	input           clk,
	input   [7:0]   current_data,
	output  [7:0]   x_ball,
	output  [6:0]   y_ball,
	output  [6:0]   y_paddle,
	output  [6:0]   y_ai,
	output  [3:0]   player_score,
	output  [3:0]   ai_score
	);
	
	wire t;
	framerate_clock clock(
		.VGA_CLK(clk),
		.t(t)
	);
	
	wire en_x_ball, en_y_ball, en_y_paddle, en_y_ai, en_player_score, en_ai_score;
	wire [1:0] sel_x_ball, sel_y_ball, sel_y_paddle, sel_y_ai;
	wire sel_player_score, sel_ai_score;
	
	wire ball_too_high, ball_too_low, paddle_too_low, paddle_too_high, y_sign, x_sign;
	wire paddle_up, paddle_down, ai_up, ai_down;
	wire ai_too_high, ai_too_low;
	wire player_collision, ai_collision;
	wire player_scored, ai_scored;
	wire game_over;
	
	controller controller(
		.clk(t),
		.en_x_ball(en_x_ball),
		.sel_x_ball(sel_x_ball),
		.en_y_ball(en_y_ball),
		.sel_y_ball(sel_y_ball),
		.en_y_paddle(en_y_paddle),
		.sel_y_paddle(sel_y_paddle),
		.en_y_ai(en_y_ai),
		.sel_y_ai(sel_y_ai),
		.en_player_score(en_player_score),
		.sel_player_score(sel_player_score),
		.en_ai_score(en_ai_score),
		.sel_ai_score(sel_ai_score),
		.ball_too_high(ball_too_high),
		.ball_too_low(ball_too_low),
		.paddle_too_low(paddle_too_low),
		.paddle_too_high(paddle_too_high),
		.y_sign(y_sign),
		.x_sign(x_sign),
		.ai_too_high(ai_too_high),
		.ai_too_low(ai_too_low),
		.player_collision(player_collision),
		.ai_collision(ai_collision),
		.player_scored(player_scored),
		.ai_scored(ai_scored),
		.game_over(game_over),
		.paddle_up(paddle_up),
		.paddle_down(paddle_down),
		.ai_up(ai_up),
		.ai_down(ai_down)
	);
	
	datapath datapath(
		.clk(t),
		.en_x_ball(en_x_ball),
		.sel_x_ball(sel_x_ball),
		.en_y_ball(en_y_ball),
		.sel_y_ball(sel_y_ball),
		.en_y_paddle(en_y_paddle),
		.sel_y_paddle(sel_y_paddle),
		.en_y_ai(en_y_ai),
		.sel_y_ai(sel_y_ai),
		.en_player_score(en_player_score),
		.sel_player_score(sel_player_score),
		.en_ai_score(en_ai_score),
		.sel_ai_score(sel_ai_score),
		.x_ball(x_ball),
		.y_ball(y_ball),
		.y_paddle(y_paddle),
		.y_ai(y_ai),
		.ball_too_high(ball_too_high),
		.ball_too_low(ball_too_low),
		.paddle_too_low(paddle_too_low),
		.paddle_too_high(paddle_too_high),
		.y_sign(y_sign),
		.x_sign(x_sign),
		.ai_too_high(ai_too_high),
		.ai_too_low(ai_too_low),
		.player_collision(player_collision),
		.ai_collision(ai_collision),
		.player_scored(player_scored),
		.ai_scored(ai_scored),
		.player_score(player_score),
		.ai_score(ai_score),
		.game_over(game_over),
		.paddle_up(paddle_up),
		.paddle_down(paddle_down),
		.ai_up(ai_up),
		.ai_down(ai_down),
		.user_in(current_data)
	);

	
endmodule