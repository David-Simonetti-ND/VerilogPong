`timescale 1ns/1ns
module datapath_tb();

	reg [7:0] current_data = 8'd0;
	reg en_x_ball = 1'b0, en_y_ball = 1'b0, en_y_paddle = 1'b0, en_y_ai = 1'b0, en_player_score = 1'b0, en_ai_score = 1'b0;
	reg [1:0] sel_x_ball = 2'd0, sel_y_ball = 2'd0, sel_y_paddle = 2'd0, sel_y_ai = 2'd0;
	reg sel_player_score = 1'b0, sel_ai_score = 1'b0;
	reg clk = 1'b0;
	
	wire [7:0] x_ball;
	wire [6:0] y_ball;
	wire [6:0] y_paddle;
	wire [6:0] y_ai;
	wire [3:0] player_score, ai_score;
	
	wire ball_too_high, ball_too_low, paddle_too_low, paddle_too_high, y_sign, x_sign;
	wire paddle_up, paddle_down, ai_up, ai_down;
	wire ai_too_high, ai_too_low;
	wire player_collision, ai_collision;
	wire player_scored, ai_scored;
	wire game_over;
	
	datapath uut(
		.clk(clk),
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
	
	always #5 clk = ~clk;
	
	initial begin
				current_data = 8'h0; 
				en_x_ball = 1'b0; en_y_ball = 1'b0; en_y_paddle = 1'b0; en_y_ai = 1'b0; en_player_score = 1'b0; en_ai_score = 1'b0;
				sel_x_ball = 2'b0; sel_y_ball = 2'b0; sel_y_paddle = 2'b0; sel_y_ai = 2'b0;
				sel_player_score = 1'b0; sel_ai_score = 1'b0;
		// test x and y for ball
		#10;  en_x_ball = 1'b1; en_y_ball = 1'b1; sel_x_ball = 2'h0; sel_y_ball = 2'h0;
		#10;  en_x_ball = 1'b0; en_y_ball = 1'b0; sel_x_ball = 2'h0; sel_y_ball = 2'h0;
		
		#10;  en_x_ball = 1'b1; en_y_ball = 1'b1; sel_x_ball = 2'h1; sel_y_ball = 2'h1;
		#10;  en_x_ball = 1'b0; en_y_ball = 1'b0; sel_x_ball = 2'h0; sel_y_ball = 2'h0;
		
		#10;  en_x_ball = 1'b1; en_y_ball = 1'b1; sel_x_ball = 2'h1; sel_y_ball = 2'h1;
		#10;  en_x_ball = 1'b0; en_y_ball = 1'b0; sel_x_ball = 2'h0; sel_y_ball = 2'h0;
		
		#10;  en_x_ball = 1'b1; en_y_ball = 1'b1; sel_x_ball = 2'h2; sel_y_ball = 2'h2;
		#10;  en_x_ball = 1'b0; en_y_ball = 1'b0; sel_x_ball = 2'h0; sel_y_ball = 2'h0;
		
		#10;  en_x_ball = 1'b1; en_y_ball = 1'b1; sel_x_ball = 2'h2; sel_y_ball = 2'h2;
		#10;  en_x_ball = 1'b0; en_y_ball = 1'b0; sel_x_ball = 2'h0; sel_y_ball = 2'h0;
		
		// wait until player scores
		#10;  en_x_ball = 1'b1; sel_x_ball = 2'h1;
		while (~player_scored) #5;
		#10;  en_x_ball = 1'b1; sel_x_ball = 2'h0; 
		#10;  en_x_ball = 1'b0; sel_x_ball = 2'h0; 
		
		// wait until ai scores
		#10;  en_x_ball = 1'b1; sel_x_ball = 2'h2;
		while (~ai_scored) #5;
		#10;  en_x_ball = 1'b1; sel_x_ball = 2'h0; 
		#10;  en_x_ball = 1'b0; sel_x_ball = 2'h0;
		
		// wait until ball is too high
		#10;  en_y_ball = 1'b1; sel_y_ball = 2'h1;
		while (~ball_too_high) #5;
		#10;  en_y_ball = 1'b1; sel_y_ball = 2'h0; 
		#10;  en_y_ball = 1'b0; sel_y_ball = 2'h0; 
		
		// wait until ball is too low
		#10;  en_y_ball = 1'b1; sel_y_ball = 2'h2;
		while (~ball_too_low) #5;
		#10;  en_y_ball = 1'b1; sel_y_ball = 2'h0;
		#10;  en_y_ball = 1'b0; sel_y_ball = 2'h0; 
		
		// test y for paddle and ai
		#10;  en_y_paddle = 1'b1; en_y_ai = 1'b1; sel_y_paddle = 2'h0; sel_y_ai = 2'h0;
		#10;  en_y_paddle = 1'b0; en_y_ai = 1'b0; sel_y_paddle = 2'h0; sel_y_ai = 2'h0;
		
		#10;  en_y_paddle = 1'b1; en_y_ai = 1'b1; sel_y_paddle = 2'h1; sel_y_ai = 2'h1;
		#10;  en_y_paddle = 1'b0; en_y_ai = 1'b0; sel_y_paddle = 2'h0; sel_y_ai = 2'h0;
		
		#10;  en_y_paddle = 1'b1; en_y_ai = 1'b1; sel_y_paddle = 2'h1; sel_y_ai = 2'h1;
		#10;  en_y_paddle = 1'b0; en_y_ai = 1'b0; sel_y_paddle = 2'h0; sel_y_ai = 2'h0;
		
		#10;  en_y_paddle = 1'b1; en_y_ai = 1'b1; sel_y_paddle = 2'h2; sel_y_ai = 2'h2;
		#10;  en_y_paddle = 1'b0; en_y_ai = 1'b0; sel_y_paddle = 2'h0; sel_y_ai = 2'h0;
		
		#10;  en_y_paddle = 1'b1; en_y_ai = 1'b1; sel_y_paddle = 2'h2; sel_y_ai = 2'h2;
		#10;  en_y_paddle = 1'b0; en_y_ai = 1'b0; sel_y_paddle = 2'h0; sel_y_ai = 2'h0;
		
		// wait until paddle is too high
		#10;  en_y_paddle = 1'b1; sel_y_paddle = 2'h1;
		while (~paddle_too_high) #5;
		#10;  en_y_paddle = 1'b1; sel_y_paddle = 2'h0; 
		#10;  en_y_paddle = 1'b0; sel_y_paddle = 2'h0; 
		
		// wait until paddle is too low
		#10;  en_y_paddle = 1'b1; sel_y_paddle = 2'h2;
		while (~paddle_too_low) #5;
		#10;  en_y_paddle = 1'b1; sel_y_paddle = 2'h0; 
		#10;  en_y_paddle = 1'b0; sel_y_paddle = 2'h0;
		
		// wait until ai is too high
		#10;  en_y_ai = 1'b1; sel_y_ai = 2'h1;
		while (~ai_too_high) #5;
		#10;  en_y_ai = 1'b1; sel_y_ai = 2'h0; 
		#10;  en_y_ai = 1'b0; sel_y_ai = 2'h0; 
		
		// wait until ai is too low
		#10;  en_y_ai = 1'b1; sel_y_ai = 2'h2;
		while (~ai_too_low) #5;
		#10;  en_y_ai = 1'b1; sel_y_ai = 2'h0;
		#10;  en_y_ai = 1'b0; sel_y_ai = 2'h0; 
		
		// test collision
		#10;  en_x_ball = 1'b1; sel_x_ball = 2'h1;
		while (x_ball >= 5) #5;
		#10;  en_x_ball = 1'b0; sel_x_ball = 2'h0;
		
		#10;  en_y_ball = 1'b1; sel_y_ball = 2'h2;
		while (y_ball >= 5) #5;
		#10;  en_y_ball = 1'b0; sel_y_ball = 2'h0; 
		
		#10;  en_x_ball = 1'b1; sel_x_ball = 2'h2;
		while (x_ball <= 155) #5;
		#10;  en_x_ball = 1'b0; sel_x_ball = 2'h0;
		
		
		// test score
		#10;  en_player_score = 1'b1; en_ai_score = 1'b1; sel_player_score = 1'b1; sel_ai_score = 1'b1;
		#10;  en_player_score = 1'b0; en_ai_score = 1'b0;
		#10;  en_player_score = 1'b1; en_ai_score = 1'b1; sel_player_score = 1'b1; sel_ai_score = 1'b1;
		while (~game_over) #10;
		#10;  en_player_score = 1'b0; en_ai_score = 1'b0;
		
		#10;  current_data = 7'h77;
		#10;  current_data = 7'h73;
		#10;  current_data = 7'h42;
		#10;  current_data = 7'h41;
 
	end
	

	endmodule