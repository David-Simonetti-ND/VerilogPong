`timescale 1ns/1ns

module controller_tb();
	reg clk = 1'b0;
	reg reset = 1'b0;
	reg y_sign = 1'b0, x_sign = 1'b0, paddle_up = 1'b0, paddle_down = 1'b0, ai_up = 1'b0, ai_down = 1'b0;
	reg ball_too_high = 1'b0, ball_too_low = 1'b0, paddle_too_low = 1'b0, paddle_too_high = 1'b0, ai_too_low = 1'b0, ai_too_high = 1'b0; 
	reg player_collision = 1'b0, ai_collision = 1'b0, player_scored = 1'b0, ai_scored = 1'b0, game_over = 1'b0;
	
	wire [1:0] sel_x_ball, sel_y_ball;
	wire [2:0] sel_y_paddle, sel_y_ai;
	wire en_x_ball, en_y_ball, en_y_paddle, en_y_ai, sel_player_score, en_player_score, sel_ai_score, en_ai_score;
	
	controller uut(
		.clk (clk),
		.reset (reset),
		.sel_x_ball (sel_x_ball),
		.en_x_ball (en_x_ball),
		.sel_y_ball (sel_y_ball),
		.en_y_ball (en_y_ball),
		.sel_y_paddle (sel_y_paddle),
		.en_y_paddle (en_y_paddle),
		.sel_y_ai (sel_y_ai),
		.en_y_ai (en_y_ai),
		.sel_player_score (sel_player_score),
		.en_player_score (en_player_score),
		.sel_ai_score (sel_ai_score),
		.en_ai_score (en_ai_score),
		.y_sign (y_sign),
		.x_sign (x_sign),
		.ball_too_high (ball_too_high),
		.ball_too_low (ball_too_low),
		.paddle_too_low (paddle_too_low),
		.paddle_too_high (paddle_too_high),
		.ai_too_low (ai_too_low),
		.ai_too_high (ai_too_high),
		.paddle_up (paddle_up),
		.paddle_down (paddle_down),
		.ai_up (ai_up),
		.ai_down (ai_down),
		.player_collision (player_collision),
		.ai_collision (ai_collision),
		.player_scored (player_scored), 
		.ai_scored (ai_scored),
		.game_over (game_over)
	);
	
	always #5 clk = ~clk;

	
	initial begin
					reset = 0; // reset state
			#10;	// BALL_Y_UP
			#10;	x_sign = 1; // transition to BALL_X_UP
			#10;  // BALL_X_UP
			#10;	ai_collision = 1; // transition to BALL_X_DOWN
			#10;	// BALL_X_DOWN
			#10;  player_collision = 1; // transition BALL_X_UP
			#10;  // BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 1; // transition to BALL_X_UP
			#10;	// BALL_X_UP
			#10;  ai_collision = 0; player_scored = 1; // transition to PLAYER_SCORE
			#10;  // PLAYER_SCORE
			#10;	game_over = 1; // transition to RESET
			#10;  // transition to BALL_Y_UP
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;  player_collision = 0; ai_scored = 1; // transition to AI_SCORE
			#10;  // AI_SCORE
			#10;	game_over = 1; // transition to RESET
			#10;  // transition to BALL_Y_UP
			#10;  x_sign = 1; // transition to BALL_X_UP
			#10;  ai_collision = 0; player_scored = 0; paddle_down = 1; paddle_too_high = 1; // transition to PADDLE_RESET
			#10;	ai_down = 1; ai_too_high = 1; // transition to AI_RESET
			#10;	ball_too_high = 1; // transition to BALL_Y_DOWN
			#10;	x_sign = 1; // transition to BALL_X_UP
			#10;	ai_collision = 0; player_scored = 0; paddle_down = 1; paddle_too_high = 0; // transition to PADDLE_DOWN
			#10;	ai_down = 1; ai_too_high = 1; // transition to AI_RESET
			#10;  ball_too_high = 0; ball_too_low = 1; // transition to BALL_Y_UP
			#10; 	x_sign = 1; // transition to BALL_X_UP
			#10;	ai_collision = 0; player_scored = 0; paddle_down = 0; paddle_up = 1; paddle_too_low = 1; // transition to PADDLE_RESET
			#10;	ai_down = 1; ai_too_high = 0; // transition to AI_DOWN
			#10;	ball_too_high = 1; // transition to BALL_Y_DOWN
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 1; paddle_too_high = 1; // transition to PADDLE_RESET
			#10;	ai_down = 0; ai_up = 1; ai_too_low = 1; // transition to AI_RESET
			#10;	ball_too_high = 0; ball_too_low = 0; y_sign = 1; // transition to BALL_Y_UP
			#10; 	x_sign = 1; // transition to BALL_X_UP
			#10;	ai_collision = 0; player_scored = 0; paddle_down = 0; paddle_up = 1; paddle_too_low = 0; // transition to PADDLE_UP
			#10;	ai_down = 1; ai_too_high = 1; // transition to AI_RESET
			#10;	ball_too_high = 0; ball_too_low = 0; y_sign = 0; // transition to BALL_Y_DOWN
			#10;	x_sign = 1; // transition to BALL_X_UP
			#10;	ai_collision = 0; player_scored = 0; paddle_down = 0; paddle_up = 0; // transition to PADDLE_RESET
			#10;	ai_down = 0; ai_up = 1; ai_too_low = 0; // transition to AI_UP
			#10;	ball_too_high = 1; // transition to BALL_Y_DOWN
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 1; paddle_too_high = 0; // transition to PADDLE_DOWN
			#10;	ai_down = 1; ai_too_high = 0; // transition to AI_DOWN
			#10;	ball_too_high = 0; ball_too_low = 1; // transition to BALL_Y_UP
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 0; paddle_up = 1; paddle_too_low = 1; // transition to PADDLE_RESET
			#10;	ai_down = 0; ai_up = 0; // transition to AI_RESET
			#10;	ball_too_high = 1; // transition to BALL_Y_DOWN
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 0; paddle_up = 1; paddle_too_low = 0; // transition to PADDLE_UP
			#10;	ai_down = 1; ai_too_high = 0; // transition to AI_DOWN
			#10;	ball_too_high = 0; ball_too_low = 0; y_sign = 1; // transition to BALL_Y_UP
			#10; 	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 0; paddle_up = 0; // transition to PADDLE_RESET
			#10;	ai_down = 1; ai_too_high = 0; // transition to AI_DOWN
			#10;	ball_too_high = 0; ball_too_low = 0; y_sign = 0; // transition to BALL_Y_DOWN
			#10;	x_sign = 1; // transition to BALL_X_UP
			#10;	ai_collision = 0; player_scored = 1; // transition to PLAYER_SCORE
			#10;	game_over = 0; // transition to BALL_Y_UP
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 1; // transition to AI_SCORE
			#10;	game_over = 0; // transition to BALL_Y_UP
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 1; paddle_too_high = 0; // transition to PADDLE_DOWN
			#10;	ai_down = 0; ai_up = 1; ai_too_low = 1; // transition to AI_RESET
			#10;	ball_too_high = 1; // transition to BALL_Y_DOWN
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 1; paddle_too_high = 0; // transition to PADDLE_DOWN
			#10;	ai_down = 0; ai_up = 1; ai_too_low = 0; // transition to AI_UP
			#10;	ball_too_high = 0; ball_too_low = 1; // transition to BALL_Y_UP
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 1; paddle_too_high = 0; // transition to PADDLE_DOWN
			#10;	ai_down = 0; ai_up = 0; // transition to AI_RESET
			#10;	ball_too_high = 1; // transition to BALL_Y_DOWN
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 0; paddle_up = 1; paddle_too_low = 0; // transition to PADDLE_UP
			#10;	ai_down = 0; ai_up = 1; ai_too_low = 1; // transition to AI_RESET
			#10;	ball_too_high = 1; // transition to BALL_Y_DOWN
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 0; paddle_up = 1; paddle_too_low = 0; // transition to PADDLE_UP
			#10; 	ai_down = 0; ai_up = 1; ai_too_low = 0; // transition to AI_UP
			#10;	ball_too_high = 0; ball_too_low = 0; y_sign = 1; // transition to BALL_Y_UP
			#10;	x_sign = 0; // transition to BALL_X_DOWN
			#10;	player_collision = 0; ai_scored = 0; paddle_down = 0; paddle_up = 1; paddle_too_low = 0; // transition to PADDLE_UP
			#10; 	ai_down = 0; ai_up = 1; ai_too_low = 0; // transition to AI_UP
			#10;	ball_too_high = 0; ball_too_low = 0; y_sign = 0; // transition to BALL_Y_DOWN
		
	end


endmodule 