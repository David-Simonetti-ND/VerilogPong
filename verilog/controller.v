module controller(
	input clk,
	input reset,
	output reg [1:0]sel_x_ball,
	output reg en_x_ball,
	output reg [1:0]sel_y_ball,
	output reg en_y_ball,
	output reg [2:0]sel_y_paddle,
	output reg en_y_paddle,
	output reg [2:0]sel_y_ai,
	output reg en_y_ai,
	output reg sel_player_score,
	output reg en_player_score,
	output reg sel_ai_score,
	output reg en_ai_score,
	input y_sign,
	input x_sign,
	input ball_too_high,
	input ball_too_low,
	input paddle_too_low,
	input paddle_too_high,
	input ai_too_low,
	input ai_too_high,
	input paddle_up,
	input paddle_down,
	input ai_up,
	input ai_down,
	input player_collision,
	input ai_collision,
	input player_scored, 
	input ai_scored,
	input game_over
	);
	
	parameter RESET = 6'd0;
	parameter BALL_Y_DOWN = 6'd1;
	parameter BALL_Y_UP = 6'd2;
	parameter BALL_X_DOWN = 6'd3;
	parameter BALL_X_UP = 6'd4;
	parameter PLAYER_SCORE = 6'd5;
	parameter AI_SCORE = 6'd6;
	parameter PADDLE_DOWN = 6'd7;
	parameter PADDLE_UP = 6'd8;
	parameter PADDLE_RESET = 6'd9;
	parameter AI_DOWN = 6'd10;
	parameter AI_UP = 6'd11;
	parameter AI_RESET = 6'd12;
	
	reg [6:0] state;
	reg [6:0] next_state;
	
	initial state = 6'd0;
	initial next_state = 6'd0;
	
	always @(posedge clk)
		if (reset)
			state <= RESET;
		else
			state <= next_state;
	always @(*) begin
		en_x_ball = 1'b0;
		sel_x_ball = 2'b0;
		en_y_ball = 1'b0;
		sel_y_ball = 2'b0;
		en_y_paddle = 1'b0; 
		sel_y_paddle = 2'h0;
		en_y_ai = 1'b0; 
		sel_y_ai = 2'h0;
		en_player_score = 1'b0; 
		sel_player_score = 1'b0;
		en_ai_score = 1'b0; 
		sel_ai_score = 1'b0;
		next_state = RESET;
		case (state)
			RESET: 
			begin
				en_x_ball = 1'b1; sel_x_ball = 2'h0;
				en_y_ball = 1'b1; sel_y_ball = 2'h0;
				en_player_score = 1'b1; sel_player_score = 1'b0;
				en_ai_score = 1'b1; sel_ai_score = 1'b0;
				next_state = BALL_Y_UP;
			end
			BALL_Y_DOWN: 
			begin
				en_y_ball = 1'b1; sel_y_ball = 2'h2;
				if (x_sign) next_state = BALL_X_UP;
				else next_state = BALL_X_DOWN;
			end
			BALL_Y_UP: 
			begin
				en_y_ball = 1'b1; sel_y_ball = 2'h1;
				if (x_sign) next_state = BALL_X_UP;
				else next_state = BALL_X_DOWN;
			end
			BALL_X_DOWN:
			begin
				en_x_ball = 1'b1; sel_x_ball = 2'h2;
				if (ai_scored) next_state = AI_SCORE;
				else if (player_collision) next_state = BALL_X_UP;
				else if (paddle_down)
				begin
					if (paddle_too_high) next_state = PADDLE_RESET;
					else next_state = PADDLE_DOWN;
				end
				else if (paddle_up)
				begin
					if (paddle_too_low) next_state = PADDLE_RESET;
					else next_state = PADDLE_UP;
				end
				else next_state = PADDLE_RESET;
			end
			BALL_X_UP:
			begin
				en_x_ball = 1'b1; sel_x_ball = 2'h1;
				if (player_scored) next_state = PLAYER_SCORE;
				else if (ai_collision) next_state = BALL_X_DOWN;
				else if (paddle_down)
				begin
					if (paddle_too_high) next_state = PADDLE_RESET;
					else next_state = PADDLE_DOWN;
				end
				else if (paddle_up)
				begin
					if (paddle_too_low) next_state = PADDLE_RESET;
					else next_state = PADDLE_UP;
				end
				else next_state = PADDLE_RESET;
			end
			
			PLAYER_SCORE:
			begin
				en_x_ball = 1'b1; sel_x_ball = 2'h0;
				en_y_ball = 1'b1; sel_y_ball = 2'h0;
				en_player_score = 1'b1; sel_player_score = 1'b1;
				if (game_over) next_state = RESET;
				else next_state = BALL_Y_UP;
			end
			AI_SCORE:
			begin
				en_x_ball = 1'b1; sel_x_ball = 2'h0;
				en_y_ball = 1'b1; sel_y_ball = 2'h0;
				en_ai_score = 1'b1; sel_ai_score = 1'b1;
				if (game_over) next_state = RESET;
				else next_state = BALL_Y_UP;
			end
			PADDLE_DOWN: 
			begin
				en_y_paddle = 1'b1; sel_y_paddle = 3'h1;
				if (ai_down)
				begin
					if (ai_too_high) next_state = AI_RESET;
					else next_state = AI_DOWN;
				end
				else if (ai_up)
				begin
					if (ai_too_low) next_state = AI_RESET;
					else next_state = AI_UP;
				end
				else next_state = AI_RESET;
			end
			PADDLE_UP: 
			begin
				en_y_paddle = 1'b1; sel_y_paddle = 3'h2;
				if (ai_down)
				begin
					if (ai_too_high) next_state = AI_RESET;
					else next_state = AI_DOWN;
				end
				else if (ai_up)
				begin
					if (ai_too_low) next_state = AI_RESET;
					else next_state = AI_UP;
				end
				else next_state = AI_RESET;
			end
			PADDLE_RESET: 
			begin
				en_y_paddle = 1'b1; sel_y_paddle = 3'h3;
				if (ai_down)
				begin
					if (ai_too_high) next_state = AI_RESET;
					else next_state = AI_DOWN;
				end
				else if (ai_up)
				begin
					if (ai_too_low) next_state = AI_RESET;
					else next_state = AI_UP;
				end
				else next_state = AI_RESET;
			end
			AI_DOWN: 
			begin
				en_y_ai = 1'b1; sel_y_ai = 3'h1;
				if (ball_too_high) next_state = BALL_Y_DOWN;
				else if (ball_too_low) next_state = BALL_Y_UP;
				else if (y_sign) next_state = BALL_Y_UP;
				else next_state = BALL_Y_DOWN;
			end
			AI_UP: 
			begin
				en_y_ai = 1'b1; sel_y_ai = 3'h2;
				if (ball_too_high) next_state = BALL_Y_DOWN;
				else if (ball_too_low) next_state = BALL_Y_UP;
				else if (y_sign) next_state = BALL_Y_UP;
				else next_state = BALL_Y_DOWN;
			end
			AI_RESET: 
			begin
				en_y_ai = 1'b1; sel_y_ai = 3'h3;
				if (ball_too_high) next_state = BALL_Y_DOWN;
				else if (ball_too_low) next_state = BALL_Y_UP;
				else if (y_sign) next_state = BALL_Y_UP;
				else next_state = BALL_Y_DOWN;
			end
			default: ;
		endcase
	end
endmodule



